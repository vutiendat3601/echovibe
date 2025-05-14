"""create activity table

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

    create_activity_table_ddl = """
CREATE TABLE activity (
    id uuid NOT NULL,
    aggregate_id varchar(12) NOT NULL,
    session_id varchar(12),
    description varchar(255) NULL,
    type varchar(255) NOT NULL,
    data_json jsonb NULL,
    created_at timestamptz DEFAULT current_timestamp,
    fingerprint varchar(255),
    created_by varchar(255),
    CONSTRAINT activity_pkey PRIMARY KEY (id),
    CONSTRAINT activity__session_id___key UNIQUE (session_id)
);
"""

    create_aritst_like_table_ddl = """
CREATE TABLE public.artist_like (
	id uuid NOT NULL,
	aggregate_id varchar(12) NOT NULL,
	user_id varchar(255) NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamptz DEFAULT current_timestamp,
    updated_at timestamptz DEFAULT current_timestamp,
    created_by varchar(255),
    updated_by varchar(255),
	CONSTRAINT artist_like_pkey PRIMARY KEY (id),
    CONSTRAINT artist_like___user_id__aggregate_id___key UNIQUE (user_id, aggregate_id)
);
"""

    create_artist_detail_page_view_table_ddl = """
CREATE TABLE public.artist_detail_page_view (
	id uuid NOT NULL,
	aggregate_id varchar(12) NOT NULL,
	user_id varchar(255) NOT NULL,
    duration_second int NOT NULL DEFAULT 0,
    session_id varchar(12) NOT NULL,
    created_at timestamptz DEFAULT current_timestamp,
    updated_at timestamptz DEFAULT current_timestamp,
    created_by varchar(255),
    updated_by varchar(255),
	CONSTRAINT aritst_detail_page_view__pkey PRIMARY KEY (id),
    CONSTRAINT aritst_detail_page_view___session_id___key UNIQUE (session_id)
);
"""

    create_artist_stats_table_ddl = """
CREATE TABLE public.artist_stats (
	id uuid NOT NULL,
    aggregate_id varchar(12) NOT NULL,
	total_detail_page_views bigint NOT NULL DEFAULT 0,
	total_likes bigint NOT NULL DEFAULT 0,
    created_at timestamptz DEFAULT current_timestamp,
    updated_at timestamptz DEFAULT current_timestamp,
    created_by varchar(255),
    updated_by varchar(255),
	CONSTRAINT artist_stats__pkey PRIMARY KEY (id)
);
"""

    create_artist_recommendation_table_ddl = """
CREATE TABLE public.artist_recommendation (
    id uuid NOT NULL,
    aggregate_id varchar(12) NOT NULL,
    most_popular_track_ids text[] NOT NULL, -- listen count + like count
    most_listened_track_ids text[] NOT NULL,
    most_listened_track_ids_current_month text[] NOT NULL,
    created_at timestamptz DEFAULT current_timestamp,
    updated_at timestamptz DEFAULT current_timestamp,
    created_by varchar(255),
    updated_by varchar(255),
    CONSTRAINT artist_recommendation__pkey PRIMARY KEY (id),
    CONSTRAINT artist_recommendation__aggregate_id___key UNIQUE (aggregate_id)
);
"""
    create_artist_stats_detail_view_ddl = """
CREATE OR REPLACE VIEW public.v_artist_stats_detail
AS SELECT _as.id,
    _as.aggregate_id,
    _as.total_detail_page_views,
    _as.total_likes,
    _as.created_at,
    _as.updated_at,
    _as.created_by,
    _as.updated_by,
    ar.id AS artist_recommendation_id,
    ar.most_popular_track_ids,
    ar.most_listened_track_ids,
    ar.most_listened_track_ids_current_month
   FROM artist_stats _as
     LEFT JOIN artist_recommendation ar ON _as.aggregate_id::text = ar.aggregate_id::text
;"""

    create_track_like_table_ddl = """
