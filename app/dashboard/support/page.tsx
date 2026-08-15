"use client";

import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import { useDashboard } from "@/components/dashboard/DashboardShell";

interface Faq {
  q: string;
  a: string;
}

const FAQS: Faq[] = [
  {
    q: "How do the flashcards work?",
    a: "Praxist Prep uses spaced repetition. The cards you find harder come back more often, and the cards you know well are spaced out so you don't waste time on them. Each cloze card (with blanks like {{c1::answer}}) reveals one answer at a time, so every card is multiple study items in one.",
  },
  {
    q: "Can I study on my phone?",
    a: "Yes. The whole app is mobile-first, so you can study cards on your phone or tablet just as easily as on a laptop. Your progress and review schedule sync across devices when you're signed in.",
  },
  {
    q: "How do I track my progress?",
    a: "Open the Analytics tab in your dashboard sidebar. You'll see your accuracy, daily and weekly study volume, and how your performance breaks down across MCAT sections.",
  },
  {
    q: "I found a mistake in a flashcard. What should I do?",
    a: "Please tell us! Use the form below. Paste the card text (or a screenshot via your reply email) and what you think the correct version should be. We aim to fix card errors within a few days.",
  },
  {
    q: "How do I change my password or name?",
    a: "Click your name at the bottom of the sidebar to open Settings, where you can update your profile information and change your password.",
  },
  {
    q: "I need help with something else.",
    a: "Use the form below. We read every message and reply by email, usually within one business day. If it's urgent, mention that in the subject line.",
  },
];

