"""create tables: artist, artist_profile, artist_image, artist_revision

Revision ID: 1b898650e836
Revises: 
Create Date: 2025-03-10 16:24:15.189539

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision: str = "1b898650e836"
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
	aggregate_id varchar(12) NOT NULL,
	urn varchar(255) NOT NULL,
	ref_code varchar(100) NULL,
	revision_number numeric NOT NULL,
	is_public bool NOT NULL,
	is_released bool NOT NULL,
	is_active bool NOT NULL,
	is_verified bool NOT NULL,
	tags _text NOT NULL DEFAULT '{}', -- used for tsv trigger
  tags_json jsonb NOT NULL,
  tsv tsvector,
	event_type text NULL,
	event_version numeric NULL,
	event_timestamp timestamptz NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NOT NULL,
	created_by varchar(255) NULL,
	updated_by varchar(255) NULL,
	CONSTRAINT artist_aggregate_id_key UNIQUE (aggregate_id),
	CONSTRAINT artist_pkey PRIMARY KEY (id),
	CONSTRAINT artist_urn_key UNIQUE (urn)
);
CREATE INDEX idx_artist__tsv ON artist USING GIN (tsv);

-- Function: artist_set_tsv
CREATE OR REPLACE FUNCTION artist_set_tsv()
RETURNS trigger AS $$
DECLARE
  artist_name text;
BEGIN
    SELECT COALESCE(name, '') INTO artist_name
    FROM artist_profile WHERE aggregate_id = NEW.aggregate_id;
    
    NEW.tsv = to_tsvector('english', artist_name || unaccent(artist_name) || array_to_string(NEW.tags, ' ') || unaccent(array_to_string(NEW.tags, ' ')));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: artist_set_tsv_trigger
CREATE TRIGGER artist_set_tsv_trigger
BEFORE INSERT OR UPDATE ON artist
FOR EACH ROW
EXECUTE FUNCTION artist_set_tsv();

CREATE OR REPLACE FUNCTION artist_update_tsv(update_aggregate_id TEXT)
RETURNS void AS $$
DECLARE
    artist_name text;
BEGIN
    SELECT COALESCE(name, '') INTO artist_name
    FROM artist_profile WHERE aggregate_id = update_aggregate_id;
    
    UPDATE artist
    SET tsv = to_tsvector('english', artist_name || unaccent(artist_name) || array_to_string(tags, ' ') || unaccent(array_to_string(tags, ' ')))
    WHERE aggregate_id = update_aggregate_id;
END;
$$ LANGUAGE plpgsql;
"""

    create_artist_profile_ddl = """
CREATE TABLE artist_profile (
	id uuid NOT NULL,
	artist_id uuid NULL,
	aggregate_id varchar(12) NOT NULL,
	ref_code varchar(255) NULL,
	"name" varchar(255) NOT NULL,
	description varchar(255) NULL,
	biography text NULL,
	nationality_iso_code text NULL,
	thumbnail_file_key text NULL,
	thumbnail_url text NULL,
	background_file_key text NULL,
	background_url text NULL,
	is_active bool NOT NULL,
	event_type text NULL,
	event_version numeric NULL,
	event_timestamp timestamptz NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NOT NULL,
	created_by varchar(255) NULL,
	updated_by varchar(255) NULL,
	CONSTRAINT artist_profile_aggregate_id_key UNIQUE (aggregate_id),
	CONSTRAINT artist_profile_artist_id_key UNIQUE (artist_id),
	CONSTRAINT artist_profile_pkey PRIMARY KEY (id)
);

-- Foreign key:
ALTER TABLE artist_profile ADD CONSTRAINT fk_artist_profile__artist_id___artist__id
FOREIGN KEY (artist_id) REFERENCES artist(id) ON DELETE CASCADE ON UPDATE CASCADE;


-- Function: artist_set_tsv
CREATE OR REPLACE FUNCTION on_artist_profile_after_insert_update()
RETURNS trigger AS $$
BEGIN
    PERFORM artist_update_tsv(NEW.aggregate_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: artist_profile_after_insert_update_trigger
CREATE TRIGGER artist_profile_after_insert_update_trigger
AFTER INSERT OR UPDATE ON artist_profile
FOR EACH ROW
EXECUTE FUNCTION on_artist_profile_after_insert_update();
"""

    create_artist_image_table_ddl = """
CREATE TABLE artist_image (
	id uuid NOT NULL,
	artist_id uuid NOT NULL,
	aggregate_id varchar(12) NOT NULL,
	ref_code varchar(255) NULL,
	file_url text NULL,
	file_key text NULL,
	is_active bool NOT NULL,
	"type" varchar(32) NULL,
	thumbnail_url text NULL,
	event_type text NULL,
	event_version numeric NULL,
	event_timestamp timestamptz NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NOT NULL,
	created_by varchar(255) NULL,
	updated_by varchar(255) NULL,
	CONSTRAINT artist_image_pkey PRIMARY KEY (id)
);

-- Foreign key: 
ALTER TABLE artist_image ADD CONSTRAINT fk_artist_image__artist_id___artist__id
FOREIGN KEY (artist_id) REFERENCES artist(id) ON DELETE CASCADE ON UPDATE CASCADE
;"""

    create_artist_revision_table_ddl = """
CREATE TABLE artist_revision (
	id uuid NOT NULL,
	artist_id uuid NOT NULL,
	aggregate_id varchar(12) NOT NULL,
	"number" numeric NOT NULL,
	ref_code varchar(255) NULL,
	"name" varchar(255) NOT NULL,
	urn varchar(255) NOT NULL,
	is_public bool NOT NULL,
	is_released bool NOT NULL,
	is_verified bool NOT NULL,
	is_active bool NOT NULL,
	description varchar(255) NULL,
	biography text NULL,
	nationality_iso_code text NULL,
	thumbnail_url text NULL,
	thumbnail_file_key text NULL,
	background_url text NULL,
	background_file_key text NULL,
	-- tags _text NOT NULL DEFAULT '{}',
  tags_json jsonb NOT NULL,
	event_type text NULL,
	event_version numeric NULL,
	event_timestamp timestamptz NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NOT NULL,
	created_by varchar(255) NULL,
	updated_by varchar(255) NULL,
	CONSTRAINT artist_revision_pkey PRIMARY KEY (id)
);

-- Foreign key: 
ALTER TABLE artist_revision ADD CONSTRAINT fk_artist_revision__artist_id___artist__id
FOREIGN KEY (artist_id) REFERENCES artist(id) ON DELETE CASCADE ON UPDATE CASCADE
;"""

    ddls = [
        create_uuid_ossp_extension_ddl, create_unaccent_extension_ddl,
        create_artist_table_ddl, create_artist_profile_ddl,
        create_artist_image_table_ddl, create_artist_revision_table_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)


def downgrade() -> None:
    drop_uuid_ossp_extension_ddl = 'DROP EXTENSION IF NOT EXISTS "uuid-ossp";'
    drop_unaccent_extension_ddl = "DROP EXTENSION IF NOT EXISTS unaccent;"
    drop_artist_set_tsv_trigger_ddl = "DROP TRIGGER IF EXISTS artist_set_tsv_trigger ON artist;"
    drop_artist_set_tsv_function_ddl = "DROP FUNCTION IF EXISTS artist_set_tsv;"
    drop_artist_revision_table_ddl = "DROP TABLE IF EXISTS artist_revision;"
    drop_artist_profile_table_ddl = "DROP TABLE IF EXISTS artist_profile;"
    drop_artist_image_table_ddl = "DROP TABLE IF EXISTS artist_image;"
    drop_artist_table_ddl = "DROP TABLE IF EXISTS artist;"

    ddls = [
        drop_uuid_ossp_extension_ddl, drop_unaccent_extension_ddl,
        drop_artist_set_tsv_trigger_ddl, drop_artist_set_tsv_function_ddl,
        drop_artist_revision_table_ddl, drop_artist_profile_table_ddl,
        drop_artist_image_table_ddl, drop_artist_table_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)