CREATE TABLE public.track_like (
	id uuid NOT NULL,
	aggregate_id varchar NOT NULL,
	user_id varchar(255) NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamptz DEFAULT current_timestamp,
    updated_at timestamptz DEFAULT current_timestamp,
    created_by varchar(255),
    updated_by varchar(255),
	CONSTRAINT track_like_pkey PRIMARY KEY (id),
    CONSTRAINT track_like___user_id__aggregate_id___key UNIQUE (user_id, aggregate_id)
);
"""

    create_track_detail_page_view_table_ddl = """
CREATE TABLE public.track_detail_page_view (
	id uuid NOT NULL,
	aggregate_id varchar(12) NOT NULL,
	user_id varchar(255) NOT NULL,
    duration_second int NOT NULL DEFAULT 0,
    session_id varchar(12) NOT NULL,
    created_at timestamptz DEFAULT current_timestamp,
    updated_at timestamptz DEFAULT current_timestamp,
    created_by varchar(255),
    updated_by varchar(255),
	CONSTRAINT track_detail_page_view__pkey PRIMARY KEY (id),
    CONSTRAINT track_detail_page_view___session_id___key UNIQUE (session_id)
);
"""

    create_track_listen_table_ddl = """
CREATE TABLE public.track_listen (
	id uuid NOT NULL,
	aggregate_id varchar NOT NULL,
	user_id varchar(255) NOT NULL,
    duration_second int NOT NULL DEFAULT 0,
    session_id varchar(12) NOT NULL,
    created_at timestamptz DEFAULT current_timestamp,
    updated_at timestamptz DEFAULT current_timestamp,
    created_by varchar(255),
    updated_by varchar(255),
	CONSTRAINT track_listen__pkey PRIMARY KEY (id),
    CONSTRAINT track_listen___session_id___key UNIQUE (session_id)
);
"""

    create_track_stats_table_ddl = """
CREATE TABLE public.track_stats (
	id uuid NOT NULL,
    aggregate_id varchar(12) NOT NULL,
	total_detail_page_views bigint NOT NULL DEFAULT 0,
	total_likes bigint NOT NULL DEFAULT 0,
    total_listens bigint NOT NULL DEFAULT 0,
    created_at timestamptz DEFAULT current_timestamp,
    updated_at timestamptz DEFAULT current_timestamp,
    created_by varchar(255),
    updated_by varchar(255),
	CONSTRAINT track_stats__pkey PRIMARY KEY (id)
);
"""

    create_user_playlist_table_ddl = """
CREATE TABLE public.user_playlist (
	id uuid NOT NULL,
    playlist_id varchar(12) NOT NULL,
	user_id varchar(255) NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    created_at timestamptz DEFAULT current_timestamp,
    updated_at timestamptz DEFAULT current_timestamp,
    created_by varchar(255),
    updated_by varchar(255),
	CONSTRAINT user_playlist__pkey PRIMARY KEY (id)
);
"""

    create_user_data_table_ddl = """
CREATE TABLE public.user_data (
	id uuid NOT NULL,
	user_id varchar(255) NOT NULL,
	data_json jsonb NOT NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	created_by varchar(255) NULL,
	updated_by varchar(255) NULL,
	CONSTRAINT user_data__pkey PRIMARY KEY (id),
	CONSTRAINT user_data__user_id___key UNIQUE (user_id)
);
"""

    create_user_stats_materialized_view_ddl = """
CREATE MATERIALIZED VIEW public.mv_user_usage_data
TABLESPACE pg_default
AS SELECT id,
    user_id,
    data_json,
    updated_at,
    ( SELECT array_agg(tl.aggregate_id) AS array_agg
           FROM track_like tl
          WHERE tl.is_active AND tl.user_id::text = ud.user_id::text) AS liked_track_ids,
    ( SELECT array_agg(al.aggregate_id) AS array_agg
           FROM artist_like al
          WHERE al.is_active AND al.user_id::text = ud.user_id::text) AS liked_artist_ids,
    ( SELECT array_agg(up.playlist_id) AS array_agg
           FROM user_playlist up
          WHERE up.is_active AND up.user_id::text = ud.user_id::text) AS created_playlist_ids
   FROM user_data ud
