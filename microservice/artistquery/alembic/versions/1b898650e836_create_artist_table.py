"""create tables: artist, artist_profile

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
    op.create_table(
        "artist", sa.Column("id", sa.UUID(), nullable=False),
        sa.Column("profile_id", sa.UUID(), nullable=True),
        sa.Column("aggregate_id", sa.String(length=12), nullable=False),
        sa.Column("urn", sa.String(length=255), nullable=False),
        sa.Column("ref_code", sa.String(length=100), nullable=True),
        sa.Column("is_public", sa.Boolean(), nullable=False, default=False),
        sa.Column("is_released", sa.Boolean(), nullable=False, default=False),
        sa.Column("is_active", sa.Boolean(), nullable=False, default=True),
        sa.Column("tags", sa.ARRAY(sa.Text()), nullable=False, default="{}"),
        sa.Column("event_timestamp",
                  sa.TIMESTAMP(timezone=True),
                  nullable=False),
        sa.Column("created_at", sa.TIMESTAMP(timezone=True), nullable=False),
        sa.Column("updated_at", sa.TIMESTAMP(timezone=True), nullable=False),
        sa.Column("created_by", sa.String(length=255), nullable=True),
        sa.Column("updated_by", sa.String(length=255), nullable=True),
        sa.PrimaryKeyConstraint("id"), sa.UniqueConstraint("aggregate_id"),
        sa.UniqueConstraint("urn"), sa.UniqueConstraint("profile_id"))

    op.create_table(
        "artist_profile", sa.Column("id", sa.UUID(), nullable=False),
        sa.Column("name", sa.String(length=255), nullable=False),
        sa.Column("biography", sa.String(length=255), nullable=True),
        sa.Column("description", sa.Text(), nullable=True),
        sa.Column("thumbnail_file_key", sa.Text(), nullable=True),
        sa.Column("thumbnail_url", sa.Text(), nullable=True),
        sa.Column("background_file_key", sa.Text(), nullable=True),
        sa.Column("background_url", sa.Text(), nullable=True),
        sa.Column("event_timestamp",
                  sa.TIMESTAMP(timezone=True),
                  nullable=False),
        sa.Column("created_at", sa.TIMESTAMP(timezone=True), nullable=False),
        sa.Column("updated_at", sa.TIMESTAMP(timezone=True), nullable=False),
        sa.Column("created_by", sa.String(length=255), nullable=True),
        sa.Column("updated_by", sa.String(length=255), nullable=True),
        sa.PrimaryKeyConstraint("id"), sa.UniqueConstraint("ref_code"))
    op.create_foreign_key(constraint_name="fk_artist_profile_id_artist_profile",
                          source_table="artist",
                          referent_table="artist_profile",
                          local_cols=["profile_id"],
                          remote_cols=["id"],
                          onupdate="CASCADE",
                          ondelete="CASCADE")


def downgrade() -> None:
    op.drop_table("artist_profile")
    op.drop_table("artist")
