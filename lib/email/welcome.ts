import { Resend } from "resend";

/**
 * Welcome email sent the moment a visitor joins the waitlist.
 *
 * Designed to fail gracefully: if RESEND_API_KEY is unset, or sending fails,
 * we log and return — we do NOT throw. The waitlist signup itself must still
 * succeed (Supabase already saved the email; we'll send the welcome later if
 * we need to).
 */

const FROM_ADDRESS = process.env.RESEND_FROM ?? "Praxist Prep <hello@praxistprep.com>";

export async function sendWaitlistWelcome(toEmail: string): Promise<void> {
  const apiKey = process.env.RESEND_API_KEY;
  if (!apiKey) {
    console.info("[email] RESEND_API_KEY not set — skipping welcome email");
    return;
  }

  const resend = new Resend(apiKey);

  try {
    await resend.emails.send({
      from: FROM_ADDRESS,
      to: toEmail,
      subject: "You're on the list — Praxist Prep",
      html: WELCOME_HTML,
      text: WELCOME_TEXT,
    });
  } catch (err) {
    console.error("[email] welcome send failed:", err);
  }
}

const WELCOME_HTML = `<!DOCTYPE html>
<html>
  <body style="margin:0;padding:0;background:#f6f4e3;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;color:#1a2723;">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#f6f4e3;padding:40px 20px;">
      <tr>
        <td align="center">
          <table role="presentation" width="560" cellpadding="0" cellspacing="0" style="max-width:560px;background:#fbf8eb;border:1px solid #e3dabe;border-radius:20px;padding:40px;">
            <tr>
              <td>
                <div style="font-size:11px;letter-spacing:0.28em;text-transform:uppercase;color:#7a8a82;font-weight:600;margin-bottom:24px;">
                  Praxist Prep · MCAT
                </div>
                <h1 style="font-family:Georgia,'Times New Roman',serif;font-size:30px;line-height:1.15;color:#054f46;margin:0 0 20px 0;font-weight:500;letter-spacing:-0.01em;">
                  You're on the list.
                </h1>
                <p style="font-size:16px;line-height:1.6;color:#1a2723;margin:0 0 16px 0;">
                  Thank you for signing up. You'll be the first to know the moment Praxist Prep opens its doors.
                </p>
                <p style="font-size:16px;line-height:1.6;color:#1a2723;margin:0 0 16px 0;">
                  We're building something different — an MCAT prep course that meets you where you are, with the personal mentorship you'd expect from a tutor and the rigor of a structured program. No score guarantees. Just the tools, and someone in your corner.
                </p>
                <p style="font-size:16px;line-height:1.6;color:#1a2723;margin:0 0 32px 0;">
                  More from us soon.
                </p>
                <p style="font-family:Georgia,'Times New Roman',serif;font-style:italic;font-size:14px;color:#4a5d56;margin:0;">
                  — Built deliberately. Tempered by practice. —
                </p>
              </td>
            </tr>
          </table>
          <div style="font-size:11px;color:#7a8a82;margin-top:24px;">
            © Praxist Prep · You're receiving this because you joined the waitlist at praxistprep.com
          </div>
        </td>
      </tr>
    </table>
  </body>
</html>`;

const WELCOME_TEXT = `You're on the list.

Thank you for signing up. You'll be the first to know the moment Praxist Prep opens its doors.

We're building something different — an MCAT prep course that meets you where you are, with the personal mentorship you'd expect from a tutor and the rigor of a structured program. No score guarantees. Just the tools, and someone in your corner.

More from us soon.

— Built deliberately. Tempered by practice. —

© Praxist Prep · You're receiving this because you joined the waitlist at praxistprep.com`;