WITH DATA;

CREATE OR REPLACE FUNCTION refresh_mv_user_usage_data()
RETURNS trigger AS $$
BEGIN
  REFRESH MATERIALIZED VIEW public.mv_user_usage_data;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER user_data__refresh_mv_user_usage_data_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.user_data
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_mv_user_usage_data();

CREATE TRIGGER track_like__refresh_mv_user_usage_data_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.track_like
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_mv_user_usage_data();

CREATE TRIGGER artist_like__refresh_mv_user_usage_data_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.artist_like
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_mv_user_usage_data();

CREATE TRIGGER user_playlist__refresh_mv_user_usage_data_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.user_playlist
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_mv_user_usage_data();
"""

    create_track_stats_report_view_ddl = """
CREATE OR REPLACE VIEW public.v_track_stats_report
AS SELECT COALESCE(tdpv1.aggregate_id, tl1.aggregate_id) AS aggregate_id,
    COALESCE(tdpv1.year, tl1.year) AS year,
    COALESCE(tdpv1.month, tl1.month) AS month,
    COALESCE(tdpv1.total_track_detail_page_view_duration_seconds, 0::bigint) AS total_track_detail_page_view_duration_seconds,
    COALESCE(tl1.total_track_listen_duration_seconds, 0::bigint) AS total_track_listen_duration_seconds,
    COALESCE(tdpv1.total_track_detail_page_views, 0::bigint) AS total_track_detail_page_views,
    COALESCE(tl1.total_track_listens, 0::bigint) AS total_track_listens,
    ( SELECT (COALESCE(tdpv1.total_track_detail_page_view_duration_seconds, 0::bigint) / 60 * 3 + COALESCE(tl1.total_track_listen_duration_seconds, 0::bigint) / 60 * 4) / 7 + (COALESCE(tdpv1.total_track_detail_page_views, 0::bigint) * 1 + COALESCE(tl1.total_track_listens, 0::bigint) * 2) / 3) AS score
   FROM ( SELECT tdpv0.aggregate_id,
            tdpv0.created_at_year AS year,
            tdpv0.created_at_month AS month,
            sum(tdpv0.duration_second) AS total_track_detail_page_view_duration_seconds,
            count(tdpv0.duration_second) AS total_track_detail_page_views
           FROM ( SELECT tdpv.id,
                    tdpv.aggregate_id,
                    tdpv.user_id,
                    tdpv.duration_second,
                    tdpv.session_id,
                    tdpv.created_at,
                    tdpv.updated_at,
                    tdpv.created_by,
                    tdpv.updated_by,
                    EXTRACT(year FROM tdpv.created_at) AS created_at_year,
                    EXTRACT(month FROM tdpv.created_at) AS created_at_month
                   FROM track_detail_page_view tdpv) tdpv0
          GROUP BY tdpv0.aggregate_id, tdpv0.created_at_year, tdpv0.created_at_month) tdpv1
     FULL JOIN ( SELECT tl0.aggregate_id,
            tl0.created_at_year AS year,
            tl0.created_at_month AS month,
            sum(tl0.duration_second) AS total_track_listen_duration_seconds,
            count(tl0.duration_second) AS total_track_listens
           FROM ( SELECT tl.id,
                    tl.aggregate_id,
                    tl.user_id,
                    tl.duration_second,
                    tl.session_id,
                    tl.created_at,
                    tl.updated_at,
                    tl.created_by,
                    tl.updated_by,
                    EXTRACT(year FROM tl.created_at) AS created_at_year,
                    EXTRACT(month FROM tl.created_at) AS created_at_month
                   FROM track_listen tl) tl0
          GROUP BY tl0.aggregate_id, tl0.created_at_year, tl0.created_at_month) tl1 ON tdpv1.aggregate_id::text = tl1.aggregate_id::text AND tdpv1.year = tl1.year AND tdpv1.month = tl1.month
