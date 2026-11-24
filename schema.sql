CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  display_name TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('admin','clinician','patient','auditor')),
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS patients (
  id TEXT PRIMARY KEY,
  patient_code TEXT UNIQUE NOT NULL,
  display_name TEXT NOT NULL,
  birth_year INTEGER,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS consent_records (
  id TEXT PRIMARY KEY,
  patient_id TEXT NOT NULL REFERENCES patients(id),
  consent_type TEXT NOT NULL,
  consented_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  version TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS assessment_sessions (
  id TEXT PRIMARY KEY,
  patient_id TEXT NOT NULL REFERENCES patients(id),
  assessment_key TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('draft','in_progress','submitted','reviewed')),
  started_at TEXT,
  submitted_at TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS assessment_answers (
  id TEXT PRIMARY KEY,
  session_id TEXT NOT NULL REFERENCES assessment_sessions(id),
  item_key TEXT NOT NULL,
  answer_value TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS clinical_notes (
  id TEXT PRIMARY KEY,
  session_id TEXT NOT NULL REFERENCES assessment_sessions(id),
  author_user_id TEXT REFERENCES users(id),
  note_text TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS audit_logs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  actor_user_id TEXT,
  action TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT OR IGNORE INTO users (id, display_name, role) VALUES ('demo-clinician-001', 'Demo Clinician', 'clinician');
INSERT OR IGNORE INTO patients (id, patient_code, display_name, birth_year) VALUES ('demo-patient-001', 'MJ-DEMO-0042', 'Synthetic Patient', 1997);
INSERT OR IGNORE INTO assessment_sessions (id, patient_id, assessment_key, status) VALUES ('demo-session-001', 'demo-patient-001', 'mood-anxiety-check-in', 'draft');
