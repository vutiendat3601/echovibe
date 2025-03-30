"""create artist table, artist_detail materialized view

Revision ID: e1804fc053c1
Revises: 
Create Date: 2025-03-06 23:05:14.300814

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision: str = "e1804fc053c1"
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    create_uuid_ossp_extension_ddl = 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
    create_unaccent_extension_ddl = "CREATE EXTENSION IF NOT EXISTS unaccent;"

    create_artist_table_ddl = """
-- Table: artist
CREATE TABLE artist (
	id uuid NOT NULL,
	aggregate_id varchar(16) NOT NULL,
	urn varchar(255) NOT NULL,
	ref_code varchar(100),
	"name" varchar(255) NOT NULL,
	description varchar(255),
	biography text,
	nationality_iso_code varchar(32),
	thumbnail_file_key text,
	thumbnail_url text,
	background_file_key text,
	background_url text,
	revision_number int NOT NULL,
	is_public bool NOT NULL,
	is_released bool NOT NULL,
	is_verified bool NOT NULL,
	is_active bool NOT NULL,
	tags _text NOT NULL DEFAULT '{}', -- used for tsv trigger
  tsv tsvector,
	event_type text,
	event_version int,
	event_timestamp timestamptz,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NOT NULL,
	created_by varchar(255),
	updated_by varchar(255),
	CONSTRAINT artist_aggregate_id_key UNIQUE (aggregate_id),
	CONSTRAINT artist_pkey PRIMARY KEY (id),
	CONSTRAINT artist_urn_key UNIQUE (urn)
);
CREATE INDEX idx_artist__tsv ON artist USING GIN (tsv);

-- Function: artist_update_tsv
CREATE OR REPLACE FUNCTION artist_update_tsv()
RETURNS TRIGGER AS $$
BEGIN
    NEW.tsv = to_tsvector('english', NEW.name || ' ' || unaccent(NEW.name) || ' ' || array_to_string(NEW.tags, ' ') || ' ' || unaccent(array_to_string(NEW.tags, ' ')));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql
;

-- Trigger: artist_update_tsv_trigger
CREATE TRIGGER artist_update_tsv_trigger
BEFORE INSERT OR UPDATE ON artist
FOR EACH ROW
EXECUTE FUNCTION artist_update_tsv()
;"""

    create_artist_detail_materialized_view_ddl = """
CREATE MATERIALIZED VIEW public.mv_artist_detail
TABLESPACE pg_default
AS SELECT id,
    aggregate_id,
    urn,
    name,
    description,
    biography,
    nationality_iso_code,
    thumbnail_file_key,
    thumbnail_url,
    background_file_key,
    background_url,
    is_public,
    is_verified,
    tags
   FROM artist
  WHERE is_active
WITH DATA
;"""
    refresh_mv_artist_detail_view_function_ddl = """
CREATE OR REPLACE FUNCTION refresh_mv_artist_detail()
RETURNS trigger AS $$
BEGIN
  REFRESH MATERIALIZED VIEW mv_artist_detail;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql
;"""

    artist_refresh_mv_artist_detail_trigger_ddl = """
CREATE TRIGGER artist_refresh_mv_artist_detail_trigger
AFTER INSERT OR UPDATE OR DELETE ON artist
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_mv_artist_detail()
;"""

    ddls = [
        create_uuid_ossp_extension_ddl, create_unaccent_extension_ddl,
        create_artist_table_ddl, create_artist_detail_materialized_view_ddl,
        refresh_mv_artist_detail_view_function_ddl,
        artist_refresh_mv_artist_detail_trigger_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)


def downgrade() -> None:
    drop_uuid_ossp_extension_ddl = 'DROP EXTENSION IF NOT EXISTS "uuid-ossp";'
    drop_unaccent_extension_ddl = "DROP EXTENSION IF NOT EXISTS unaccent;"
    drop_artist_detail_materialized_view = "DROP MATERIALIZED VIEW mv_artist_detail;"
    drop_artist_table_ddl = "DROP TABLE IF EXISTS artist;"
    drop_artist_refresh_mv_artist_detail_trigger = "DROP TRIGGER IF EXISTS artist_refresh_mv_artist_detail_trigger;"
    drop_refresh_mv_artist_detail_function = "DROP FUNCTION IF EXISTS refresh_mv_artist_detail;"
    ddls = [
        drop_uuid_ossp_extension_ddl, drop_unaccent_extension_ddl,
        drop_artist_detail_materialized_view, drop_artist_table_ddl,
        drop_artist_refresh_mv_artist_detail_trigger,
        drop_refresh_mv_artist_detail_function
    ]
    for ddl in ddls:
        op.execute(ddl)