;"""

    create_track_stats_report_current_month_view_ddl = """
CREATE OR REPLACE VIEW public.v_track_stats_report_current_month
AS SELECT COALESCE(tdpv1.aggregate_id, tl1.aggregate_id) AS aggregate_id,
    COALESCE(tdpv1.year, tl1.year) AS year,
    COALESCE(tdpv1.month, tl1.month) AS month,
    COALESCE(tdpv1.total_track_detail_page_view_duration_seconds, 0::bigint) AS total_track_detail_page_view_duration_seconds,
    COALESCE(tl1.total_track_listen_duration_seconds, 0::bigint) AS total_track_listen_duration_seconds,
    COALESCE(tdpv1.total_track_detail_page_views, 0::bigint) AS total_track_detail_page_views,
    COALESCE(tl1.total_track_listens, 0::bigint) AS total_track_listens,
    ( SELECT (COALESCE(tdpv1.total_track_detail_page_view_duration_seconds, 0::bigint) / 60 * 3 + COALESCE(tl1.total_track_listen_duration_seconds, 0::bigint) / 60 * 4) / 7 + (COALESCE(tdpv1.total_track_detail_page_views, 0::bigint) * 1 + COALESCE(tl1.total_track_listens, 0::bigint) * 2) / 3) AS score
   FROM ( SELECT tdpv0.aggregate_id,
            tdpv0.created_at_year AS year,
            tdpv0.created_at_month AS month,
            sum(tdpv0.duration_second) AS total_track_detail_page_view_duration_seconds,
            count(tdpv0.duration_second) AS total_track_detail_page_views
           FROM ( SELECT tdpv.id,
                    tdpv.aggregate_id,
                    tdpv.user_id,
                    tdpv.duration_second,
                    tdpv.session_id,
                    tdpv.created_at,
                    tdpv.updated_at,
                    tdpv.created_by,
                    tdpv.updated_by,
                    EXTRACT(year FROM tdpv.created_at) AS created_at_year,
                    EXTRACT(month FROM tdpv.created_at) AS created_at_month
                   FROM track_detail_page_view tdpv
                  WHERE to_date(((EXTRACT(year FROM CURRENT_TIMESTAMP) || '-'::text) || EXTRACT(month FROM CURRENT_TIMESTAMP)) || '-01'::text, 'YYYY-MM-DD'::text) <= tdpv.created_at) tdpv0
          GROUP BY tdpv0.aggregate_id, tdpv0.created_at_year, tdpv0.created_at_month) tdpv1
     FULL JOIN ( SELECT tl0.aggregate_id,
            tl0.created_at_year AS year,
            tl0.created_at_month AS month,
            sum(tl0.duration_second) AS total_track_listen_duration_seconds,
            count(tl0.duration_second) AS total_track_listens
           FROM ( SELECT tl.id,
                    tl.aggregate_id,
                    tl.user_id,
                    tl.duration_second,
                    tl.session_id,
                    tl.created_at,
                    tl.updated_at,
                    tl.created_by,
                    tl.updated_by,
                    EXTRACT(year FROM tl.created_at) AS created_at_year,
                    EXTRACT(month FROM tl.created_at) AS created_at_month
                   FROM track_listen tl
                  WHERE to_date(((EXTRACT(year FROM CURRENT_TIMESTAMP) || '-'::text) || EXTRACT(month FROM CURRENT_TIMESTAMP)) || '-01'::text, 'YYYY-MM-DD'::text) <= tl.created_at) tl0
          GROUP BY tl0.aggregate_id, tl0.created_at_year, tl0.created_at_month) tl1 ON tdpv1.aggregate_id::text = tl1.aggregate_id::text AND tdpv1.year = tl1.year AND tdpv1.month = tl1.month
;"""

    create_artist_stats_report_view_ddl = """
