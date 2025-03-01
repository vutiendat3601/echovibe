CREATE TABLE artist (
  id uuid NOT NULL PRIMARY KEY,
  aggregate_id varchar(16) NOT NULL UNIQUE,
  urn varchar(255) NOT NULL,
  "name" varchar(255) NOT NULL,
  is_public boolean NOT NULL DEFAULT false,
  is_published boolean NOT NULL DEFAULT false,
  is_active boolean NOT NULL DEFAULT true,
  "description" text,
  thumbnail_file_key text,
  background_file_key text,
  tags text[] NOT NULL DEFAULT '{}',
  ref text,
  created_at timestamptz NOT NULL DEFAULT current_timestamp,
  updated_at timestamptz NOT NULL DEFAULT current_timestamp,
  created_by varchar(255),
  updated_by varchar(255)
);
