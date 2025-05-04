"""create artist table, artist_detail materialized view, track table, track_detail materialized view

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
    tags,
    tsv
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

    search_artist_function_ddl = """
CREATE OR REPLACE FUNCTION public.search_artist(keyword text)
 RETURNS TABLE(tsv_criteria text, id uuid, aggregate_id character varying, urn character varying, name character varying, description character varying, biography text, nationality_iso_code character varying, thumbnail_file_key text, thumbnail_url text, background_file_key text, background_url text, is_public boolean, is_verified boolean, tags text[], tsv tsvector)
 LANGUAGE plpgsql
AS $function$
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
      ad.id,
      ad.aggregate_id,
      ad.urn,
      ad."name",
      ad.description,
      ad.biography,
      ad.nationality_iso_code,
      ad.thumbnail_file_key,
      ad.thumbnail_url,
      ad.background_file_key,
      ad.background_url,
      ad.is_public,
      ad.is_verified,
      ad.tags,
      ad.tsv
    FROM mv_artist_detail ad
    WHERE ad.is_public AND ad.tsv @@ to_tsquery('english', tsv_criteria);
END;
$function$
;"""

    create_track_table_ddl = """
-- Table: track
CREATE TABLE track (
	id uuid NOT NULL,
	aggregate_id varchar(16) NOT NULL,
	urn varchar(255) NOT NULL,
	ref_code varchar(100),
	"name" varchar(255) NOT NULL,
	description varchar(255),
	is_public bool NOT NULL,
	is_released bool NOT NULL,
	revision_number int,
	thumbnail_file_key text,
	thumbnail_url text,
    audio_file_m3u8_url text,
    audio_duration_second int NULL,
    official_released_date varchar(16),
	tags _text NOT NULL DEFAULT '{}', -- used for tsv trigger
	is_active bool NOT NULL,
    tsv tsvector,
	event_type text,
	event_version int,
	event_timestamp timestamptz,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NOT NULL,
	created_by varchar(255),
	updated_by varchar(255),
	CONSTRAINT track_aggregate_id_key UNIQUE (aggregate_id),
	CONSTRAINT track_pkey PRIMARY KEY (id),
	CONSTRAINT track_urn_key UNIQUE (urn)
);
CREATE INDEX idx_track__tsv ON track USING GIN (tsv);

-- Function: track_update_tsv
CREATE OR REPLACE FUNCTION track_update_tsv()
RETURNS TRIGGER AS $$
BEGIN
    NEW.tsv = to_tsvector('english', NEW.name || ' ' || unaccent(NEW.name) || ' ' || array_to_string(NEW.tags, ' ') || ' ' || unaccent(array_to_string(NEW.tags, ' ')));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql
;

-- Trigger: track_update_tsv_trigger
CREATE TRIGGER track_update_tsv_trigger
BEFORE INSERT OR UPDATE ON track
FOR EACH ROW
EXECUTE FUNCTION track_update_tsv()
;"""

    create_track_artist_table_ddl = """
CREATE TABLE track_artist (
    id uuid NOT NULL,
    track_id uuid NOT NULL,
    artist_id uuid NOT NULL,
	track_aggregate_id varchar(12) NOT NULL,
    artist_aggregate_id varchar(12) NOT NULL,
    is_active bool NOT NULL DEFAULT true,
    is_main_artist bool NOT NULL DEFAULT false,
    event_type text NULL,
    event_version int NULL,
    event_timestamp timestamptz NULL,
    created_at timestamptz NOT NULL,
    updated_at timestamptz NOT NULL,
    created_by varchar(255) NULL,
    updated_by varchar(255) NULL,
    CONSTRAINT track_artist_pkey PRIMARY KEY (id)
);

-- Foreign key:
ALTER TABLE track_artist ADD CONSTRAINT fk_track_artist__track_id___track__id
FOREIGN KEY (track_id) REFERENCES track(id) ON DELETE CASCADE ON UPDATE CASCADE
;
ALTER TABLE track_artist ADD CONSTRAINT fk_track_artist__artist_id___artist__id
FOREIGN KEY (artist_id) REFERENCES artist(id) ON DELETE CASCADE ON UPDATE CASCADE
;"""

    create_track_detail_materialized_view_ddl = """
CREATE MATERIALIZED VIEW public.mv_track_detail
TABLESPACE pg_default
AS SELECT id,
    aggregate_id,
    urn,
    name,
    description,
    is_public,
    is_released,
    thumbnail_file_key,
    thumbnail_url,
    audio_file_m3u8_url,
    audio_duration_second,
    official_released_date,
    tags,
    is_active,
    tsv,
    (( SELECT json_agg(ta.*) AS json_agg
           FROM ( SELECT artist.aggregate_id AS id,
                    artist.urn,
                    artist.name,
                    artist.description,
                    artist.is_public,
                    artist.is_verified,
                    artist.thumbnail_file_key,
                    artist.thumbnail_url
                   FROM artist
                  WHERE (artist.id IN ( SELECT track_artist.artist_id
                           FROM track_artist
                          WHERE track_artist.track_id = t.id))) ta))::jsonb AS artists_json
   FROM track t
  WHERE is_active