CREATE OR REPLACE VIEW public.v_artist_stats_report
AS SELECT aggregate_id,
    year,
    month,
    COALESCE(total_artist_detail_page_view_duration_seconds, 0::bigint) AS total_artist_detail_page_view_duration_seconds,
    COALESCE(total_artist_detail_page_views, 0::bigint) AS total_artist_detail_page_views,
    ( SELECT COALESCE(adpv1.total_artist_detail_page_view_duration_seconds, 0::bigint) / 60 + COALESCE(adpv1.total_artist_detail_page_views, 0::bigint)) AS score
   FROM ( SELECT adpv0.aggregate_id,
            adpv0.created_at_year AS year,
            adpv0.created_at_month AS month,
            sum(adpv0.duration_second) AS total_artist_detail_page_view_duration_seconds,
            count(adpv0.duration_second) AS total_artist_detail_page_views
           FROM ( SELECT adpv.id,
                    adpv.aggregate_id,
                    adpv.user_id,
                    adpv.duration_second,
                    adpv.session_id,
                    adpv.created_at,
                    adpv.updated_at,
                    adpv.created_by,
                    adpv.updated_by,
                    EXTRACT(year FROM adpv.created_at) AS created_at_year,
                    EXTRACT(month FROM adpv.created_at) AS created_at_month
                   FROM artist_detail_page_view adpv) adpv0
          GROUP BY adpv0.aggregate_id, adpv0.created_at_year, adpv0.created_at_month) adpv1
;"""

    create_artist_stats_report_current_month_view_ddl = """
CREATE OR REPLACE VIEW public.v_artist_stats_report_current_month
AS SELECT aggregate_id,
    year,
    month,
    COALESCE(total_artist_detail_page_view_duration_seconds, 0::bigint) AS total_artist_detail_page_view_duration_seconds,
    COALESCE(total_artist_detail_page_views, 0::bigint) AS total_artist_detail_page_views,
    ( SELECT COALESCE(adpv1.total_artist_detail_page_view_duration_seconds, 0::bigint) / 60 + COALESCE(adpv1.total_artist_detail_page_views, 0::bigint)) AS score
   FROM ( SELECT adpv0.aggregate_id,
            adpv0.created_at_year AS year,
            adpv0.created_at_month AS month,
            sum(adpv0.duration_second) AS total_artist_detail_page_view_duration_seconds,
            count(adpv0.duration_second) AS total_artist_detail_page_views
           FROM ( SELECT adpv.id,
                    adpv.aggregate_id,
                    adpv.user_id,
                    adpv.duration_second,
                    adpv.session_id,
                    adpv.created_at,
                    adpv.updated_at,
                    adpv.created_by,
                    adpv.updated_by,
                    EXTRACT(year FROM adpv.created_at) AS created_at_year,
                    EXTRACT(month FROM adpv.created_at) AS created_at_month
                   FROM artist_detail_page_view adpv
                  WHERE to_date(((EXTRACT(year FROM CURRENT_TIMESTAMP) || '-'::text) || EXTRACT(month FROM CURRENT_TIMESTAMP)) || '-01'::text, 'YYYY-MM-DD'::text) <= adpv.created_at) adpv0
          GROUP BY adpv0.aggregate_id, adpv0.created_at_year, adpv0.created_at_month) adpv1
;"""

    create_find_track_stats_report_order_by_avg_score_desc_function_ddl = """
CREATE OR REPLACE FUNCTION find_track_stats_report_order_by_avg_score_desc(aggregate_ids TEXT[])
RETURNS TABLE (
    aggregate_id CHARACTER VARYING,
    total_track_detail_page_view_duration_seconds BIGINT,
    total_track_detail_page_views BIGINT,
    total_track_listen_duration_seconds BIGINT,
    total_track_listens BIGINT,
    avg_score DOUBLE PRECISION
)
AS $$
BEGIN
  RETURN QUERY
  SELECT
    tsr.aggregate_id,
    SUM(tsr.total_track_detail_page_view_duration_seconds)::bigint AS total_track_detail_page_view_duration_seconds,
    SUM(tsr.total_track_detail_page_views)::bigint AS total_track_detail_page_views,
    SUM(tsr.total_track_listen_duration_seconds)::bigint AS total_track_listen_duration_seconds,
    SUM(tsr.total_track_listens)::bigint AS total_track_listens,
    AVG(score)::DOUBLE PRECISION AS avg_score
  FROM
    v_track_stats_report tsr
  WHERE
    tsr.aggregate_id = ANY(aggregate_ids)
  GROUP BY
    tsr.aggregate_id
  ORDER BY
    avg(tsr.score) DESC;
