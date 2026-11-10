"use client";

import Link from "next/link";
import { SmallCaps, praxBtnGhost, praxBtnGreenOnCream } from "@/components/dashboard/PraxUI";
import {
  describeSubjectReview,
  sessionHref,
  type SectionId,
  type SubjectProjection,
} from "@/lib/flashcards/sections";

// Study one subject with every chapter mixed together. Review is today's
// recommended work limited to this subject, so it shares the daily limits with
// every other subject. Extra Study goes beyond them and spends none.
export default function SubjectStudyBar({
  section,
  label,
  projection,
  dueElsewhere,
}: {
  section: SectionId;
  label: string;
  projection: SubjectProjection;
  /** Due reviews waiting in the other subjects, for a quiet reminder. */
  dueElsewhere: number;
}) {
  const { served, limitReached, newLimitUsed, reviewLimitUsed } = projection;
  const { headline, detail, elsewhere } = describeSubjectReview(projection, label, dueElsewhere);
  const unavailable = limitReached
    ? newLimitUsed && reviewLimitUsed
      ? "Both daily limits are used up"
      : newLimitUsed
      ? "Today's new-card limit is used up"
      : "Today's review limit is used up"
    : "Nothing is due right now";

  return (
    <div
      className="flex flex-col sm:flex-row sm:items-center gap-3 sm:gap-5 px-4 py-3.5 mb-2"
      style={{
        background: "var(--color-prax-cream-card)",
        border: "1px solid var(--color-prax-green)",
        borderRadius: 10,
      }}
    >
      <div className="flex-1 min-w-0">
        <SmallCaps style={{ color: "var(--color-prax-ink-mute)" }}>
          All {label} chapters, mixed
        </SmallCaps>
        <div
          className="mt-1 font-medium"
          style={{
            fontFamily: "var(--font-prax-serif)",
            fontSize: 16,
            color: "var(--color-prax-green)",
            fontVariantNumeric: "tabular-nums lining-nums",
          }}
        >
          {headline}
        </div>
        <p
          className="mt-0.5"
          style={{ fontSize: 12, color: "var(--color-prax-ink-soft)", lineHeight: 1.5 }}
        >
          {detail}
        </p>
        {elsewhere && (
          <p
            className="mt-0.5"
            style={{ fontSize: 11.5, color: "var(--color-prax-ink-mute)", lineHeight: 1.5 }}
          >
            {elsewhere}
          </p>
        )}
      </div>
      <div className="flex gap-2 shrink-0">
        {served > 0 ? (
          <Link href={sessionHref("due", section)} style={praxBtnGreenOnCream}>
            Review
          </Link>
        ) : (
          <span
            aria-disabled="true"
            title={unavailable}
            style={{ ...praxBtnGreenOnCream, opacity: 0.4, cursor: "default" }}
          >
            Review
          </span>
        )}
        <Link
          href={sessionHref("extra_study", section)}
          style={{ ...praxBtnGhost, display: "inline-flex", alignItems: "center" }}
        >
          Extra Study
        </Link>
      </div>
    </div>
  );
}
