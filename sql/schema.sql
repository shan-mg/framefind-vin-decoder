CREATE TABLE IF NOT EXISTS vehicles (
 id BIGSERIAL PRIMARY KEY, chassis_number TEXT NOT NULL UNIQUE, vin_type TEXT, make TEXT, model TEXT,
 model_code TEXT, grade TEXT, manufacture_year INTEGER, engine_code TEXT, engine_number TEXT,
 engine_cc INTEGER, fuel_type TEXT, fuel_system TEXT, hybrid_type TEXT, transmission TEXT, drive_type TEXT,
 fuel_consumption TEXT, tyre_size TEXT, specs JSONB NOT NULL DEFAULT '{}'::jsonb,
 valuation_data JSONB NOT NULL DEFAULT '{}'::jsonb, inspection_notes TEXT, specification_source TEXT,
 verification_status TEXT NOT NULL DEFAULT 'unverified', updated_by_session TEXT,
 created_at TIMESTAMPTZ NOT NULL DEFAULT now(), updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS search_history (
 id BIGSERIAL PRIMARY KEY, session_id TEXT, chassis_number TEXT NOT NULL,
 searched_at TIMESTAMPTZ NOT NULL DEFAULT now(), status TEXT NOT NULL DEFAULT 'no_match', result_snapshot JSONB
);
CREATE INDEX IF NOT EXISTS search_history_chassis_idx ON search_history(chassis_number);
CREATE INDEX IF NOT EXISTS search_history_searched_at_idx ON search_history(searched_at DESC);
CREATE TABLE IF NOT EXISTS source_evidence (
 id BIGSERIAL PRIMARY KEY, vehicle_id BIGINT REFERENCES vehicles(id) ON DELETE CASCADE,
 chassis_number TEXT NOT NULL, source_name TEXT, source_url TEXT, field_name TEXT NOT NULL, field_value TEXT,
 evidence_status TEXT NOT NULL DEFAULT 'unverified' CHECK (evidence_status IN ('verified','reported','estimated','unverified','unavailable')),
 retrieved_at TIMESTAMPTZ NOT NULL DEFAULT now(), metadata JSONB NOT NULL DEFAULT '{}'::jsonb
);
CREATE INDEX IF NOT EXISTS source_evidence_chassis_idx ON source_evidence(chassis_number);