END;
$$ LANGUAGE plpgsql;
"""

    create_find_track_stats_report_order_by_total_track_listens_desc_function_ddl = """
CREATE OR REPLACE FUNCTION find_track_stats_report_order_by_total_track_listens_desc(aggregate_ids TEXT[])
RETURNS TABLE (
    aggregate_id CHARACTER VARYING,
    total_track_detail_page_view_duration_seconds BIGINT,
    total_track_detail_page_views BIGINT,
    total_track_listen_duration_seconds BIGINT,
    total_track_listens BIGINT,
    avg_score DOUBLE PRECISION
)
AS $$
BEGIN
  RETURN QUERY
  SELECT
    tsr.aggregate_id,
    SUM(tsr.total_track_detail_page_view_duration_seconds)::bigint AS total_track_detail_page_view_duration_seconds,
    SUM(tsr.total_track_detail_page_views)::bigint AS total_track_detail_page_views,
    SUM(tsr.total_track_listen_duration_seconds)::bigint AS total_track_listen_duration_seconds,
    SUM(tsr.total_track_listens)::bigint AS total_track_listens,
    AVG(score)::DOUBLE PRECISION AS avg_score
  FROM
    v_track_stats_report tsr
  WHERE
    tsr.aggregate_id = ANY(aggregate_ids)
  GROUP BY
    tsr.aggregate_id
  ORDER BY
    SUM(tsr.total_track_listens) DESC;
END;
$$ LANGUAGE plpgsql;
"""
    create_find_track_stats_report_order_by_total_track_listens_desc_current_month_function_ddl = """
CREATE OR REPLACE FUNCTION public.find_track_stats_report_order_by_total_track_listens_desc_cm(aggregate_ids text[])
 RETURNS TABLE(aggregate_id character varying, total_track_detail_page_view_duration_seconds bigint, total_track_detail_page_views bigint, total_track_listen_duration_seconds bigint, total_track_listens bigint, avg_score double precision)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    tsrcm.aggregate_id,
    SUM(tsrcm.total_track_detail_page_view_duration_seconds)::bigint AS total_track_detail_page_view_duration_seconds,
    SUM(tsrcm.total_track_detail_page_views)::bigint AS total_track_detail_page_views,
    SUM(tsrcm.total_track_listen_duration_seconds)::bigint AS total_track_listen_duration_seconds,
    SUM(tsrcm.total_track_listens)::bigint AS total_track_listens,
    AVG(score)::DOUBLE PRECISION AS avg_score
  FROM
    v_track_stats_report_current_month tsrcm
  WHERE
    tsrcm.aggregate_id = ANY(aggregate_ids)
  GROUP BY
    tsrcm.aggregate_id
  ORDER BY
    SUM(tsrcm.total_track_listens) DESC;
END;
$function$
;
"""

    create_user_track_rating_view_ddl = """