export default function SupportPage() {
  const { user, profile } = useDashboard();

  const [openIdx, setOpenIdx] = useState<number | null>(null);

  const [subject, setSubject] = useState("");
  const [message, setMessage] = useState("");
  const [replyEmail, setReplyEmail] = useState("");

  const [submitting, setSubmitting] = useState(false);
  const [sent, setSent] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Pre-fill the reply email with the user's email
  useEffect(() => {
    if (user.email && !replyEmail) setReplyEmail(user.email);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user.email]);

  async function submitMessage(e: React.FormEvent) {
    e.preventDefault();
    setError(null);

    if (subject.trim() === "" || message.trim() === "") {
      setError("Please add a subject and message.");
      return;
    }
    if (replyEmail.trim() === "") {
      setError("Please add a reply email.");
      return;
    }

    setSubmitting(true);

    const displayName = [profile?.first_name, profile?.last_name]
      .filter(Boolean)
      .join(" ")
      .trim();

    const { error: insertError } = await supabase
      .from("support_messages")
      .insert({
        user_id: user.id,
        email: replyEmail.trim(),
        name: displayName || null,
        subject: subject.trim(),
        message: message.trim(),
      });

    setSubmitting(false);

    if (insertError) {
      setError(insertError.message || "Couldn't send message");
      return;
    }

    setSent(true);
    setSubject("");
    setMessage("");
  }

  return (
    <div className="font-body px-5 py-8 lg:px-0 lg:py-0 max-w-[720px]">
      <div className="mb-8">
        <div
          className="text-[11px] uppercase mb-2 font-semibold"
          style={{
            letterSpacing: "0.22em",
            color: "var(--color-prax-ink-mute)",
          }}
        >
          Help & Contact
        </div>
        <h1
          className="font-serif mb-2"
          style={{
            fontSize: 32,
            fontWeight: 500,
            color: "var(--color-prax-ink)",
            lineHeight: 1.15,
          }}
        >
          Support
        </h1>
        <p
          className="text-[14px]"
          style={{ color: "var(--color-prax-ink-soft)" }}
        >
          Check the FAQ first. It covers the most common questions. If you
          still need help, send us a message at the bottom of the page.
        </p>
      </div>

      {/* ─────────── FAQ section ─────────── */}
      <section className="mb-8">
        <h2
          className="font-serif mb-4"
          style={{
            fontSize: 18,
            fontWeight: 500,
            color: "var(--color-prax-ink)",
          }}
        >
          Frequently asked questions
        </h2>
        <div className="space-y-2">
          {FAQS.map((faq, i) => {
            const isOpen = openIdx === i;
            return (
              <div
                key={i}
                className="rounded-lg overflow-hidden"
                style={{
                  background: "var(--color-prax-cream-card)",
                  border: "1px solid var(--color-prax-cream-border)",
                }}
              >
                <button
                  onClick={() => setOpenIdx(isOpen ? null : i)}
                  className="w-full text-left px-4 py-3 flex items-start justify-between gap-3"
                  type="button"
                >
                  <span
                    className="text-[14px] font-semibold"
                    style={{ color: "var(--color-prax-ink)" }}
                  >
                    {faq.q}
                  </span>
                  <span
                    className="shrink-0 mt-0.5 text-[14px]"
                    style={{
                      color: "var(--color-prax-ink-mute)",
                      transform: isOpen ? "rotate(180deg)" : "none",
                      transition: "transform 150ms",
                    }}
                  >
                    ▾
                  </span>
                </button>
                {isOpen && (
                  <div
                    className="px-4 pb-4 text-[13.5px] leading-relaxed"
                    style={{ color: "var(--color-prax-ink-soft)" }}
                  >
                    {faq.a}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      </section>

      {/* ─────────── Contact form section ─────────── */}
      <section
        className="px-5 py-5 rounded-xl"
        style={{
          background: "var(--color-prax-cream-card)",
          border: "1px solid var(--color-prax-cream-border)",
        }}
      >
        <h2
          className="font-serif mb-1"
          style={{
            fontSize: 18,
            fontWeight: 500,
            color: "var(--color-prax-ink)",
          }}
        >
          Send us a message
        </h2>
        <p
          className="text-[13px] mb-4"
          style={{ color: "var(--color-prax-ink-soft)" }}
        >
          We read every message and reply by email, usually within one
          business day.
        </p>

        {sent ? (
          <div
            className="rounded-lg px-4 py-3"
            style={{
              background: "var(--color-prax-cream)",
              border: "1px solid var(--color-prax-green)",
              color: "var(--color-prax-green)",
            }}
          >
            ✓ Got it. We'll reply to <strong>{replyEmail}</strong> within one
            business day.
            <button
              onClick={() => setSent(false)}
              className="block mt-2 text-[12px] underline"
              style={{ color: "var(--color-prax-ink-soft)" }}
            >
              Send another message
            </button>
          </div>
        ) : (
          <form onSubmit={submitMessage} className="space-y-4">
            <Field
              label="Subject"
              value={subject}
              onChange={setSubject}
              placeholder="What's this about?"
            />
            <Field
              label="Reply to"
              type="email"
              value={replyEmail}
              onChange={setReplyEmail}
              placeholder="you@example.com"
            />
            <div>
              <Label>Message</Label>
              <textarea
                value={message}
                onChange={(e) => setMessage(e.target.value)}
                placeholder="Tell us what you need help with…"
                className="w-full px-3 py-2 rounded-lg text-[14px] resize-y leading-relaxed"
                style={{
                  minHeight: 140,
                  background: "var(--color-prax-cream)",
                  color: "var(--color-prax-ink)",
                  border: "1px solid var(--color-prax-cream-border)",
                }}
              />
            </div>

            {error && (
              <div
                className="text-[12px]"
                style={{ color: "var(--color-prax-red, #b94a4a)" }}
              >
                {error}
              </div>
            )}

            <button
              type="submit"
              disabled={submitting}
              className="px-5 py-2 rounded-lg font-semibold text-[13px] disabled:opacity-50"
              style={{
                background: "var(--color-prax-green)",
                color: "#fff",
              }}
            >
              {submitting ? "Sending…" : "Send message"}
            </button>
          </form>
        )}
      </section>
    </div>
  );
}

/* ─────────────── tiny field helpers ─────────────── */

function Field({
  label,
  value,
  onChange,
  type = "text",
  placeholder,
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
  type?: string;
  placeholder?: string;
}) {
  return (
    <div>
      <Label>{label}</Label>
      <input
        type={type}
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        className="w-full px-3 py-2 rounded-lg text-[14px]"
        style={{
          background: "var(--color-prax-cream)",
          color: "var(--color-prax-ink)",
          border: "1px solid var(--color-prax-cream-border)",
        }}
      />
    </div>
  );
}

function Label({ children }: { children: React.ReactNode }) {
  return (
    <div
      className="text-[11px] font-semibold uppercase mb-1.5"
      style={{
        letterSpacing: "0.14em",
        color: "var(--color-prax-ink-mute)",
      }}
    >
      {children}
    </div>
  );
}
