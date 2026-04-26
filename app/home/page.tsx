"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";

/**
 * /home is a legacy URL that previously hosted the marketing site directly.
 * The marketing content now lives at / and is dispatched by app/page.tsx
 * based on launch mode + auth state. /home permanently redirects to /.
 */
export default function HomeRedirect() {
  const router = useRouter();
  useEffect(() => {
    router.replace("/");
  }, [router]);
  return null;
}