CREATE OR REPLACE VIEW public.v_user_track_rating
AS SELECT ud.user_id,
    tl.aggregate_id AS track_id,
        CASE
            WHEN sum(tl.duration_second) < 15 THEN 0
            WHEN sum(tl.duration_second) >= 15 AND sum(tl.duration_second) <= 600 THEN 1
            WHEN sum(tl.duration_second) >= 601 AND sum(tl.duration_second) <= 3000 THEN 2
            WHEN sum(tl.duration_second) >= 3001 AND sum(tl.duration_second) <= 9000 THEN 3
            WHEN sum(tl.duration_second) >= 9001 AND sum(tl.duration_second) <= 18000 THEN 4
            WHEN sum(tl.duration_second) >= 18001 AND sum(tl.duration_second) <= 36000 THEN 5
            WHEN sum(tl.duration_second) >= 36001 AND sum(tl.duration_second) <= 72000 THEN 6
            WHEN sum(tl.duration_second) >= 72001 AND sum(tl.duration_second) <= 144000 THEN 7
            WHEN sum(tl.duration_second) >= 144001 AND sum(tl.duration_second) <= 576000 THEN 8
            WHEN sum(tl.duration_second) >= 576001 AND sum(tl.duration_second) <= 864000 THEN 9
            ELSE 10
        END AS rating,
    EXTRACT(year FROM CURRENT_TIMESTAMP) AS year,
    EXTRACT(month FROM CURRENT_TIMESTAMP) AS month,
    sum(tl.duration_second) AS total_listened_seconds
   FROM user_data ud
     JOIN track_listen tl ON ud.user_id::text = tl.user_id::text
  GROUP BY ud.user_id, tl.aggregate_id;
"""

    create_user_track_rating_last_half_year_view_ddl = """
CREATE OR REPLACE VIEW public.v_user_track_rating_last_half_year
AS SELECT ud.user_id,
    tl.aggregate_id AS track_id,
        CASE
            WHEN sum(tl.duration_second) >= 15 AND sum(tl.duration_second) <= 60 THEN 1
            WHEN sum(tl.duration_second) >= 61 AND sum(tl.duration_second) <= 300 THEN 2
            WHEN sum(tl.duration_second) >= 301 AND sum(tl.duration_second) <= 900 THEN 3
            WHEN sum(tl.duration_second) >= 901 AND sum(tl.duration_second) <= 1800 THEN 4
            WHEN sum(tl.duration_second) >= 1801 AND sum(tl.duration_second) <= 3600 THEN 5
            WHEN sum(tl.duration_second) >= 3601 AND sum(tl.duration_second) <= 7200 THEN 6
            WHEN sum(tl.duration_second) >= 7201 AND sum(tl.duration_second) <= 14400 THEN 7
            WHEN sum(tl.duration_second) >= 14401 AND sum(tl.duration_second) <= 57600 THEN 8
            WHEN sum(tl.duration_second) >= 57601 AND sum(tl.duration_second) <= 86400 THEN 9
            ELSE 10
        END AS rating,
    sum(tl.duration_second) AS total_listened_seconds
   FROM user_data ud
     JOIN ( SELECT track_listen.id,
            track_listen.aggregate_id,
            track_listen.user_id,
            track_listen.duration_second,
            track_listen.session_id,
            track_listen.created_at,
            track_listen.updated_at,
            track_listen.created_by,
            track_listen.updated_by
           FROM track_listen
          WHERE track_listen.duration_second >= 15 AND track_listen.created_at >= (CURRENT_TIMESTAMP - '6 mons'::interval)) tl ON ud.user_id::text = tl.user_id::text
  GROUP BY ud.user_id, tl.aggregate_id;"""

    create_user_track_recommendation_table_ddl = """