WITH DATA;"""

    refresh_mv_track_detail_view_function_ddl = """
CREATE OR REPLACE FUNCTION refresh_mv_track_detail()
RETURNS trigger AS $$
BEGIN
    REFRESH MATERIALIZED VIEW mv_track_detail;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql
;"""

    track_refresh_mv_track_detail_trigger_ddl = """
CREATE TRIGGER track_refresh_mv_track_detail_trigger
AFTER INSERT OR UPDATE OR DELETE ON track
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_mv_track_detail()
;"""

    track_artist_refresh_mv_track_detail_trigger_ddl = """
CREATE TRIGGER track_artist_refresh_mv_track_detail_trigger
AFTER INSERT OR UPDATE OR DELETE ON track_artist
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_mv_track_detail()
;"""

    search_track_function_ddl = """
CREATE OR REPLACE FUNCTION public.search_track(keyword text)
 RETURNS TABLE(tsv_criteria text, id uuid, aggregate_id character varying, urn character varying, name character varying, description character varying, is_public boolean, is_released boolean, thumbnail_file_key text, thumbnail_url text, audio_file_m3u8_url text, audio_duration_second int, official_released_date character varying, tags text[], is_active boolean, tsv tsvector, artists_json jsonb)
 LANGUAGE plpgsql
AS $function$
DECLARE
    words text[];
    tsv_criteria text;

BEGIN
    SELECT
    string_to_array(keyword, ' ')
INTO
    words;

SELECT
    array_to_string(words, ':* | ')
INTO
    tsv_criteria;

SELECT
    tsv_criteria || ':*'
INTO
    tsv_criteria;

RETURN QUERY
    SELECT
    tsv_criteria,
    td.id,
    td.aggregate_id,
    td.urn,
    td."name",
    td.description,
    td.is_public,
    td.is_released,
    td.thumbnail_file_key,
    td.thumbnail_url,
    td.audio_file_m3u8_url,
    td.audio_duration_second,
    td.official_released_date,
    td.tags,
    td.is_active,
    td.tsv,
    td.artists_json
FROM
    mv_track_detail td
WHERE
    td.is_public
    AND td.tsv @@ to_tsquery('english', tsv_criteria);
END;

$function$
;"""

    create_playlist_table_ddl = """
CREATE TABLE public.playlist (
	id uuid NOT NULL,
	urn varchar(255) NOT NULL,
	aggregate_id varchar(12) NOT NULL,
	"name" varchar(255) NOT NULL,
	is_public bool DEFAULT true NOT NULL,
	is_active bool DEFAULT true NOT NULL,
	thumbnail_url text NULL,
	track_ids _text DEFAULT '{}'::text[] NOT NULL,
	tsv tsvector NULL,
	event_type text NULL,
	event_version int4 NULL,
	event_timestamp timestamptz NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NOT NULL,
	created_by varchar(255) NULL,
	updated_by varchar(255) NULL,
	CONSTRAINT playlist_pkey PRIMARY KEY (id)
);

-- DROP FUNCTION public.playlist_update_tsv();
CREATE OR REPLACE FUNCTION public.playlist_update_tsv()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    NEW.tsv = to_tsvector('english', NEW.name || ' ' || unaccent(NEW.name));
    RETURN NEW;
END;
$function$;

-- Trigger: playlist_update_tsv_trigger
CREATE TRIGGER playlist_update_tsv_trigger
BEFORE INSERT OR UPDATE ON playlist
FOR EACH ROW
EXECUTE FUNCTION playlist_update_tsv()
;
"""

    create_playlist_detail_materialized_view_ddl = """
CREATE MATERIALIZED VIEW public.mv_playlist_detail
TABLESPACE pg_default
AS SELECT
    p.id,
    p.aggregate_id,
    p.urn,
    p."name",
    p.is_public,
    p.thumbnail_url,
    p.created_by,
    p.updated_by,
    p.created_at,
    p.updated_at,
    p.is_active,
    p.tsv,
    (SELECT
        json_agg(t0.*) AS json_agg
    FROM
        (SELECT * FROM mv_track_detail mtd
            WHERE
                mtd.aggregate_id::text = ANY (p.track_ids)
            ORDER BY
                array_position(p.track_ids, mtd.aggregate_id)
            ) AS t0
    )::jsonb AS tracks_json
   FROM playlist p
   WHERE p.is_active
WITH DATA;

CREATE OR REPLACE FUNCTION refresh_mv_playlist_detail()
RETURNS trigger AS $$
BEGIN
  REFRESH MATERIALIZED VIEW mv_playlist_detail;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql
;

