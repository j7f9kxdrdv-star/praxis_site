CREATE TABLE IF NOT EXISTS performance_reports (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  report_type TEXT CHECK (report_type IN ('daily', 'weekly')) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  raw_metrics_json JSONB NOT NULL,
  report_text TEXT NOT NULL,
  top_priority_subtopic TEXT,
  top_priority_section TEXT,
  top_priority_reason TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

CREATE INDEX IF NOT EXISTS performance_reports_user_type_idx
  ON performance_reports(user_id, report_type, created_at DESC);

ALTER TABLE performance_reports ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own reports"
  ON performance_reports FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own reports"
  ON performance_reports FOR INSERT
  WITH CHECK (auth.uid() = user_id);