CREATE TABLE public.user_track_recommendation (
  id uuid NOT NULL,
  user_id varchar(255) NOT NULL,
  track_ids _text NOT NULL DEFAULT '{}',
  ratings_json jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
  updated_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
  created_by varchar(255) NULL,
  updated_by varchar(255) NULL,
  CONSTRAINT user_track_recommendation__pkey PRIMARY KEY (id)
)
;"""

    ddls = [
        create_uuid_ossp_extension_ddl, create_unaccent_extension_ddl,
        create_activity_table_ddl, create_aritst_like_table_ddl,
        create_artist_detail_page_view_table_ddl, create_artist_stats_table_ddl,
        create_artist_recommendation_table_ddl,
        create_artist_stats_detail_view_ddl, create_track_like_table_ddl,
        create_track_detail_page_view_table_ddl, create_track_listen_table_ddl,
        create_track_stats_table_ddl, create_user_data_table_ddl,
        create_user_playlist_table_ddl, create_user_stats_materialized_view_ddl,
        create_track_stats_report_view_ddl, create_user_track_rating_view_ddl,
        create_track_stats_report_current_month_view_ddl,
        create_artist_stats_report_view_ddl,
        create_artist_stats_report_current_month_view_ddl,
        create_find_track_stats_report_order_by_total_track_listens_desc_function_ddl,
        create_find_track_stats_report_order_by_avg_score_desc_function_ddl,
        create_find_track_stats_report_order_by_total_track_listens_desc_current_month_function_ddl,
        create_user_track_rating_last_half_year_view_ddl,
        create_user_track_recommendation_table_ddl
    ]

    for ddl in ddls:
        op.execute(ddl)


def downgrade() -> None:
    drop_uuid_ossp_extension_ddl = 'DROP EXTENSION IF NOT EXISTS "uuid-ossp";'
    drop_unaccent_extension_ddl = "DROP EXTENSION IF NOT EXISTS unaccent;"
    drop_activity_table_ddl = "DROP TABLE IF EXISTS activity;"
    drop_artist_like_table_ddl = "DROP TABLE IF EXISTS public.artist_like;"
    drop_artist_stats_table_ddl = "DROP TABLE IF EXISTS public.artist_stats;"
    drop_aritst_detail_page_view_table_ddl = "DROP TABLE IF EXISTS public.aritst_detail_page_view;"
    drop_artist_stats_detail_view_ddl = "DROP VIEW IF EXISTS public.v_artist_stats_detail;"
    drop_artist_recommendation_table_ddl = "DROP TABLE IF EXISTS public.artist_recommendation;"
    drop_track_like_table_ddl = "DROP TABLE IF EXISTS public.track_like;"
    drop_track_detail_page_view_table_ddl = "DROP TABLE IF EXISTS public.track_detail_page_view;"
    drop_track_listen_table_ddl = "DROP TABLE IF EXISTS public.track_listen;"
    drop_user_playlist_table_ddl = "DROP TABLE IF EXISTS public.user_playlist;"
    drop_track_stats_table_ddl = "DROP TABLE IF EXISTS public.track_stats;"
    drop_track_stats_report_view_ddl = "DROP VIEW IF EXISTS public.v_track_stats_report;"
    drop_track_stats_report__current_month_view_ddl = "DROP VIEW IF EXISTS public.v_track_stats_report_current_month;"
    drop_artist_stats_report_view_ddl = "DROP VIEW IF EXISTS public.v_artist_stats_report;"
    drop_artist_stats_report_current_month_view_ddl = "DROP VIEW IF EXISTS public.v_artist_stats_report_current_month;"
    drop_user_track_rating_last_half_year_view_ddl = "DROP VIEW IF EXISTS public.track_rating_last_half_year;"
    drop_user_track_rating_view_ddl = "DROP VIEW IF EXISTS public.v_user_track_rating_last_half_year;"
    drop_user_track_recommendation_table_ddl = "DROP TABLE IF EXISTS public.user_track_recommendation;"

    ddls = [
        drop_uuid_ossp_extension_ddl, drop_unaccent_extension_ddl,
        drop_activity_table_ddl, drop_artist_like_table_ddl,
        drop_artist_like_table_ddl, drop_artist_stats_table_ddl,
        drop_aritst_detail_page_view_table_ddl,
        drop_artist_stats_report_view_ddl,
        drop_artist_stats_report_current_month_view_ddl,
        drop_user_track_rating_view_ddl,
        drop_user_track_rating_last_half_year_view_ddl,
        drop_track_stats_report_view_ddl,
        drop_track_stats_report__current_month_view_ddl,
        drop_artist_stats_detail_view_ddl, drop_artist_stats_table_ddl,
        drop_artist_recommendation_table_ddl, drop_track_like_table_ddl,
        drop_track_detail_page_view_table_ddl, drop_user_playlist_table_ddl,
        drop_track_listen_table_ddl, drop_track_stats_table_ddl,
        drop_user_track_recommendation_table_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)