CREATE TRIGGER playlist_refresh_mv_playlist_detail_trigger
AFTER INSERT OR UPDATE OR DELETE ON playlist
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_mv_playlist_detail()
;
    """

    search_playlist_function_ddl = """
CREATE OR REPLACE FUNCTION public.search_playlist(keyword text)
 RETURNS TABLE(tsv_criteria text, id uuid, aggregate_id character varying, urn character varying, name character varying, is_public boolean, is_active boolean, thumbnail_url text, tsv tsvector, tracks_json jsonb)
 LANGUAGE plpgsql
AS $function$
DECLARE
    words text[];
    tsv_criteria text;

BEGIN
    SELECT
    string_to_array(keyword, ' ')
INTO
    words;

SELECT
    array_to_string(words, ':* | ')
INTO
    tsv_criteria;

SELECT
    tsv_criteria || ':*'
INTO
    tsv_criteria;

RETURN QUERY
    SELECT
    tsv_criteria,
    pd.id,
    pd.aggregate_id,
    pd.urn,
    pd."name",
    pd.is_public,
    pd.is_active,
    pd.thumbnail_url,
    pd.tsv,
    pd.tracks_json
FROM
    mv_playlist_detail pd
WHERE
    pd.is_public
    AND pd.tsv @@ to_tsquery('english', tsv_criteria);
END;

$function$
;"""

    ddls = [
        create_uuid_ossp_extension_ddl, create_unaccent_extension_ddl,
        create_artist_table_ddl, create_artist_detail_materialized_view_ddl,
        refresh_mv_artist_detail_view_function_ddl,
        artist_refresh_mv_artist_detail_trigger_ddl, search_artist_function_ddl,
        create_track_table_ddl, create_track_artist_table_ddl,
        create_track_detail_materialized_view_ddl,
        refresh_mv_track_detail_view_function_ddl,
        track_refresh_mv_track_detail_trigger_ddl,
        track_artist_refresh_mv_track_detail_trigger_ddl,
        search_track_function_ddl, create_playlist_table_ddl,
        create_playlist_detail_materialized_view_ddl,
        search_playlist_function_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)


def downgrade() -> None:
    drop_uuid_ossp_extension_ddl = 'DROP EXTENSION IF NOT EXISTS "uuid-ossp";'
    drop_unaccent_extension_ddl = "DROP EXTENSION IF NOT EXISTS unaccent;"
    drop_artist_table_ddl = "DROP TABLE IF EXISTS artist;"
    drop_search_artist_function_ddl = "DROP FUNCTION IF EXISTS search_artist;"
    drop_artist_refresh_mv_artist_detail_trigger = "DROP TRIGGER IF EXISTS artist_refresh_mv_artist_detail_trigger;"
    drop_refresh_mv_artist_detail_function = "DROP FUNCTION IF EXISTS refresh_mv_artist_detail;"
    drop_artist_detail_materialized_view = "DROP MATERIALIZED VIEW mv_artist_detail;"
    drop_search_track_function_ddl = "DROP FUNCTION IF EXISTS search_track;"
    drop_track_refresh_mv_track_detail_trigger_ddl = "DROP TRIGGER IF EXISTS track_refresh_mv_track_detail_trigger;"
    drop_refresh_mv_track_detail_view_function_ddl = "DROP FUNCTION IF EXISTS refresh_mv_track_detail;"
    drop_track_detail_materialized_view = "DROP MATERIALIZED VIEW mv_track_detail;"
    drop_track_artist_table_ddl = "DROP TABLE IF EXISTS track_artist;"
    drop_track_table_ddl = "DROP TABLE IF EXISTS track;"
    drop_playlist_table_ddl = "DROP TABLE IF EXISTS playlist;"
    drop_playlist_detail_materialized_view_ddl = "DROP MATERIALIZED VIEW IF EXISTS mv_playlist_detail;"
    drop_playlist_refresh_mv_playlist_detail_trigger_ddl = "DROP TRIGGER IF EXISTS playlist_refresh_mv_playlist_detail_trigger;"
    drop_search_playlist_function_ddl = "DROP FUNCTION IF EXISTS search_playlist;"

    ddls = [
        drop_uuid_ossp_extension_ddl, drop_unaccent_extension_ddl,
        drop_artist_table_ddl, drop_search_artist_function_ddl,
        drop_artist_refresh_mv_artist_detail_trigger,
        drop_artist_detail_materialized_view,
        drop_refresh_mv_artist_detail_function, drop_search_track_function_ddl,
        drop_track_refresh_mv_track_detail_trigger_ddl,
        drop_refresh_mv_track_detail_view_function_ddl,
        drop_track_detail_materialized_view, drop_track_artist_table_ddl,
        drop_track_table_ddl, drop_playlist_table_ddl,
        drop_playlist_refresh_mv_playlist_detail_trigger_ddl,
        drop_search_playlist_function_ddl,
        drop_playlist_detail_materialized_view_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)
