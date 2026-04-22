import BackgroundCanvas from "@/components/dashboard/BackgroundCanvas";

export default function FlashcardsLayout({ children }: { children: React.ReactNode }) {
  return (
    <>
      <BackgroundCanvas />
      {children}
    </>
  );
}
