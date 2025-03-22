"""create tables: artist, artist_profile, artist_image

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
        "artist",
        sa.Column("id",
                  sa.UUID(),
                  primary_key=True,
                  nullable=False,
                  unique=True),
        sa.Column("profile_id", sa.UUID(), nullable=True, unique=True),
        sa.Column("aggregate_id",
                  sa.String(length=12),
                  nullable=False,
                  unique=True),
        sa.Column("urn", sa.String(length=255), nullable=False, unique=True),
        sa.Column("ref_code",
                  sa.String(length=100),
                  nullable=True,
                  unique=True,
                  default=None),
        sa.Column("is_public", sa.Boolean(), nullable=False, default=False),
        sa.Column("is_released", sa.Boolean(), nullable=False, default=False),
        sa.Column("is_active", sa.Boolean(), nullable=False, default=True),
        sa.Column("is_verified", sa.Boolean(), nullable=False, default=False),
        sa.Column("tags", sa.ARRAY(sa.Text()), nullable=False, default="{}"),
        sa.Column("event_type", sa.Text(), nullable=True),
        sa.Column("event_version", sa.Numeric(), nullable=True),
        sa.Column("event_timestamp", sa.TIMESTAMP(timezone=True),
                  nullable=True),
        sa.Column("created_at", sa.TIMESTAMP(timezone=True), nullable=False),
        sa.Column("updated_at", sa.TIMESTAMP(timezone=True), nullable=False),
        sa.Column("created_by", sa.String(length=255), nullable=True),
        sa.Column("updated_by", sa.String(length=255), nullable=True))

    op.create_table(
        "artist_profile",
        sa.Column("id",
                  sa.UUID(),
                  primary_key=True,
                  nullable=False,
                  unique=True),
        sa.Column("aggregate_id",
                  sa.String(length=12),
                  nullable=False,
                  unique=True),
        sa.Column("artist_ref_code", sa.String(length=255), nullable=True),
        sa.Column("name", sa.Text(), nullable=False),
        sa.Column("biography", sa.String(length=255), nullable=True),
        sa.Column("description", sa.Text(), nullable=True),
        sa.Column("nationality_iso_code", sa.Text(), nullable=True),
        sa.Column("thumbnail_file_key", sa.Text(), nullable=True),
        sa.Column("thumbnail_url", sa.Text(), nullable=True),
        sa.Column("background_file_key", sa.Text(), nullable=True),
        sa.Column("background_url", sa.Text(), nullable=True),
        sa.Column("is_active", sa.Boolean(), nullable=False, default=True),
        sa.Column("event_type", sa.Text(), nullable=True),
        sa.Column("event_version", sa.Numeric(), nullable=True),
        sa.Column("event_timestamp", sa.TIMESTAMP(timezone=True),
                  nullable=True),
        sa.Column("created_at", sa.TIMESTAMP(timezone=True), nullable=False),
        sa.Column("updated_at", sa.TIMESTAMP(timezone=True), nullable=False),
        sa.Column("created_by", sa.String(length=255), nullable=True),
        sa.Column("updated_by", sa.String(length=255), nullable=True))

    op.create_table(
        "artist_image",
        sa.Column("id",
                  sa.UUID(),
                  primary_key=True,
                  nullable=False,
                  unique=True),
        sa.Column("aggregate_id", sa.String(length=12), nullable=False),
        sa.Column("artist_ref_code", sa.String(length=255), nullable=True),
        sa.Column("artist_id", sa.UUID(), nullable=False),
        sa.Column("file_url", sa.Text(), nullable=True),
        sa.Column("file_key", sa.Text(), nullable=True),
        sa.Column("is_active", sa.Boolean(), nullable=False, default=True),
        sa.Column("type", sa.String(length=32), nullable=True),
        sa.Column("thumbnail_url", sa.Text(), nullable=True),
        sa.Column("event_type", sa.Text(), nullable=True),
        sa.Column("event_version", sa.Numeric(), nullable=True),
        sa.Column("event_timestamp", sa.TIMESTAMP(timezone=True),
                  nullable=True),
        sa.Column("created_at", sa.TIMESTAMP(timezone=True), nullable=False),
        sa.Column("updated_at", sa.TIMESTAMP(timezone=True), nullable=False),
        sa.Column("created_by", sa.String(length=255), nullable=True),
        sa.Column("updated_by", sa.String(length=255), nullable=True))

    op.create_foreign_key(
        constraint_name="fk_artist__profile_id___artist_profile__id",
        source_table="artist",
        local_cols=["profile_id"],
        referent_table="artist_profile",
        remote_cols=["id"],
        onupdate="CASCADE",
        ondelete="CASCADE")

    op.create_foreign_key(
        constraint_name="fk_artist_image__artist_id___artist__id",
        source_table="artist_image",
        local_cols=["artist_id"],
        referent_table="artist",
        remote_cols=["id"],
        onupdate="CASCADE",
        ondelete="CASCADE")


def downgrade() -> None:
    op.drop_table("artist_image")
    op.drop_table("artist")
    op.drop_table("artist_profile")
