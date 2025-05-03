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
    created_by varchar(255),
	CONSTRAINT aritst_detail_page_view__pkey PRIMARY KEY (id),
    CONSTRAINT artist_detail_page_view__session_id___key UNIQUE (session_id)
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
    created_by varchar(255),
	CONSTRAINT track_detail_page_view__pkey PRIMARY KEY (id),
    CONSTRAINT track_detail_page_view__session_id___key UNIQUE (session_id)
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
    created_by varchar(255),
	CONSTRAINT track_listen__pkey PRIMARY KEY (id),
    CONSTRAINT track_listen__session_id___key UNIQUE (session_id)
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

    ddls = [
        create_uuid_ossp_extension_ddl, create_unaccent_extension_ddl,
        create_activity_table_ddl, create_aritst_like_table_ddl,
        create_artist_detail_page_view_table_ddl, create_artist_stats_table_ddl,
        create_track_like_table_ddl, create_track_detail_page_view_table_ddl,
        create_track_listen_table_ddl, create_track_stats_table_ddl
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
    drop_artist_stats_table_ddl = "DROP TABLE IF EXISTS public.artist_stats;"
    drop_track_like_table_ddl = "DROP TABLE IF EXISTS public.track_like;"
    drop_track_detail_page_view_table_ddl = "DROP TABLE IF EXISTS public.track_detail_page_view;"
    drop_track_listen_table_ddl = "DROP TABLE IF EXISTS public.track_listen;"
    drop_track_stats_table_ddl = "DROP TABLE IF EXISTS public.track_stats;"
    ddls = [
        drop_uuid_ossp_extension_ddl, drop_unaccent_extension_ddl,
        drop_activity_table_ddl, drop_artist_like_table_ddl,
        drop_artist_like_table_ddl, drop_artist_stats_table_ddl,
        drop_aritst_detail_page_view_table_ddl, drop_artist_stats_table_ddl,
        drop_track_like_table_ddl, drop_track_detail_page_view_table_ddl,
        drop_track_listen_table_ddl, drop_track_stats_table_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)
