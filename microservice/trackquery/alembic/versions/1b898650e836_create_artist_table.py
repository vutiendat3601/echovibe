"""create tables: track, track_detail, track_image, track_revision

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

    create_track_table_ddl = """
-- Table: track
CREATE TABLE track (
	id uuid NOT NULL,
	aggregate_id varchar(12) NOT NULL,
	urn varchar(255) NOT NULL,
	ref_code varchar(100) NULL,
	revision_number numeric NOT NULL,
	is_public bool NOT NULL,
	is_released bool NOT NULL,
	is_active bool NOT NULL,
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
	CONSTRAINT track_aggregate_id_key UNIQUE (aggregate_id),
	CONSTRAINT track_pkey PRIMARY KEY (id),
	CONSTRAINT track_urn_key UNIQUE (urn)
);
CREATE INDEX idx_track__tsv ON track USING GIN (tsv);

-- Function: track_set_tsv
CREATE OR REPLACE FUNCTION track_set_tsv()
RETURNS trigger AS $$
DECLARE
  track_name text;
BEGIN
    SELECT COALESCE(name, '') INTO track_name
    FROM track_detail WHERE aggregate_id = NEW.aggregate_id;
    
    NEW.tsv = to_tsvector('english', track_name || ' ' || unaccent(track_name) || ' ' || array_to_string(NEW.tags, ' ') || ' ' || unaccent(array_to_string(NEW.tags, ' ')));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: track_set_tsv_trigger
CREATE TRIGGER track_set_tsv_trigger
BEFORE INSERT OR UPDATE ON track
FOR EACH ROW
EXECUTE FUNCTION track_set_tsv();

CREATE OR REPLACE FUNCTION track_update_tsv(update_aggregate_id TEXT)
RETURNS void AS $$
DECLARE
    track_name text;
BEGIN
    SELECT COALESCE(name, '') INTO track_name
    FROM track_detail WHERE aggregate_id = update_aggregate_id;
    
    UPDATE track
    SET tsv = to_tsvector('english', track_name || unaccent(track_name) || array_to_string(tags, ' ') || unaccent(array_to_string(tags, ' ')))
    WHERE aggregate_id = update_aggregate_id;
END;
$$ LANGUAGE plpgsql;
"""

    create_track_detail_ddl = """
CREATE TABLE track_detail (
	id uuid NOT NULL,
	track_id uuid NULL,
	aggregate_id varchar(12) NOT NULL,
	ref_code varchar(255) NULL,
	"name" varchar(255) NOT NULL,
	description varchar(255) NULL,
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
	CONSTRAINT track_detail_aggregate_id_key UNIQUE (aggregate_id),
	CONSTRAINT track_detail_track_id_key UNIQUE (track_id),
	CONSTRAINT track_detail_pkey PRIMARY KEY (id)
);

-- Foreign key:
ALTER TABLE track_detail ADD CONSTRAINT fk_track_detail__track_id___track__id
FOREIGN KEY (track_id) REFERENCES track(id) ON DELETE CASCADE ON UPDATE CASCADE;


-- Function: track_set_tsv
CREATE OR REPLACE FUNCTION on_track_detail_after_insert_update()
RETURNS trigger AS $$
BEGIN
    PERFORM track_update_tsv(NEW.aggregate_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: track_detail_after_insert_update_trigger
CREATE TRIGGER track_detail_after_insert_update_trigger
AFTER INSERT OR UPDATE ON track_detail
FOR EACH ROW
EXECUTE FUNCTION on_track_detail_after_insert_update();
"""

    create_track_image_table_ddl = """
CREATE TABLE track_image (
	id uuid NOT NULL,
	track_id uuid NOT NULL,
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
	CONSTRAINT track_image_pkey PRIMARY KEY (id)
);

-- Foreign key: 
ALTER TABLE track_image ADD CONSTRAINT fk_track_image__track_id___track__id
FOREIGN KEY (track_id) REFERENCES track(id) ON DELETE CASCADE ON UPDATE CASCADE
;"""

    create_track_revision_table_ddl = """
CREATE TABLE track_revision (
	id uuid NOT NULL,
	track_id uuid NOT NULL,
	aggregate_id varchar(12) NOT NULL,
	"number" numeric NOT NULL,
	ref_code varchar(255) NULL,
	"name" varchar(255) NOT NULL,
	urn varchar(255) NOT NULL,
	is_public bool NOT NULL,
	is_released bool NOT NULL,
	is_active bool NOT NULL,
	description varchar(255) NULL,
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
	CONSTRAINT track_revision_pkey PRIMARY KEY (id)
);

-- Foreign key: 
ALTER TABLE track_revision ADD CONSTRAINT fk_track_revision__track_id___track__id
FOREIGN KEY (track_id) REFERENCES track(id) ON DELETE CASCADE ON UPDATE CASCADE
;"""
    search_track_function_ddl = """
    CREATE OR REPLACE FUNCTION search_track(keyword text)
    RETURNS TABLE (
        tsv_criteria text,
        id uuid,
        aggregate_id varchar,
        urn varchar,
        "name" varchar,
        description varchar,
        thumbnail_file_key text,
        thumbnail_url text,
        background_file_key text,
        background_url text,
        is_public boolean,
        tags text[],
        tsv tsvector
    )
    LANGUAGE PLPGSQL AS $function$
    DECLARE
        words text[];
        tsv_criteria text;
    BEGIN
        SELECT string_to_array(keyword, ' ') INTO words;
        SELECT array_to_string(words, ':* | ') INTO tsv_criteria;
        SELECT tsv_criteria || ':*' INTO tsv_criteria;
        RETURN QUERY
        SELECT
        tsv_criteria,
        a.id uuid,
        a.aggregate_id,
        a.urn,
        a."name",
        a.description,
        a.biography,
        a.nationality_iso_code,
        a.thumbnail_file_key,
        a.thumbnail_url,
        a.background_file_key,
        a.background_url,
        a.is_public,
        a.is_verified,
        a.tags,
        a.tsv
        FROM track a
        WHERE a.is_active AND a.tsv @@ to_tsquery('english', tsv_criteria);
    END;
    $function$
    ;"""
    ddls = [
        create_uuid_ossp_extension_ddl, create_unaccent_extension_ddl,
        create_track_table_ddl, create_track_detail_ddl,
        create_track_image_table_ddl, create_track_revision_table_ddl,
        search_track_function_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)


def downgrade() -> None:
    drop_uuid_ossp_extension_ddl = 'DROP EXTENSION IF NOT EXISTS "uuid-ossp";'
    drop_unaccent_extension_ddl = "DROP EXTENSION IF NOT EXISTS unaccent;"
    drop_track_set_tsv_trigger_ddl = "DROP TRIGGER IF EXISTS track_set_tsv_trigger ON track;"
    drop_track_set_tsv_function_ddl = "DROP FUNCTION IF EXISTS track_set_tsv;"
    drop_track_revision_table_ddl = "DROP TABLE IF EXISTS track_revision;"
    drop_track_detail_table_ddl = "DROP TABLE IF EXISTS track_detail;"
    drop_track_image_table_ddl = "DROP TABLE IF EXISTS track_image;"
    drop_track_table_ddl = "DROP TABLE IF EXISTS track;"

    ddls = [
        drop_uuid_ossp_extension_ddl, drop_unaccent_extension_ddl,
        drop_track_set_tsv_trigger_ddl, drop_track_set_tsv_function_ddl,
        drop_track_revision_table_ddl, drop_track_detail_table_ddl,
        drop_track_image_table_ddl, drop_track_table_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)
