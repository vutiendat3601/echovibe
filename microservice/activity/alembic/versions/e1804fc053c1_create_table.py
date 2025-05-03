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
        description varchar(255) NULL,
        type varchar(255) NOT NULL,
        data_json jsonb NULL,
        created_at timestamptz DEFAULT current_timestamp,
        created_by varchar(255),
        CONSTRAINT activity_pkey PRIMARY KEY (id)
    );
"""
    ddls = [
        create_uuid_ossp_extension_ddl, create_unaccent_extension_ddl,
        create_activity_table_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)


def downgrade() -> None:
    drop_uuid_ossp_extension_ddl = 'DROP EXTENSION IF NOT EXISTS "uuid-ossp";'
    drop_unaccent_extension_ddl = "DROP EXTENSION IF NOT EXISTS unaccent;"
    drop_activity_table_ddl = "DROP TABLE IF EXISTS activity;"
    ddls = [
        drop_uuid_ossp_extension_ddl, drop_unaccent_extension_ddl,
        drop_activity_table_ddl
    ]
    for ddl in ddls:
        op.execute(ddl)
