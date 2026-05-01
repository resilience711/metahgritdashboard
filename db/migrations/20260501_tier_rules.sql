CREATE TABLE IF NOT EXISTS tier_rulesets (
  id                BIGSERIAL PRIMARY KEY,
  version           TEXT NOT NULL UNIQUE,
  rules             JSONB NOT NULL,
  is_active         BOOLEAN NOT NULL DEFAULT FALSE,
  created_by        UUID,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  activated_at      TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_tier_rulesets_active
  ON tier_rulesets(is_active)
  WHERE is_active = TRUE;

CREATE INDEX IF NOT EXISTS idx_tier_rulesets_rules_gin
  ON tier_rulesets
  USING GIN (rules);

CREATE OR REPLACE FUNCTION set_active_tier_ruleset(p_version TEXT)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE tier_rulesets
  SET is_active = FALSE
  WHERE is_active = TRUE;

  UPDATE tier_rulesets
  SET is_active = TRUE,
      activated_at = NOW()
  WHERE version = p_version;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Tier ruleset version % not found', p_version;
  END IF;
END;
$$;

CREATE OR REPLACE VIEW active_tier_rules AS
SELECT id, version, rules, created_at, activated_at
FROM tier_rulesets
WHERE is_active = TRUE
ORDER BY activated_at DESC NULLS LAST
LIMIT 1;
