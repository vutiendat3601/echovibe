"""create track_audio table

Revision ID: 0a27f00af6ef
Revises: 1b898650e836
Create Date: 2025-04-25 12:31:38.768436

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision: str = '0a27f00af6ef'
down_revision: Union[str, None] = '1b898650e836'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    create_track_audio_table_ddl = """
-- Table: track_audio
CREATE TABLE track_audio (
    id uuid NOT NULL,
    track_id uuid NOT NULL,
    audio_file_key text NULL,
    file_m3u8_url text NULL,
    is_active bool NOT NULL DEFAULT true,
	event_type text NULL,
	event_version numeric NULL,
	event_timestamp timestamptz NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NOT NULL,
	created_by varchar(255) NULL,
	updated_by varchar(255) NULL,
	CONSTRAINT track_audio_pkey PRIMARY KEY (id)
);

-- Foreign key: 
ALTER TABLE track_audio ADD CONSTRAINT fk_track_audio__track_id___track__id
FOREIGN KEY (track_id) REFERENCES track (id) ON DELETE CASCADE ON UPDATE CASCADE
;"""

    ddls = [create_track_audio_table_ddl]
    for ddl in ddls:
        op.execute(ddl)


def downgrade() -> None:
    drop_track_audio_table_ddl = "DROP TABLE IF EXISTS track_audio;"
    ddls = [drop_track_audio_table_ddl]
    for ddl in ddls:
        op.execute(ddl)
