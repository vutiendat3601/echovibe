--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

-- CREATE ROLE echovibe_keycloak;
-- ALTER ROLE echovibe_keycloak WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:G/WgvqZdUWMLRD+mTXVRGQ==$cFzQoMk9RWwAY+qLA2/GtcGKJ1hOU2kY1Um1tRy2AZs=:loTx5mHJI5haS6JV6e2pWED+5hyb3lurAYZYcbXdgOM=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6
-- Dumped by pg_dump version 16.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "echovibe_keycloak" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6
-- Dumped by pg_dump version 16.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: echovibe_keycloak; Type: DATABASE; Schema: -; Owner: echovibe_keycloak
--

CREATE DATABASE echovibe_keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE echovibe_keycloak OWNER TO echovibe_keycloak;

\connect echovibe_keycloak

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO echovibe_keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO echovibe_keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO echovibe_keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO echovibe_keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO echovibe_keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO echovibe_keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO echovibe_keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO echovibe_keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO echovibe_keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO echovibe_keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO echovibe_keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO echovibe_keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO echovibe_keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO echovibe_keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO echovibe_keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO echovibe_keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO echovibe_keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO echovibe_keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO echovibe_keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO echovibe_keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO echovibe_keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO echovibe_keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO echovibe_keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO echovibe_keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO echovibe_keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO echovibe_keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO echovibe_keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO echovibe_keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO echovibe_keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO echovibe_keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO echovibe_keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO echovibe_keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO echovibe_keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO echovibe_keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO echovibe_keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO echovibe_keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO echovibe_keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO echovibe_keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO echovibe_keycloak;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO echovibe_keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO echovibe_keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO echovibe_keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO echovibe_keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO echovibe_keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO echovibe_keycloak;

--
-- Name: org; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO echovibe_keycloak;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO echovibe_keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO echovibe_keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO echovibe_keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO echovibe_keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO echovibe_keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO echovibe_keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO echovibe_keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO echovibe_keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO echovibe_keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO echovibe_keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO echovibe_keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO echovibe_keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO echovibe_keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO echovibe_keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO echovibe_keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO echovibe_keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO echovibe_keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO echovibe_keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO echovibe_keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO echovibe_keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO echovibe_keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO echovibe_keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO echovibe_keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO echovibe_keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO echovibe_keycloak;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO echovibe_keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO echovibe_keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO echovibe_keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO echovibe_keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO echovibe_keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO echovibe_keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO echovibe_keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO echovibe_keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO echovibe_keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO echovibe_keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO echovibe_keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO echovibe_keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO echovibe_keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO echovibe_keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO echovibe_keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: echovibe_keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO echovibe_keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.associated_policy VALUES ('0f980173-3ba3-4e30-9cd2-a2eabaff30d1', 'a863d98f-759f-4421-a553-5ab9c376960c');
INSERT INTO public.associated_policy VALUES ('6d07f7f7-a448-4384-9afa-9d610faeeeb8', 'a863d98f-759f-4421-a553-5ab9c376960c');
INSERT INTO public.associated_policy VALUES ('a2b8dbe4-2cf1-426d-8585-d8f91de7ec54', 'a863d98f-759f-4421-a553-5ab9c376960c');
INSERT INTO public.associated_policy VALUES ('06ff0c72-da49-4c3d-a412-6a676b14b7af', 'a863d98f-759f-4421-a553-5ab9c376960c');
INSERT INTO public.associated_policy VALUES ('06ff0c72-da49-4c3d-a412-6a676b14b7af', 'ce1c5c87-c666-43ad-8075-ca2ae2e880d1');
INSERT INTO public.associated_policy VALUES ('0e5b46dd-6d47-401d-ac5d-b140f60a39b4', 'a863d98f-759f-4421-a553-5ab9c376960c');
INSERT INTO public.associated_policy VALUES ('0e5b46dd-6d47-401d-ac5d-b140f60a39b4', 'ce1c5c87-c666-43ad-8075-ca2ae2e880d1');


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.authentication_execution VALUES ('ecdb5103-1556-4707-916e-ecb3b75f389b', NULL, 'auth-cookie', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '0aa764fe-6e73-4d5d-93bf-c25e097aea09', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('43f79078-eace-41a5-878b-1389fc2380d3', NULL, 'auth-spnego', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '0aa764fe-6e73-4d5d-93bf-c25e097aea09', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d272c3f6-7984-4497-9555-cd9b389244ae', NULL, 'identity-provider-redirector', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '0aa764fe-6e73-4d5d-93bf-c25e097aea09', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('23d9fb20-ddb2-480a-af08-ac916c5fe3fb', NULL, NULL, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '0aa764fe-6e73-4d5d-93bf-c25e097aea09', 2, 30, true, '5479f6cd-eb3e-40f8-b948-d17022cd5f46', NULL);
INSERT INTO public.authentication_execution VALUES ('5ae710b6-0a0f-40da-a75f-0f9f61df21f1', NULL, 'auth-username-password-form', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '5479f6cd-eb3e-40f8-b948-d17022cd5f46', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a4f39f91-bec8-4f56-a760-f4cbe1db152c', NULL, NULL, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '5479f6cd-eb3e-40f8-b948-d17022cd5f46', 1, 20, true, '142872a9-609d-4545-849e-185b452f3fc2', NULL);
INSERT INTO public.authentication_execution VALUES ('1dfa3558-a78b-4177-b584-716a62f7593b', NULL, 'conditional-user-configured', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '142872a9-609d-4545-849e-185b452f3fc2', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('8e5f36ce-c06d-4c0b-822a-491d26fdec0e', NULL, 'auth-otp-form', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '142872a9-609d-4545-849e-185b452f3fc2', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('17478740-cb4b-485e-9b99-f416e30fc987', NULL, 'direct-grant-validate-username', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'be9df596-47c7-4be2-aae8-d15e77881bdb', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d5b54f55-7bf7-4093-ac27-c8ec8fd8d308', NULL, 'direct-grant-validate-password', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'be9df596-47c7-4be2-aae8-d15e77881bdb', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('65319f84-0efb-4976-b3e1-ba0cc8509e4b', NULL, NULL, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'be9df596-47c7-4be2-aae8-d15e77881bdb', 1, 30, true, '5a7815e2-02ce-4d67-b2d9-217d2126a728', NULL);
INSERT INTO public.authentication_execution VALUES ('319e42fd-ff6e-47e7-8807-7220c6377bdd', NULL, 'conditional-user-configured', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '5a7815e2-02ce-4d67-b2d9-217d2126a728', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('55024860-4270-466d-955e-edb23368daa1', NULL, 'direct-grant-validate-otp', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '5a7815e2-02ce-4d67-b2d9-217d2126a728', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('36d7620a-03c8-4c26-a90d-8c360705e77a', NULL, 'registration-page-form', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '29a30685-2903-42e2-b426-e498378457ff', 0, 10, true, '0fcd8d35-ce64-4152-9d09-a85dc7ca084d', NULL);
INSERT INTO public.authentication_execution VALUES ('7f2561c6-bc8a-47b6-ae8f-7b1161f6001b', NULL, 'registration-user-creation', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '0fcd8d35-ce64-4152-9d09-a85dc7ca084d', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('48f92f50-8b30-4430-b321-415912ae2225', NULL, 'registration-password-action', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '0fcd8d35-ce64-4152-9d09-a85dc7ca084d', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('52847bab-9c6e-4238-9b7a-601f70dd5471', NULL, 'registration-recaptcha-action', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '0fcd8d35-ce64-4152-9d09-a85dc7ca084d', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('4a1adc2c-e5b2-41fb-8b47-c5dc2cabbbd6', NULL, 'registration-terms-and-conditions', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '0fcd8d35-ce64-4152-9d09-a85dc7ca084d', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('02a15236-4515-4dbf-9256-f2e3dffff7e7', NULL, 'reset-credentials-choose-user', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '86831432-0aee-4cb3-8553-3f0c02adcc0c', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('7a9c731e-14ff-4ec9-b7c6-c7219f75cd09', NULL, 'reset-credential-email', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '86831432-0aee-4cb3-8553-3f0c02adcc0c', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ecc5b49a-850b-423d-900e-473274693621', NULL, 'reset-password', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '86831432-0aee-4cb3-8553-3f0c02adcc0c', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('4fb5057d-3cc8-4430-8d5b-1e999c734864', NULL, NULL, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '86831432-0aee-4cb3-8553-3f0c02adcc0c', 1, 40, true, 'c2cdc319-6769-4378-84ad-079cd1c513a7', NULL);
INSERT INTO public.authentication_execution VALUES ('347da9e8-4d3e-49cc-ab09-e96789a64701', NULL, 'conditional-user-configured', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'c2cdc319-6769-4378-84ad-079cd1c513a7', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('4d0c35d0-539c-40c0-aded-c96ab708e417', NULL, 'reset-otp', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'c2cdc319-6769-4378-84ad-079cd1c513a7', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('fc43d7c7-2de6-444d-a0db-b7a5de726200', NULL, 'client-secret', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '08509b88-90c3-4b83-9051-7f9d0653fb09', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a8b0cc5a-b8c0-4bcc-bbd9-120beb6b27bb', NULL, 'client-jwt', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '08509b88-90c3-4b83-9051-7f9d0653fb09', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('28bd7c2e-459a-4020-b77b-7948389617b7', NULL, 'client-secret-jwt', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '08509b88-90c3-4b83-9051-7f9d0653fb09', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('412575f3-59da-409a-9e5b-f8dd9dc00c38', NULL, 'client-x509', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '08509b88-90c3-4b83-9051-7f9d0653fb09', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('621a1287-2bbb-4aed-b17d-7d731a1d92c0', NULL, 'idp-review-profile', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '77759c75-384f-492c-8528-188eb9a83ebc', 0, 10, false, NULL, '4c699193-c4eb-4e3b-96b0-027ec1ddc4fe');
INSERT INTO public.authentication_execution VALUES ('533110c5-9de8-4a41-af1a-3494a942df10', NULL, NULL, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '77759c75-384f-492c-8528-188eb9a83ebc', 0, 20, true, '370aa5a1-0005-4431-b9c7-71849ff369a8', NULL);
INSERT INTO public.authentication_execution VALUES ('ed7453cb-6be7-424a-9902-c8f3341cbd90', NULL, 'idp-create-user-if-unique', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '370aa5a1-0005-4431-b9c7-71849ff369a8', 2, 10, false, NULL, '00c40d3b-cc6f-4b85-991e-d767c7695a6b');
INSERT INTO public.authentication_execution VALUES ('be313667-25fc-4928-9244-63a03a7d775d', NULL, NULL, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '370aa5a1-0005-4431-b9c7-71849ff369a8', 2, 20, true, 'f15606d5-f5ca-4cfc-b5a2-a6a0e78f7ec1', NULL);
INSERT INTO public.authentication_execution VALUES ('e48fa96a-aef9-488c-a098-4ae468680a11', NULL, 'idp-confirm-link', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'f15606d5-f5ca-4cfc-b5a2-a6a0e78f7ec1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('4b7f3ffe-2b28-4219-af6e-c886f2d79db6', NULL, NULL, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'f15606d5-f5ca-4cfc-b5a2-a6a0e78f7ec1', 0, 20, true, 'b5a31c0e-fea1-4e2d-a6d2-73a0f29e6b71', NULL);
INSERT INTO public.authentication_execution VALUES ('20f3888a-b1fe-423e-8ba4-b455cdec79c9', NULL, 'idp-email-verification', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'b5a31c0e-fea1-4e2d-a6d2-73a0f29e6b71', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('17f82007-4a72-47ab-95fc-e0bb3ecfa6ec', NULL, NULL, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'b5a31c0e-fea1-4e2d-a6d2-73a0f29e6b71', 2, 20, true, 'b26f30ed-a367-4c65-bc06-ce485ab3a5e4', NULL);
INSERT INTO public.authentication_execution VALUES ('d5bb7bdf-f7ef-4b7d-8a7f-00a63a3e122d', NULL, 'idp-username-password-form', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'b26f30ed-a367-4c65-bc06-ce485ab3a5e4', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('37d66745-d067-4f40-934f-4307081afa16', NULL, NULL, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'b26f30ed-a367-4c65-bc06-ce485ab3a5e4', 1, 20, true, '2e902200-a672-4c37-b6e5-3f7c7db89b5d', NULL);
INSERT INTO public.authentication_execution VALUES ('d7c9f3ff-87f9-4ae6-956f-2e359ee63005', NULL, 'conditional-user-configured', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '2e902200-a672-4c37-b6e5-3f7c7db89b5d', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c3963caf-48f3-4ff0-a27d-817806f6b8a5', NULL, 'auth-otp-form', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '2e902200-a672-4c37-b6e5-3f7c7db89b5d', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('f81205c0-70a6-44ad-8223-7b962816be2e', NULL, 'http-basic-authenticator', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '13ad19c8-724b-4a06-b213-38c2bb8f1f61', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b4af7009-1654-478f-88d8-256a9716e3f9', NULL, 'docker-http-basic-authenticator', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'bec85556-25e3-4a80-9694-3a33ec4af0fa', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('599f25e9-d149-4585-a620-ceba48d62b12', NULL, 'auth-cookie', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0ed8e62f-94ce-4146-bc9c-d291a4b3d549', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('61a65211-8284-461d-8e35-029e2937700c', NULL, 'auth-spnego', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0ed8e62f-94ce-4146-bc9c-d291a4b3d549', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('22b55857-0690-4ecd-a797-3a6b402353a6', NULL, 'identity-provider-redirector', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0ed8e62f-94ce-4146-bc9c-d291a4b3d549', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('beee63d6-976d-47ee-9749-a7f0d8148498', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0ed8e62f-94ce-4146-bc9c-d291a4b3d549', 2, 30, true, 'c952e269-bcad-4e11-9d73-5d1c34ad757d', NULL);
INSERT INTO public.authentication_execution VALUES ('c9df53a5-e217-4195-9ffb-53535f4fb49c', NULL, 'auth-username-password-form', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'c952e269-bcad-4e11-9d73-5d1c34ad757d', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6b71413e-c1d1-4f3c-99ed-036660e31e2a', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'c952e269-bcad-4e11-9d73-5d1c34ad757d', 1, 20, true, '521c8403-c29a-47b6-9d36-ef87d9527968', NULL);
INSERT INTO public.authentication_execution VALUES ('d11fb081-73bf-4a06-8e54-d966688a788d', NULL, 'conditional-user-configured', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '521c8403-c29a-47b6-9d36-ef87d9527968', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('37ef8fff-a0eb-483c-9d34-52d91d77c535', NULL, 'auth-otp-form', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '521c8403-c29a-47b6-9d36-ef87d9527968', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('163d8da1-3fb6-41c5-8c23-b6e096f563d5', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0ed8e62f-94ce-4146-bc9c-d291a4b3d549', 2, 26, true, 'e080ecc3-dca3-407d-a48f-23d71bd38512', NULL);
INSERT INTO public.authentication_execution VALUES ('dcc04aca-4e71-4fe6-aacd-7163bbda0e04', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'e080ecc3-dca3-407d-a48f-23d71bd38512', 1, 10, true, '1ca6dfcb-3229-458c-8deb-558bec73ef9c', NULL);
INSERT INTO public.authentication_execution VALUES ('acc82475-8283-40ba-9113-b7bbabe0d8eb', NULL, 'conditional-user-configured', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '1ca6dfcb-3229-458c-8deb-558bec73ef9c', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('f03e2810-9426-44c0-94d2-23f461918eed', NULL, 'organization', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '1ca6dfcb-3229-458c-8deb-558bec73ef9c', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a719fd31-b1cd-4d67-bcd0-beaa2744a192', NULL, 'direct-grant-validate-username', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '52cbefb3-05f6-415f-9e97-20dbb4a78d16', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('8a125d88-2791-4bfe-910b-e161a0abdeb4', NULL, 'direct-grant-validate-password', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '52cbefb3-05f6-415f-9e97-20dbb4a78d16', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0ff6d456-55ab-4642-bef8-4539ea5ecbc2', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '52cbefb3-05f6-415f-9e97-20dbb4a78d16', 1, 30, true, 'e4ba5642-142e-4b05-880b-78d713eebf55', NULL);
INSERT INTO public.authentication_execution VALUES ('0bf478ae-d6dc-4cc7-a9a6-74521d0ba278', NULL, 'conditional-user-configured', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'e4ba5642-142e-4b05-880b-78d713eebf55', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('604626a4-a77c-4419-9f88-3e607877f4d9', NULL, 'direct-grant-validate-otp', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'e4ba5642-142e-4b05-880b-78d713eebf55', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('f38a92cd-b01b-4bec-a025-5b43991a0707', NULL, 'registration-page-form', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '360aad8e-458e-42c5-826d-c20278b7de14', 0, 10, true, '857965ef-18e0-47d2-bc80-38acbed41bc7', NULL);
INSERT INTO public.authentication_execution VALUES ('0234b6e0-7610-4790-8927-6072ba02259a', NULL, 'registration-user-creation', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '857965ef-18e0-47d2-bc80-38acbed41bc7', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e581466a-587b-4eaa-bc32-2f7a643d8cb9', NULL, 'registration-password-action', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '857965ef-18e0-47d2-bc80-38acbed41bc7', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('db2e04fe-412c-4bd8-ac41-7f38688176a0', NULL, 'registration-recaptcha-action', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '857965ef-18e0-47d2-bc80-38acbed41bc7', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('55a635ef-6758-4130-9aa3-acd773dce869', NULL, 'registration-terms-and-conditions', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '857965ef-18e0-47d2-bc80-38acbed41bc7', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c12acc89-1434-4217-868d-3444caad5467', NULL, 'reset-credentials-choose-user', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '812c0516-667b-4f3e-95d1-d0f0f7d4e6ee', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('8c47b114-9fd6-4fc5-baea-d478ab6ef18a', NULL, 'reset-credential-email', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '812c0516-667b-4f3e-95d1-d0f0f7d4e6ee', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('13270448-e2b1-4735-8d8d-3cfc54478dc4', NULL, 'reset-password', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '812c0516-667b-4f3e-95d1-d0f0f7d4e6ee', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0b57aeff-e9ce-4e52-9afa-1bff044012e1', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '812c0516-667b-4f3e-95d1-d0f0f7d4e6ee', 1, 40, true, '3e75a761-7de4-4c17-a95c-587695125d35', NULL);
INSERT INTO public.authentication_execution VALUES ('e034e250-e780-456d-b076-cc08cf10d225', NULL, 'conditional-user-configured', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '3e75a761-7de4-4c17-a95c-587695125d35', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('481e0863-e6de-453b-8f80-3993d34292f8', NULL, 'reset-otp', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '3e75a761-7de4-4c17-a95c-587695125d35', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('f6b9b9f9-c0fd-4cf6-9610-3bc8433ee0d5', NULL, 'client-secret', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'b33b4e31-0267-472a-be12-59fad29ee939', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a8eaa352-cd6e-4ec0-8f12-aa309069991a', NULL, 'client-jwt', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'b33b4e31-0267-472a-be12-59fad29ee939', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('497699c5-468c-4278-ae57-c7fc422774d7', NULL, 'client-secret-jwt', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'b33b4e31-0267-472a-be12-59fad29ee939', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6cb70242-d38b-4d00-9ce2-7d82e62d4513', NULL, 'client-x509', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'b33b4e31-0267-472a-be12-59fad29ee939', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('909cd268-e0a9-4015-b0ba-26a240f79d80', NULL, 'idp-review-profile', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '24414d03-6364-49e6-b667-e0ada658459e', 0, 10, false, NULL, 'a08e9fad-3d7b-48dc-a35b-37a0a86a79e7');
INSERT INTO public.authentication_execution VALUES ('c4829943-13cb-4532-a2e6-1258dc3401c6', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '24414d03-6364-49e6-b667-e0ada658459e', 0, 20, true, '94b0b5ee-a99c-4d3b-abff-02e9137a19fc', NULL);
INSERT INTO public.authentication_execution VALUES ('98296aa5-267e-4c3a-9723-e8d030ccd843', NULL, 'idp-create-user-if-unique', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '94b0b5ee-a99c-4d3b-abff-02e9137a19fc', 2, 10, false, NULL, '3ed0434a-a27d-4adf-98f8-265bcb19c3e6');
INSERT INTO public.authentication_execution VALUES ('aa7c4305-22a9-4408-b3c1-0c9d0c49217a', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '94b0b5ee-a99c-4d3b-abff-02e9137a19fc', 2, 20, true, 'e6f5bf8f-2fbd-4402-9e33-e49a97221436', NULL);
INSERT INTO public.authentication_execution VALUES ('05e229f1-05d3-41fd-934f-86fff6a45e22', NULL, 'idp-confirm-link', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'e6f5bf8f-2fbd-4402-9e33-e49a97221436', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('88b033d2-aa65-4bf7-8bda-93e63fccbe6e', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'e6f5bf8f-2fbd-4402-9e33-e49a97221436', 0, 20, true, '53f56fd9-c339-47ba-a0b6-ade9aa332b7b', NULL);
INSERT INTO public.authentication_execution VALUES ('a8b207d8-73c0-4a9a-8a58-42e8a8951a6f', NULL, 'idp-email-verification', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '53f56fd9-c339-47ba-a0b6-ade9aa332b7b', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0f4da48a-b118-4576-a29c-2b611255cd04', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '53f56fd9-c339-47ba-a0b6-ade9aa332b7b', 2, 20, true, '559587d5-b5ef-4076-afc7-6f2ba0b7afde', NULL);
INSERT INTO public.authentication_execution VALUES ('4f673315-c665-4119-8b1c-b7e68cfeba6c', NULL, 'idp-username-password-form', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '559587d5-b5ef-4076-afc7-6f2ba0b7afde', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('04519b22-1261-4d42-a0f1-3381ac976104', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '559587d5-b5ef-4076-afc7-6f2ba0b7afde', 1, 20, true, '329eae33-4840-45e5-9d3a-60518578aab8', NULL);
INSERT INTO public.authentication_execution VALUES ('4087f2b2-9732-4224-bc9b-7789281fc11d', NULL, 'conditional-user-configured', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '329eae33-4840-45e5-9d3a-60518578aab8', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ba44c29b-7e7e-456d-a355-66b844ac4458', NULL, 'auth-otp-form', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '329eae33-4840-45e5-9d3a-60518578aab8', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c56471ae-0059-4099-85cc-5d34aafb97e2', NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '24414d03-6364-49e6-b667-e0ada658459e', 1, 50, true, '6315a63e-de0e-44de-841d-09e88d9c2625', NULL);
INSERT INTO public.authentication_execution VALUES ('86d7b07d-68ed-4823-a0e4-13de113099fc', NULL, 'conditional-user-configured', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '6315a63e-de0e-44de-841d-09e88d9c2625', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('bddcc433-432a-445e-99a3-e8b387efd87d', NULL, 'idp-add-organization-member', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '6315a63e-de0e-44de-841d-09e88d9c2625', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('aa214c1c-2216-418a-a29f-91b602c70bbc', NULL, 'http-basic-authenticator', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '6bfe4b76-6cc4-4285-9767-3c3d1241e04a', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('fa4e5996-ebac-4d7f-95ec-464c7c73b37f', NULL, 'docker-http-basic-authenticator', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '39e07c10-b846-4eab-96e1-d138458cdefa', 0, 10, false, NULL, NULL);


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.authentication_flow VALUES ('0aa764fe-6e73-4d5d-93bf-c25e097aea09', 'browser', 'Browser based authentication', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('5479f6cd-eb3e-40f8-b948-d17022cd5f46', 'forms', 'Username, password, otp and other auth forms.', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('142872a9-609d-4545-849e-185b452f3fc2', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('be9df596-47c7-4be2-aae8-d15e77881bdb', 'direct grant', 'OpenID Connect Resource Owner Grant', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('5a7815e2-02ce-4d67-b2d9-217d2126a728', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('29a30685-2903-42e2-b426-e498378457ff', 'registration', 'Registration flow', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('0fcd8d35-ce64-4152-9d09-a85dc7ca084d', 'registration form', 'Registration form', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'form-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('86831432-0aee-4cb3-8553-3f0c02adcc0c', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('c2cdc319-6769-4378-84ad-079cd1c513a7', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('08509b88-90c3-4b83-9051-7f9d0653fb09', 'clients', 'Base authentication for clients', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'client-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('77759c75-384f-492c-8528-188eb9a83ebc', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('370aa5a1-0005-4431-b9c7-71849ff369a8', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('f15606d5-f5ca-4cfc-b5a2-a6a0e78f7ec1', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('b5a31c0e-fea1-4e2d-a6d2-73a0f29e6b71', 'Account verification options', 'Method with which to verity the existing account', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('b26f30ed-a367-4c65-bc06-ce485ab3a5e4', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('2e902200-a672-4c37-b6e5-3f7c7db89b5d', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('13ad19c8-724b-4a06-b213-38c2bb8f1f61', 'saml ecp', 'SAML ECP Profile Authentication Flow', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('bec85556-25e3-4a80-9694-3a33ec4af0fa', 'docker auth', 'Used by Docker clients to authenticate against the IDP', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('0ed8e62f-94ce-4146-bc9c-d291a4b3d549', 'browser', 'Browser based authentication', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('c952e269-bcad-4e11-9d73-5d1c34ad757d', 'forms', 'Username, password, otp and other auth forms.', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('521c8403-c29a-47b6-9d36-ef87d9527968', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('e080ecc3-dca3-407d-a48f-23d71bd38512', 'Organization', NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('1ca6dfcb-3229-458c-8deb-558bec73ef9c', 'Browser - Conditional Organization', 'Flow to determine if the organization identity-first login is to be used', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('52cbefb3-05f6-415f-9e97-20dbb4a78d16', 'direct grant', 'OpenID Connect Resource Owner Grant', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('e4ba5642-142e-4b05-880b-78d713eebf55', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('360aad8e-458e-42c5-826d-c20278b7de14', 'registration', 'Registration flow', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('857965ef-18e0-47d2-bc80-38acbed41bc7', 'registration form', 'Registration form', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'form-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('812c0516-667b-4f3e-95d1-d0f0f7d4e6ee', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('3e75a761-7de4-4c17-a95c-587695125d35', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('b33b4e31-0267-472a-be12-59fad29ee939', 'clients', 'Base authentication for clients', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'client-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('24414d03-6364-49e6-b667-e0ada658459e', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('94b0b5ee-a99c-4d3b-abff-02e9137a19fc', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('e6f5bf8f-2fbd-4402-9e33-e49a97221436', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('53f56fd9-c339-47ba-a0b6-ade9aa332b7b', 'Account verification options', 'Method with which to verity the existing account', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('559587d5-b5ef-4076-afc7-6f2ba0b7afde', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('329eae33-4840-45e5-9d3a-60518578aab8', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('6315a63e-de0e-44de-841d-09e88d9c2625', 'First Broker Login - Conditional Organization', 'Flow to determine if the authenticator that adds organization members is to be used', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('6bfe4b76-6cc4-4285-9767-3c3d1241e04a', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('39e07c10-b846-4eab-96e1-d138458cdefa', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'basic-flow', true, true);


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.authenticator_config VALUES ('4c699193-c4eb-4e3b-96b0-027ec1ddc4fe', 'review profile config', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e');
INSERT INTO public.authenticator_config VALUES ('00c40d3b-cc6f-4b85-991e-d767c7695a6b', 'create unique user config', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e');
INSERT INTO public.authenticator_config VALUES ('a08e9fad-3d7b-48dc-a35b-37a0a86a79e7', 'review profile config', 'dd6a5b23-a699-44e1-8210-886a0a2eafac');
INSERT INTO public.authenticator_config VALUES ('3ed0434a-a27d-4adf-98f8-265bcb19c3e6', 'create unique user config', 'dd6a5b23-a699-44e1-8210-886a0a2eafac');


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.authenticator_config_entry VALUES ('00c40d3b-cc6f-4b85-991e-d767c7695a6b', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry VALUES ('4c699193-c4eb-4e3b-96b0-027ec1ddc4fe', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry VALUES ('3ed0434a-a27d-4adf-98f8-265bcb19c3e6', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry VALUES ('a08e9fad-3d7b-48dc-a35b-37a0a86a79e7', 'missing', 'update.profile.on.first.login');


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', true, true, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', true, true, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client VALUES ('3031e683-70a3-4b1f-af4d-e6677b127cf9', true, false, 'echovibe-realm', 0, false, NULL, NULL, true, NULL, false, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL, 0, false, false, 'echovibe Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', true, false, 'realm-management', 0, false, NULL, NULL, true, NULL, false, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', true, false, 'account', 0, true, NULL, '/realms/echovibe/account/', false, NULL, false, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', true, false, 'account-console', 0, true, NULL, '/realms/echovibe/account/', false, NULL, false, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', true, true, 'security-admin-console', 0, true, NULL, '/admin/echovibe/console/', false, NULL, false, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', true, true, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', true, true, 'echovibe', 0, false, 'idG7DvzAfpgGb8UDrsVzfZu5jTm38va1', '', false, '', false, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'openid-connect', -1, true, false, 'Echo Vibe', true, 'client-secret', '', '', NULL, false, false, false, false);
INSERT INTO public.client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', true, true, 'echovibe-clientweb', 0, true, NULL, '', false, '', false, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'openid-connect', -1, true, false, 'Echo Vibe - Client web application', false, 'client-secret', '', '', NULL, true, false, false, true);
INSERT INTO public.client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', true, true, 'echovibe-adminweb', 0, true, NULL, 'http://localhost:4200', false, 'https://localhost:4200', false, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'openid-connect', -1, true, true, 'Echo Vibe - Admin Web Application', false, 'client-secret', 'http://localhost:4200', 'Echo Vibe - Admin Web Application', NULL, true, false, false, true);


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.client_attributes VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'client.secret.creation.time', '1739865201');
INSERT INTO public.client_attributes VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'oauth2.device.authorization.grant.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'oidc.ciba.grant.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'backchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'backchannel.logout.revoke.offline.tokens', 'false');
INSERT INTO public.client_attributes VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'realm_client', 'false');
INSERT INTO public.client_attributes VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'display.on.consent.screen', 'false');
INSERT INTO public.client_attributes VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'frontchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'token.endpoint.auth.signing.alg', 'HS256');
INSERT INTO public.client_attributes VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'x509.allow.regex.pattern.comparison', 'true');
INSERT INTO public.client_attributes VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'oauth2.device.authorization.grant.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'oidc.ciba.grant.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'backchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'backchannel.logout.revoke.offline.tokens', 'false');
INSERT INTO public.client_attributes VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'realm_client', 'false');
INSERT INTO public.client_attributes VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'display.on.consent.screen', 'false');
INSERT INTO public.client_attributes VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'frontchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'oauth2.device.authorization.grant.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'oidc.ciba.grant.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'backchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'backchannel.logout.revoke.offline.tokens', 'false');
INSERT INTO public.client_attributes VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'realm_client', 'false');
INSERT INTO public.client_attributes VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'frontchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'login_theme', 'keycloak.v2');
INSERT INTO public.client_attributes VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'display.on.consent.screen', 'true');
INSERT INTO public.client_attributes VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'post.logout.redirect.uris', '*');


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.client_scope VALUES ('56086087-2c7f-47cd-8a38-560049879758', 'offline_access', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope VALUES ('b22c1685-375c-4d89-8235-42a2710575bb', 'role_list', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'SAML role list', 'saml');
INSERT INTO public.client_scope VALUES ('cefd84e3-17e1-4cbd-8478-55edcec42b37', 'saml_organization', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'Organization Membership', 'saml');
INSERT INTO public.client_scope VALUES ('459c69bf-a9f1-4e3b-a409-893c5f00d62b', 'profile', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope VALUES ('e3075fee-3825-4b1e-83d5-b407887919cb', 'email', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope VALUES ('8d935235-1c1d-4901-a961-b7d709422674', 'address', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope VALUES ('0f950e6a-2aa5-4201-8a7b-3af0879c1e90', 'phone', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope VALUES ('8b514977-3187-4562-bbb2-d3f9218405b6', 'roles', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('62ffe561-93df-4ea9-aad1-c85fd0285023', 'web-origins', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('e37b686c-e516-40b0-9155-e8e452a659ce', 'microprofile-jwt', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope VALUES ('b17d39ca-4adc-41f6-ba17-42428af3bb9a', 'acr', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('dfe013ea-56ad-4180-84a4-31db0e05868f', 'basic', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'OpenID Connect scope for add all basic claims to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('28e81e5e-7356-4d30-abf6-0d0a176c850d', 'service_account', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'Specific scope for a client enabled for service accounts', 'openid-connect');
INSERT INTO public.client_scope VALUES ('af2ce3a9-d869-4664-8446-e62e161506f8', 'organization', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'Additional claims about the organization a subject belongs to', 'openid-connect');
INSERT INTO public.client_scope VALUES ('0a21b0dd-6ab7-4d39-bec1-0162a769c732', 'offline_access', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope VALUES ('504ad71b-16c0-424f-a3be-53dc3fb1adcc', 'role_list', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'SAML role list', 'saml');
INSERT INTO public.client_scope VALUES ('626783bd-c0b7-483f-80fc-725dc3b9bc2f', 'saml_organization', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'Organization Membership', 'saml');
INSERT INTO public.client_scope VALUES ('cc09bd09-2896-4add-a759-5c0d146c22fb', 'profile', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope VALUES ('348e9652-774c-48ec-b36a-35db8e017f49', 'email', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope VALUES ('32db0564-2af7-4320-8587-38ee49ccac5f', 'address', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope VALUES ('d3481252-222c-49ad-9023-bdbae7e49ad6', 'phone', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope VALUES ('ad83b366-1434-49b7-9641-986840523046', 'roles', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('01220075-fd5e-4ed7-9aa4-03c1524a184c', 'web-origins', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('7675260a-43b4-4cac-9e87-b9855d128744', 'microprofile-jwt', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope VALUES ('a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', 'acr', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('f54bb7da-6403-42f1-8725-10601970b46f', 'basic', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'OpenID Connect scope for add all basic claims to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('cf8e4818-388d-48e8-867f-bce0dd4ac5d0', 'service_account', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'Specific scope for a client enabled for service accounts', 'openid-connect');
INSERT INTO public.client_scope VALUES ('e12a9cd9-0860-4df4-9056-20a211fd57fa', 'organization', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'Additional claims about the organization a subject belongs to', 'openid-connect');


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.client_scope_attributes VALUES ('56086087-2c7f-47cd-8a38-560049879758', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('56086087-2c7f-47cd-8a38-560049879758', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('b22c1685-375c-4d89-8235-42a2710575bb', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('b22c1685-375c-4d89-8235-42a2710575bb', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('cefd84e3-17e1-4cbd-8478-55edcec42b37', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('459c69bf-a9f1-4e3b-a409-893c5f00d62b', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('459c69bf-a9f1-4e3b-a409-893c5f00d62b', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('459c69bf-a9f1-4e3b-a409-893c5f00d62b', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('e3075fee-3825-4b1e-83d5-b407887919cb', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('e3075fee-3825-4b1e-83d5-b407887919cb', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('e3075fee-3825-4b1e-83d5-b407887919cb', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('8d935235-1c1d-4901-a961-b7d709422674', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('8d935235-1c1d-4901-a961-b7d709422674', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('8d935235-1c1d-4901-a961-b7d709422674', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('0f950e6a-2aa5-4201-8a7b-3af0879c1e90', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('0f950e6a-2aa5-4201-8a7b-3af0879c1e90', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('0f950e6a-2aa5-4201-8a7b-3af0879c1e90', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('8b514977-3187-4562-bbb2-d3f9218405b6', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('8b514977-3187-4562-bbb2-d3f9218405b6', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('8b514977-3187-4562-bbb2-d3f9218405b6', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('62ffe561-93df-4ea9-aad1-c85fd0285023', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('62ffe561-93df-4ea9-aad1-c85fd0285023', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('62ffe561-93df-4ea9-aad1-c85fd0285023', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('e37b686c-e516-40b0-9155-e8e452a659ce', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('e37b686c-e516-40b0-9155-e8e452a659ce', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('b17d39ca-4adc-41f6-ba17-42428af3bb9a', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('b17d39ca-4adc-41f6-ba17-42428af3bb9a', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('dfe013ea-56ad-4180-84a4-31db0e05868f', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('dfe013ea-56ad-4180-84a4-31db0e05868f', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('28e81e5e-7356-4d30-abf6-0d0a176c850d', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('28e81e5e-7356-4d30-abf6-0d0a176c850d', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('af2ce3a9-d869-4664-8446-e62e161506f8', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('af2ce3a9-d869-4664-8446-e62e161506f8', '${organizationScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('af2ce3a9-d869-4664-8446-e62e161506f8', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('0a21b0dd-6ab7-4d39-bec1-0162a769c732', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('0a21b0dd-6ab7-4d39-bec1-0162a769c732', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('504ad71b-16c0-424f-a3be-53dc3fb1adcc', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('504ad71b-16c0-424f-a3be-53dc3fb1adcc', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('626783bd-c0b7-483f-80fc-725dc3b9bc2f', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('cc09bd09-2896-4add-a759-5c0d146c22fb', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('cc09bd09-2896-4add-a759-5c0d146c22fb', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('cc09bd09-2896-4add-a759-5c0d146c22fb', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('348e9652-774c-48ec-b36a-35db8e017f49', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('348e9652-774c-48ec-b36a-35db8e017f49', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('348e9652-774c-48ec-b36a-35db8e017f49', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('32db0564-2af7-4320-8587-38ee49ccac5f', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('32db0564-2af7-4320-8587-38ee49ccac5f', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('32db0564-2af7-4320-8587-38ee49ccac5f', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('d3481252-222c-49ad-9023-bdbae7e49ad6', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('d3481252-222c-49ad-9023-bdbae7e49ad6', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('d3481252-222c-49ad-9023-bdbae7e49ad6', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('ad83b366-1434-49b7-9641-986840523046', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('ad83b366-1434-49b7-9641-986840523046', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('ad83b366-1434-49b7-9641-986840523046', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('01220075-fd5e-4ed7-9aa4-03c1524a184c', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('01220075-fd5e-4ed7-9aa4-03c1524a184c', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('01220075-fd5e-4ed7-9aa4-03c1524a184c', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('7675260a-43b4-4cac-9e87-b9855d128744', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('7675260a-43b4-4cac-9e87-b9855d128744', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('f54bb7da-6403-42f1-8725-10601970b46f', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('f54bb7da-6403-42f1-8725-10601970b46f', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('cf8e4818-388d-48e8-867f-bce0dd4ac5d0', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('cf8e4818-388d-48e8-867f-bce0dd4ac5d0', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('e12a9cd9-0860-4df4-9056-20a211fd57fa', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('e12a9cd9-0860-4df4-9056-20a211fd57fa', '${organizationScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('e12a9cd9-0860-4df4-9056-20a211fd57fa', 'true', 'include.in.token.scope');


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', '459c69bf-a9f1-4e3b-a409-893c5f00d62b', true);
INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', 'b17d39ca-4adc-41f6-ba17-42428af3bb9a', true);
INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', '8b514977-3187-4562-bbb2-d3f9218405b6', true);
INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', 'dfe013ea-56ad-4180-84a4-31db0e05868f', true);
INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', '62ffe561-93df-4ea9-aad1-c85fd0285023', true);
INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', 'e3075fee-3825-4b1e-83d5-b407887919cb', true);
INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', '56086087-2c7f-47cd-8a38-560049879758', false);
INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', '8d935235-1c1d-4901-a961-b7d709422674', false);
INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', 'af2ce3a9-d869-4664-8446-e62e161506f8', false);
INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', '0f950e6a-2aa5-4201-8a7b-3af0879c1e90', false);
INSERT INTO public.client_scope_client VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', 'e37b686c-e516-40b0-9155-e8e452a659ce', false);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', '459c69bf-a9f1-4e3b-a409-893c5f00d62b', true);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', 'b17d39ca-4adc-41f6-ba17-42428af3bb9a', true);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', '8b514977-3187-4562-bbb2-d3f9218405b6', true);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', 'dfe013ea-56ad-4180-84a4-31db0e05868f', true);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', '62ffe561-93df-4ea9-aad1-c85fd0285023', true);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', 'e3075fee-3825-4b1e-83d5-b407887919cb', true);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', '56086087-2c7f-47cd-8a38-560049879758', false);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', '8d935235-1c1d-4901-a961-b7d709422674', false);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', 'af2ce3a9-d869-4664-8446-e62e161506f8', false);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', '0f950e6a-2aa5-4201-8a7b-3af0879c1e90', false);
INSERT INTO public.client_scope_client VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', 'e37b686c-e516-40b0-9155-e8e452a659ce', false);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', '459c69bf-a9f1-4e3b-a409-893c5f00d62b', true);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', 'b17d39ca-4adc-41f6-ba17-42428af3bb9a', true);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', '8b514977-3187-4562-bbb2-d3f9218405b6', true);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', 'dfe013ea-56ad-4180-84a4-31db0e05868f', true);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', '62ffe561-93df-4ea9-aad1-c85fd0285023', true);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', 'e3075fee-3825-4b1e-83d5-b407887919cb', true);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', '56086087-2c7f-47cd-8a38-560049879758', false);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', '8d935235-1c1d-4901-a961-b7d709422674', false);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', 'af2ce3a9-d869-4664-8446-e62e161506f8', false);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', '0f950e6a-2aa5-4201-8a7b-3af0879c1e90', false);
INSERT INTO public.client_scope_client VALUES ('3402b02c-38f6-4ce8-aba9-9fa44ef8f4c0', 'e37b686c-e516-40b0-9155-e8e452a659ce', false);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', '459c69bf-a9f1-4e3b-a409-893c5f00d62b', true);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', 'b17d39ca-4adc-41f6-ba17-42428af3bb9a', true);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', '8b514977-3187-4562-bbb2-d3f9218405b6', true);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', 'dfe013ea-56ad-4180-84a4-31db0e05868f', true);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', '62ffe561-93df-4ea9-aad1-c85fd0285023', true);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', 'e3075fee-3825-4b1e-83d5-b407887919cb', true);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', '56086087-2c7f-47cd-8a38-560049879758', false);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', '8d935235-1c1d-4901-a961-b7d709422674', false);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', 'af2ce3a9-d869-4664-8446-e62e161506f8', false);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', '0f950e6a-2aa5-4201-8a7b-3af0879c1e90', false);
INSERT INTO public.client_scope_client VALUES ('bc5b718d-dea6-421c-a128-ee4a0073136b', 'e37b686c-e516-40b0-9155-e8e452a659ce', false);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', '459c69bf-a9f1-4e3b-a409-893c5f00d62b', true);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', 'b17d39ca-4adc-41f6-ba17-42428af3bb9a', true);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', '8b514977-3187-4562-bbb2-d3f9218405b6', true);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', 'dfe013ea-56ad-4180-84a4-31db0e05868f', true);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', '62ffe561-93df-4ea9-aad1-c85fd0285023', true);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', 'e3075fee-3825-4b1e-83d5-b407887919cb', true);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', '56086087-2c7f-47cd-8a38-560049879758', false);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', '8d935235-1c1d-4901-a961-b7d709422674', false);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', 'af2ce3a9-d869-4664-8446-e62e161506f8', false);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', '0f950e6a-2aa5-4201-8a7b-3af0879c1e90', false);
INSERT INTO public.client_scope_client VALUES ('31dbe232-8b52-42b7-b84e-a211b8b15e83', 'e37b686c-e516-40b0-9155-e8e452a659ce', false);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', '459c69bf-a9f1-4e3b-a409-893c5f00d62b', true);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', 'b17d39ca-4adc-41f6-ba17-42428af3bb9a', true);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', '8b514977-3187-4562-bbb2-d3f9218405b6', true);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', 'dfe013ea-56ad-4180-84a4-31db0e05868f', true);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', '62ffe561-93df-4ea9-aad1-c85fd0285023', true);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', 'e3075fee-3825-4b1e-83d5-b407887919cb', true);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', '56086087-2c7f-47cd-8a38-560049879758', false);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', '8d935235-1c1d-4901-a961-b7d709422674', false);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', 'af2ce3a9-d869-4664-8446-e62e161506f8', false);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', '0f950e6a-2aa5-4201-8a7b-3af0879c1e90', false);
INSERT INTO public.client_scope_client VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', 'e37b686c-e516-40b0-9155-e8e452a659ce', false);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', 'f54bb7da-6403-42f1-8725-10601970b46f', true);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', true);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', '348e9652-774c-48ec-b36a-35db8e017f49', true);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', 'cc09bd09-2896-4add-a759-5c0d146c22fb', true);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', '01220075-fd5e-4ed7-9aa4-03c1524a184c', true);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', 'ad83b366-1434-49b7-9641-986840523046', true);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', '32db0564-2af7-4320-8587-38ee49ccac5f', false);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', 'd3481252-222c-49ad-9023-bdbae7e49ad6', false);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', '0a21b0dd-6ab7-4d39-bec1-0162a769c732', false);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', '7675260a-43b4-4cac-9e87-b9855d128744', false);
INSERT INTO public.client_scope_client VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', 'e12a9cd9-0860-4df4-9056-20a211fd57fa', false);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', 'f54bb7da-6403-42f1-8725-10601970b46f', true);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', true);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', '348e9652-774c-48ec-b36a-35db8e017f49', true);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', 'cc09bd09-2896-4add-a759-5c0d146c22fb', true);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', '01220075-fd5e-4ed7-9aa4-03c1524a184c', true);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', 'ad83b366-1434-49b7-9641-986840523046', true);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', '32db0564-2af7-4320-8587-38ee49ccac5f', false);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', 'd3481252-222c-49ad-9023-bdbae7e49ad6', false);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', '0a21b0dd-6ab7-4d39-bec1-0162a769c732', false);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', '7675260a-43b4-4cac-9e87-b9855d128744', false);
INSERT INTO public.client_scope_client VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', 'e12a9cd9-0860-4df4-9056-20a211fd57fa', false);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', 'f54bb7da-6403-42f1-8725-10601970b46f', true);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', true);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', '348e9652-774c-48ec-b36a-35db8e017f49', true);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', 'cc09bd09-2896-4add-a759-5c0d146c22fb', true);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', '01220075-fd5e-4ed7-9aa4-03c1524a184c', true);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', 'ad83b366-1434-49b7-9641-986840523046', true);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', '32db0564-2af7-4320-8587-38ee49ccac5f', false);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', 'd3481252-222c-49ad-9023-bdbae7e49ad6', false);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', '0a21b0dd-6ab7-4d39-bec1-0162a769c732', false);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', '7675260a-43b4-4cac-9e87-b9855d128744', false);
INSERT INTO public.client_scope_client VALUES ('90da81ff-cd55-42dd-9b4a-d210f3040f59', 'e12a9cd9-0860-4df4-9056-20a211fd57fa', false);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', 'f54bb7da-6403-42f1-8725-10601970b46f', true);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', true);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', '348e9652-774c-48ec-b36a-35db8e017f49', true);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', 'cc09bd09-2896-4add-a759-5c0d146c22fb', true);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', '01220075-fd5e-4ed7-9aa4-03c1524a184c', true);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', 'ad83b366-1434-49b7-9641-986840523046', true);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', '32db0564-2af7-4320-8587-38ee49ccac5f', false);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', 'd3481252-222c-49ad-9023-bdbae7e49ad6', false);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', '0a21b0dd-6ab7-4d39-bec1-0162a769c732', false);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', '7675260a-43b4-4cac-9e87-b9855d128744', false);
INSERT INTO public.client_scope_client VALUES ('8336ebe7-6995-4c27-bdc1-20e484e05418', 'e12a9cd9-0860-4df4-9056-20a211fd57fa', false);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', 'f54bb7da-6403-42f1-8725-10601970b46f', true);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', true);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', '348e9652-774c-48ec-b36a-35db8e017f49', true);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', 'cc09bd09-2896-4add-a759-5c0d146c22fb', true);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', '01220075-fd5e-4ed7-9aa4-03c1524a184c', true);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', 'ad83b366-1434-49b7-9641-986840523046', true);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', '32db0564-2af7-4320-8587-38ee49ccac5f', false);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', 'd3481252-222c-49ad-9023-bdbae7e49ad6', false);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', '0a21b0dd-6ab7-4d39-bec1-0162a769c732', false);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', '7675260a-43b4-4cac-9e87-b9855d128744', false);
INSERT INTO public.client_scope_client VALUES ('35f739f0-f75b-42d7-97ac-82224feeeb7c', 'e12a9cd9-0860-4df4-9056-20a211fd57fa', false);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', 'f54bb7da-6403-42f1-8725-10601970b46f', true);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', true);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', '348e9652-774c-48ec-b36a-35db8e017f49', true);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', 'cc09bd09-2896-4add-a759-5c0d146c22fb', true);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', '01220075-fd5e-4ed7-9aa4-03c1524a184c', true);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', 'ad83b366-1434-49b7-9641-986840523046', true);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', '32db0564-2af7-4320-8587-38ee49ccac5f', false);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', 'd3481252-222c-49ad-9023-bdbae7e49ad6', false);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', '0a21b0dd-6ab7-4d39-bec1-0162a769c732', false);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', '7675260a-43b4-4cac-9e87-b9855d128744', false);
INSERT INTO public.client_scope_client VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', 'e12a9cd9-0860-4df4-9056-20a211fd57fa', false);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'f54bb7da-6403-42f1-8725-10601970b46f', true);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', true);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '348e9652-774c-48ec-b36a-35db8e017f49', true);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'cc09bd09-2896-4add-a759-5c0d146c22fb', true);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '01220075-fd5e-4ed7-9aa4-03c1524a184c', true);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'ad83b366-1434-49b7-9641-986840523046', true);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '32db0564-2af7-4320-8587-38ee49ccac5f', false);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'd3481252-222c-49ad-9023-bdbae7e49ad6', false);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0a21b0dd-6ab7-4d39-bec1-0162a769c732', false);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '7675260a-43b4-4cac-9e87-b9855d128744', false);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'e12a9cd9-0860-4df4-9056-20a211fd57fa', false);
INSERT INTO public.client_scope_client VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'cf8e4818-388d-48e8-867f-bce0dd4ac5d0', true);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'f54bb7da-6403-42f1-8725-10601970b46f', true);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', true);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '348e9652-774c-48ec-b36a-35db8e017f49', true);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'cc09bd09-2896-4add-a759-5c0d146c22fb', true);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '01220075-fd5e-4ed7-9aa4-03c1524a184c', true);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'ad83b366-1434-49b7-9641-986840523046', true);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '32db0564-2af7-4320-8587-38ee49ccac5f', false);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'd3481252-222c-49ad-9023-bdbae7e49ad6', false);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '0a21b0dd-6ab7-4d39-bec1-0162a769c732', false);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '7675260a-43b4-4cac-9e87-b9855d128744', false);
INSERT INTO public.client_scope_client VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'e12a9cd9-0860-4df4-9056-20a211fd57fa', false);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', '01220075-fd5e-4ed7-9aa4-03c1524a184c', true);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'ad83b366-1434-49b7-9641-986840523046', true);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'd3481252-222c-49ad-9023-bdbae7e49ad6', false);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'e12a9cd9-0860-4df4-9056-20a211fd57fa', false);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', '7675260a-43b4-4cac-9e87-b9855d128744', false);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'cc09bd09-2896-4add-a759-5c0d146c22fb', false);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', '32db0564-2af7-4320-8587-38ee49ccac5f', false);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', false);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', '0a21b0dd-6ab7-4d39-bec1-0162a769c732', false);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', '348e9652-774c-48ec-b36a-35db8e017f49', false);
INSERT INTO public.client_scope_client VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'f54bb7da-6403-42f1-8725-10601970b46f', true);


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.client_scope_role_mapping VALUES ('56086087-2c7f-47cd-8a38-560049879758', 'c1a662d0-51bf-43ff-96d4-1e48918c0f05');
INSERT INTO public.client_scope_role_mapping VALUES ('0a21b0dd-6ab7-4d39-bec1-0162a769c732', '64efa757-9b4b-4b6c-a080-40424d8920e4');


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.component VALUES ('16ecc003-8afc-41e0-8441-8385e50083f7', 'Trusted Hosts', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'anonymous');
INSERT INTO public.component VALUES ('2034258a-e387-49c3-b959-4d1f98125fa1', 'Consent Required', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'anonymous');
INSERT INTO public.component VALUES ('cac630fd-30bc-42aa-a99f-5f85ff2c2af5', 'Full Scope Disabled', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'anonymous');
INSERT INTO public.component VALUES ('3d707818-1075-4250-be77-37713f799460', 'Max Clients Limit', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'anonymous');
INSERT INTO public.component VALUES ('6019462a-cbd5-4afd-922c-7a9dca89dd27', 'Allowed Protocol Mapper Types', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'anonymous');
INSERT INTO public.component VALUES ('af5b00c9-aff6-4ade-9b3c-e156d7f222f7', 'Allowed Client Scopes', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'anonymous');
INSERT INTO public.component VALUES ('955f82d6-8b5c-4a7b-92f8-feb7e668892b', 'Allowed Protocol Mapper Types', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'authenticated');
INSERT INTO public.component VALUES ('b646de30-0718-4b54-bd69-7ae221893da2', 'Allowed Client Scopes', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'authenticated');
INSERT INTO public.component VALUES ('a19b0d7c-77d5-47d5-b6c5-0d91512fbee4', 'rsa-generated', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'rsa-generated', 'org.keycloak.keys.KeyProvider', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL);
INSERT INTO public.component VALUES ('b1814cf7-771b-42d2-b786-e576d8f3abac', 'rsa-enc-generated', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL);
INSERT INTO public.component VALUES ('b8148b2d-28b6-4f77-bd77-1d3e6860c955', 'hmac-generated-hs512', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'hmac-generated', 'org.keycloak.keys.KeyProvider', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL);
INSERT INTO public.component VALUES ('c9fdd1cb-d435-40b5-adc0-9c152a90d3b0', 'aes-generated', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'aes-generated', 'org.keycloak.keys.KeyProvider', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL);
INSERT INTO public.component VALUES ('1270bec7-8a67-4906-9f2e-ea38b8d6d90b', NULL, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL);
INSERT INTO public.component VALUES ('cfa9a784-228c-489e-a8d6-01a1f91b580c', 'rsa-generated', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', NULL);
INSERT INTO public.component VALUES ('ea65d09a-0873-4644-ae95-96fdce095309', 'rsa-enc-generated', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', NULL);
INSERT INTO public.component VALUES ('acf4d1be-520c-4b6f-8187-bf17f3682fb6', 'hmac-generated-hs512', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', NULL);
INSERT INTO public.component VALUES ('5d5604c8-3675-40e9-8979-bfbbd79b3dcd', 'aes-generated', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', NULL);
INSERT INTO public.component VALUES ('ae113236-eec2-46d5-8ca9-6a237b3b1c49', 'Trusted Hosts', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'anonymous');
INSERT INTO public.component VALUES ('3220b8eb-f2f4-49ed-af6f-a18c96df86be', 'Consent Required', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'anonymous');
INSERT INTO public.component VALUES ('8a4c1f89-9ed3-4ac6-86eb-7b26784d8d64', 'Full Scope Disabled', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'anonymous');
INSERT INTO public.component VALUES ('be271f7e-4f77-4974-b759-56910c025efe', 'Max Clients Limit', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'anonymous');
INSERT INTO public.component VALUES ('2f370440-99b4-4c73-99f6-354909be5dc6', 'Allowed Protocol Mapper Types', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'anonymous');
INSERT INTO public.component VALUES ('bb9eabc1-f99c-4a53-8eba-bd3c9a2df6b7', 'Allowed Client Scopes', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'anonymous');
INSERT INTO public.component VALUES ('f687699a-01be-4d69-8c9a-4b3b053da03e', 'Allowed Protocol Mapper Types', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'authenticated');
INSERT INTO public.component VALUES ('0ce10203-e23e-4db9-ad39-b54e09c044f8', 'Allowed Client Scopes', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'authenticated');
INSERT INTO public.component VALUES ('25977c9e-7f63-43a3-addf-4c7cfaa153ca', NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', NULL);


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.component_config VALUES ('ec0e2d18-8329-4916-8ff8-d77ab86a135c', '955f82d6-8b5c-4a7b-92f8-feb7e668892b', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('daa3c86e-30e7-4b6f-aed9-c9b47eb5fda5', '955f82d6-8b5c-4a7b-92f8-feb7e668892b', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('b842c98f-16bd-46e5-9c3b-eeed7ebe54b5', '955f82d6-8b5c-4a7b-92f8-feb7e668892b', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('b000b6fa-5a48-4a84-9057-f29ff1ad1804', '955f82d6-8b5c-4a7b-92f8-feb7e668892b', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('24bbcae1-9a04-41dd-be0b-90fcb9f2f274', '955f82d6-8b5c-4a7b-92f8-feb7e668892b', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('7dc761f9-7c3c-40d9-8715-24917bda025d', '955f82d6-8b5c-4a7b-92f8-feb7e668892b', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('360f9cb5-3048-4183-913a-499692a40d60', '955f82d6-8b5c-4a7b-92f8-feb7e668892b', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('6de86e70-9d5b-4170-9d02-bab14d3d9d4f', '955f82d6-8b5c-4a7b-92f8-feb7e668892b', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('af4d2e0d-667f-4e9a-93ef-f8eeedd2b3f9', 'af5b00c9-aff6-4ade-9b3c-e156d7f222f7', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('5b71245a-533d-423c-9688-962c44fe2a5d', '6019462a-cbd5-4afd-922c-7a9dca89dd27', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('bd31fcf9-1f33-48c5-aee5-8932c4fc54d9', '6019462a-cbd5-4afd-922c-7a9dca89dd27', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('9f708774-007e-4e34-bba6-d394f9efef74', '6019462a-cbd5-4afd-922c-7a9dca89dd27', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('15cbbc94-9cce-46c8-b3c5-73abe0c08db1', '6019462a-cbd5-4afd-922c-7a9dca89dd27', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('e8d0fce9-8e0e-48c1-a1ca-ce03a3581b0f', '6019462a-cbd5-4afd-922c-7a9dca89dd27', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('5e045eef-7503-4a9b-a852-cd3eecc1e36b', '6019462a-cbd5-4afd-922c-7a9dca89dd27', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('355cfeca-ae45-4dd1-9e54-08f9d9f66c46', '6019462a-cbd5-4afd-922c-7a9dca89dd27', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('f500b56d-a355-4e7b-b724-777ce6a2f060', '6019462a-cbd5-4afd-922c-7a9dca89dd27', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('aacfd897-4866-4864-88e2-67b3316bffd2', '3d707818-1075-4250-be77-37713f799460', 'max-clients', '200');
INSERT INTO public.component_config VALUES ('8ee6f426-80b9-4f25-b3b6-ec6e31472f96', 'b646de30-0718-4b54-bd69-7ae221893da2', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('a92f99e9-d545-404f-9634-12ef79713cfe', '16ecc003-8afc-41e0-8441-8385e50083f7', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config VALUES ('3f826f2b-37bf-4bd4-be05-9941fcb20496', '16ecc003-8afc-41e0-8441-8385e50083f7', 'client-uris-must-match', 'true');
INSERT INTO public.component_config VALUES ('7eb560c4-30fb-46a9-8666-f958aedc5d73', 'b8148b2d-28b6-4f77-bd77-1d3e6860c955', 'priority', '100');
INSERT INTO public.component_config VALUES ('9573053a-8e55-4503-bad9-5702506eb12a', 'b8148b2d-28b6-4f77-bd77-1d3e6860c955', 'secret', 'w8MmknWteQc61q9uAivqv3bibUyu2mj7urSAHooJKtrZs2WBG7TE0ZWP1lughwqkiFHXZ0WPA0fw9zHS5BInjBKr9bXs5YAPyBYdovChlrEGuD9A1wJzfWRNPjSIouZQmLosbnxCNanHCWf6d-f27MGHsx6oFhA8NPWUXXEam1o');
INSERT INTO public.component_config VALUES ('097e92c5-0dff-4090-94a3-4dd9c36bb703', 'b8148b2d-28b6-4f77-bd77-1d3e6860c955', 'kid', '704fb480-02b4-430f-ae17-f4b9e7270577');
INSERT INTO public.component_config VALUES ('730f3b19-1f25-4427-b6a3-38d8edd302a7', 'b8148b2d-28b6-4f77-bd77-1d3e6860c955', 'algorithm', 'HS512');
INSERT INTO public.component_config VALUES ('b65c1895-57f7-4ff4-8993-720e106e0f56', 'c9fdd1cb-d435-40b5-adc0-9c152a90d3b0', 'secret', 'ul5AAAGRLmWVG6-yASlonw');
INSERT INTO public.component_config VALUES ('bc61934f-613c-4b61-b37a-d01e3297da42', 'c9fdd1cb-d435-40b5-adc0-9c152a90d3b0', 'kid', '1c3cbbe6-2305-47ee-9570-88caf36e7a75');
INSERT INTO public.component_config VALUES ('59cd876e-bd3c-4d03-96c6-e6de98c6362d', 'c9fdd1cb-d435-40b5-adc0-9c152a90d3b0', 'priority', '100');
INSERT INTO public.component_config VALUES ('d1765023-74b7-4f9e-a008-acf4e7b600ec', '1270bec7-8a67-4906-9f2e-ea38b8d6d90b', 'kc.user.profile.config', '{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}');
INSERT INTO public.component_config VALUES ('5bc9d76c-3f7b-4378-b21f-e5e785da21f1', 'a19b0d7c-77d5-47d5-b6c5-0d91512fbee4', 'certificate', 'MIICmzCCAYMCBgGVGAjZOTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMjE4MDc0ODA3WhcNMzUwMjE4MDc0OTQ3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCl3TWxsS+HP6N676YEgD/xhjbR87uGXw9IihAGy4tjHWXbrrJK0P1g3novzCDtxxpSJDjgPIqAE1S4VbW9amMGatV1BziUGBNdaWLUWcllVes113hQSH3Pqr/nD4eZQTgZeAzRkMIYnOpEpo4Sz1Krkplk8PQ09qBTeLOF4fhN+R2bvX6Frik+hU0pGy4IqAZ/gOLNSUvgEVV1fOweS1KmjGpQVlCaAIwpjXbFYtrugcDT6sf/2bXF+zE15mzrPWP4kyRMc9zQ+S0C5mOblcS3yseCO/B3Alful84dE2NW/FxVlkX9OCr/56sgbyLAGpc8ZviXuLULiO2q5mxPaYdvAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJnik+bM/XyN31smFxQ7BZrzlKn3gtUjldO33rHjfuNkNHVBWxqPuXflafgiY10lLjslgf8ty6Bp4SS+9wqXImVbI1PRTVpoCAEsfit8aOOhz5J7/nWoykVssQ+YWowmqAA5XRrRRllhphAWMHo/P9gXPw9WNICeLnKcRssXI/LGE3df4crJggztPiEeO1dGcCkpyYDm8NFKbFr4CSmZ3nWlpfFXMgGBCjZ2GZzgiRMuGxsenoXWhoWZ9sUF2gc23Vv3L7zwTc2Pu4Kfs5nSgAItIc3qa6yVKJHZtm1iovegdEY2OSA4oWv1Arh8xtu7Z9m2chdky0U5PUEbHqFp2K4=');
INSERT INTO public.component_config VALUES ('351e5a7f-9bdd-474a-856c-5464cb6adb7d', 'a19b0d7c-77d5-47d5-b6c5-0d91512fbee4', 'keyUse', 'SIG');
INSERT INTO public.component_config VALUES ('6dcd1e39-1b00-4fab-b8d7-05f07ed7ee85', 'a19b0d7c-77d5-47d5-b6c5-0d91512fbee4', 'priority', '100');
INSERT INTO public.component_config VALUES ('2895bfab-88fc-4fe2-946d-42cee2c27ff3', '0ce10203-e23e-4db9-ad39-b54e09c044f8', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('ede119e6-c05d-4f69-886e-5106ce7ad668', 'ae113236-eec2-46d5-8ca9-6a237b3b1c49', 'client-uris-must-match', 'true');
INSERT INTO public.component_config VALUES ('34cb2c79-7d97-4dfd-981b-b463469f20cf', 'ae113236-eec2-46d5-8ca9-6a237b3b1c49', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config VALUES ('5fb3a8c3-8389-4273-85c3-f66320836d8f', 'bb9eabc1-f99c-4a53-8eba-bd3c9a2df6b7', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('c767522b-ee08-4a06-85a4-890760ecea2d', 'a19b0d7c-77d5-47d5-b6c5-0d91512fbee4', 'privateKey', 'MIIEowIBAAKCAQEApd01sbEvhz+jeu+mBIA/8YY20fO7hl8PSIoQBsuLYx1l266yStD9YN56L8wg7ccaUiQ44DyKgBNUuFW1vWpjBmrVdQc4lBgTXWli1FnJZVXrNdd4UEh9z6q/5w+HmUE4GXgM0ZDCGJzqRKaOEs9Sq5KZZPD0NPagU3izheH4Tfkdm71+ha4pPoVNKRsuCKgGf4DizUlL4BFVdXzsHktSpoxqUFZQmgCMKY12xWLa7oHA0+rH/9m1xfsxNeZs6z1j+JMkTHPc0PktAuZjm5XEt8rHgjvwdwJX7pfOHRNjVvxcVZZF/Tgq/+erIG8iwBqXPGb4l7i1C4jtquZsT2mHbwIDAQABAoIBABPBzlgMuZMcNv55Vma52iQMbzJCHKfMYfcrju4oR8G2KkBpRk6YJ15nEdnosFFygoWfT/ER9RN9ef19JClcZ1BH4IZQpmIpngDmAUI3McCy49IliOzTPb1DYxmEZYwRUzvha3F5E024P0WPK2Q9MuVCEKiP9R7r87wNqCC+AoRTA6ZuPE/w5qpOU+tDf7AT3KjKA5Eu0laADh5DE6eK4SHjrSEEnbfm842Du9x/s/BZauimsTcjPHy89T0k8mfDgfE6/WWuWyeJgSdV66D2WkQesq4VgBQNbDoJXXZwdviTH/f1s4xGvdZj9fnxieRTe3+558xhU5Cw+csQ3lF6nIkCgYEA0B4IRDe9deYEMJDoirF3811ojX3rToBxyzqoqAktJ/BUpSVUf0tdYMJIIUjvDMFmSbdeKiRPRoBwzvOcUhNtgC/9XO+rxvz2hnsJdz4/7+thmAh859eOVpf5AZD/gcjj5dot4stubZQBhJvfyMHg2ppUUIN0k/d2T0NsRXdi0DkCgYEAzAZ99pjdnIgBaFw0kw5m1OMC/VX6hv74AxhXOm/4YiPNdD6Tm70pR1xXX87xBzfeP5LyHayygPsV3tIMd+toqp4BXnfDFvaJTzlevH2J7p+/a/QPE5coDAvyfLwnpFQyMAoePejMHRuP9TuYOjy/9xBPcBu0wlrOaNGbZDR0xOcCgYEAuLDuRRvyVx65uR/gPrUf7imHD4ofuJrkYaa85eK+4CK3+5cVVaJcS/IecOt4uakoTWMdfeibMcXqVr56i5wSISB1iHRpzT3QyaeGzvu/YftRsMpXjqgM+WwE3w7+sP7GwMTO0+YVKcmfTz/FaTQlh9pN2OXQH0ANDmqXO06nsoECgYBGNeG5L+frix445KovBSC8GBcaSTE6rZl5rzGtaYTnePymCTbQvGrtJMjorpVhb4drB02MiravDjj7gftKdVeCh3dfJAWd7F9aRRrl8Km71XuRUd6yVi0w4BeldzaJJXRT9ddsZKWBSs/ii4yaVfeVtSYxJUeyLn+jsKYx+J9KdwKBgFGxxJNatib02SAW/mnKksMw3Y34l1IjoRIFlJfjbjTxZOp95C9QRKGboGaXS+qKEhRIryb2xC11OUhyouPo5h/mQmMqOwcMWdAVx5bJOnNdEolNEytYlWfcsKAWHsERCLDen0tmUwTZbXM0/ZVnI++D62GdAALRor5tETasRoP7');
INSERT INTO public.component_config VALUES ('39e59e96-8170-412d-bfd5-65eb5efb838a', 'b1814cf7-771b-42d2-b786-e576d8f3abac', 'privateKey', 'MIIEpQIBAAKCAQEAxurTRXq+4zUdMsiWq0iHgdGk7N83VWNOShP+u3DOmxFtkFi4F2zIUmgHYjnfzuN1NUHrx0IipLPRoFojyHdpB+3FOxZ1SQtIMAWAz7RURW63nSHYTJ2ls110HjqJxeYfLCcxf5ukENOn0uNz8KP90AWbLJwT4JeO0tYVBABC29O/9W6CNozkiJIygZUe7bkVCydit6r6E4YlJoYaG/cYI55a6nfiyN7yvxk/yJJTR+awxEhHPYDVN+GLrrOR5oTMfX4bK7/FI9HnBNpr8GanvycJu6rmFC5ChX48GuRYKNE3e3iFR2zb36bJYtqbYl4wWbpNllDKV8GwZDaaA0rfLwIDAQABAoIBAASjqG7H6JjS/c3X6M+w3twzwAV4RUmcCdDne3ryrBboxqXls9F0C44EeBud3u7r1il6Up3wmG8/9GUphQkhY9U4AfAZW33rIfFgx3rQqWB/LxAeoHVU/e7bgKBN3DW94r88YMapoh90WEcuX99ea8aEwvQ85afI0R9wt8fCm8yVrq8GN/4nnfJFDI9eB6pijEemU5rvHfnhn7vz0V8kER1FpqoSaSsK77aAg9MCgDQqMaH3U6IHK2tMhHp4yxnS7eysPfEL9wPs4XxRq6NmtaDhfJN49GdBpV3DlOqhdJXcxljYqx61pM0M+qyX2SdDt2mtui/WcHts7VGONDcJ91ECgYEA5IWGHkq58E/LMOH3f8bHwtDlKqJ3nYJs9GKAXoeO49MuohICNOfD4U2h6yWPIBRZkoiDuaEBbIPlUoOVTW2bai4qa/9JjshaRdhgv3fyZ7fJk8c4IyWvsBDcKe9veEG86qssoqnHgv+L5JIA63Q3Gn73pElGUgD6nO+z4fKuHd8CgYEA3tYBgpePm7moTSxJn2rn1Ko0RnFdFIx5z0bnHM+09AbzNT/I9mhqabfFfcAEQL1oeREmWPY3/FiModkWzV8HvafQhlfFrF5U+afinCD4Di/ghkqdJ+Ou9F2HaSRxko4rIGj0txccmCbncDwJYQa2AO/BmF/HK+equvFIY5yuyLECgYEAz+SdF8+5imK9IlJgG9FWB+iMoxW8pgFyZ3149QZzutVzViP19/Vk4QIELO01YOTCfClPVL+hkPwI0uE8IX12Zslq9GcBnzCr12C621UepLaxXoxdiLQPOaiM8mWNziRX3lEtQSodhBJBTQZ6abmHK8aYOdAjdhTH6Z+z0Pk655cCgYEAhvq2+3X3JWs2iVi0V/6X43geJjVxHothFa9rO0aN4+t50t2KS8g//T22QU/Yw6Z37C35PpYWn6K7vSYU694OgFFwvI/aS2jwrDGH0O8fkuhpZq83tvvx9E/bQFM1AINhmEY7RdSYG4olUxTq0X0RLkwMxtHtgajZAFg7cytrrGECgYEAkbwlkGLBTvVOp/hgeafhcZ3Bs9ss5nJimgQPu3SNtDYmxl+y+d+++U93m9JH8Al5ZxCeud9UrN7g2CJ3fDH2W05FtAE+Z66Qcf57PSOIsxJjjGELTO87WRTRo1gWYSH9WZ81vjPAzPWvl9KvPEPoT94pdHCM04gvrgziJXSQdZk=');
INSERT INTO public.component_config VALUES ('8b449aab-78d5-49f8-8887-db7d7d7db141', 'b1814cf7-771b-42d2-b786-e576d8f3abac', 'certificate', 'MIICmzCCAYMCBgGVGAjanzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMjE4MDc0ODA4WhcNMzUwMjE4MDc0OTQ4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDG6tNFer7jNR0yyJarSIeB0aTs3zdVY05KE/67cM6bEW2QWLgXbMhSaAdiOd/O43U1QevHQiKks9GgWiPId2kH7cU7FnVJC0gwBYDPtFRFbredIdhMnaWzXXQeOonF5h8sJzF/m6QQ06fS43Pwo/3QBZssnBPgl47S1hUEAELb07/1boI2jOSIkjKBlR7tuRULJ2K3qvoThiUmhhob9xgjnlrqd+LI3vK/GT/IklNH5rDESEc9gNU34Yuus5HmhMx9fhsrv8Uj0ecE2mvwZqe/Jwm7quYULkKFfjwa5Fgo0Td7eIVHbNvfpsli2ptiXjBZuk2WUMpXwbBkNpoDSt8vAgMBAAEwDQYJKoZIhvcNAQELBQADggEBALC51Hji2Q6guBD0D1bSPZoTfWOiezRSAN/g2u1OU+IXUct9OT5OxM0c+Zdic+VIfXlEU5vzllGrQfqpSfgiy2JYtkP/n+HUpa2cxATZE7vtLV4CI3pHzyhrdcQr1osE1FUOjLZydDSLVCQVC7GRDbbbgsrgiGjZJ1iNRyHz6nKWV8bIlPLX191NlfmcvWIpBfbdAKYP36G+a2E54seDq2lBo+mHauokdc+OpqHDzbQolck2zWmEBh9NFD9L5oEfoj6pWRclPkMAr+P7jup686+cnWNvWPv6ZlS91AbSfyN4oYT4PLm1e0E8nUnzgYNurj5Z58zUCkXA7ePt1b5sNWU=');
INSERT INTO public.component_config VALUES ('2cbfe970-8fd5-4c2a-8d3a-976b234a0a83', 'b1814cf7-771b-42d2-b786-e576d8f3abac', 'keyUse', 'ENC');
INSERT INTO public.component_config VALUES ('ddcaaaa6-113e-4dff-b0ad-cbae6e7f5bbd', 'b1814cf7-771b-42d2-b786-e576d8f3abac', 'priority', '100');
INSERT INTO public.component_config VALUES ('e989ee9d-d5da-4b9b-87eb-66b1101d1ffa', 'b1814cf7-771b-42d2-b786-e576d8f3abac', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config VALUES ('7df21aea-327e-48bd-a981-6667534c92ac', 'acf4d1be-520c-4b6f-8187-bf17f3682fb6', 'kid', '35db1a79-d972-4bd9-a114-05b7167b0706');
INSERT INTO public.component_config VALUES ('7a12efad-4b54-4cca-a148-fed0f99433a3', 'acf4d1be-520c-4b6f-8187-bf17f3682fb6', 'algorithm', 'HS512');
INSERT INTO public.component_config VALUES ('960b9156-47f3-48ff-b3fb-6e863c3197c7', 'acf4d1be-520c-4b6f-8187-bf17f3682fb6', 'secret', 'N2cfkiXpgneKxIK57ktL_5V3jU-4LeKsPaSsnKVzlfvE2dc4GCIBziminD7ynHUlwgslWLZlm10SynQVHHntbbIT3PjECWKyLA8Tb7iUIgHrSV-hfhqIDZtd1t3rHmJaeG1ATZOf7s70xSfgqKT51xkkyVPHsBWnvrDqNL9CoM4');
INSERT INTO public.component_config VALUES ('ee22820c-1b0d-498d-92e7-124f1e406372', 'acf4d1be-520c-4b6f-8187-bf17f3682fb6', 'priority', '100');
INSERT INTO public.component_config VALUES ('5e42e53a-ed13-4555-8ff8-851e16b372ed', 'cfa9a784-228c-489e-a8d6-01a1f91b580c', 'certificate', 'MIICnzCCAYcCBgGVGAs1YDANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhlY2hvdmliZTAeFw0yNTAyMTgwNzUwNDJaFw0zNTAyMTgwNzUyMjJaMBMxETAPBgNVBAMMCGVjaG92aWJlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvsiaMZYMrkxzQgGkbZ+79dWj6l9O4/Jy8BKVzxXzuIxUFJPzVOQZcte1V9Ap2g8UXhxCSOu8NkKlr589RfqVYmyvxZWfpRPFm0N4mOPZLZOIbJ5vSsHrI/2zmVVyRC5atXWpQS+Qv0IfOIDUFtLOTid0TtIiqHJnxiRP36gltQNMAvqyeJMbemLrN3db/X4oYCC/GzcgycfJsGXJ7xI2ic1LAaccE+NKMEh1qfvJT22GjqnTgeM23rFd9nMaMQ1SHWIpFwvddFOEkX3pwQBrOHiyFG1U8+819QyiYCs7met2xmEoMvunwSaXH2ehGBA1fvpFWH0mEo3cA/XG29DGyQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQB3vzKyDAF3kYZLmw5Fpe6bdtvwwkjlwB0YMYx2eeUI0mvaLYh9qG1hUMDQSS8KwW7wGZ4yXgE4v+oIXifEgZh2UQ5NbTbctatUBokkjfPPZ+G6oAjPR89b62NKP2nEZQGi8UHy8mqZ7Qs5TZjOmfNvUpOilFJbylIFNl3008AxOI2OC0bAScpYbeSFl4UZ424MR46fNktBSdvEhTuBm6QrwIWXo50AneSciMOlU71dn4oRFICyjwpRQolbcQ0nRLHrwAVv7iowrdQ27BacOO0pE7nqvBhV+NfYomOWmjVLVI4u1jOpiQR4r9o9C2hxTK3mDhjHpCnJwVqAQKjL7goc');
INSERT INTO public.component_config VALUES ('c91e41b6-4843-4fb5-8dcb-3939fdd7dd4d', '25977c9e-7f63-43a3-addf-4c7cfaa153ca', 'kc.user.profile.config', '{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}');
INSERT INTO public.component_config VALUES ('fae60a56-0009-402e-8e12-d71d46935f33', 'cfa9a784-228c-489e-a8d6-01a1f91b580c', 'privateKey', 'MIIEpAIBAAKCAQEAvsiaMZYMrkxzQgGkbZ+79dWj6l9O4/Jy8BKVzxXzuIxUFJPzVOQZcte1V9Ap2g8UXhxCSOu8NkKlr589RfqVYmyvxZWfpRPFm0N4mOPZLZOIbJ5vSsHrI/2zmVVyRC5atXWpQS+Qv0IfOIDUFtLOTid0TtIiqHJnxiRP36gltQNMAvqyeJMbemLrN3db/X4oYCC/GzcgycfJsGXJ7xI2ic1LAaccE+NKMEh1qfvJT22GjqnTgeM23rFd9nMaMQ1SHWIpFwvddFOEkX3pwQBrOHiyFG1U8+819QyiYCs7met2xmEoMvunwSaXH2ehGBA1fvpFWH0mEo3cA/XG29DGyQIDAQABAoIBAExu8deL1ei+mC6JmeaRaCxFOzZamLCaIZIs3/fnQ41cKxNTctk/yTJJWU2lCB9kizRo/eVZDD5w1RBXK6Utj0uvX3w5RYxNL43UqiwWnJu1z6I0l0HMDviMW7fCk9Tc/VpVmUmUVNlLFFb+xfme2yhUhjRN27TAoPKw+Y8RPooV5ZOq5AKrknsEajobVRepYLH0TY4AsuTkXq+NV2d6PBfUQdUUrr4gh9XFZziFwYBQWxESvMrlqeGzR2TwTg9pPOzLgnwOu5RdRLcmkJyMookjufmU0Ia+Vvwp+OMn2G8lyqs6oQNhNoNaWjLIONXztGmEbU10bN6OxWtES2fXVkECgYEA+pIbdokIesvXpz616VRom1H5I1XL2mFM6Saa6sykDa8pp4RM+9B4icc0tmMd6J1kkjSOoSKp21jITEv/8BjU8wMlskOpIeMAKX426mUAOeOVwFIwY9udsImzVZfkR79XvwPJBqE555z/wE8skgfU+EaXSvzdK57ccSl6Ytu7kEsCgYEAwurcgdk8u3MyIxHRXjHpyfEW68cm7+2in3JuS1prURUi/5iWxhEJCTPAULD6VBP8hPPKQJdcaVXjrR7AqxyEYWI6IZMZzhoNsK10KZsNdjp2Bjin3GPVrWjX7LZ8WS/tesDTms1768cCg7EpoRl4IpIoaRnuWM3nqt9hHf4vILsCgYBKDPPgzA6de7B31KieFDv16vvd3XUpTKgWHzqZOXEiOintP8QghzOYRC7n19L288zNCIs+Q6g/ErXfFnbE1hHY3408aZKKWTOrD4nbK44tjXysIZ37ZOPtUESXfxQPwBSGdu/p7avXLybGBp/9aCMgXHxJxQD36zLqnn90x8tekQKBgQCrPj12Es3JfZ45s0i2sbFMynOxtyidN7Bc1uLRbuHDvYce+QbVglfm7sFx4to6jciXYbt53cDBhkTdbpwkeIxRJkQeBSdxq/AFHY5lkyRTj27rblEDTe6HSAoTnAtJK9M+ujPt18OcVB4AZuBE+aRS8wdvtulwuY1j0JZ5DDyJSwKBgQCzJH6jQjJhEaxdwv6JrBkZhO8wMJnDozEZznFwNccbdtJhtid6I81VLP1xkTtVef6jWNywx4KKlhVl6ZhwORZcOtiiqGYO4nhWaDCXm5NEh6b7OkQQepVJpyD+zrkzCp+xhAFm5RSUV2EMoPS/nHjYZB7fypBZ0sgOpWWguy7+lw==');
INSERT INTO public.component_config VALUES ('3190fa23-5a77-4f36-bbb6-86c457c6ddaf', 'cfa9a784-228c-489e-a8d6-01a1f91b580c', 'priority', '100');
INSERT INTO public.component_config VALUES ('22639fbe-851e-4b1c-bdc7-91110e93a415', 'cfa9a784-228c-489e-a8d6-01a1f91b580c', 'keyUse', 'SIG');
INSERT INTO public.component_config VALUES ('f622112c-f06b-4fc7-a484-5561eade81e2', 'ea65d09a-0873-4644-ae95-96fdce095309', 'priority', '100');
INSERT INTO public.component_config VALUES ('b88b14f4-a7cb-4d3e-aa3b-33eb56ee1f2d', 'ea65d09a-0873-4644-ae95-96fdce095309', 'keyUse', 'ENC');
INSERT INTO public.component_config VALUES ('ee53c60d-96db-4ac9-9b50-163e3e6355d3', 'ea65d09a-0873-4644-ae95-96fdce095309', 'certificate', 'MIICnzCCAYcCBgGVGAs14DANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhlY2hvdmliZTAeFw0yNTAyMTgwNzUwNDJaFw0zNTAyMTgwNzUyMjJaMBMxETAPBgNVBAMMCGVjaG92aWJlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7LFfjztdqe4Fp5GlOlN57/vB3KtAsTFYbx5J+u6fd2sAWS6w0ncsUhJVtXY5keayJmd1YE0YNj00ucW7piBxc0qX2IS4U8Wj8T/jK+EwlHyQo8+koTEMZE6IfUSyv1u5bgWGfq5hKj5CY6ad4RR4QLs35mNWQGI2+M/PBzEPyPrVKgGsJVrr3x9ED9srJT9LT5L4AoYgQ4H98rArxC+q2qZ19Pm6Dnr09Mp2+0CPqxQoZFjb9YEkrXx0M10rosPGdHUNzB6cMg85Vs97MXZijLNneC9Hnma87+B6EltrxknZcX+10+pyJfdF5P7uDvlNTIWCHYX7l78hLF5vOkaIpQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCnDflud+MpXj5SsBbRLBJJlIbIb5wvSo/nb8HWB+aCmE9//ijlmMElXzgMe5FtHXRbplRLdNX0Iz8soVNvbV9ddXfyu0P862fTjni7B+BkyyUzwYRubn58vCh9RqotHX6fK97KkUn74F0WjrItxYGAP20PC3zMMdDHbX2WzBoZc4L4nd1LfgD9o3dTLW63mfc0x/5rI+2sKO9M2QB6JPfpYXON8d4tD8Ov/rqRsd9YsSbaZxH4T+2bZG94qqi7pvN40I8AcQe9bx9oCaw1qIIe1KP05obU61zfjHK+rrfP6b0N/D4iAmiF/0W6lb8rPCGQSHlaAEQQSzIIvI8dBLcc');
INSERT INTO public.component_config VALUES ('97d58086-d834-4a43-8c5f-ef34a780eaa6', 'ea65d09a-0873-4644-ae95-96fdce095309', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config VALUES ('651cf9ab-a76b-4e84-a601-580161d02477', 'ea65d09a-0873-4644-ae95-96fdce095309', 'privateKey', 'MIIEowIBAAKCAQEA7LFfjztdqe4Fp5GlOlN57/vB3KtAsTFYbx5J+u6fd2sAWS6w0ncsUhJVtXY5keayJmd1YE0YNj00ucW7piBxc0qX2IS4U8Wj8T/jK+EwlHyQo8+koTEMZE6IfUSyv1u5bgWGfq5hKj5CY6ad4RR4QLs35mNWQGI2+M/PBzEPyPrVKgGsJVrr3x9ED9srJT9LT5L4AoYgQ4H98rArxC+q2qZ19Pm6Dnr09Mp2+0CPqxQoZFjb9YEkrXx0M10rosPGdHUNzB6cMg85Vs97MXZijLNneC9Hnma87+B6EltrxknZcX+10+pyJfdF5P7uDvlNTIWCHYX7l78hLF5vOkaIpQIDAQABAoIBACojY9tYmtK7bOdJvyw0m1NVs0xJcsF5AwD5V/tkCyDT/GJkNRerHslXuUmOjC5E73d12Mg1wXc6i039fWxUf04ivAjQjA5h889p69QuiZsN2CRJvcnytP2Qm60Nk3MM7eS/+BNKkULXhbM/AQGGxufjTM7n5X2d3qKKQJXLrr89TRsI3agxo/S2vNhhRRB20ErTXZReQU8nCGxy10QNtIZMtI5PQcyT86ge44LGlhXyVSrfzL+anDfmxtQ/Gmti6NrnU5+lO9RTNEPIaCAanti36M0cY2KBntg/Ac95rGFbqIcGXVddCW7y6k92rKTFkIblTpnnfSWGDVTKylos7rECgYEA9rqskEhh2SaeRQNDD8y/m+8MziVjb93nw/5HeunMODtANDgGMMgJlNETgjMv9jBYYvA9P+3QyL2SQgHjMpUX7vWy1jY4MJzVpiAoquqElFFwAqpUFPFKMwTdSggksQGupMOD16kHeckiqZ5jLyxEHsRz0gXvoeaXdERSdGBrIvkCgYEA9ZYof3x9lZIf0/cDK6o197mzc9KhFsQYmHecr943xZrA+em3NM4I15NI/pi8P9DMy5Tji/tqdUSkJ4d/r1eEtxS7/wWB8M8jYSTMceV8prJjS8THhEc3TKZfVDBFdJDvBiYrbbPTKnoSEsLtlZUQXPtrCGmDnIORTdD5DWcyUg0CgYEAqbTg+SUwWILdni6ONBHrQcB9mFXTPaDux7rhQ8QIuizXDpPyfh85p+jfeFDpDndWdEc2egCD+W+baFeQBLzUh4Lsjbchkx5tPiUkk9tXcgVJ/CtYRkdpeApCg6dyRWYY0C/DQdV71OLqOq09H7dc66TI3Y9DsqK/TjOoW2/ugVECgYBlqBpraySw3SO/oef2EybzvDLEJtP3kIR92EVLpzh+22g2CsCDYyXV1mnIuYBzCgM74g2uzAttL1Sj6Dq6YgfVoQeQsL7w501F0O2v18aZWg4wNuw/nRsO529ecfzOG5BVg0dGycEHPDBvA7FE0cdMNeZAPSz1hKCJDY+KNMVnoQKBgBDqBpzSGzTzKRt+NotlhBK5300v3HljxrSY3Y6ZvcvvEkAYKoCnKuObudN9FbED2c8dtCF3jJN60JlyPX1RG6DZKRzBo+XOlWSNQ2f5/hU1mColcTbY1OmLZZpaUlXlAR24tgNqwyHsaMPpb3b298OdtcPBhWvwy6Wegtq/WDxP');
INSERT INTO public.component_config VALUES ('4c33c1b8-0a73-4774-a83b-07c01fa59d77', '5d5604c8-3675-40e9-8979-bfbbd79b3dcd', 'kid', '04976e7a-114d-44a3-b3a7-05470c32417f');
INSERT INTO public.component_config VALUES ('8d0f1ac1-bd2c-4f32-8b5e-06869c611376', '5d5604c8-3675-40e9-8979-bfbbd79b3dcd', 'priority', '100');
INSERT INTO public.component_config VALUES ('f8f87908-c98f-4c68-bb6e-8a0fbc4b7ce7', '5d5604c8-3675-40e9-8979-bfbbd79b3dcd', 'secret', 'NaLlxbRTAJngwcLkGRpZfQ');
INSERT INTO public.component_config VALUES ('865b1317-6e12-4ae0-af54-8c99e5f33d94', '2f370440-99b4-4c73-99f6-354909be5dc6', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('3dce86da-5d53-4cd5-8807-7265dde829c2', '2f370440-99b4-4c73-99f6-354909be5dc6', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('21f6593f-2669-4288-9f72-0b5e770397ef', '2f370440-99b4-4c73-99f6-354909be5dc6', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('8efc2e5c-1018-410f-a9cd-9208585cce5f', '2f370440-99b4-4c73-99f6-354909be5dc6', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('b9ec902a-c766-428a-9a51-e604ae4856a8', '2f370440-99b4-4c73-99f6-354909be5dc6', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('a37c52a3-17b2-4b3a-b148-14e91ead611e', '2f370440-99b4-4c73-99f6-354909be5dc6', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('15220502-b810-4c29-ab19-9d8a0fc70895', '2f370440-99b4-4c73-99f6-354909be5dc6', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('0d02e7f3-4065-44e2-8e3e-4c7893364e14', '2f370440-99b4-4c73-99f6-354909be5dc6', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('9fd35f6e-5336-4670-90c0-6d29d00500e6', 'f687699a-01be-4d69-8c9a-4b3b053da03e', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('32df2367-cb5e-4094-8b42-2b07d771f07a', 'f687699a-01be-4d69-8c9a-4b3b053da03e', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('7d744b4b-a77f-491f-9b61-7d38e7f656c7', 'f687699a-01be-4d69-8c9a-4b3b053da03e', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('b6bb9bb0-4de5-4b20-bf07-ae31348a56e8', 'f687699a-01be-4d69-8c9a-4b3b053da03e', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('4bc4cb82-5fbb-4cef-90e3-ce45ffa7a3ee', 'f687699a-01be-4d69-8c9a-4b3b053da03e', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('326f3f30-a0d8-4a55-9c28-cf07385cb1e1', 'f687699a-01be-4d69-8c9a-4b3b053da03e', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('5b647956-4d70-4774-9b9a-f4bf49e9cd77', 'f687699a-01be-4d69-8c9a-4b3b053da03e', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('3ce6a468-25b1-4ac7-8c3d-23bdc4fcd175', 'f687699a-01be-4d69-8c9a-4b3b053da03e', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('fc5e74be-b12e-43bd-90a4-cac5a10ecfeb', 'be271f7e-4f77-4974-b759-56910c025efe', 'max-clients', '200');


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '90f9c3d5-9103-48b9-8ed7-df08696d71c8');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'd520ac7f-3728-4149-b4d8-8ae8c9e28216');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '2d9f2c00-c967-48e2-92d7-676d2e22e4f7');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '58838024-f927-4c2b-8fd1-53bcf416285f');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'c500bd77-e0b2-45a3-b227-1f84fdda100c');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '47d28230-4bfe-4071-b4ad-353713ec23f2');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'bbaaabd2-198d-4670-97f4-1e670fcbed5f');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '9d3c5fac-57e4-40e6-8816-81feda9fb837');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'a81f7977-121c-4833-be86-27a3b6fa73d2');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '16203318-f9e1-4098-b41d-9c8744172c16');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '242f3efb-0bd0-46a4-900a-956600353642');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '48933e21-1151-4559-8425-32f3aa8b0f06');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'c8650a4c-c6f0-4019-a815-a09cf55729a9');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'bf3d98fb-2d7e-4fd3-8736-955f41746b92');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '472725c7-9ff2-49a1-85c9-81eb9ac19075');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '9eb4a721-1bd7-440f-8916-ec217adc6329');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'd01f434d-5652-4784-bc49-7e3fbc7fd45c');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '979d011b-98ce-4d8f-b52c-eeae0bd0dd55');
INSERT INTO public.composite_role VALUES ('58838024-f927-4c2b-8fd1-53bcf416285f', '979d011b-98ce-4d8f-b52c-eeae0bd0dd55');
INSERT INTO public.composite_role VALUES ('58838024-f927-4c2b-8fd1-53bcf416285f', '472725c7-9ff2-49a1-85c9-81eb9ac19075');
INSERT INTO public.composite_role VALUES ('c500bd77-e0b2-45a3-b227-1f84fdda100c', '9eb4a721-1bd7-440f-8916-ec217adc6329');
INSERT INTO public.composite_role VALUES ('d3c05f33-6706-4396-a2b2-2268456979e3', 'b45e837b-6fcf-44c9-ac2e-5b22b5645ff7');
INSERT INTO public.composite_role VALUES ('d3c05f33-6706-4396-a2b2-2268456979e3', 'c8ba8356-8216-46bf-a431-47b0b9de0d34');
INSERT INTO public.composite_role VALUES ('c8ba8356-8216-46bf-a431-47b0b9de0d34', '694ddf7d-3a30-45a5-b3a9-1009f9b66dfa');
INSERT INTO public.composite_role VALUES ('8c5e9bf4-bde3-4d00-b7ff-5248221bcc9a', '777a4a38-0eeb-481e-ba22-9cbd06f462c5');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '86ec3620-4f6e-48e9-848f-62e842354319');
INSERT INTO public.composite_role VALUES ('d3c05f33-6706-4396-a2b2-2268456979e3', 'c1a662d0-51bf-43ff-96d4-1e48918c0f05');
INSERT INTO public.composite_role VALUES ('d3c05f33-6706-4396-a2b2-2268456979e3', '48e6c230-8c04-4682-a594-50f40015b60a');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '9fdb12ac-6a24-4f1b-b609-4cb445ddbf12');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '0f1b767f-2dfb-44b2-89ac-5571effeab09');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '517217fd-ff05-42db-80fb-b8144966698e');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '8f67d525-da63-4721-8f8d-84bde38daeb4');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '44005010-22b9-42d6-9daf-cecbdebe68db');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'eb6aaaab-f201-42ea-8784-0c8782eaa8ee');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'e11b0d6d-7835-4d40-9de3-ca5d2d7f4d65');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'd4572116-b13a-4dc5-802f-260fa49f1d48');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'a886a2c1-bb4c-46c1-add9-377cd7d3d00e');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'd6843af6-35ac-402f-a47f-ad522fa2dcf8');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'b620c24b-0793-4312-8f1a-f30593f8f3f3');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '8971b3b9-c3b2-43b8-8295-13fc6c796016');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '271cfd2d-91ac-4709-ad4d-babdc43e6d8d');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '5ef854bd-68ae-4a3d-adbb-a2c6349eeb2c');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '9b361a6d-4c7e-44d8-a18b-13581268ea2b');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'aedab4e3-6655-4751-acd9-78d5e75031ce');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', 'a0861a27-78c7-4d09-9ea2-978195c7e917');
INSERT INTO public.composite_role VALUES ('517217fd-ff05-42db-80fb-b8144966698e', '5ef854bd-68ae-4a3d-adbb-a2c6349eeb2c');
INSERT INTO public.composite_role VALUES ('517217fd-ff05-42db-80fb-b8144966698e', 'a0861a27-78c7-4d09-9ea2-978195c7e917');
INSERT INTO public.composite_role VALUES ('8f67d525-da63-4721-8f8d-84bde38daeb4', '9b361a6d-4c7e-44d8-a18b-13581268ea2b');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', 'a81d15fa-7dde-41d7-a442-23cc82355df0');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', 'd2b1bdb5-fca3-40b3-ac55-760dc7b2bab9');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '6fdc94fa-bf18-4810-9855-8b2896f428a5');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '44b45f91-4b23-49d3-bf05-c52a2b56c629');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '83b9f2cc-737e-4aea-b7ae-2c5bad0e17ff');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', 'aa56f4f6-5aa9-4965-9924-46f3af55502d');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '42bd1074-987d-409c-a494-0cc504d084f0');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '3f471337-62da-4a46-b8a7-17424a790618');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', 'b7b009bd-5932-4cec-b0f1-308f913c1f5c');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '1399ad75-8c8e-4c2b-bede-9639abe5492c');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '72be0591-a36c-4f66-a915-a749035d7152');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '62901d69-6a2b-48ac-9946-f7e937f77f63');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', 'f4d97501-58a6-46d8-b1f0-691504623c37');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', 'b42c9c10-448f-440a-af35-8c67583f3e22');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', 'd41e0d07-46ed-4427-ab0e-4ac93bc34317');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '1bd2b1f1-790c-439f-a19a-9ac069878ffb');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '4355c3bc-9487-4f78-8ede-f5cb257ca4c4');
INSERT INTO public.composite_role VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '27e1ca03-473f-4f79-83be-3a1bcfe4a513');
INSERT INTO public.composite_role VALUES ('44b45f91-4b23-49d3-bf05-c52a2b56c629', 'd41e0d07-46ed-4427-ab0e-4ac93bc34317');
INSERT INTO public.composite_role VALUES ('6fdc94fa-bf18-4810-9855-8b2896f428a5', 'b42c9c10-448f-440a-af35-8c67583f3e22');
INSERT INTO public.composite_role VALUES ('6fdc94fa-bf18-4810-9855-8b2896f428a5', '4355c3bc-9487-4f78-8ede-f5cb257ca4c4');
INSERT INTO public.composite_role VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '4f8af0cb-3953-4212-bbce-820870e010b4');
INSERT INTO public.composite_role VALUES ('4f8af0cb-3953-4212-bbce-820870e010b4', '40e3ec88-cc76-4c76-bda3-51e2519185c3');
INSERT INTO public.composite_role VALUES ('a17ed491-2603-481b-9175-f383c241d9f3', 'fd687c2f-9a61-41e7-bd78-2aed4561aa35');
INSERT INTO public.composite_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '003e1b7b-a684-4fd0-aab7-04232cd3afbd');
INSERT INTO public.composite_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', 'a776a0a2-94d5-4d5d-b811-cc40d9bb0762');
INSERT INTO public.composite_role VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '64efa757-9b4b-4b6c-a080-40424d8920e4');
INSERT INTO public.composite_role VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '755f878b-3ade-4b2f-b278-7224f5a20352');
INSERT INTO public.composite_role VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '7683a5f1-cf76-4cb3-ad13-f68f3975d95f');


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.credential VALUES ('9b476195-8627-42e5-b4e0-502ab3121bb3', NULL, 'password', '4a047c9a-f502-4788-a0ce-2f8f3f632960', 1739865113716, 'My password', '{"value":"inDkNmnb76WhgAONCTT/C5ofHxq3vHSeBH992AttdNo=","salt":"6acdBmljPHskEw9aUSwShA==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10);
INSERT INTO public.credential VALUES ('afbcbb5c-f11e-451b-bdde-7d31f12fcd6b', NULL, 'password', '790e017c-4459-4921-b732-49b14a7779be', 1739865572644, 'My password', '{"value":"8c4DeyPFLmmNyahThKajD6d/LMgSZQhsLRKspIk0KsI=","salt":"95+KrTGFcTxhhwCmydImfg==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10);
INSERT INTO public.credential VALUES ('281aef76-3fc8-44aa-8a2e-691ecf3b142c', NULL, 'password', '2aad1ba3-aa92-44b7-9d86-e8d51b3ee6e1', 1739892141380, 'My password', '{"value":"JQaaYccBWIhGiODgSnun92Mo4+UR/nLxskkNnde6WcE=","salt":"E5GBY3bXveEAyFCZxfieGA==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10);
INSERT INTO public.credential VALUES ('52598b96-c87d-42b4-9d0b-0d812eebe506', NULL, 'password', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc', 1742441950350, 'My password', '{"value":"6WW+BlyaMyjn3T6b0FpRJV/CutxrK3UNDwvV+aFgajE=","salt":"P7wIIRZBe2rPSDZ4rZDeww==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10);
INSERT INTO public.credential VALUES ('def27d2d-f834-4eb3-b5a6-6ea9bcf0053e', NULL, 'password', 'ece32357-5624-4a80-9367-58ae81562601', 1742549723661, 'My password', '{"value":"HQx2SoIW8OglKOMoKkVjnmM9iUdUKGZLjaAp9lTA0Ac=","salt":"rKYKujlzZcOI6gsHXpx/dA==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10);


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2025-02-18 07:49:28.723459', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2025-02-18 07:49:28.768012', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2025-02-18 07:49:28.878049', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2025-02-18 07:49:28.889215', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2025-02-18 07:49:29.168368', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2025-02-18 07:49:29.182407', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2025-02-18 07:49:29.403345', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2025-02-18 07:49:29.41356', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2025-02-18 07:49:29.427383', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2025-02-18 07:49:29.670403', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2025-02-18 07:49:29.820809', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2025-02-18 07:49:29.830059', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2025-02-18 07:49:29.875156', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-02-18 07:49:29.941714', 14, 'EXECUTED', '9:6005e15e84714cd83226bf7879f54190', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-02-18 07:49:29.950819', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-02-18 07:49:29.959132', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-02-18 07:49:29.968487', 17, 'EXECUTED', '9:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2025-02-18 07:49:30.084157', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2025-02-18 07:49:30.196856', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2025-02-18 07:49:30.210059', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2025-02-18 07:49:30.219541', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2025-02-18 07:49:30.226643', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2025-02-18 07:49:30.382601', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2025-02-18 07:49:30.397255', 24, 'EXECUTED', '9:c9999da42f543575ab790e76439a2679', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2025-02-18 07:49:30.40168', 25, 'MARK_RAN', '9:0d6c65c6f58732d81569e77b10ba301d', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2025-02-18 07:49:31.222318', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2025-02-18 07:49:31.395656', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2025-02-18 07:49:31.403881', 28, 'EXECUTED', '9:44bae577f551b3738740281eceb4ea70', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2025-02-18 07:49:31.553105', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2025-02-18 07:49:31.591137', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2025-02-18 07:49:31.63147', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2025-02-18 07:49:31.642282', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-02-18 07:49:31.656006', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-02-18 07:49:31.66191', 34, 'MARK_RAN', '9:3a32bace77c84d7678d035a7f5a8084e', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-02-18 07:49:31.737117', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2025-02-18 07:49:31.751306', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-02-18 07:49:31.764979', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2025-02-18 07:49:31.774857', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2025-02-18 07:49:31.787432', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-02-18 07:49:31.80212', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-02-18 07:49:31.808782', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2025-02-18 07:49:31.820634', 42, 'EXECUTED', '9:fc86359c079781adc577c5a217e4d04c', 'customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-02-18 07:49:35.103936', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2025-02-18 07:49:35.122595', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-02-18 07:49:35.14412', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-02-18 07:49:35.158768', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-02-18 07:49:35.165227', 47, 'MARK_RAN', '9:51abbacd7b416c50c4421a8cabf7927e', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-02-18 07:49:35.534605', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-02-18 07:49:35.552246', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2025-02-18 07:49:35.707561', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2025-02-18 07:49:36.775649', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2025-02-18 07:49:36.789745', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2025-02-18 07:49:36.798203', 53, 'EXECUTED', '9:8f23e334dbc59f82e0a328373ca6ced0', 'update tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2025-02-18 07:49:36.807627', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-02-18 07:49:36.830775', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-02-18 07:49:36.855453', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-02-18 07:49:37.006923', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-02-18 07:49:38.055737', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2025-02-18 07:49:38.115325', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2025-02-18 07:49:38.128342', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2025-02-18 07:49:38.148851', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2025-02-18 07:49:38.187613', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2025-02-18 07:49:38.196551', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2025-02-18 07:49:38.204221', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2025-02-18 07:49:38.211651', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2025-02-18 07:49:38.319416', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2025-02-18 07:49:38.402824', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2025-02-18 07:49:38.414551', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2025-02-18 07:49:38.532717', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2025-02-18 07:49:38.545877', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2025-02-18 07:49:38.556585', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-02-18 07:49:38.573979', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-02-18 07:49:38.589775', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-02-18 07:49:38.596381', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-02-18 07:49:38.65374', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-02-18 07:49:38.747395', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-02-18 07:49:38.758141', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-02-18 07:49:38.762245', 78, 'MARK_RAN', '9:6bdb5658951e028bfe16fa0a8228b530', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-02-18 07:49:38.813419', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-02-18 07:49:38.818307', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-02-18 07:49:38.906373', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-02-18 07:49:38.91013', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-02-18 07:49:38.92138', 83, 'EXECUTED', '9:966bda61e46bebf3cc39518fbed52fa7', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-02-18 07:49:38.925432', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-02-18 07:49:39.037289', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2025-02-18 07:49:39.051379', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2025-02-18 07:49:39.077158', 87, 'EXECUTED', '9:a9ba7d47f065f041b7da856a81762021', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2025-02-18 07:49:39.105888', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-02-18 07:49:39.119643', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-02-18 07:49:39.137368', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-02-18 07:49:39.216181', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-02-18 07:49:39.241854', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-02-18 07:49:39.245581', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-02-18 07:49:39.272387', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-02-18 07:49:39.278422', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-02-18 07:49:39.294392', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-02-18 07:49:39.557312', 97, 'EXECUTED', '9:24fb8611e97f29989bea412aa38d12b7', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-02-18 07:49:39.563179', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-02-18 07:49:39.600518', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-02-18 07:49:39.707713', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-02-18 07:49:39.713231', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-02-18 07:49:39.813775', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-02-18 07:49:39.826309', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2025-02-18 07:49:39.844865', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2025-02-18 07:49:39.950341', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2025-02-18 07:49:40.065855', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('18.0.15-30992-index-consent', 'keycloak', 'META-INF/jpa-changelog-18.0.15.xml', '2025-02-18 07:49:40.17511', 107, 'EXECUTED', '9:80071ede7a05604b1f4906f3bf3b00f0', 'createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2025-02-18 07:49:40.185153', 108, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-02-18 07:49:40.305782', 109, 'EXECUTED', '9:e5f243877199fd96bcc842f27a1656ac', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-02-18 07:49:40.31146', 110, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-02-18 07:49:40.329917', 111, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2025-02-18 07:49:40.340922', 112, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2025-02-18 07:49:40.400806', 113, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2025-02-18 07:49:40.409585', 114, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('22.0.0-17484-updated', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2025-02-18 07:49:40.422204', 115, 'EXECUTED', '9:90af0bfd30cafc17b9f4d6eccd92b8b3', 'customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('22.0.5-24031', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2025-02-18 07:49:40.426354', 116, 'MARK_RAN', '9:a60d2d7b315ec2d3eba9e2f145f9df28', 'customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('23.0.0-12062', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2025-02-18 07:49:40.442733', 117, 'EXECUTED', '9:2168fbe728fec46ae9baf15bf80927b8', 'addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('23.0.0-17258', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2025-02-18 07:49:40.453232', 118, 'EXECUTED', '9:36506d679a83bbfda85a27ea1864dca8', 'addColumn tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('24.0.0-9758', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-02-18 07:49:40.795849', 119, 'EXECUTED', '9:502c557a5189f600f0f445a9b49ebbce', 'addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('24.0.0-9758-2', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-02-18 07:49:40.80639', 120, 'EXECUTED', '9:bf0fdee10afdf597a987adbf291db7b2', 'customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('24.0.0-26618-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-02-18 07:49:40.818373', 121, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('24.0.0-26618-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-02-18 07:49:40.910816', 122, 'EXECUTED', '9:08707c0f0db1cef6b352db03a60edc7f', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27228', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-02-18 07:49:40.920919', 123, 'EXECUTED', '9:eaee11f6b8aa25d2cc6a84fb86fc6238', 'customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27967-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-02-18 07:49:40.925683', 124, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27967-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-02-18 07:49:40.932735', 125, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-tables', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:40.948815', 126, 'EXECUTED', '9:deda2df035df23388af95bbd36c17cef', 'addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.05696', 127, 'EXECUTED', '9:3e96709818458ae49f3c679ae58d263a', 'createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-createdon', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.161468', 128, 'EXECUTED', '9:78ab4fc129ed5e8265dbcc3485fba92f', 'dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-preload', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.23243', 129, 'EXECUTED', '9:de5f7c1f7e10994ed8b62e621d20eaab', 'dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-by-usersess', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.303099', 130, 'EXECUTED', '9:6eee220d024e38e89c799417ec33667f', 'dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-css-preload', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.372752', 131, 'EXECUTED', '9:5411d2fb2891d3e8d63ddb55dfa3c0c9', 'dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-2-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.376806', 132, 'MARK_RAN', '9:b7ef76036d3126bb83c2423bf4d449d6', 'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-2-not-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.49016', 133, 'EXECUTED', '9:23396cf51ab8bc1ae6f0cac7f9f6fcf7', 'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('25.0.0-org', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.571283', 134, 'EXECUTED', '9:5c859965c2c9b9c72136c360649af157', 'createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('unique-consentuser', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.604337', 135, 'EXECUTED', '9:5857626a2ea8767e9a6c66bf3a2cb32f', 'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('unique-consentuser-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.609782', 136, 'MARK_RAN', '9:b79478aad5adaa1bc428e31563f55e8e', 'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28861-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-02-18 07:49:41.849869', 137, 'EXECUTED', '9:b9acb58ac958d9ada0fe12a5d4794ab1', 'createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-alias', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-02-18 07:49:41.87373', 138, 'EXECUTED', '9:6ef7d63e4412b3c2d66ed179159886a4', 'addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-group', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-02-18 07:49:41.89403', 139, 'EXECUTED', '9:da8e8087d80ef2ace4f89d8c5b9ca223', 'addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-indexes', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-02-18 07:49:42.050434', 140, 'EXECUTED', '9:79b05dcd610a8c7f25ec05135eec0857', 'createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-group-membership', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-02-18 07:49:42.073234', 141, 'EXECUTED', '9:a6ace2ce583a421d89b01ba2a28dc2d4', 'addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('31296-persist-revoked-access-tokens', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-02-18 07:49:42.092663', 142, 'EXECUTED', '9:64ef94489d42a358e8304b0e245f0ed4', 'createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('31725-index-persist-revoked-access-tokens', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-02-18 07:49:42.209281', 143, 'EXECUTED', '9:b994246ec2bf7c94da881e1d28782c7b', 'createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('26.0.0-idps-for-login', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-02-18 07:49:42.447733', 144, 'EXECUTED', '9:51f5fffadf986983d4bd59582c6c1604', 'addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('26.0.0-32583-drop-redundant-index-on-client-session', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-02-18 07:49:42.519017', 145, 'EXECUTED', '9:24972d83bf27317a055d234187bb4af9', 'dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-02-18 07:49:42.563602', 146, 'EXECUTED', '9:febdc0f47f2ed241c59e60f58c3ceea5', 'dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('26.0.0-33201-org-redirect-url', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-02-18 07:49:42.572891', 147, 'EXECUTED', '9:4d0e22b0ac68ebe9794fa9cb752ea660', 'addColumn tableName=ORG', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('29399-jdbc-ping-default', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-02-18 07:49:42.599025', 148, 'EXECUTED', '9:007dbe99d7203fca403b89d4edfdf21e', 'createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('26.1.0-34013', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-02-18 07:49:42.619072', 149, 'EXECUTED', '9:e6b686a15759aef99a6d758a5c4c6a26', 'addColumn tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '9864967699');
INSERT INTO public.databasechangelog VALUES ('26.1.0-34380', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-02-18 07:49:42.634706', 150, 'EXECUTED', '9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01', 'dropTable tableName=USERNAME_LOGIN_FAILURE', '', NULL, '4.29.1', NULL, NULL, '9864967699');


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.databasechangeloglock VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock VALUES (1000, false, NULL, NULL);


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '56086087-2c7f-47cd-8a38-560049879758', false);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'b22c1685-375c-4d89-8235-42a2710575bb', true);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'cefd84e3-17e1-4cbd-8478-55edcec42b37', true);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '459c69bf-a9f1-4e3b-a409-893c5f00d62b', true);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'e3075fee-3825-4b1e-83d5-b407887919cb', true);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '8d935235-1c1d-4901-a961-b7d709422674', false);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '0f950e6a-2aa5-4201-8a7b-3af0879c1e90', false);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '8b514977-3187-4562-bbb2-d3f9218405b6', true);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '62ffe561-93df-4ea9-aad1-c85fd0285023', true);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'e37b686c-e516-40b0-9155-e8e452a659ce', false);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'b17d39ca-4adc-41f6-ba17-42428af3bb9a', true);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'dfe013ea-56ad-4180-84a4-31db0e05868f', true);
INSERT INTO public.default_client_scope VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'af2ce3a9-d869-4664-8446-e62e161506f8', false);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', '0a21b0dd-6ab7-4d39-bec1-0162a769c732', false);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', '504ad71b-16c0-424f-a3be-53dc3fb1adcc', true);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', '626783bd-c0b7-483f-80fc-725dc3b9bc2f', true);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'cc09bd09-2896-4add-a759-5c0d146c22fb', true);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', '348e9652-774c-48ec-b36a-35db8e017f49', true);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', '32db0564-2af7-4320-8587-38ee49ccac5f', false);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'd3481252-222c-49ad-9023-bdbae7e49ad6', false);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'ad83b366-1434-49b7-9641-986840523046', true);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', '01220075-fd5e-4ed7-9aa4-03c1524a184c', true);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', '7675260a-43b4-4cac-9e87-b9855d128744', false);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d', true);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'f54bb7da-6403-42f1-8725-10601970b46f', true);
INSERT INTO public.default_client_scope VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'e12a9cd9-0860-4df4-9056-20a211fd57fa', false);


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.federated_identity VALUES ('google', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '111360646318490639273', 'vutien.dat.3601@gmail.com', NULL, '4c50b1e9-e68d-4dcc-af55-90239c585a43');
INSERT INTO public.federated_identity VALUES ('google', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '115231815514181279511', 'ptung230801@gmail.com', NULL, '0b217f9c-59b3-4b71-a0cb-082bd43b2c35');
INSERT INTO public.federated_identity VALUES ('google', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '111061934930526084256', 'pttung230801@gmail.com', NULL, 'b6165172-130a-4480-bbf5-3651691834ca');
INSERT INTO public.federated_identity VALUES ('google', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '116149246634223445701', 'truonglam.113.147@gmail.com', NULL, '82e87c6a-1ad1-4fa3-98d3-f8cc366b030b');


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.identity_provider VALUES ('77895c6e-2f44-4cd0-87cd-e46df9674ae2', true, 'google', 'google', false, false, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', false, false, NULL, NULL, '', false, NULL, false);


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.identity_provider_config VALUES ('77895c6e-2f44-4cd0-87cd-e46df9674ae2', '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', 'clientSecret');
INSERT INTO public.identity_provider_config VALUES ('77895c6e-2f44-4cd0-87cd-e46df9674ae2', '177688628623-uhq05ubipt14c7341ubkg106qouink3o.apps.googleusercontent.com', 'clientId');


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.identity_provider_mapper VALUES ('72b4599a-6c33-437b-af6a-c985963e2afc', 'Google Picture Mapper', 'google', 'google-user-attribute-mapper', 'dd6a5b23-a699-44e1-8210-886a0a2eafac');


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.idp_mapper_config VALUES ('72b4599a-6c33-437b-af6a-c985963e2afc', 'INHERIT', 'syncMode');
INSERT INTO public.idp_mapper_config VALUES ('72b4599a-6c33-437b-af6a-c985963e2afc', 'picture', 'userAttribute');
INSERT INTO public.idp_mapper_config VALUES ('72b4599a-6c33-437b-af6a-c985963e2afc', 'picture', 'jsonField');


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.jgroups_ping VALUES ('uuid://1ce4b8cd-cb9e-4b34-a62c-8c47d5bcfe00', 'echovibe-keycloak-i1-17528', 'ISPN', '172.18.0.3:7800', true);


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.keycloak_role VALUES ('d3c05f33-6706-4396-a2b2-2268456979e3', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', false, '${role_default-roles}', 'default-roles-master', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', false, '${role_admin}', 'admin', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('90f9c3d5-9103-48b9-8ed7-df08696d71c8', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', false, '${role_create-realm}', 'create-realm', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('d520ac7f-3728-4149-b4d8-8ae8c9e28216', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_create-client}', 'create-client', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('2d9f2c00-c967-48e2-92d7-676d2e22e4f7', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_view-realm}', 'view-realm', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('58838024-f927-4c2b-8fd1-53bcf416285f', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_view-users}', 'view-users', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('c500bd77-e0b2-45a3-b227-1f84fdda100c', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_view-clients}', 'view-clients', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('47d28230-4bfe-4071-b4ad-353713ec23f2', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_view-events}', 'view-events', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('bbaaabd2-198d-4670-97f4-1e670fcbed5f', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_view-identity-providers}', 'view-identity-providers', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('9d3c5fac-57e4-40e6-8816-81feda9fb837', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_view-authorization}', 'view-authorization', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('a81f7977-121c-4833-be86-27a3b6fa73d2', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_manage-realm}', 'manage-realm', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('16203318-f9e1-4098-b41d-9c8744172c16', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_manage-users}', 'manage-users', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('242f3efb-0bd0-46a4-900a-956600353642', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_manage-clients}', 'manage-clients', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('48933e21-1151-4559-8425-32f3aa8b0f06', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_manage-events}', 'manage-events', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('c8650a4c-c6f0-4019-a815-a09cf55729a9', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_manage-identity-providers}', 'manage-identity-providers', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('bf3d98fb-2d7e-4fd3-8736-955f41746b92', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_manage-authorization}', 'manage-authorization', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('472725c7-9ff2-49a1-85c9-81eb9ac19075', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_query-users}', 'query-users', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('9eb4a721-1bd7-440f-8916-ec217adc6329', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_query-clients}', 'query-clients', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('d01f434d-5652-4784-bc49-7e3fbc7fd45c', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_query-realms}', 'query-realms', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('979d011b-98ce-4d8f-b52c-eeae0bd0dd55', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_query-groups}', 'query-groups', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('b45e837b-6fcf-44c9-ac2e-5b22b5645ff7', 'd7b0975b-215f-4b16-8118-663a45af5a3c', true, '${role_view-profile}', 'view-profile', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'd7b0975b-215f-4b16-8118-663a45af5a3c', NULL);
INSERT INTO public.keycloak_role VALUES ('c8ba8356-8216-46bf-a431-47b0b9de0d34', 'd7b0975b-215f-4b16-8118-663a45af5a3c', true, '${role_manage-account}', 'manage-account', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'd7b0975b-215f-4b16-8118-663a45af5a3c', NULL);
INSERT INTO public.keycloak_role VALUES ('694ddf7d-3a30-45a5-b3a9-1009f9b66dfa', 'd7b0975b-215f-4b16-8118-663a45af5a3c', true, '${role_manage-account-links}', 'manage-account-links', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'd7b0975b-215f-4b16-8118-663a45af5a3c', NULL);
INSERT INTO public.keycloak_role VALUES ('28b2de13-4ada-4dc8-8806-57db83a74a71', 'd7b0975b-215f-4b16-8118-663a45af5a3c', true, '${role_view-applications}', 'view-applications', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'd7b0975b-215f-4b16-8118-663a45af5a3c', NULL);
INSERT INTO public.keycloak_role VALUES ('777a4a38-0eeb-481e-ba22-9cbd06f462c5', 'd7b0975b-215f-4b16-8118-663a45af5a3c', true, '${role_view-consent}', 'view-consent', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'd7b0975b-215f-4b16-8118-663a45af5a3c', NULL);
INSERT INTO public.keycloak_role VALUES ('8c5e9bf4-bde3-4d00-b7ff-5248221bcc9a', 'd7b0975b-215f-4b16-8118-663a45af5a3c', true, '${role_manage-consent}', 'manage-consent', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'd7b0975b-215f-4b16-8118-663a45af5a3c', NULL);
INSERT INTO public.keycloak_role VALUES ('98fd5993-790b-45d6-9b0f-9594e32a5647', 'd7b0975b-215f-4b16-8118-663a45af5a3c', true, '${role_view-groups}', 'view-groups', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'd7b0975b-215f-4b16-8118-663a45af5a3c', NULL);
INSERT INTO public.keycloak_role VALUES ('1e9b9992-02e9-4aeb-9391-a0b2d7ab3b5a', 'd7b0975b-215f-4b16-8118-663a45af5a3c', true, '${role_delete-account}', 'delete-account', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'd7b0975b-215f-4b16-8118-663a45af5a3c', NULL);
INSERT INTO public.keycloak_role VALUES ('b3723922-e9fb-4177-b250-d4ad370a9f67', 'bc5b718d-dea6-421c-a128-ee4a0073136b', true, '${role_read-token}', 'read-token', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'bc5b718d-dea6-421c-a128-ee4a0073136b', NULL);
INSERT INTO public.keycloak_role VALUES ('86ec3620-4f6e-48e9-848f-62e842354319', '31dbe232-8b52-42b7-b84e-a211b8b15e83', true, '${role_impersonation}', 'impersonation', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '31dbe232-8b52-42b7-b84e-a211b8b15e83', NULL);
INSERT INTO public.keycloak_role VALUES ('c1a662d0-51bf-43ff-96d4-1e48918c0f05', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', false, '${role_offline-access}', 'offline_access', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('48e6c230-8c04-4682-a594-50f40015b60a', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', false, '${role_uma_authorization}', 'uma_authorization', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', false, '${role_default-roles}', 'default-roles-echovibe', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('9fdb12ac-6a24-4f1b-b609-4cb445ddbf12', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_create-client}', 'create-client', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('0f1b767f-2dfb-44b2-89ac-5571effeab09', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_view-realm}', 'view-realm', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('517217fd-ff05-42db-80fb-b8144966698e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_view-users}', 'view-users', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('8f67d525-da63-4721-8f8d-84bde38daeb4', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_view-clients}', 'view-clients', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('44005010-22b9-42d6-9daf-cecbdebe68db', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_view-events}', 'view-events', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('eb6aaaab-f201-42ea-8784-0c8782eaa8ee', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_view-identity-providers}', 'view-identity-providers', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('e11b0d6d-7835-4d40-9de3-ca5d2d7f4d65', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_view-authorization}', 'view-authorization', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('d4572116-b13a-4dc5-802f-260fa49f1d48', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_manage-realm}', 'manage-realm', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('a886a2c1-bb4c-46c1-add9-377cd7d3d00e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_manage-users}', 'manage-users', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('d6843af6-35ac-402f-a47f-ad522fa2dcf8', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_manage-clients}', 'manage-clients', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('b620c24b-0793-4312-8f1a-f30593f8f3f3', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_manage-events}', 'manage-events', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('8971b3b9-c3b2-43b8-8295-13fc6c796016', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_manage-identity-providers}', 'manage-identity-providers', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('271cfd2d-91ac-4709-ad4d-babdc43e6d8d', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_manage-authorization}', 'manage-authorization', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('5ef854bd-68ae-4a3d-adbb-a2c6349eeb2c', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_query-users}', 'query-users', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('9b361a6d-4c7e-44d8-a18b-13581268ea2b', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_query-clients}', 'query-clients', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('aedab4e3-6655-4751-acd9-78d5e75031ce', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_query-realms}', 'query-realms', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('a0861a27-78c7-4d09-9ea2-978195c7e917', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_query-groups}', 'query-groups', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_realm-admin}', 'realm-admin', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('a81d15fa-7dde-41d7-a442-23cc82355df0', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_create-client}', 'create-client', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('d2b1bdb5-fca3-40b3-ac55-760dc7b2bab9', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_view-realm}', 'view-realm', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('6fdc94fa-bf18-4810-9855-8b2896f428a5', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_view-users}', 'view-users', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('44b45f91-4b23-49d3-bf05-c52a2b56c629', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_view-clients}', 'view-clients', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('83b9f2cc-737e-4aea-b7ae-2c5bad0e17ff', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_view-events}', 'view-events', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('aa56f4f6-5aa9-4965-9924-46f3af55502d', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_view-identity-providers}', 'view-identity-providers', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('42bd1074-987d-409c-a494-0cc504d084f0', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_view-authorization}', 'view-authorization', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('3f471337-62da-4a46-b8a7-17424a790618', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_manage-realm}', 'manage-realm', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('b7b009bd-5932-4cec-b0f1-308f913c1f5c', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_manage-users}', 'manage-users', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('1399ad75-8c8e-4c2b-bede-9639abe5492c', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_manage-clients}', 'manage-clients', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('72be0591-a36c-4f66-a915-a749035d7152', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_manage-events}', 'manage-events', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('62901d69-6a2b-48ac-9946-f7e937f77f63', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('f4d97501-58a6-46d8-b1f0-691504623c37', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_manage-authorization}', 'manage-authorization', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('b42c9c10-448f-440a-af35-8c67583f3e22', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_query-users}', 'query-users', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('d41e0d07-46ed-4427-ab0e-4ac93bc34317', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_query-clients}', 'query-clients', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('1bd2b1f1-790c-439f-a19a-9ac069878ffb', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_query-realms}', 'query-realms', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('4355c3bc-9487-4f78-8ede-f5cb257ca4c4', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_query-groups}', 'query-groups', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('27e1ca03-473f-4f79-83be-3a1bcfe4a513', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', true, '${role_view-profile}', 'view-profile', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', NULL);
INSERT INTO public.keycloak_role VALUES ('4f8af0cb-3953-4212-bbce-820870e010b4', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', true, '${role_manage-account}', 'manage-account', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', NULL);
INSERT INTO public.keycloak_role VALUES ('40e3ec88-cc76-4c76-bda3-51e2519185c3', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', true, '${role_manage-account-links}', 'manage-account-links', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', NULL);
INSERT INTO public.keycloak_role VALUES ('22004d3b-0773-4e07-9789-1c628128c373', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', true, '${role_view-applications}', 'view-applications', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', NULL);
INSERT INTO public.keycloak_role VALUES ('fd687c2f-9a61-41e7-bd78-2aed4561aa35', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', true, '${role_view-consent}', 'view-consent', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', NULL);
INSERT INTO public.keycloak_role VALUES ('a17ed491-2603-481b-9175-f383c241d9f3', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', true, '${role_manage-consent}', 'manage-consent', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', NULL);
INSERT INTO public.keycloak_role VALUES ('dbfdc817-d71a-4673-b890-bbf0d37f0da7', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', true, '${role_view-groups}', 'view-groups', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', NULL);
INSERT INTO public.keycloak_role VALUES ('ac383a78-e1ce-4800-bb18-58986bbb3f18', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', true, '${role_delete-account}', 'delete-account', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', NULL);
INSERT INTO public.keycloak_role VALUES ('003e1b7b-a684-4fd0-aab7-04232cd3afbd', '3031e683-70a3-4b1f-af4d-e6677b127cf9', true, '${role_impersonation}', 'impersonation', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '3031e683-70a3-4b1f-af4d-e6677b127cf9', NULL);
INSERT INTO public.keycloak_role VALUES ('a776a0a2-94d5-4d5d-b811-cc40d9bb0762', '35f739f0-f75b-42d7-97ac-82224feeeb7c', true, '${role_impersonation}', 'impersonation', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '35f739f0-f75b-42d7-97ac-82224feeeb7c', NULL);
INSERT INTO public.keycloak_role VALUES ('b18947c5-2899-4c3f-a03b-46d34c64751c', '8336ebe7-6995-4c27-bdc1-20e484e05418', true, '${role_read-token}', 'read-token', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '8336ebe7-6995-4c27-bdc1-20e484e05418', NULL);
INSERT INTO public.keycloak_role VALUES ('64efa757-9b4b-4b6c-a080-40424d8920e4', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', false, '${role_offline-access}', 'offline_access', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('755f878b-3ade-4b2f-b278-7224f5a20352', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', false, '${role_uma_authorization}', 'uma_authorization', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('adc8ecf8-ecad-4583-afd3-1322cbeae86a', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', true, NULL, 'uma_protection', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);
INSERT INTO public.keycloak_role VALUES ('7683a5f1-cf76-4cb3-ad13-f68f3975d95f', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', true, 'End-user role', 'user', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);
INSERT INTO public.keycloak_role VALUES ('435aeb6e-b775-44dd-9387-ce3dc556d2b2', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', true, 'Adminitrator', 'admin', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);
INSERT INTO public.keycloak_role VALUES ('0b4eccd2-b305-4026-9705-4b9fa028cb1c', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', true, '', 'artist', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);
INSERT INTO public.keycloak_role VALUES ('73d2123e-fd74-4ba8-876a-d0decdef85eb', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', true, 'Use to manage related details of artist like account, recover ...', 'artist_manager', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.migration_model VALUES ('5cpdg', '26.1.2', 1739864985);


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.offline_client_session VALUES ('89d2a229-439b-4dcd-8cc2-46e1b4d8f435', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745143383, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745143382","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"b294dVl-MHYuaGJrbDJEZmpHcll0VTBRUVJ5ZFhQeHl6R2pnYUtwSU5IdmtV","scope":"openid profile email offline_access","userSessionStartedAt":"1745143382","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"b294dVl-MHYuaGJrbDJEZmpHcll0VTBRUVJ5ZFhQeHl6R2pnYUtwSU5IdmtV","code_challenge":"n8stWVNK_x8Y91jj-PXGW8WPViwu0aOqjs8ws523fBI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('8aa5f3e1-ad93-4b2f-b267-c12f50426351', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745566757, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745566757","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"XzZfUndJbFNXdWxYWDQ3S3lZck5CRWFkRDduel9RbGdyYl9Qc1h1TkdPU35H","scope":"openid profile email offline_access","userSessionStartedAt":"1745566757","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"XzZfUndJbFNXdWxYWDQ3S3lZck5CRWFkRDduel9RbGdyYl9Qc1h1TkdPU35H","code_challenge":"wt8FrX8yK2h5v305obPPFy8hsoyotfeLFQjDKWeBEco"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c468666b-c57d-4707-aae3-3831846f185b', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745733000, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745732999","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Wk9kQUMzUnNWeGlNNkZtVGdweGswTUhLZm8zOHk4TGxFc0hocEJpdXN2NGtR","scope":"openid profile email offline_access","userSessionStartedAt":"1745732999","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"Wk9kQUMzUnNWeGlNNkZtVGdweGswTUhLZm8zOHk4TGxFc0hocEJpdXN2NGtR","code_challenge":"DkOVufuW__-FfKz0mICIW1NUwp-tq19ZqHBC87SzJvE"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('dcf8e6a7-90e8-4234-9844-3679011bfc82', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742631048, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742629252","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742631048","level-of-authentication":"-1"}}', 'local', 'local', 100);
INSERT INTO public.offline_client_session VALUES ('fcfcf91d-e0db-4c7a-8d21-5fef7ce90deb', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745919020, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745919020","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cUlZQ3pCWlRwYXk2NWtGdzhFelBPYktJcDRNanBoYzBwNzlYMUw0WGsuT0FU","scope":"openid profile email offline_access","userSessionStartedAt":"1745919020","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"cUlZQ3pCWlRwYXk2NWtGdzhFelBPYktJcDRNanBoYzBwNzlYMUw0WGsuT0FU","code_challenge":"Ih-0_d-wpuxJVGwL-SwcAFpd8zHD_oFMH0HRaGBeDyU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('f75a7605-4a43-4acd-899b-637276aa7f86', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745734559, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745734559","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bDliV1BWclZOY2h5S1FtdllaSnZpNUMxUGNaQTJFTlRNRjJxc29RS0p1eTB0","scope":"openid profile email offline_access","userSessionStartedAt":"1745734559","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"bDliV1BWclZOY2h5S1FtdllaSnZpNUMxUGNaQTJFTlRNRjJxc29RS0p1eTB0","code_challenge":"9twEWcAwdmP0R2VvsrfKXf5RChID7zm_NDB91-8LKCU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3dcf0c36-aa13-4fb8-8873-b97435e72725', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745143387, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745143387","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TWtkOE9GYnp-VXN2aldzSmszWmxDMlJtV3gycn43Z2E0TlAwMk00ek1xYUpT","scope":"openid profile email offline_access","userSessionStartedAt":"1745143387","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"TWtkOE9GYnp-VXN2aldzSmszWmxDMlJtV3gycn43Z2E0TlAwMk00ek1xYUpT","code_challenge":"7eB5Un5JulORBaIgEPq3kmUYIRu70PPTEo8VRUkeNVY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3dcf0c36-aa13-4fb8-8873-b97435e72725', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745144719, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745143387","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745144719","level-of-authentication":"-1"}}', 'local', 'local', 10);
INSERT INTO public.offline_client_session VALUES ('37e1adbc-20b9-418f-a8be-282c26b1cc80', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745144745, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745144745","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SHNGZWJtb2hkUjRJNUJLa1VQSV9NbFcxNFBJZ0tTMmtwdmh4b1poS1hBTXd1","scope":"openid profile email offline_access","userSessionStartedAt":"1745144745","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"SHNGZWJtb2hkUjRJNUJLa1VQSV9NbFcxNFBJZ0tTMmtwdmh4b1poS1hBTXd1","code_challenge":"MZ1ZLMXVr3WX_ZRg7hYhP_u_sHXobaW-yusuGsnn0Jo"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('f68505f8-eb23-4520-b960-3ce591287568', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745568252, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745568252","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NDhPRElhQVRPNjB3QzVsan50S3FCV1RRdUE5VUNQRlVrT0dqamxrSW9wNVRy","scope":"openid profile email offline_access","userSessionStartedAt":"1745568252","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"NDhPRElhQVRPNjB3QzVsan50S3FCV1RRdUE5VUNQRlVrT0dqamxrSW9wNVRy","code_challenge":"FcC0sSFSDeCiLpfFsCrNh3BFPB6LgA64jNKnSLzSCY0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('1341bfae-dec6-456f-bda3-d6cebc235637', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745734958, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"wD9_OVSeK7NABc4CEMw21Q","startedAt":"1745734957","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZmhocmxXNzJZU35lOThQa2NSTzRTVWVzWEVMS3ZhX3h5QVdiWVowNzVxci1Y","scope":"openid profile email offline_access","userSessionStartedAt":"1745734957","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"ZmhocmxXNzJZU35lOThQa2NSTzRTVWVzWEVMS3ZhX3h5QVdiWVowNzVxci1Y","code_challenge":"fhPJawp-59ltD2QKs1JbBerR3Iuc0Wx7qQLMLVy9q3o"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b6f6a60a-36dd-4516-8cad-2c31fbcadb46', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745919036, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745919036","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TlN3ZmptMzRPc0s1aUhvTkdYMzV4WDVsM0tCQ0Z-QjN4fmJRS2RMLngwMzZk","scope":"openid profile email offline_access","userSessionStartedAt":"1745919036","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"TlN3ZmptMzRPc0s1aUhvTkdYMzV4WDVsM0tCQ0Z-QjN4fmJRS2RMLngwMzZk","code_challenge":"ZqzUR3wQM3e6NJjslfQo0xjDsDHe1mtVkiz4IXAXE5Y"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('9f26c794-a0eb-444c-a95c-b1d7b01bc30c', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745571428, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745571428","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cWtVUm1XU3dfWXFzSXhvYkxwbXVOdWZORH5MZG1idmgtZlJReXJKdmp5eDU2","scope":"openid profile email offline_access","userSessionStartedAt":"1745571428","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"cWtVUm1XU3dfWXFzSXhvYkxwbXVOdWZORH5MZG1idmgtZlJReXJKdmp5eDU2","code_challenge":"qc5BiL816k3-gESIIhLJnb7jF1srDJFH-sruRXKcYKI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('4911baa6-9457-47c0-9f49-09bbabab0615', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745734966, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"3xGoD8DovCyaxfsVMFZd4g","startedAt":"1745734965","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MmQ3NGVjak1iaVVpeFR4ZHN4R0RJSHB1UlFCdy5vVDZOcjVEb1lmYjguQ0pP","scope":"openid profile email offline_access","userSessionStartedAt":"1745734965","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"MmQ3NGVjak1iaVVpeFR4ZHN4R0RJSHB1UlFCdy5vVDZOcjVEb1lmYjguQ0pP","code_challenge":"ichmqlVYrl78b5fvXeYtIE-5kNlcIoWtz3hoU8n-vRM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b6f6a60a-36dd-4516-8cad-2c31fbcadb46', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745919082, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745919082","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TG5lTGcyYU9PMEJKdG5RVmtiWDZ4Si5sU3FwQ0gzTTY1clVkQm5rY0FDSFZj","scope":"openid profile email offline_access","userSessionStartedAt":"1745919082","redirect_uri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","state":"TG5lTGcyYU9PMEJKdG5RVmtiWDZ4Si5sU3FwQ0gzTTY1clVkQm5rY0FDSFZj","code_challenge":"NoN5FipvqgoEtKI1YJotRMIu0dmivShJa8XVpNj7RQ0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('f68505f8-eb23-4520-b960-3ce591287568', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745571414, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745571413","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"fn5YbFhxNjBLQjVLeTl3RlBoVkpRYkxqdlJyTXJNdjVtWER5NFVDQ1Y0OGJk","scope":"openid profile email offline_access","userSessionStartedAt":"1745571413","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"fn5YbFhxNjBLQjVLeTl3RlBoVkpRYkxqdlJyTXJNdjVtWER5NFVDQ1Y0OGJk","code_challenge":"AFijl9F2DMEImUMAEFr3MMQ6v3opeGV4C_J6Y4arNx0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3191a4ba-b10a-4175-bdb2-0a352c09188f', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745919086, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745919086","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bTZqRWNOWUJMbkYtcnNkRThlaWZGanhTWkJUTGdxWl8yalhUTGJZaGlrYUVf","scope":"openid profile email offline_access","userSessionStartedAt":"1745919086","redirect_uri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","state":"bTZqRWNOWUJMbkYtcnNkRThlaWZGanhTWkJUTGdxWl8yalhUTGJZaGlrYUVf","code_challenge":"2vJNB1HVBFUEeeQosDpf0_pC60nsnxxOcVS7c_-7adQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('fcfcf91d-e0db-4c7a-8d21-5fef7ce90deb', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745919180, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1745919020","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745919180","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('201d1d3e-e74a-4704-a2cc-0537424d781f', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742760823, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1742759959","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742760823","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('6a09ef1e-0304-44bc-960b-08a6481cf928', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745574247, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745574246","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"eWxBVW1MZ2JsUjNKNUc3ejJ6bko4MjNKenhYcy5CcWFQWWpHemJNM0pLVnJw","scope":"openid profile email offline_access","userSessionStartedAt":"1745574246","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"eWxBVW1MZ2JsUjNKNUc3ejJ6bko4MjNKenhYcy5CcWFQWWpHemJNM0pLVnJw","code_challenge":"wwqaXnmc40xi0nljZJGsYnu8zf_Yevo28NIP_1jNEEY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('1ddf84ac-82fd-45f1-b18f-f704b30f64b2', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745144748, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745144748","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"dkRQME9tUFdJWmZqQTAxbHhDLWZoTVB0eWQ2eV96Tkd1cVJ4SkRJQy5FY21F","scope":"openid profile email offline_access","userSessionStartedAt":"1745144748","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"dkRQME9tUFdJWmZqQTAxbHhDLWZoTVB0eWQ2eV96Tkd1cVJ4SkRJQy5FY21F","code_challenge":"6hB9ZzsvoFBjWzoTVssUL0D1XxcNnFTihDoKCH3_FCQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('6a09ef1e-0304-44bc-960b-08a6481cf928', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745574372, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745574372","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"c2dXWTFsVHRTTGJnc0d2YnFpNUpOLmZUN2ZuSDhiajJ1eklWNzg0Tm9lMWZL","scope":"openid profile email offline_access","userSessionStartedAt":"1745574372","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"c2dXWTFsVHRTTGJnc0d2YnFpNUpOLmZUN2ZuSDhiajJ1eklWNzg0Tm9lMWZL","code_challenge":"92lEq54OlMcjqefNSTPGjj-hWlKEJn_9_BluCc_0g10"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('1ddf84ac-82fd-45f1-b18f-f704b30f64b2', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745145679, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745144748","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745145679","level-of-authentication":"-1"}}', 'local', 'local', 11);
INSERT INTO public.offline_client_session VALUES ('dc05b564-4df8-4a1d-a469-54263bd7f077', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745591104, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"XtbPYel8bMvDBpI9VEfMGQ","startedAt":"1745591103","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TXVqSWxqamp5dFh5WDc1d0lhS2dCLXdBR1ozVGVWSC1TV0FYQ01sek95TXlL","scope":"openid profile email offline_access","userSessionStartedAt":"1745591103","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"TXVqSWxqamp5dFh5WDc1d0lhS2dCLXdBR1ozVGVWSC1TV0FYQ01sek95TXlL","code_challenge":"o1vqoScdseZRiiQzHUHZ0thtI6DAfCuXfePAFIuvWqo"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('099f7617-5288-445b-b628-7b9d942addc5', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745596967, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"JltqIXUCYXDeXbbXpg2FBw","startedAt":"1745596965","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WFlOVl9rRF94RXJNSXBwSlZ1N1M1Smc3RkFIQUlBb1A1NHRpeVBEcEJxWTRC","scope":"openid profile email offline_access","userSessionStartedAt":"1745596965","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"WFlOVl9rRF94RXJNSXBwSlZ1N1M1Smc3RkFIQUlBb1A1NHRpeVBEcEJxWTRC","code_challenge":"No79MZJgt4jakJGi1EmEzleF0cflRzdF3_nB6__1TzI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('aaeeb0e4-4fc1-457e-9dae-f13c8b6d3792', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745601122, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"0sJXh-7u0syo6CGAifphrw","startedAt":"1745601121","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Sm5GRWljWFZNekhkQXpyeU4wUlF4OGo3Y2o1MlNGQ0JYbXRvMlVqX18yeTVU","scope":"openid profile email offline_access","userSessionStartedAt":"1745601121","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"Sm5GRWljWFZNekhkQXpyeU4wUlF4OGo3Y2o1MlNGQ0JYbXRvMlVqX18yeTVU","code_challenge":"AWdWuMcQECRyj6FyMSBw7KEIEM_ib1eYZ4FEKPrAsSU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('782cdf79-9343-417b-b1a1-c56da7476767', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745643748, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745643747","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"aVBGRjExMS5HYzdGT1F5d0V5VUxVajhyMGxtTFdSQkV-NVBsY0dxUE1kN1Nk","scope":"openid profile email offline_access","userSessionStartedAt":"1745643747","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"aVBGRjExMS5HYzdGT1F5d0V5VUxVajhyMGxtTFdSQkV-NVBsY0dxUE1kN1Nk","code_challenge":"Rg8AzT82Egh5x53z9TgkMDdw_satK02s8q8UMt0KX8g"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('782cdf79-9343-417b-b1a1-c56da7476767', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745643924, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745643748","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745643924","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('752f811f-b47e-499e-a5f5-a3aa300ce555', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745644324, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745644323","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"dnlRV3QtdXM4S09iQ1FlcUlSckVKfnAtZDMtczVXSndTREtzbWo1Q2FOby1D","scope":"openid profile email offline_access","userSessionStartedAt":"1745644323","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"dnlRV3QtdXM4S09iQ1FlcUlSckVKfnAtZDMtczVXSndTREtzbWo1Q2FOby1D","code_challenge":"srmnLAnSS7DC1MEnppfRLe2oiz29E5JCL8N3d1iGCjI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('132aba6b-9458-4725-90df-d276f1099be8', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745923977, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745923976","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"YlpoTDdLRlB5aXROOHI1R3hDTXIzVnp-bW0xNVUyNVd1aUJ3LlcyaHpjQy1q","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1745923976","redirect_uri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","state":"YlpoTDdLRlB5aXROOHI1R3hDTXIzVnp-bW0xNVUyNVd1aUJ3LlcyaHpjQy1q","code_challenge":"DyRsKi3x1QAyD-DMTnCbqsDav48S6B0-sLbyp4kOW2c"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('21437fe2-51ed-4205-b867-dbac2fd077d8', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745647536, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745647536","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"VThBQlVJSFl-NlJkdXltNjh6NkUyQWJUY1BMWU5iN21haHh4Z0N3MkhDRlpL","scope":"openid profile email offline_access","userSessionStartedAt":"1745647536","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"VThBQlVJSFl-NlJkdXltNjh6NkUyQWJUY1BMWU5iN21haHh4Z0N3MkhDRlpL","code_challenge":"Uc1CY1FN-OI1PTX36VCNubwiQRBrmr6JglWtqd6Fcfg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5cdff061-5010-4a72-a235-0888d1ee9ece', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745736509, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"sxWBneU2KGRtfFjV5XSwJA","startedAt":"1745736508","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"a1gwNFdFOH5SWEd-M3hFVHFvNkJPSUt5MFZ-TVFHMWF3RTlSQUtUWk9mUVlT","scope":"openid profile email offline_access","userSessionStartedAt":"1745736508","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"a1gwNFdFOH5SWEd-M3hFVHFvNkJPSUt5MFZ-TVFHMWF3RTlSQUtUWk9mUVlT","code_challenge":"jb1mecUgMpUxRkM2P5s-BImtAPotKYw86mbjdntrbS0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('9c26345f-a92f-45f8-ab7f-81ea746fd852', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745645837, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745645837","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"d1kteGlQUlN0al94VERJdm56TG4waVNLQ000anE2VUJ3QXNGWFR3c3ZRakMt","scope":"openid profile email offline_access","userSessionStartedAt":"1745645837","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"d1kteGlQUlN0al94VERJdm56TG4waVNLQ000anE2VUJ3QXNGWFR3c3ZRakMt","code_challenge":"sLezOc8n04qMjEvH3CJZTC6IgqYY2_sw75T0tHLL8pI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('51dbc34b-23ab-4063-b2c8-e25324890819', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745645850, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745645849","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZmYtWkc0ZlAwTkpITzN4d1g0NnBFcDNkcS5NTkdaNzRIaENSdExHanp2M3Va","scope":"openid profile email offline_access","userSessionStartedAt":"1745645849","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"ZmYtWkc0ZlAwTkpITzN4d1g0NnBFcDNkcS5NTkdaNzRIaENSdExHanp2M3Va","code_challenge":"ousVuzsOLwBlr-02B38Y0J-kpiaeJU__wONEYsYL2Ns"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5fb231b5-271a-433c-865c-94aa8bfd3776', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745737868, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"fcYxlhu_FdACxOgVYnh4Mg","startedAt":"1745737867","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"dldKSkFwS1A0U2RzSVd4VUlBeVR-RGlHTG1SMU5zZHZ5NVlLVnVpbFRqOFd4","scope":"openid profile email offline_access","userSessionStartedAt":"1745737867","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"dldKSkFwS1A0U2RzSVd4VUlBeVR-RGlHTG1SMU5zZHZ5NVlLVnVpbFRqOFd4","code_challenge":"BwM396x8220Cpjx4FpV2AbngNq76bj9p6uK6JR72Ldc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('0a395635-f343-4b48-ada7-5a1e36bc97ce', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745646165, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745646164","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"LkxFSX5uLUxObE14czlzWHZtY2JuR0lXZ2dRUGdXUm11NjVnc0VmMS5NM084","scope":"openid profile email offline_access","userSessionStartedAt":"1745646164","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"LkxFSX5uLUxObE14czlzWHZtY2JuR0lXZ2dRUGdXUm11NjVnc0VmMS5NM084","code_challenge":"G60yquKyromviGzBUvLqIOqbgvXAAXtyvRDDZWSx6ng"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('6e809142-b150-477b-b719-e56b9df4643b', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745647541, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745647541","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Zk5Sb2J2b05CbE1yMHZGaHJ6WHZWMFdZaHVTNGR4X1hFWVdpOWJ6Y3BIckhk","scope":"openid profile email offline_access","userSessionStartedAt":"1745647541","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"Zk5Sb2J2b05CbE1yMHZGaHJ6WHZWMFdZaHVTNGR4X1hFWVdpOWJ6Y3BIckhk","code_challenge":"gan5UPHy9ra1gRgGNLOOLYb0-wrvgF3eSePKg73_XNg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('132aba6b-9458-4725-90df-d276f1099be8', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745924022, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745924021","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bURjd1dOWXpLcGdhfmFPWmRLcEczTmlXNEM5WldTTWRlMktTc0pERC5yT356","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1745923976","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"bURjd1dOWXpLcGdhfmFPWmRLcEczTmlXNEM5WldTTWRlMktTc0pERC5yT356","code_challenge":"CWTEzYFuVuvfePglKhebPymkH7dN-9SsKtiuZqc_rtM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('79786345-fad9-4a36-8959-89ecbd8e9ef3', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745651267, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745651267","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"eHc5ZVlhLjcyUkpMR0IzX2tqZjVFenpKSXFkWExFMzlVbi1YMkc2dkVUdmV6","scope":"openid profile email offline_access","userSessionStartedAt":"1745651267","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"eHc5ZVlhLjcyUkpMR0IzX2tqZjVFenpKSXFkWExFMzlVbi1YMkc2dkVUdmV6","code_challenge":"LEd5kRJ2Zbr0vXT5uOhqboEe-AcgPDH2K2lYa6giowU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('2d7298d0-8bc7-4c8a-ab8a-acbc69fad2c8', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745737901, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"U_j8P00k6jt_Ucz4e48L4w","startedAt":"1745737900","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UDU0YWxPaE1JTTNiLnNLTmNfWUJtaWxfaFB2SThDZmswQmVWRXFpeVguNHh1","scope":"openid profile email offline_access","userSessionStartedAt":"1745737900","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"UDU0YWxPaE1JTTNiLnNLTmNfWUJtaWxfaFB2SThDZmswQmVWRXFpeVguNHh1","code_challenge":"7mSDJOR8mAppCG4CpG8Vqyx4X-wVe8Y6PuPqvrIj62U"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('4a6fd55f-9acb-437b-bbf9-b4eb8328eec2', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745653228, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745653227","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ckFtNUhqZUdnLi5HdWJ5SC1KOUNUT084YlVmT2lVTlNoTzZIcmZvS1VkNH5Q","scope":"openid profile email offline_access","userSessionStartedAt":"1745653227","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"ckFtNUhqZUdnLi5HdWJ5SC1KOUNUT084YlVmT2lVTlNoTzZIcmZvS1VkNH5Q","code_challenge":"HgXMIe4JPIrEB9nUJ08PmjZFyWWxcIkNp1T49kS7NSg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('461eec9c-15f6-475a-a9c0-24610d778a19', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745653237, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745653237","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bmdZRWN0MVEyZVZYU1ppU014d3kyNX5qNVJaYW0wLllLM25NZl9WLjZidl9l","scope":"openid profile email offline_access","userSessionStartedAt":"1745653237","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"bmdZRWN0MVEyZVZYU1ppU014d3kyNX5qNVJaYW0wLllLM25NZl9WLjZidl9l","code_challenge":"K3freIPk0ePOyeFNv9vmOtjr_DxMlwhsocQ7ngPCJGc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('648eca2c-28c7-4b3b-99dd-aed7ab62b045', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742638650, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742637116","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742638650","level-of-authentication":"-1"}}', 'local', 'local', 111);
INSERT INTO public.offline_client_session VALUES ('df681716-d2bb-4dc2-93e5-08beacdc4ae8', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745659558, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"iGO3qwwnSdChA3zjGfDMQQ","startedAt":"1745659557","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NGNnbW5iZkR4T3NnLjR4ZWdleW5PYWNBbEd5ejltZFJtdjdUclRSU0l6UEdF","scope":"openid profile email offline_access","userSessionStartedAt":"1745659557","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"NGNnbW5iZkR4T3NnLjR4ZWdleW5PYWNBbEd5ejltZFJtdjdUclRSU0l6UEdF","code_challenge":"C9ozHdcTy26dBzkLn4fRC3jwifMRqs72oxKXW1thqC4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e6aa6b60-40f4-4ec5-8c3a-f88b190645a6', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742644701, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742644630","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742644701","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('755a3c8b-fb9b-4683-a992-e92ae55401b2', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745659932, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745659931","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TXpRRnppTXh0SUR-VG5weVdfNTZJOHFNXzF4d0hIZ3RwR1d5dFQuSWpHQ1pa","scope":"openid profile email offline_access","userSessionStartedAt":"1745659931","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"TXpRRnppTXh0SUR-VG5weVdfNTZJOHFNXzF4d0hIZ3RwR1d5dFQuSWpHQ1pa","code_challenge":"zag9duJGMIUbDxxI62WHFA4vuMMc4AmC8md0dMD1TM4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('84150c97-919e-4796-83b0-2150eac0bb92', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742647851, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742646054","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742647851","level-of-authentication":"-1"}}', 'local', 'local', 116);
INSERT INTO public.offline_client_session VALUES ('ed542f82-32b7-4508-a316-639cf1ce4c0f', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742647917, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742647648","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742647917","level-of-authentication":"-1"}}', 'local', 'local', 5);
INSERT INTO public.offline_client_session VALUES ('12a3bbce-f3bf-419b-bd5b-4dcca896cf8e', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745719512, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745719512","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bGotdEFaUWd5Unl4Y0RzYV90VW4tcWVNdEwwVkZ5V2x2bzVSODJUWGIuTFZi","scope":"openid profile email offline_access","userSessionStartedAt":"1745719512","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"bGotdEFaUWd5Unl4Y0RzYV90VW4tcWVNdEwwVkZ5V2x2bzVSODJUWGIuTFZi","code_challenge":"9X-WnYok_zAO9DjYCWe9DIdZh76JjCFBLSQEuDsHmz0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('0b18f5a5-538f-4719-a37a-390792d567bc', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745746845, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"4OeAMH6yic2hMYuPGo3bsQ","startedAt":"1745746844","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"U1JNVExBU1llZnNrSzRvdkVMLUdIdVotY3BQUkxOSjZyNF9xMkNmdm5oYm5V","scope":"openid profile email offline_access","userSessionStartedAt":"1745746844","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"U1JNVExBU1llZnNrSzRvdkVMLUdIdVotY3BQUkxOSjZyNF9xMkNmdm5oYm5V","code_challenge":"vljyCXLJvAHRTAI5dcOeHxtpxketTPtumDPBJ9jGE08"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('ab70b74a-06ab-47a0-8d49-bfec689811ab', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745720869, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745720869","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SVZNWFFQbHZKcmV2bExWUGI1c0MyOGpxY0pCc01NMmFidjYxfnRINFFma3hS","scope":"openid profile email offline_access","userSessionStartedAt":"1745720869","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"SVZNWFFQbHZKcmV2bExWUGI1c0MyOGpxY0pCc01NMmFidjYxfnRINFFma3hS","code_challenge":"YbgaHif6ncrp7HGTr0kZVPhzzmV7sPhxrEqKrNPKqyE"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('36379249-5fd1-42e0-8b64-f07731f4081e', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745720873, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745720873","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"dEtSZ2txQTRYMEh5aVJ3V1ZlM35ZbENJM1k0UFY0MTZpTk4yT3pUd2tHWDRP","scope":"openid profile email offline_access","userSessionStartedAt":"1745720873","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"dEtSZ2txQTRYMEh5aVJ3V1ZlM35ZbENJM1k0UFY0MTZpTk4yT3pUd2tHWDRP","code_challenge":"BNF_-5TJquNX4SYuWWmQykc132Fx4uVd2Yi-99icCFU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7305aaeb-85c0-4e1e-8ba2-ea888282ab0a', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745720877, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"8u0tgQHecMmqQYasHiCT2w","startedAt":"1745720876","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"QTFILVpnVGR2Q255UHBDbjd2NWJPUU9KMDZORG9LRnJicVpQNVllU2ZZUEEu","scope":"openid profile email offline_access","userSessionStartedAt":"1745720876","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"QTFILVpnVGR2Q255UHBDbjd2NWJPUU9KMDZORG9LRnJicVpQNVllU2ZZUEEu","code_challenge":"wM_Ixya0zplu9QwNoVdGsBkylaZRJGItjW5U8o6dcIM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('80851030-d0c6-465a-89a5-1c6969e77095', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745721029, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"G8gJa2VX2k_fg6GOTEK1qg","startedAt":"1745721028","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"di1hMDFocWE0dXItLXVHQ29-Y0dzY1kzaTZJR3lyaEZ1N2VCc2Z5dlRzTlJV","scope":"openid profile email offline_access","userSessionStartedAt":"1745721028","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"di1hMDFocWE0dXItLXVHQ29-Y0dzY1kzaTZJR3lyaEZ1N2VCc2Z5dlRzTlJV","code_challenge":"KCxRFU28c5ax8ft4fNn6LyBftXwt4Zn-VFKA96Clqmk"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('80851030-d0c6-465a-89a5-1c6969e77095', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745721139, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1745721029","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745721139","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('835bb029-3c67-4da2-8e5d-305bea39100d', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745721266, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745721266","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZVBFQzBxczNCV2ZEdFJNTTRXT1RuYm5GcGNxeG1VcTBYZlgycEJrVUIyY003","scope":"openid profile email offline_access","userSessionStartedAt":"1745721266","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"ZVBFQzBxczNCV2ZEdFJNTTRXT1RuYm5GcGNxeG1VcTBYZlgycEJrVUIyY003","code_challenge":"OVyTKgmby544-qpbp6SvXVf6Lxikgxygf9LgfSAr_g4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('de214adb-259e-4cfd-acb4-6b18fcf6a53d', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745748264, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"DierQjhfjvw3SBa90YXtfQ","startedAt":"1745748255","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZWlWY3FUVV83SHdEcDN1ZVcwczBkWmh3RUdHQzEubC1IV0pLSkpvVkJDTWdE","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1745748255","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"ZWlWY3FUVV83SHdEcDN1ZVcwczBkWmh3RUdHQzEubC1IV0pLSkpvVkJDTWdE","prompt":"none","code_challenge":"UEuEJvJTgA8Tx98HaTKfcaIuCymYXlX7HmJVkPbrDuI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('0727a901-592d-448c-82f3-3003bfad9520', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745722243, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"ny5ZcJDoI1RnU2S9rt3CQw","startedAt":"1745722241","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MFY0dGxyVk9wX0llcUhRQkpuaWhkSFJXeTNDVVNHNktTYTB2Q3dOaVo4aU91","scope":"openid profile email offline_access","userSessionStartedAt":"1745722241","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"MFY0dGxyVk9wX0llcUhRQkpuaWhkSFJXeTNDVVNHNktTYTB2Q3dOaVo4aU91","code_challenge":"YTkXzqKZ27zCKfWE98BeJocZ2KMPe76QfEas13FTvCE"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('4bf5cd29-e79f-4164-af9d-ec62f8250391', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745722256, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"lWK2_Yu0kihmpL6Nhia9cQ","startedAt":"1745722254","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bzQzfkg5NVF5WnNKZnNHWkJfVzhIM09qejFBZm9lWUhGWUVqdWxNa3Q2Z21w","scope":"openid profile email offline_access","userSessionStartedAt":"1745722254","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"bzQzfkg5NVF5WnNKZnNHWkJfVzhIM09qejFBZm9lWUhGWUVqdWxNa3Q2Z21w","code_challenge":"QSMbGN_qWlWjDsvIyb-5LOFjc6uTTrJ1zg350vacE3w"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('ddba2025-f0b2-4c20-a106-c3ec396fa9d3', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745942871, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745942869","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"VHhISldmU3RnZXhzWlkxRFpqV3V2NEpmYVNFeWJQei5zYVFVMjlBdjN0ckNh","scope":"openid profile email offline_access","userSessionStartedAt":"1745942869","redirect_uri":"https://echovibe.io.vn/vi/auth/oidc/callback","state":"VHhISldmU3RnZXhzWlkxRFpqV3V2NEpmYVNFeWJQei5zYVFVMjlBdjN0ckNh","code_challenge":"a4IHidkmAHHZQowOF2AuteWj037Hek3oLGfGN4s0M48"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('0a5e89d1-cedf-43f2-9f74-2921d6b29cf4', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745722550, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"q7xwnO8gon1htCO6vtgwEA","startedAt":"1745722549","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RVl3M0ppdjVUTVR4MVRGXzIuNGItanNKV1NrRFVSU19vSGFLT01FSC1Hd1Fm","scope":"openid profile email offline_access","userSessionStartedAt":"1745722549","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"RVl3M0ppdjVUTVR4MVRGXzIuNGItanNKV1NrRFVSU19vSGFLT01FSC1Hd1Fm","code_challenge":"pSQrGN9TnE8DaiUtE4ILLFmUKMF8KCNnRmUKHO-btos"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('00d77880-c719-41c6-a5e9-66bc5a261353', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745722558, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"x4KU6ejcskF9XBUwKuES-w","startedAt":"1745722557","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"dEtDbWJ3MnIzWXFrU21xLnNQTVZNLlJIOS1KR1ZYempEcndUQmpESndzbXVO","scope":"openid profile email offline_access","userSessionStartedAt":"1745722557","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"dEtDbWJ3MnIzWXFrU21xLnNQTVZNLlJIOS1KR1ZYempEcndUQmpESndzbXVO","code_challenge":"2QjJKTVMw6DKc0e25w1dCw9ebrvTPp53SOvQ8ty-8Fo"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('ddba2025-f0b2-4c20-a106-c3ec396fa9d3', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745942925, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745942925","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"b1B1YTZqQVp0eWR2SFR-dU1MQnJud0UxWWQ0UEdKTHIza1EtMjNTb2t6WWNP","scope":"openid profile email offline_access","userSessionStartedAt":"1745942925","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"b1B1YTZqQVp0eWR2SFR-dU1MQnJud0UxWWQ0UEdKTHIza1EtMjNTb2t6WWNP","code_challenge":"oQce795wkOJpzJC01tM1ThJZNQmz8m2-MJzudVMY8nk"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('9b09b151-5f4b-48fc-96a1-41346ea8ccb5', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745722821, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745722821","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"OW5OS2JUX3BMeUJ0Vy5VUjhOMWhYYVNUTTZvZ2RJN2ZOQVVwRFZuY2UtNC1V","scope":"openid profile email offline_access","userSessionStartedAt":"1745722821","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"OW5OS2JUX3BMeUJ0Vy5VUjhOMWhYYVNUTTZvZ2RJN2ZOQVVwRFZuY2UtNC1V","code_challenge":"wWjafT7VWW_YYHzEgPughE5lqNHgeH_9Nt3YgeYfLOc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('56af8b9f-944e-4d97-b2a9-80f632c21602', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745765736, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745765736","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"dVZwX1VMdHBOdE1qVnZBeW1LR3NmZDRPUUpaeVJTOU02fm1jOWxiSDJpSVFT","scope":"openid profile email offline_access","userSessionStartedAt":"1745765736","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"dVZwX1VMdHBOdE1qVnZBeW1LR3NmZDRPUUpaeVJTOU02fm1jOWxiSDJpSVFT","code_challenge":"ZgffRBrQ4qpK09IBI5ipZFYvnEQxZyr5dJOUGrwfwE0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b2a366fe-1ba5-4e0f-b81e-37fdbca11e9e', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745723270, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"5agih3KtlxtUPHMSr9SCMQ","startedAt":"1745723269","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"emhnX0Nhc3hKeFVwdThiR21QTW1kLWVNai1CdXlCT0c2UFZUUHMzdm4tV3M4","scope":"openid profile email offline_access","userSessionStartedAt":"1745723269","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"emhnX0Nhc3hKeFVwdThiR21QTW1kLWVNai1CdXlCT0c2UFZUUHMzdm4tV3M4","code_challenge":"IvhhancHzQqWzY13x1pz_o8qpNfDV0lOGGnWtGyK1jw"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('8bd272fe-4add-42c4-b755-f1fbb3bde124', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745723325, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745723325","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"U3kxTVdrWUFQMllUYVRkcTRBNWllQWhXUlkwR2FncGl1Y3kwaTBoVm5CdHRE","scope":"openid profile email offline_access","userSessionStartedAt":"1745723325","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"U3kxTVdrWUFQMllUYVRkcTRBNWllQWhXUlkwR2FncGl1Y3kwaTBoVm5CdHRE","code_challenge":"wTbI6h2SIA46jQxXBtu8SxNJN5CrKuniimVXCLELHYY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('bdb97f3e-93f5-4dd3-9cf9-1a17bd867869', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742815598, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742814520","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742815598","level-of-authentication":"-1"}}', 'local', 'local', 8);
INSERT INTO public.offline_client_session VALUES ('91fcbbff-9fa2-4087-9c02-875c2304a7f1', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745723423, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"kCA1PUFmvLvrrfXqFwFv3Q","startedAt":"1745723422","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WjFDNDVVSHRVVGNsdmFVRjMybWJMbTVzNlJwNm1Lb35WWFFWWExsTF9GQVdz","scope":"openid profile email offline_access","userSessionStartedAt":"1745723422","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"WjFDNDVVSHRVVGNsdmFVRjMybWJMbTVzNlJwNm1Lb35WWFFWWExsTF9GQVdz","code_challenge":"42nqsvrI3Mu3TOiopOIXp9rK-Uo2OLVNPefDhKRjs3k"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('8bd272fe-4add-42c4-b755-f1fbb3bde124', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745723580, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745723325","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745723580","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('e0ab0b0e-f56f-4f0e-a905-50b3c5b588d7', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745723845, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"QYq_ahhADCgl0--7dAU3_A","startedAt":"1745723844","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"YThrWXB4ZWdzaH5JLWtCTjlELmJMNy1LTThYVlRVZHVsY2lhMFJiRUZuRVBr","scope":"openid profile email offline_access","userSessionStartedAt":"1745723844","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"YThrWXB4ZWdzaH5JLWtCTjlELmJMNy1LTThYVlRVZHVsY2lhMFJiRUZuRVBr","code_challenge":"DakhFZQCXB-qcD1ycQW4DuFeEO9pOcMbZk3srBWfIjU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('dcc408f3-615b-4ec5-b240-d20a37812484', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745723856, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"fOul1dFi5AW-vvv3KoKJyg","startedAt":"1745723854","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ODRpUU1QUmhBd280bnBjUjQwLVZvZkF5MmxPMmdsa0VVfksxTnBZRVd2Mmxh","scope":"openid profile email offline_access","userSessionStartedAt":"1745723854","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"ODRpUU1QUmhBd280bnBjUjQwLVZvZkF5MmxPMmdsa0VVfksxTnBZRVd2Mmxh","code_challenge":"xj8vEjrNdMsvHpgYFB3c-01CJ4L2l_ZnD6v2AipA94s"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('29175639-74c1-450f-93b2-dc02f39fcb5f', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1746061957, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1746061955","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZDJKb1NDYXNaYkhvaDdOU1ZILWRweXNnTU8zQ0lFMFdOZXQtdFlUZUpRclRC","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1746061955","redirect_uri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","state":"ZDJKb1NDYXNaYkhvaDdOU1ZILWRweXNnTU8zQ0lFMFdOZXQtdFlUZUpRclRC","code_challenge":"Q4CMRXVZM33Jmc1rvkfwZhRjvxSaDBazmtewS2HiO60"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('214dd239-9426-4454-ba43-585f838056eb', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745726827, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745726826","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Lk5EMjhnZjB4T2N0TkN-NnZDX1dHd2xZcWdtRXR5YkdrcHNrQ2ZscXZxdWMu","scope":"openid profile email offline_access","userSessionStartedAt":"1745726826","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"Lk5EMjhnZjB4T2N0TkN-NnZDX1dHd2xZcWdtRXR5YkdrcHNrQ2ZscXZxdWMu","code_challenge":"ZfP8k-1427vAWMNTSxR2NOA8u8JgUbL2E4lYd-X6sVQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('cd2d32e9-3d45-4c4f-ba7a-0eabfc49f3f9', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745726928, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"DW-tsmmzeD9B70jiCjVp_Q","startedAt":"1745726926","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NjNHRXRFSFAwcWtrRE5oZUdrZGNBaDNJOUdhNUNrQXJmYWJGTTNxek9EajJZ","scope":"openid profile email offline_access","userSessionStartedAt":"1745726926","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"NjNHRXRFSFAwcWtrRE5oZUdrZGNBaDNJOUdhNUNrQXJmYWJGTTNxek9EajJZ","code_challenge":"IoYBHOCAl9Wy7twWCYfv_gkVKv9ZIGEXa3z-nRyPVzI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('1591e4fb-8cde-4a3c-a917-eccec849059e', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745894672, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745894672","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"U3E5VnRzVWs1QXVTaXBveWlrQzdXVjBja0NybW5DWkticE5nVEdIVjJPZXo1","scope":"openid profile email offline_access","userSessionStartedAt":"1745894672","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"U3E5VnRzVWs1QXVTaXBveWlrQzdXVjBja0NybW5DWkticE5nVEdIVjJPZXo1","code_challenge":"Fs0rUKxM1gYsBxBLX5xdt0LZtKdvpviKJecL9F0cd7E"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('29175639-74c1-450f-93b2-dc02f39fcb5f', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746062015, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1746062014","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"S0JKUWlFNmRyZkRpdk96N0R3X0V2d0FQZlREcXdMT2taVzFhYXRBOF9jdHNr","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1746061955","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"S0JKUWlFNmRyZkRpdk96N0R3X0V2d0FQZlREcXdMT2taVzFhYXRBOF9jdHNr","code_challenge":"iu5jjw69rfIlkHyJp5PsT0TngocngKZ9r-x4EE8oE6M"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('8cf98b40-244d-4238-ae12-4e25394aa296', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745896623, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745896622","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TDlmN2tlMUxBV2cyOXN2N3VMU2F3alRiWV9MNm1kUm1zTHVob0VHR2lPbDRx","scope":"openid profile email offline_access","userSessionStartedAt":"1745896622","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"TDlmN2tlMUxBV2cyOXN2N3VMU2F3alRiWV9MNm1kUm1zTHVob0VHR2lPbDRx","code_challenge":"EtoaCJHvVRgf1nwbKZQ72m_cVbrySqBvFEq2p6yk8CI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e5150cd1-55e3-451a-be83-6624fdc2cecf', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742756047, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1742754384","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742756047","level-of-authentication":"-1"}}', 'local', 'local', 5);
INSERT INTO public.offline_client_session VALUES ('9f8cf9d6-8a48-4869-bd34-198472bb2247', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742804212, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742802734","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742804212","level-of-authentication":"-1"}}', 'local', 'local', 7);
INSERT INTO public.offline_client_session VALUES ('bc428509-b5c1-4df6-809d-ff205d7d0071', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745727977, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745727976","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"LmFSaUlMLlZvc3VIV19CcENScGNDT04xczVLTVp-amJzbXlzenlRRGlSM2s1","scope":"openid profile email offline_access","userSessionStartedAt":"1745727976","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"LmFSaUlMLlZvc3VIV19CcENScGNDT04xczVLTVp-amJzbXlzenlRRGlSM2s1","code_challenge":"6UI8wNaBflrks8AQXHRZs6xuCGVtvpELIpXI8Mh0vT8"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('a8bbbb15-06e1-4ab2-8826-90869d9d9e04', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743353804, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743353539","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743353804","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c444bd96-042a-45c4-ae23-d112187995c5', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745896627, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745896626","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"a0lXdXRRVkZaZnhqYTlwRjFhZ0RTZUtlbldPX05HTm0ub3E0VjNPTm9kOGVk","scope":"openid profile email offline_access","userSessionStartedAt":"1745896626","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"a0lXdXRRVkZaZnhqYTlwRjFhZ0RTZUtlbldPX05HTm0ub3E0VjNPTm9kOGVk","code_challenge":"S4VQs69O-bfBkn1s-skjGS1cQw3SNH_U3jeouCaePjU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('53c3766c-0a30-4f03-9a73-cc7921241a5c', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742807595, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742806032","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742807595","level-of-authentication":"-1"}}', 'local', 'local', 14);
INSERT INTO public.offline_client_session VALUES ('075e84cd-7883-4ab4-911f-8b3338660617', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742757828, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1742756278","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742757828","level-of-authentication":"-1"}}', 'local', 'local', 16);
INSERT INTO public.offline_client_session VALUES ('20180017-abf4-4e31-abc3-e23038682962', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745728549, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"mmaipNL57KP0RfiZJBYskQ","startedAt":"1745728548","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NFRRU0dpUEk5U29GaUlIdThweH5Ha1ZGc1pKMzMxUURuNGZjalNvQlV6Zzh6","scope":"openid profile email offline_access","userSessionStartedAt":"1745728548","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"NFRRU0dpUEk5U29GaUlIdThweH5Ha1ZGc1pKMzMxUURuNGZjalNvQlV6Zzh6","code_challenge":"De2W68a5uS4tkiFoD8Ip7zTEUkQ9YG9B8CZ__Y-hl1U"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('03249b2c-99dd-408b-964c-d64ab5d2f43d', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742814409, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742813829","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742814409","level-of-authentication":"-1"}}', 'local', 'local', 8);
INSERT INTO public.offline_client_session VALUES ('6db2c99e-ce85-4702-bacd-eab0ab592e1c', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745728558, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"83YQ5kcgQyvSntMgtLiV2w","startedAt":"1745728557","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"YUtndzJrbndvTGJMc0F3ekNTQTB4MllEYzU1Y3BWUUdHMzlaR1gxOG5RVS14","scope":"openid profile email offline_access","userSessionStartedAt":"1745728557","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"YUtndzJrbndvTGJMc0F3ekNTQTB4MllEYzU1Y3BWUUdHMzlaR1gxOG5RVS14","code_challenge":"j0punWZBIGq9mFZ1Vvk6WXdGXS-xzn0MrtqPsFyg3ZQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7fcabcbe-0eb4-4cc7-be78-495bc5a679d5', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742810268, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742808793","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742810268","level-of-authentication":"-1"}}', 'local', 'local', 5);
INSERT INTO public.offline_client_session VALUES ('bc428509-b5c1-4df6-809d-ff205d7d0071', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745728949, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745727977","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745728949","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e877f31f-7d6f-4077-a4e9-ab6a7c838e65', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742812316, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742811214","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742812316","level-of-authentication":"-1"}}', 'local', 'local', 14);
INSERT INTO public.offline_client_session VALUES ('bada835c-978c-4350-86c4-3773bdde63bd', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745729928, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"BYc9KeW7dqnhMc6ksdRxzA","startedAt":"1745729926","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WjlJZjFIYmlNVUQ3dkhPelFsRHpvdzFNMWJqV3N6SjJER1drMk5GNTdOTnVq","scope":"openid profile email offline_access","userSessionStartedAt":"1745729926","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"WjlJZjFIYmlNVUQ3dkhPelFsRHpvdzFNMWJqV3N6SjJER1drMk5GNTdOTnVq","code_challenge":"rhxDqLckIx1wy4HfaZGm0VIPnyYQw0fDRusxogvuMFs"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('ac03fdf7-0be7-43c9-b715-2ee35e77c175', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1742836197, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1742836128","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1742836197","level-of-authentication":"-1"}}', 'local', 'local', 2);
INSERT INTO public.offline_client_session VALUES ('09d49866-8a30-4964-a31a-70153315a951', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745898246, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745898246","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ODZRZTI2UHRBQ1NDQnB5Z25QS0Fad3FUSXB3UjhCYkRsRGthQ2YuaVVMaTRo","scope":"openid profile email offline_access","userSessionStartedAt":"1745898246","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"ODZRZTI2UHRBQ1NDQnB5Z25QS0Fad3FUSXB3UjhCYkRsRGthQ2YuaVVMaTRo","code_challenge":"KCZ62Xz4Z6GrjZsvwEF0Evdlm077p7TB7tpUa-Vfofg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('1480741f-df1b-47df-9365-e84d6406738b', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746065609, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"-7xURivI9UDYLj8BJd3RxA","startedAt":"1746065608","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"N0EuaEJoRE90YkNIdjJhZzJBeklWeDdrdVlrakNvU3kycEMzUU9sfkJ5NUZ1","scope":"openid profile email offline_access","userSessionStartedAt":"1746065608","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"N0EuaEJoRE90YkNIdjJhZzJBeklWeDdrdVlrakNvU3kycEMzUU9sfkJ5NUZ1","code_challenge":"usP133uJywZm924g9_N2S3kDjQhOdeSpz-MmvRPU9_U"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('1f76ec93-d2dd-451a-8250-cd3ef4dadc48', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745898254, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745898254","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"VTQxTEgwUV9SYWZtYzVmQmhJZHFrRFVFVmdVeE1ydXhZamhlbTUwUDNna25v","scope":"openid profile email offline_access","userSessionStartedAt":"1745898254","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"VTQxTEgwUV9SYWZtYzVmQmhJZHFrRFVFVmdVeE1ydXhZamhlbTUwUDNna25v","code_challenge":"lIHHXQJs9Mp09fXPxK5e1HJ3OHXfqm9gNSZ0ILiZ_AQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('065a9914-0ed1-487f-a03b-e4336229136a', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746067082, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"cYc6Vjh_Cd78-r-v_MS4tw","startedAt":"1746067080","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RkJnTDJKdkt4UWFEMnBtVEpnLndKcUdaZ3JTa0dKNnNGOGUuTE0yOVFJLTRy","scope":"openid profile email offline_access","userSessionStartedAt":"1746067080","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"RkJnTDJKdkt4UWFEMnBtVEpnLndKcUdaZ3JTa0dKNnNGOGUuTE0yOVFJLTRy","code_challenge":"yVV4-TqWUnh2DuyRED-ZrmFGEnNsLhmVBGa6bg1v7zI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('423d5439-87e5-4cad-b479-96571eb066b7', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746067102, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"Q4_AC0oAYh-w4BjM8NDGww","startedAt":"1746067101","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"YlBSRjN3T19WMnVrRFlYY3FJbU9jUVVINERENn5sQ0RfMEZ6cHJBfmt5WUdF","scope":"openid profile email offline_access","userSessionStartedAt":"1746067101","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"YlBSRjN3T19WMnVrRFlYY3FJbU9jUVVINERENn5sQ0RfMEZ6cHJBfmt5WUdF","code_challenge":"bsHyvXyVy5eU-EDICyQvrKs2qCA7mQhXCfiN_ABShvk"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('8d9df0e8-f85e-481f-9881-c0d76bc7f3d5', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745899611, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745899611","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"c05nM0N3bGVzemouNENXYWtoTWZGNzlkVVdyWGFDbDNHc3FEN0h3eEQycXRS","scope":"openid profile email offline_access","userSessionStartedAt":"1745899611","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"c05nM0N3bGVzemouNENXYWtoTWZGNzlkVVdyWGFDbDNHc3FEN0h3eEQycXRS","code_challenge":"YHq9ULvZX_2NuybxMkrjbYDnIKRtPXptjA9ApKCIdKc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b5f3f9ed-0296-4b42-b013-f936ff9a9088', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746068633, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"DIr7gbI4Nf6RhHXtSUcUmg","startedAt":"1746068632","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"U1V0aDB6NDQ2VThCVmJpLi5FMklzY3FpQk91VVM3d2phbFFWSHFEMVpweFpk","scope":"openid profile email offline_access","userSessionStartedAt":"1746068632","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"U1V0aDB6NDQ2VThCVmJpLi5FMklzY3FpQk91VVM3d2phbFFWSHFEMVpweFpk","code_challenge":"khiG7ZaB8eVFkBSb_JH8dSUYOp1KBP-PnzfjQeq2r8g"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('237ea8f7-1d31-4f46-a595-2666018f7f5c', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745899629, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745899629","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bW4yaGpfQkRpaERSQXZ0UzVoWS10SnBNSnl1Sy1KOHdTQld1RGZTaWFSQlRh","scope":"openid profile email offline_access","userSessionStartedAt":"1745899629","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"bW4yaGpfQkRpaERSQXZ0UzVoWS10SnBNSnl1Sy1KOHdTQld1RGZTaWFSQlRh","code_challenge":"aPCQSTXDezvSerbkTEAhtVtZFbFst017U9sMYam_JH0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('237ea8f7-1d31-4f46-a595-2666018f7f5c', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745899681, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745899629","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745899681","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7262aa7e-f6ce-4ae4-8d21-ff91958f02b9', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745900604, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745900604","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"VkRfVnZoUnlXTkhJaHlzc0tkWVU2Qjk3Zy5YWEpQYm5mX3pjMzQtMH5TLjBV","scope":"openid profile email offline_access","userSessionStartedAt":"1745900604","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"VkRfVnZoUnlXTkhJaHlzc0tkWVU2Qjk3Zy5YWEpQYm5mX3pjMzQtMH5TLjBV","code_challenge":"FyRGwodW-GGWDtK_LyDC1Fo0SYzAqvMQCY-bK8d4Gpk"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7262aa7e-f6ce-4ae4-8d21-ff91958f02b9', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745900766, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745900766","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bFpuamxDZmhxeWgxSWRXN3RVamt6MGpPRHM0VDJ4YTNwZDUuYXJFdzl5Mjl1","scope":"openid profile email offline_access","userSessionStartedAt":"1745900766","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"bFpuamxDZmhxeWgxSWRXN3RVamt6MGpPRHM0VDJ4YTNwZDUuYXJFdzl5Mjl1","code_challenge":"AryxjbzHmrTb8yaKh6H92LW-UZ3ww_Dib7V6vzK9uv4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('32d649fa-b6a5-4dbc-a61a-3292bd831e20', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745901965, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745901965","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"T1h3NWZmb21MY0hreEdjeVlnTzE2VVVyVko5SzYyb3FCRFAzTzljRW51LVVG","scope":"openid profile email offline_access","userSessionStartedAt":"1745901965","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"T1h3NWZmb21MY0hreEdjeVlnTzE2VVVyVko5SzYyb3FCRFAzTzljRW51LVVG","code_challenge":"lq6mcFPfVAIrRgYtogeptjg0hWcaI1Xg6kDwchllxwM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7262aa7e-f6ce-4ae4-8d21-ff91958f02b9', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745901921, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745900604","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745901921","level-of-authentication":"-1"}}', 'local', 'local', 2);
INSERT INTO public.offline_client_session VALUES ('958215da-b7a0-4e55-8884-0f43029b158f', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745901961, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745901961","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Y19IUEhCNXZ1OHNDcm5Sa2ZnY0ouY21Zb0pnaXVrYUdueXE4RnRNOS1YYzV4","scope":"openid profile email offline_access","userSessionStartedAt":"1745901961","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"Y19IUEhCNXZ1OHNDcm5Sa2ZnY0ouY21Zb0pnaXVrYUdueXE4RnRNOS1YYzV4","code_challenge":"x7dlmtzihWK8gvUEn94Rfn-FFcR8Cvvc1ie71TAe77g"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('0ba34d35-712e-4dbc-b6b4-c374406f653b', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745902122, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745902121","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"YkdGcHRlbFN2Y2xGWWlRa19sZjFWTHp1WGhqUTVzVzdfemlTYVdNUWZSMnhw","scope":"openid profile email offline_access","userSessionStartedAt":"1745902121","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"YkdGcHRlbFN2Y2xGWWlRa19sZjFWTHp1WGhqUTVzVzdfemlTYVdNUWZSMnhw","code_challenge":"CUwgQLsXWyA7N7Xai0Tb20tnXSYTOghDFQYrMctJDTE"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('98da45ef-62c2-457e-bf6e-9c2a63aa0957', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746068641, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"3ALU97aAGqETS_6aSMN60A","startedAt":"1746068641","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cX5vRW1rQVJLTWp4V2xqS2ZPUndxM2kxZ25lUGhiNGhSQmxZZnF0TGt0dTc0","scope":"openid profile email offline_access","userSessionStartedAt":"1746068641","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"cX5vRW1rQVJLTWp4V2xqS2ZPUndxM2kxZ25lUGhiNGhSQmxZZnF0TGt0dTc0","code_challenge":"u3I8gtnu-jCI7nZ7YRyuIWhL55MwZkeCeD8cTv68mpY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('bc02beaf-d3e2-499d-8836-8d908d599f00', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745902414, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745902414","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bXkzYlVaN1g5YUJYMUNnZmVGVVpqei5lMEhpOFNFY2w2d29XZ0xqU1hDSWdM","scope":"openid profile email offline_access","userSessionStartedAt":"1745902414","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"bXkzYlVaN1g5YUJYMUNnZmVGVVpqei5lMEhpOFNFY2w2d29XZ0xqU1hDSWdM","code_challenge":"DJbU6qpV16R1NI00lymfud7qroa9x4QdIGjbUkD-j1A"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('9cfb58de-f592-420a-ba76-db283c71ac3f', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746093493, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1746093493","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"azR-ak5NVmNyZ3pMZnIxODAxc1d6M3BmT3Iyb3k3NEZBbFZhRnl1LXVhakg4","scope":"openid profile email offline_access","userSessionStartedAt":"1746093493","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"azR-ak5NVmNyZ3pMZnIxODAxc1d6M3BmT3Iyb3k3NEZBbFZhRnl1LXVhakg4","code_challenge":"d2Y9Drw1ArD85gbGeSCOqFUmPb8QpCKCW-JQJq-9StQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b1f08e66-1b7e-449d-aaf2-e3adedf48e90', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745902547, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"HVVEWaRQy2weQbDNnGySWA","startedAt":"1745902547","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"VmZEMXg2X3VVbUR1eHpVa2tIa1FONTdDRDlJeFJqVUpoLn45Mnh5by5MLk0z","scope":"openid profile email offline_access","userSessionStartedAt":"1745902547","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"VmZEMXg2X3VVbUR1eHpVa2tIa1FONTdDRDlJeFJqVUpoLn45Mnh5by5MLk0z","code_challenge":"5sJ1sQnUTuQYR2X0CcRVj0FGevC5_C9rF08ZL5FNUeg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c973df58-d56e-4a30-9877-9f630e04a9fc', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745902836, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"AgtecDSnHQAgSD6Jne401g","startedAt":"1745902835","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Qm5ocW1CZzdjOFNJY00uLlRiN05oLTFUdHdxdHJ2YXJ-M2JNa1pLT0x1WEZU","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1745902835","redirect_uri":"https://echovibe.io.vn/vi/auth/oidc/callback","state":"Qm5ocW1CZzdjOFNJY00uLlRiN05oLTFUdHdxdHJ2YXJ-M2JNa1pLT0x1WEZU","code_challenge":"f8T-0ZMxvg4U_8vPGp8n-7WOt7BQ55btIxhZo0_mK2M"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('4d582828-383b-4fa4-837d-d3c3ffc8acd4', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745903573, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745903572","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"blhnZnRvN2xmTHJqb0I3anZ6YTE2cmlFaHNveDFjR053R216MEctWEtHazZu","scope":"openid profile email offline_access","userSessionStartedAt":"1745903572","redirect_uri":"https://echovibe.io.vn/vi/auth/oidc/callback","state":"blhnZnRvN2xmTHJqb0I3anZ6YTE2cmlFaHNveDFjR053R216MEctWEtHazZu","code_challenge":"CvP69foiagm7MKEbW0ttRJiO4YZJ23w_-VuQ0DiTydM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7b8c420e-df78-4f1d-8c09-9ef0b510795c', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745903588, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745903588","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ckhORHo1Z1F5c19QcmQxZTF0YmZVa1NOYXFpcGQwVDVJdm1LcW5TQVRwUkpx","scope":"openid profile email offline_access","userSessionStartedAt":"1745903588","redirect_uri":"https://echovibe.io.vn/vi/auth/oidc/callback","state":"ckhORHo1Z1F5c19QcmQxZTF0YmZVa1NOYXFpcGQwVDVJdm1LcW5TQVRwUkpx","code_challenge":"xru3pA5w-dJ5NWvVsBo74RS8smT3Ygd8Q5vjtszclgU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b2de0bfc-a7e1-4d3d-b28f-dcf1cbd8e7fb', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746239705, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"Yk-g8wN13Q8FFrZmet3Yhg","startedAt":"1746239694","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MllpMW9pY0RpcUJpOGp0SGhxU2tlNXJ-Z2lOcGVxOEEuLTVJSTVJNVJqbUk3","scope":"openid profile email offline_access","userSessionStartedAt":"1746239694","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"MllpMW9pY0RpcUJpOGp0SGhxU2tlNXJ-Z2lOcGVxOEEuLTVJSTVJNVJqbUk3","code_challenge":"dd-nUOI2NdCoZZoqouuY8KnTbptaOGQy5EWudUkJSwg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('1f57f55a-0d81-4283-8b78-59d12b31a1c7', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743019953, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743019499","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743019953","level-of-authentication":"-1"}}', 'local', 'local', 3);
INSERT INTO public.offline_client_session VALUES ('d8be33c5-cf18-4766-986c-7049eecc3408', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745907088, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745907087","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UXdTNkdtVjlLUEpVZVNpRFczTERKV2tZY0p3Z1BZZWZhWXk3dFMzVlZHMkxs","scope":"openid profile email offline_access","userSessionStartedAt":"1745907087","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"UXdTNkdtVjlLUEpVZVNpRFczTERKV2tZY0p3Z1BZZWZhWXk3dFMzVlZHMkxs","code_challenge":"QZd2fYtmEqHC4Eevfap4CMgpq7I3yihi9QaOf2qGNJ0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('232ce661-d383-42f5-917a-a2b94ec34532', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746241083, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"ruuKeLAWnzCO1kdEtvEECw","startedAt":"1746241082","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"YmVFa0c2dkhxSXlDenlhVEtzTnlBMURKV1lOVW1BQVJjeThseVhCeGk1S2w4","scope":"openid profile email offline_access","userSessionStartedAt":"1746241082","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"YmVFa0c2dkhxSXlDenlhVEtzTnlBMURKV1lOVW1BQVJjeThseVhCeGk1S2w4","code_challenge":"JNGLAnKreb7z2BIMkQuf4UJHQy7yFm4vI0v-VtY_b8U"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('879c7bf8-7522-4f86-8ede-3c3bec191043', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745907116, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745907116","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TzljY3VCWnQ3c0tqc0hwdDhmMjFKOExDeWd0U0ZBdnhGZlNMNnBwZnhwM0ZF","scope":"openid profile email offline_access","userSessionStartedAt":"1745907116","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"TzljY3VCWnQ3c0tqc0hwdDhmMjFKOExDeWd0U0ZBdnhGZlNMNnBwZnhwM0ZF","code_challenge":"1ao5FYzWisgd4zXLPDI5KCICyS42lCy8eHm5k0Ac1vs"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7cb44162-fcac-49e7-83da-4bf184584d78', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745908564, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745908563","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cGR2UUhXTE1VR3M1bS1WVnoyOHVWVnZfa1I4VGo5Q0RtSzc2M3BNSWc4eGk0","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1745908563","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"cGR2UUhXTE1VR3M1bS1WVnoyOHVWVnZfa1I4VGo5Q0RtSzc2M3BNSWc4eGk0","prompt":"none","code_challenge":"gkZas6A444tKy5Z5SVOdgFp5McOOH8m65O0Tnk8E5cs"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c176b22c-210b-4fd0-b3ff-4f438c3a6b81', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746241090, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"CSsh4RvlqPBWtTK7Nav-5Q","startedAt":"1746241089","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZlguZjBwYnY3ZlVKeWt-aHJmYTN0N2dUczdZR0tZa0VMV1o1eGJaRjRSdkY0","scope":"openid profile email offline_access","userSessionStartedAt":"1746241089","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"ZlguZjBwYnY3ZlVKeWt-aHJmYTN0N2dUczdZR0tZa0VMV1o1eGJaRjRSdkY0","code_challenge":"Wh4VrmhGMwXAgM7VbaYBa7WSuOXYfwDxrRwLeWhqXy4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('d5fee6d0-16d2-4777-beca-9dd5f8c25226', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746252657, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"n0pWHVlDPXurtKNcqmgaJA","startedAt":"1746252653","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SnBZdH53U3BZTEZtejdkS0dRcDVUU3laSi5tbXp2cFMubk1JRUtuYWY1V181","scope":"openid profile email offline_access","userSessionStartedAt":"1746252653","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"SnBZdH53U3BZTEZtejdkS0dRcDVUU3laSi5tbXp2cFMubk1JRUtuYWY1V181","code_challenge":"V3fvr2UFxkNftuKBaRPr67lUGUCxzqJru20pqKbAoCY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7cb44162-fcac-49e7-83da-4bf184584d78', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745908600, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745908600","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SXlqUXNzdURiZW5Zc2Z3Rnp3UDVVZF8uZzNmVXliUVNUbi1uRkREMzFWQWlk","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1745908563","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"SXlqUXNzdURiZW5Zc2Z3Rnp3UDVVZF8uZzNmVXliUVNUbi1uRkREMzFWQWlk","code_challenge":"lXKohl_YMf-UKt3CjH37-fvtdiHe5MFxMwwlcmgRNzk"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c3f50521-247a-496b-9c9f-2fedd6e7ac5e', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745918956, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1745917672","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745918956","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('3446ec6f-5e6c-4cb9-9361-25ff6ee80992', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746254045, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"6TsJKAK2q16kQg_FH39THw","startedAt":"1746254043","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"aloubX5kMjRpUEF3V2dpdE4xYmNrc3dGZFJoWWdRMUhVUWFmWFM1elIubnRL","scope":"openid profile email offline_access","userSessionStartedAt":"1746254043","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"aloubX5kMjRpUEF3V2dpdE4xYmNrc3dGZFJoWWdRMUhVUWFmWFM1elIubnRL","code_challenge":"ygYLtwjFCkfqG8CDI2gjlXhcoDoljqMT4uta7_Wx_rA"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c3f50521-247a-496b-9c9f-2fedd6e7ac5e', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745917672, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745917672","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RGdfNFIzZ2tKZjdPSUs2S1YuVzJWaU9OQ2YwMDFOLXpYbFE0dU43ZE1IX0NH","scope":"openid profile email offline_access","userSessionStartedAt":"1745917671","redirect_uri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","state":"RGdfNFIzZ2tKZjdPSUs2S1YuVzJWaU9OQ2YwMDFOLXpYbFE0dU43ZE1IX0NH","code_challenge":"bmxpB6O_ClxmOkiv6ws_Rvug7X99vYNT_IpvXL_urak"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('bb61cb70-b6dd-497d-b07b-c1ef2e88bb45', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745729942, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"srqZ9u0N-pq3evblZGgr-g","startedAt":"1745729940","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Q1M0clpseHJTXzhOVTRseVV0NmJoV1pYZUpCTnhLd25NU0ZxaDd-NkEyTzZs","scope":"openid profile email offline_access","userSessionStartedAt":"1745729940","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"Q1M0clpseHJTXzhOVTRseVV0NmJoV1pYZUpCTnhLd25NU0ZxaDd-NkEyTzZs","code_challenge":"9nJQoA9UgJe7VdWl6jG07agBUX6JHgvAdMurrcTGUqU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('94ef9b88-2f81-45a2-96f5-153651128601', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745730086, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"wnKlZnVVWkkmqdcJrdaLWg","startedAt":"1745730085","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"QlkyMWFUUFNiQVRuaXJUQjZtRWF0eX5WeHAyYkZoMDlyfkJ2Vm5xeVlGOWd3","scope":"openid profile email offline_access","userSessionStartedAt":"1745730085","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"QlkyMWFUUFNiQVRuaXJUQjZtRWF0eX5WeHAyYkZoMDlyfkJ2Vm5xeVlGOWd3","code_challenge":"szzm8VkD8WDt0VW_N-uyi_6214tQdW5ppU-z1U3OOw0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3e437c58-be24-4961-9ec8-874b90199709', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745731338, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"3hWL0q48wV3-FPS2amxdaA","startedAt":"1745731336","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SVljbFprV3FXcGYzeGxtOGhmMTFOeURiSXZ2Z2xaZVd-aG92QVRPTHpFYVZQ","scope":"openid profile email offline_access","userSessionStartedAt":"1745731336","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"SVljbFprV3FXcGYzeGxtOGhmMTFOeURiSXZ2Z2xaZVd-aG92QVRPTHpFYVZQ","code_challenge":"2H7biF6s-1NOYWK7qkCBjp9l6hX2mNxOhYMTKef06NQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('85ce417a-64d6-403c-8d1f-5465f7e0b21a', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745731345, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"mSpiwJtF49m_aIlmee06kQ","startedAt":"1745731344","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"d2E4d2FwMnlxOVlmTU9rcEVSbnJEZnlDbFVraWJ6dm05ZExXYjRqREZWNGF2","scope":"openid profile email offline_access","userSessionStartedAt":"1745731344","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"d2E4d2FwMnlxOVlmTU9rcEVSbnJEZnlDbFVraWJ6dm05ZExXYjRqREZWNGF2","code_challenge":"3a3vquCwGC7FdKM1h9AhwSmdQm3klxxbkWdrA01u6jI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('07fc4b47-6900-4a26-bdf8-55deff92fe49', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745732851, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"gQuRWKGqQ_9Xsv-Qxs-X9g","startedAt":"1745732850","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UHB3VVgyZXlLUUw1aDBRRXhUSUNEbFFvZ3hjM2VZZzF3aGhkYTU1RFpnYX5U","scope":"openid profile email offline_access","userSessionStartedAt":"1745732850","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"UHB3VVgyZXlLUUw1aDBRRXhUSUNEbFFvZ3hjM2VZZzF3aGhkYTU1RFpnYX5U","code_challenge":"oZMkH_Zfcgh1TujYsGDrmNhAuqT_VDJD8xGtgeIPfM4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('a32dfb3f-40f4-4b4e-b855-e779143b5c6f', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746254056, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"Nnx61K35e7h2mX4brvTvZw","startedAt":"1746254053","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cmpHQm40MmVCUHQ5N1dKWHRrdGguZGVaOFI1d0xQVU5oeWx5NUVRSEhOb1Vr","scope":"openid profile email offline_access","userSessionStartedAt":"1746254053","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"cmpHQm40MmVCUHQ5N1dKWHRrdGguZGVaOFI1d0xQVU5oeWx5NUVRSEhOb1Vr","code_challenge":"Uc3oagxr91d0HcDjU7eRHCGVgaaCXYRgmLKqEaRyhts"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('a27c132d-32bf-440e-a227-ce45e10c6768', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746256320, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"TXrJQnN0hQQecQJYqqRXug","startedAt":"1746256318","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UXhfR0NQcHViRVh2QlRuaFJXUVdMUm91ZH43UmVWWVo3NEtKTVpFVldqY1ZB","scope":"openid profile email offline_access","userSessionStartedAt":"1746256318","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"UXhfR0NQcHViRVh2QlRuaFJXUVdMUm91ZH43UmVWWVo3NEtKTVpFVldqY1ZB","code_challenge":"cjtZqmzGLih3ZaXIGy1PVdbdbg01hLiogcdkz-KrmqU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('2a142732-21a1-494f-9ef9-625dd34f4703', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743006002, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1743005813","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743006002","level-of-authentication":"-1"}}', 'local', 'local', 2);
INSERT INTO public.offline_client_session VALUES ('28095c57-24c4-413e-bd23-635ea3ada920', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746256328, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"ExqlQSUHcq4LD2dlv7jA1A","startedAt":"1746256327","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"VGVZQk93bXdMY21XdXZsZHVSVlUyQ1BKOFZSeHppZDB5NWQ3UFBNWWJNVVN1","scope":"openid profile email offline_access","userSessionStartedAt":"1746256327","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"VGVZQk93bXdMY21XdXZsZHVSVlUyQ1BKOFZSeHppZDB5NWQ3UFBNWWJNVVN1","code_challenge":"AabWRsXQkxmqPSt1iZ_ZwhiGxu59tWnQYLcypDCeurQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e65486bb-4bb5-45aa-a92e-848bc8258bd6', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744445038, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744444879","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NElNV2hzQTlUeEdLU29yVnFfRzdMcWU0WjVRQXJBaUU1Snp5RmMwRTR0a2hQ","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1744444879","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"NElNV2hzQTlUeEdLU29yVnFfRzdMcWU0WjVRQXJBaUU1Snp5RmMwRTR0a2hQ","code_challenge":"mnrglynpt5X-CD1Ugc7_LkBed1lW9EidHX4HjhhgARE"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('437d0479-7c12-460e-b78d-cdf1caa908bf', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746257971, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"_c7Coz474nFR3E-10KZN5g","startedAt":"1746257970","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WHVqSm41dnlyTFptMlV3ODF4SlBJODNtTk5qdEJ1VU1vcGVZOENVemY2c1ZM","scope":"openid profile email offline_access","userSessionStartedAt":"1746257970","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"WHVqSm41dnlyTFptMlV3ODF4SlBJODNtTk5qdEJ1VU1vcGVZOENVemY2c1ZM","code_challenge":"VXyuROnRASi8F8Y3tfJefqP9mzOec5_ym0Al5ZXLho8"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('a399e955-095a-4a80-803f-73517e97c883', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746257978, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"rwwUCQNc2QYfW5iw2uD05g","startedAt":"1746257977","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bU05QURrZXVmMUdFUkltVHVidnQufjNmTkJCc1ZkTWNtczV0ZWY4UVhRZm1w","scope":"openid profile email offline_access","userSessionStartedAt":"1746257977","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"bU05QURrZXVmMUdFUkltVHVidnQufjNmTkJCc1ZkTWNtczV0ZWY4UVhRZm1w","code_challenge":"VfH90bbbu1B7EUmKkQG2N-doOHWLNGaqJibEEipfroI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3ed3b402-6131-4cc7-8f00-58f3e8ffacb3', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746259770, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"0ZYvlUqVt4u59RL4v8s9NQ","startedAt":"1746259769","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"N1RuVkdKRV9Za3NwRUh0LVU2aEpxclJobW1jY09Sck50NWxvVTdBSHdqVml1","scope":"openid profile email offline_access","userSessionStartedAt":"1746259769","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"N1RuVkdKRV9Za3NwRUh0LVU2aEpxclJobW1jY09Sck50NWxvVTdBSHdqVml1","code_challenge":"Hn3iXOIxp3K6x1GB4zvJ0NiUZlPqtkmAlk-QhNxwhXI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7f9bf90c-ecf9-4900-a1d5-84615f7d14ac', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746259781, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"RRi6JpQu4V-6gE3iqggfCQ","startedAt":"1746259781","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"eGNzV3kybDVvSn5Zd3pFZGtsSXhLSEE3T3N2a0VUWmU2WENNSkYzUWhzeXVB","scope":"openid profile email offline_access","userSessionStartedAt":"1746259781","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"eGNzV3kybDVvSn5Zd3pFZGtsSXhLSEE3T3N2a0VUWmU2WENNSkYzUWhzeXVB","code_challenge":"FoIAZMZXr6O6fiA2aI1prB3v_0GhxCxPo6BXFh2alT4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('fb026717-466c-4047-a5a7-7676689a6b20', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744458552, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744458552","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"LW5YbG9nSGJ3X2oxZWpfeXBXZ29RTENaRjNzY0EyNV83bVVRdVl4Y09xNHdZ","scope":"openid profile email offline_access","userSessionStartedAt":"1744458552","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"LW5YbG9nSGJ3X2oxZWpfeXBXZ29RTENaRjNzY0EyNV83bVVRdVl4Y09xNHdZ","code_challenge":"3IddEOfY917eAdi7Ih9o8htzPnO2oVYYOBsRR2NEX7Y"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('ad134269-208c-4414-b282-e4d8236967cd', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746262314, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"vhdosq7EbpQWypd283KZyA","startedAt":"1746262313","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"OVEyWHhVSH41MUUwYzdaRzdqS2FkX1ZOVTF5U3AwalJValgwN20xczBFUFBr","scope":"openid profile email offline_access","userSessionStartedAt":"1746262313","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"OVEyWHhVSH41MUUwYzdaRzdqS2FkX1ZOVTF5U3AwalJValgwN20xczBFUFBr","code_challenge":"BoumllN58yyM0hXP7PehY7A01m_1Ne81Rgu9W9srO5Y"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('4c0935f4-8e0a-47f5-bcd8-649f6ac57988', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746278503, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"J-tpAf-ccAi-L5HaP41j7w","startedAt":"1746278502","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RG5wdWZnUW5yMC5IUGZYNlBSd2RJVml0TjVNRXRoVGxMaEZpUFkzVy5nZ3RT","scope":"openid profile email offline_access","userSessionStartedAt":"1746278502","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"RG5wdWZnUW5yMC5IUGZYNlBSd2RJVml0TjVNRXRoVGxMaEZpUFkzVy5nZ3RT","code_challenge":"WubzT6kx8uy8GN4bSgklfAIFeFG3a_tWh8E0l5mxFVI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('23848223-fe89-48b6-a958-1c712bf43148', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746280130, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"2-4B4r8Hhrra-QH4TNM-Vw","startedAt":"1746280129","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"eTlxNW5YclBEc3FXZVVGTndYRWRxWVZpOGVOZ01FVEJ4RzUySTkxTkhVYm9r","scope":"openid profile email offline_access","userSessionStartedAt":"1746280129","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"eTlxNW5YclBEc3FXZVVGTndYRWRxWVZpOGVOZ01FVEJ4RzUySTkxTkhVYm9r","code_challenge":"zcKJ_CCeSHSiNlWfBv323A-VdbKY7UievXcwNl9PBrc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3b8933e5-ceb6-4d47-87b6-f7468941969a', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746280138, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"OpYCTW9BxfyOwJZzBJZ7zg","startedAt":"1746280137","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Y2RrbTRfYTlhTkdUa2UySTRiaGZDUlQwSlJHRFQuWkdBRHRyNlNKLkdPUERC","scope":"openid profile email offline_access","userSessionStartedAt":"1746280137","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"Y2RrbTRfYTlhTkdUa2UySTRiaGZDUlQwSlJHRFQuWkdBRHRyNlNKLkdPUERC","code_challenge":"swbTEVo-Lok0htoH1AW-0w22pD7FnzzuEV-zxKriL_o"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('a3a4792a-3bcc-43e1-a778-26f9110e5562', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743432799, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1743432771","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743432799","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('11ef36d6-483c-4521-80ac-5272daeefbe7', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746281576, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"V_S_Vk1ge9ZiO2Tlu7i4tA","startedAt":"1746281574","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"S0FRVkgyS0JEeERZd0hWLVAyaHFMLnk0RlhmcnpVLkRiREpKMVh2fjBUU2Ff","scope":"openid profile email offline_access","userSessionStartedAt":"1746281574","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"S0FRVkgyS0JEeERZd0hWLVAyaHFMLnk0RlhmcnpVLkRiREpKMVh2fjBUU2Ff","code_challenge":"3f3hM6X9KR-OVnYE4Ar26BZtyJyHBUcSkwQRgxQ4sgs"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7088ca05-4e90-4d70-9d12-8ca0e3aa70fc', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743158160, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1743157221","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743158160","level-of-authentication":"-1"}}', 'local', 'local', 9);
INSERT INTO public.offline_client_session VALUES ('ce374e6a-1030-4be4-a65f-6c6737ed75ed', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746281582, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"l8MmEPTFLj2G23CvaaFBAg","startedAt":"1746281581","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"dkRoXy4ycF90TlhLWUg2ZkpaOTRPek5JSE8xcVRzaEhaWHFKaHd1WTFkb3c0","scope":"openid profile email offline_access","userSessionStartedAt":"1746281581","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"dkRoXy4ycF90TlhLWUg2ZkpaOTRPek5JSE8xcVRzaEhaWHFKaHd1WTFkb3c0","code_challenge":"lpBiMBWm88UKwkAUClk1nXtTrTk9GPsFzgZX2n69IiI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7fddfdf1-aca5-417a-bafc-8b2093989bfb', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746282940, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"1hPXMdYUM7bBd_MGdqUysw","startedAt":"1746282939","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SFdUaX5hTVFWdDJtLUFTfndrZU9Id1hjc1pIcjUyN2tfQkpxMGpGLi54djRp","scope":"openid profile email offline_access","userSessionStartedAt":"1746282939","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"SFdUaX5hTVFWdDJtLUFTfndrZU9Id1hjc1pIcjUyN2tfQkpxMGpGLi54djRp","code_challenge":"PQl8TmHhJGStJanpgi1qYRmo0OTUazYix_0d4oOBO6k"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('dbba74e8-5f87-4952-b207-72b2d031068c', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746282950, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"xbghB-dKq_4VLfw8NpaY-A","startedAt":"1746282948","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cVJQSldzZFktQldoNm1HUHF5ejI5bzl-WXhaODd0Q0M5NHRjMnJPVVIyTzVr","scope":"openid profile email offline_access","userSessionStartedAt":"1746282948","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"cVJQSldzZFktQldoNm1HUHF5ejI5bzl-WXhaODd0Q0M5NHRjMnJPVVIyTzVr","code_challenge":"20-woM5qJPzGYDCHcojEsipl78XS2FFRdtNMdIydPro"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('543a5bfc-0819-40dc-a73d-e9e87a6a994d', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746284555, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"UiJLya7323Q5ZtpEOj7KeQ","startedAt":"1746284553","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Z1V5Lm5HUUd3VUdPd1UyNThVYm0wVXlQOFNDY1Z6RTRXUzVpYkh6MHR2b2Fy","scope":"openid profile email offline_access","userSessionStartedAt":"1746284553","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"Z1V5Lm5HUUd3VUdPd1UyNThVYm0wVXlQOFNDY1Z6RTRXUzVpYkh6MHR2b2Fy","code_challenge":"PdyDpDmF46HWoHpylzT_RItiZbXR9F0G7HsW02MIAXg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('9ad9289e-ff65-4062-825a-1889f0433e64', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1746284567, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"iyhPbkOuCkHHcDs5JGZBHg","startedAt":"1746284565","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"LnlNWWRabTdBNXoxSXJEVXVkeTB1UEFPZFhCQndza2cuTHNiM1Zld0xiWVo3","scope":"openid profile email offline_access","userSessionStartedAt":"1746284565","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"LnlNWWRabTdBNXoxSXJEVXVkeTB1UEFPZFhCQndza2cuTHNiM1Zld0xiWVo3","code_challenge":"HPx0nnCj0HRS-Dlo8nZan-7bcHEJUoOHYyMEEKFtYNQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('72a82fcf-0904-4878-9a9b-8b5319d31604', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1746288082, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1746288082","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Q19HQnpHdzd-WjR0NGxLNUx4cXBzTWNhNHd5LkQtU0JmaE51U0ZQUG1ob2Jm","scope":"openid profile email offline_access","userSessionStartedAt":"1746288082","redirect_uri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","state":"Q19HQnpHdzd-WjR0NGxLNUx4cXBzTWNhNHd5LkQtU0JmaE51U0ZQUG1ob2Jm","code_challenge":"mrMamU4JnN41P6NzUwHA6gh6fAVNEQXQnIQ6EH5NHrI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('dd20095b-ec89-4583-9acd-74f1e54eacbd', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743243106, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1743242016","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743243106","level-of-authentication":"-1"}}', 'local', 'local', 3);
INSERT INTO public.offline_client_session VALUES ('d1c76649-bd76-480d-90b5-ff36b96b040d', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743217411, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743216256","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743217411","level-of-authentication":"-1"}}', 'local', 'local', 4);
INSERT INTO public.offline_client_session VALUES ('58fc1f20-bdf6-4f88-b8de-4990d27575e5', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743218126, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743217621","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743218126","level-of-authentication":"-1"}}', 'local', 'local', 2);
INSERT INTO public.offline_client_session VALUES ('d70af6f1-a998-4b7c-a0b9-2cdab2345e59', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743435076, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1743435042","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743435076","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('7d092b33-119f-4205-9272-f59f83d342bd', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745146828, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745146826","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"b1NCalJvdTY3VEJpRH5rSlNpV0dIMEM0ajlPY2pDVHllbllmSlNiLWkxSGZZ","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1745146826","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"b1NCalJvdTY3VEJpRH5rSlNpV0dIMEM0ajlPY2pDVHllbllmSlNiLWkxSGZZ","prompt":"none","code_challenge":"DsuMOf2V7PvVD-PsN3sKBKj4s0mrfpeZ9MpojZPZpOU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('ecd7d7ae-39af-43a4-b26d-b515d4461de3', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744458593, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744458592","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TnIuODJpVmhBTmJCeUpzTUhQNjV6bUlVeEstTzNGMmx2UDVSLWtSSk0teVRV","scope":"openid profile email offline_access","userSessionStartedAt":"1744458592","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"TnIuODJpVmhBTmJCeUpzTUhQNjV6bUlVeEstTzNGMmx2UDVSLWtSSk0teVRV","code_challenge":"crNErNHgTkhcOZh37LsXI8kijbCmOtl5jNV9mLyz-CU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5e5d1983-716b-44db-b031-66a80f97e3a3', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743252263, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1743251449","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743252263","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e871681d-fe11-4d2e-a03b-0702f225f574', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743338874, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1743338636","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743338874","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('8e5200ce-8ebe-4e86-98af-74bf8eda2271', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743267300, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743266506","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743267300","level-of-authentication":"-1"}}', 'local', 'local', 2);
INSERT INTO public.offline_client_session VALUES ('f9a93ebb-49ba-47a2-bd32-095f08433e3d', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743271932, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743271270","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743271932","level-of-authentication":"-1"}}', 'local', 'local', 8);
INSERT INTO public.offline_client_session VALUES ('d58521be-9a64-4af6-82ee-21308683796f', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744459665, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744459665","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UDFDWjlGZko4eURxMW5pSlMyY29OVW1GSWc0UjRzY0ozNjdsZnZwQkFmeFM4","scope":"openid profile email offline_access","userSessionStartedAt":"1744459665","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"UDFDWjlGZko4eURxMW5pSlMyY29OVW1GSWc0UjRzY0ozNjdsZnZwQkFmeFM4","code_challenge":"YIeN5KBmR1jZKpU-X0o9whEigwo5AbAC5OCUBuglAuQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('6e04740e-a130-4e93-a648-6b2e9d8c949a', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743322538, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743321791","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743322538","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('84950c45-5101-4525-8509-de8f456e67e6', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743324267, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743323367","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743324267","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('8071e339-5570-4dff-90e3-c5327ba466b9', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743324917, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1743323884","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743324917","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('2c006cb2-9329-4eb7-958d-c607e99d4de1', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743325965, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1743325488","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743325965","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('cf6c7d7d-4b32-40f9-9a7c-d0385b434512', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743336581, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743336001","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743336581","level-of-authentication":"-1"}}', 'local', 'local', 3);
INSERT INTO public.offline_client_session VALUES ('d78082df-7a67-4004-bf66-a73840f42e0c', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744466211, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744466211","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"eGRuNW01NVZNQl81bTRscTdoLTNtaWticl9-UXdqWG5zcVlNRXRka3RJTC1J","scope":"openid profile email offline_access","userSessionStartedAt":"1744466211","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"eGRuNW01NVZNQl81bTRscTdoLTNtaWticl9-UXdqWG5zcVlNRXRka3RJTC1J","code_challenge":"KlCl4mZEsOdhbnZuGlCeoRPum3dCae9xRkSDuU-ekxQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('bfb8a03b-ac37-46bd-bc49-52750d5ee12d', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743337579, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743337391","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743337579","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c3c67efc-5066-4c6f-b43c-351d26f33fcb', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743826739, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743826739","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"aUJjMmhNeEN6dHpkWnpDb2Q5TmcxSXdSYUFYeWpGcTFnbjVlSWNncko4dnlK","scope":"openid profile email offline_access","userSessionStartedAt":"1743826739","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"aUJjMmhNeEN6dHpkWnpDb2Q5TmcxSXdSYUFYeWpGcTFnbjVlSWNncko4dnlK","code_challenge":"ctZ-Zb5iJvUuGw6wFoyRjMFsHACksmQ2x97I7B4Ar5Y"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('80535829-f106-4d32-9ed6-ed3fc4aaedf1', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744516146, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744516146","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NUtFQ2Y1ZFZTYVFMVkJFOHFQaFgueTdhb0cwRC1Dbk1CVG9waFJTWjFWbX5q","scope":"openid profile email offline_access","userSessionStartedAt":"1744516146","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"NUtFQ2Y1ZFZTYVFMVkJFOHFQaFgueTdhb0cwRC1Dbk1CVG9waFJTWjFWbX5q","code_challenge":"EUlzHfdBT-1yTMOe5DwdpLJXvlQG9_LMyKJNZMDMgwM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('a14a40f9-d4c6-4d91-b2a1-3f1ccb7903f8', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743349547, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743349523","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743349547","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('76d66232-538c-4958-a788-f75517266e28', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743341435, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionStartedAt":"1743340111","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743341435","level-of-authentication":"-1"}}', 'local', 'local', 5);
INSERT INTO public.offline_client_session VALUES ('d3046a04-2c14-4eaa-9d9e-fe1cc682ae38', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743828283, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743828282","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UHd2cVV3SEw4RmJSRn5HYkhrXzZafi1lUjBCdENCZDU4US1DRmNpeWJpN1dy","scope":"openid profile email offline_access","userSessionStartedAt":"1743828282","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"UHd2cVV3SEw4RmJSRn5HYkhrXzZafi1lUjBCdENCZDU4US1DRmNpeWJpN1dy","code_challenge":"KYBo9W24F6-u_NnF7Th1AF5USvIqg6SMx9ndL_mRDFQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('fa84af14-2b1c-4ffc-bbd3-28ba592fcdd6', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745159881, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"45eza15bmUL3N7PDhaZGeg","startedAt":"1745159879","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cnhGYWE0a0FORXR3YmZmX0JiRTdzbWpRV0tPSzJXLXBXdnNKSGE4cDd5TFJG","scope":"openid profile email offline_access","userSessionStartedAt":"1745159879","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"cnhGYWE0a0FORXR3YmZmX0JiRTdzbWpRV0tPSzJXLXBXdnNKSGE4cDd5TFJG","code_challenge":"wyXqwGL1lsPq8zsGuXJ5__B27GcixWyjLCfrcTUz-k0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5e1d62e5-3177-441d-8331-8c91d6a858c5', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743352076, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743351335","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743352076","level-of-authentication":"-1"}}', 'local', 'local', 8);
INSERT INTO public.offline_client_session VALUES ('942d097b-fb79-4432-895f-0f1e124e3bb4', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744526678, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744526677","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"V1lwX0REV1BmUXdnVEZYVU00V19jUFJNZGpIOXgwbG1Zd0pGTHhLdU1QLXhz","scope":"openid profile email offline_access","userSessionStartedAt":"1744526677","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"V1lwX0REV1BmUXdnVEZYVU00V19jUFJNZGpIOXgwbG1Zd0pGTHhLdU1QLXhz","code_challenge":"_2Ma3cI5F2K65VAVjlzGWSjHf9L_xajBEl-1syY-2YQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('888debb6-2dd1-4c5b-8a5a-f742cc45623b', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743830143, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743830098","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZHBYQk5SMThrZUVCVGNFOWRpVmdQSWNuV2NNQWlJVHdrRVBnSlAwM215TldI","scope":"openid profile email offline_access","userSessionStartedAt":"1743830098","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"ZHBYQk5SMThrZUVCVGNFOWRpVmdQSWNuV2NNQWlJVHdrRVBnSlAwM215TldI","code_challenge":"MmZXiyQkceVWLSnkul0DNeNr9YtQH1H1jMWdThlfuyM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('914a52b5-8867-4b12-9fc8-3fefe39b6af5', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743830148, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743830148","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bnZIZW9rdHJ4dlAzWFQ4VnRrT1ZfTUZMOXdjVWFjcmhjYlBHWXBEdWxJVkc3","scope":"openid profile email offline_access","userSessionStartedAt":"1743830148","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"bnZIZW9rdHJ4dlAzWFQ4VnRrT1ZfTUZMOXdjVWFjcmhjYlBHWXBEdWxJVkc3","code_challenge":"Qo4nfqMJOUPTMXlU4Kwz7T5Wu1os2ceY6-A9fEK-S40"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('942d097b-fb79-4432-895f-0f1e124e3bb4', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1744527928, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1744526678","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744527928","level-of-authentication":"-1"}}', 'local', 'local', 2);
INSERT INTO public.offline_client_session VALUES ('aff8bb37-002a-4b3d-9170-ab5cb9298309', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744528039, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744528038","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"clpsanZhdXprRElsLkdJNFRDVE12Z0pYZTZPTDY2WVFOM3NSZVhDWGQ5Ulp-","scope":"openid profile email offline_access","userSessionStartedAt":"1744528038","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"clpsanZhdXprRElsLkdJNFRDVE12Z0pYZTZPTDY2WVFOM3NSZVhDWGQ5Ulp-","code_challenge":"we-TZ4so9Mz4_UCNjMVQpFaa8X3Rn-Y4UVGf_oVItRw"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3dc2d36d-23fe-4d23-bd1c-04305bf562d1', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743831833, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743831831","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"dVR5Z1Z6ME9QYW41Sng4dVJmdWotSE5DYzEzRlRUVFQyZ0djLTQ2aS5xT2Ja","scope":"openid profile email offline_access","userSessionStartedAt":"1743831831","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"dVR5Z1Z6ME9QYW41Sng4dVJmdWotSE5DYzEzRlRUVFQyZ0djLTQ2aS5xT2Ja","code_challenge":"Utda1N67aWWiiTFBZUlLzWMMjw7XGgqN7J1bcMiMcfU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('aff8bb37-002a-4b3d-9170-ab5cb9298309', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1744528063, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1744528039","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744528063","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('cdba9c02-6104-41e2-a0dd-3088f13f1737', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743831844, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743831843","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WjNMY0kxcVA5SV9CT3NyWTI5QXNuZXMwTk9sbXptc0NLQ1FGSGxHR1plT3U3","scope":"openid profile email offline_access","userSessionStartedAt":"1743831843","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"WjNMY0kxcVA5SV9CT3NyWTI5QXNuZXMwTk9sbXptc0NLQ1FGSGxHR1plT3U3","code_challenge":"pE96Yql5ggNX-S9CSqUdTkroOhSg1RinTmR03Pr87Vg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('8da602d7-4e0b-4cf3-8801-6801ffe35419', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743833924, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743833923","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UTJ5ZGJDd252b2dFTjNVRjd-ZURQeF9QakJrcy0wclFsTnp3MGFEUU9ad2pi","scope":"openid profile email offline_access","userSessionStartedAt":"1743833923","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"UTJ5ZGJDd252b2dFTjNVRjd-ZURQeF9QakJrcy0wclFsTnp3MGFEUU9ad2pi","code_challenge":"a7wRWmdJBsnh70MEdvzvHOe1RYfuEq3yn95t04DVvdA"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('4a7c6f26-d684-42a3-a6ad-d7fea0f715c0', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744529411, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744529411","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ajMxU1hqT1NyY1BBSzFlX0hrVm9zSUh2TEhMLTZ5R0YxeXdGNURQMlpHaTBY","scope":"openid profile email offline_access","userSessionStartedAt":"1744529411","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"ajMxU1hqT1NyY1BBSzFlX0hrVm9zSUh2TEhMLTZ5R0YxeXdGNURQMlpHaTBY","code_challenge":"QuAZJUPEDYFZl4O6tpv3Fsg46BRSZl7MrY6bvD7OT1A"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('fda12cd8-70a1-4117-a633-70472f2b5ecb', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743834457, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743834456","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TWhQZlRmM0N5ZXpQNnhfalBSeXhFa1VvaFRNTzRtQWo5WEQ1aFRkeC5yejF4","scope":"openid profile email offline_access","userSessionStartedAt":"1743834456","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"TWhQZlRmM0N5ZXpQNnhfalBSeXhFa1VvaFRNTzRtQWo5WEQ1aFRkeC5yejF4","code_challenge":"pHAavGUoFK7oRsEdiGgzt_F4j10gBU-0Ea4AF4WYshE"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('35d7eafb-9bf6-4286-b1d3-66dc5e7fdc53', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743835337, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743835336","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZEpKeTExbUZwa1JCN19mMWtOWkdGUVRjZm85fmtSY01Ccm5hfjRXc0ZsTG5C","scope":"openid profile email offline_access","userSessionStartedAt":"1743835336","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"ZEpKeTExbUZwa1JCN19mMWtOWkdGUVRjZm85fmtSY01Ccm5hfjRXc0ZsTG5C","code_challenge":"AkFILNG3WxsP9R17z-3sWaW5sLjAH_ZINGFJQXc_T3k"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('f2ffd927-c464-4acc-b15b-a655e0e43cae', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743835345, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743835344","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"d0ZYVlVkRkxXaDRvb0ZpanVKYXBpUEsyenAyYmo1N2Fad3Q5eHlYVWZRb1lq","scope":"openid profile email offline_access","userSessionStartedAt":"1743835344","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"d0ZYVlVkRkxXaDRvb0ZpanVKYXBpUEsyenAyYmo1N2Fad3Q5eHlYVWZRb1lq","code_challenge":"QCNroUzChr5pcbO-ItgSjAuMPbWSG8CUVj1U3hj8PEc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('2130d0f0-9af3-4384-9c56-a27858057f53', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743836432, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743836432","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SE01R2V-eUtVb0RBNk9NV01ZRUFGQndBdEswVExSQ1N5am85WFV0fmlnYWlK","scope":"openid profile email offline_access","userSessionStartedAt":"1743836432","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"SE01R2V-eUtVb0RBNk9NV01ZRUFGQndBdEswVExSQ1N5am85WFV0fmlnYWlK","code_challenge":"ExHxzpA3M5i0Z469bpx9SfJmxKTyeFnwSqhgc75eIOs"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('d1eb15de-6baf-4ffb-89da-41d20dfcffdc', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743836437, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743836436","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"N2JIMHNPa3VxdVFCWGhzWk4xS3V-VXVCQ0NCRzliekczRmxReWFDMFJsMjBM","scope":"openid profile email offline_access","userSessionStartedAt":"1743836436","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"N2JIMHNPa3VxdVFCWGhzWk4xS3V-VXVCQ0NCRzliekczRmxReWFDMFJsMjBM","code_challenge":"uzQvCKJuoz1I7wSzH_Fml0cquCs5ocoE1ytELq-6iLg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('57ea1bab-1205-4012-ba1b-9406c943217e', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743836731, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743836731","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"c0VIfkpjWi5DeldEZEhkWmZ-VXEwNExEaEVXbX5PUzBVWE0yMDdwbElTSzFq","scope":"openid profile email offline_access","userSessionStartedAt":"1743836731","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"c0VIfkpjWi5DeldEZEhkWmZ-VXEwNExEaEVXbX5PUzBVWE0yMDdwbElTSzFq","code_challenge":"Mx5DHFO-a8iJ9L-70uFdaW2EdOW5kRkSHQIjaoTkgH8"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('71d7d890-8278-4e53-bbd5-6c4ddd50ba57', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745161551, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"2_7XHx-4QFuk8dasWcmHzw","startedAt":"1745161520","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZzdORjlhbGhfSXpsS3VzTkQzeE9SbHQwcXJXcHJqaXpWczNEaVFqLk9lelNo","scope":"openid profile email offline_access","userSessionStartedAt":"1745161520","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"ZzdORjlhbGhfSXpsS3VzTkQzeE9SbHQwcXJXcHJqaXpWczNEaVFqLk9lelNo","code_challenge":"V-NWfQ2vyIHp9L5yNONm-Pioiy8IXC1BPSBsIQ0yHoY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e0e5ddb9-0dd0-4045-81a5-2ec6dac23d81', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743836736, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743836736","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RTVMY2ZTa21UOXRCUjBSLUdQVlZZWXoudVM4Vk4yM1BUWlouX1lKNGxKdWdM","scope":"openid profile email offline_access","userSessionStartedAt":"1743836736","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"RTVMY2ZTa21UOXRCUjBSLUdQVlZZWXoudVM4Vk4yM1BUWlouX1lKNGxKdWdM","code_challenge":"pQl0WpHRBZg7AZXhCIJtnQIx5PoMlCUuyy9T-6Tz9Ms"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('422354a6-c125-4040-9523-3ca4daba61e2', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744552804, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744552804","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MjdUb0czX2d2bDVvbFhwOHN3UGptcHp0eVUwdHlRRHhwTjdsaXBkelhMcHFt","scope":"openid profile email offline_access","userSessionStartedAt":"1744552804","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"MjdUb0czX2d2bDVvbFhwOHN3UGptcHp0eVUwdHlRRHhwTjdsaXBkelhMcHFt","code_challenge":"hNOUDre1cZLD-J3Yc2KagKMD_hDoTbaY-w8uhAaw5oI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('d7d64d55-0024-4d2c-8411-61194336a1c7', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743838026, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743838026","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RFF5WGpxUEF0eXJhcjhsNF9KbUxNNS0xM2VTZWFQTFguRkNTbGtKV1BqdDRz","scope":"openid profile email offline_access","userSessionStartedAt":"1743838026","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"RFF5WGpxUEF0eXJhcjhsNF9KbUxNNS0xM2VTZWFQTFguRkNTbGtKV1BqdDRz","code_challenge":"KURutPcxZExN-cBUPvFKVxWUkaFHyGIL1x-njM4tC4M"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5ab7dd9b-95d0-44ae-b8c1-82637a2f40dc', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743838059, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743838058","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SkhlWWVzOEtIRUJ1Vk96ai5CYnVsNFFOZWt3TDN0TlFnZjEubzdhT0hkSW5t","scope":"openid profile email offline_access","userSessionStartedAt":"1743838058","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"SkhlWWVzOEtIRUJ1Vk96ai5CYnVsNFFOZWt3TDN0TlFnZjEubzdhT0hkSW5t","code_challenge":"4plXd3jpZ-3jwP_AEfmXcAMTtroX5Asd4jeQ1Thb-ys"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('98242c8b-a506-4c1f-a066-55aece6bad95', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743838093, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743838092","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"QVVKekdfQTFSSX5CckhkT3hrY3h2RVVwRktOYjlrNUVPdDdqZn4zSUxqV2Zn","scope":"openid profile email offline_access","userSessionStartedAt":"1743838092","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"QVVKekdfQTFSSX5CckhkT3hrY3h2RVVwRktOYjlrNUVPdDdqZn4zSUxqV2Zn","code_challenge":"4EW48gckbEXuIFCvP3ObfKMIpoEqJnHFGCc2Gy_PmE4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('29cd46a2-6a0e-49c0-bf49-cfc02cbe34e8', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743838098, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743838097","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NjA1cHlaUnZadFFselQ0Nlcyb1RncVc4aXdiRVhPNURMaDFyXzBfTGFoUkpE","scope":"openid profile email offline_access","userSessionStartedAt":"1743838097","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"NjA1cHlaUnZadFFselQ0Nlcyb1RncVc4aXdiRVhPNURMaDFyXzBfTGFoUkpE","code_challenge":"9gYj7tGbVU8Xl71Cmc-sFJYRdhsapKHdrCVlUZI7UIc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('03714131-8e92-4ab0-9ac3-2b04c43ba466', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743839694, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743839693","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"LUk1eFBaeXJ2OWxyNmhwdlk0c1BXd2Y2OEoxeloxcDBXYXdSUUl5TERfRC1p","scope":"openid profile email offline_access","userSessionStartedAt":"1743839693","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"LUk1eFBaeXJ2OWxyNmhwdlk0c1BXd2Y2OEoxeloxcDBXYXdSUUl5TERfRC1p","code_challenge":"h5c1fda__DMltoLvADaC7PN9EkXLZuIMmSE4sgUt_Gs"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('03714131-8e92-4ab0-9ac3-2b04c43ba466', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743839819, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743839694","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743839819","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('1ba98ec5-e8cb-49de-a37d-79dd59e5aa9c', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743841031, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743841028","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MTJkRHRUalEycEJzN2wxQXNUMFFPMEY2SllScC12MWdMNS0zbFZ5ZzZRS0hu","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1743841028","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"MTJkRHRUalEycEJzN2wxQXNUMFFPMEY2SllScC12MWdMNS0zbFZ5ZzZRS0hu","code_challenge":"c9B9MVGl6iP0tG99Nkg0o9nqoKwm2dr3C2EsV8zF08A"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e34d32e8-72d9-4b4b-b8de-ac627d1ce191', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744591587, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744591587","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ODlHQmtsZURwNFNWT1k2LU4yU184WnpFXzViaWpLVzRFWmtLdExiSEpqaTdP","scope":"openid profile email offline_access","userSessionStartedAt":"1744591587","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"ODlHQmtsZURwNFNWT1k2LU4yU184WnpFXzViaWpLVzRFWmtLdExiSEpqaTdP","code_challenge":"pYTCBRm0J9MW3w60cLtEEEsD2dezoW_ugi3WrjDohMA"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e47d4ab1-2d68-4dcb-9517-ce64cd306d77', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743923046, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743923046","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"X1JROHJkcUkxLndVU0M4ZFhZaDZRb2dKTDN3dUFBdkx5WGtMTXNNRkliUXN3","scope":"openid profile email offline_access","userSessionStartedAt":"1743923046","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"X1JROHJkcUkxLndVU0M4ZFhZaDZRb2dKTDN3dUFBdkx5WGtMTXNNRkliUXN3","code_challenge":"uAbuU-vs2lhdN1tDuYbi9F7WPTmKzu7FZFy36IHbkf0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('ed269093-c362-4847-aec7-547b032c4692', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745161562, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"RtvUU_nIUAlu4mf8j4Qk-g","startedAt":"1745161559","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TVdKdWpjNkprUld2Rno2fkRtfnVmYmlIbWo1b28wZUlmNnp3MlJtU2hVTklN","scope":"openid profile email offline_access","userSessionStartedAt":"1745161559","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"TVdKdWpjNkprUld2Rno2fkRtfnVmYmlIbWo1b28wZUlmNnp3MlJtU2hVTklN","code_challenge":"Uvr5QJ2_80W0nxMc8jLP_-8WoOwb3frxb7GXaVs3lkA"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('fa69e4cc-5008-4569-a63f-00b8a1d6d72d', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1744636413, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744636413","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cDFWTDItQjhGNUZkRWlUVFpMLWllTjNLbzlKVzUzcGQ4akZwZUFqTkUycFNj","scope":"openid profile email offline_access","userSessionStartedAt":"1744636413","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"cDFWTDItQjhGNUZkRWlUVFpMLWllTjNLbzlKVzUzcGQ4akZwZUFqTkUycFNj","code_challenge":"wanxXTG7fZxK0Pagdt_9xtAeIMU4V9u_hvx1UWLndQc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('fd9b8daf-6786-4d5b-b3fa-e5a8a710d828', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1743923767, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743923766","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Wk0wYVNMa2hHOFdaeXdkdXJYcmxERDBHNzBNeVNxODBYZzQ4ZHB6NktESW02","scope":"openid profile email offline_access","userSessionStartedAt":"1743923766","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"Wk0wYVNMa2hHOFdaeXdkdXJYcmxERDBHNzBNeVNxODBYZzQ4ZHB6NktESW02","code_challenge":"QGIYG3dBV9PL3uDIz4oxmUmVQxCG7vWtWydqDxaNafU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('f1ea317f-2ce3-4e6e-afbc-0078d57d248d', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1743925202, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743925201","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MEhoZ342RzBqalpmR2E3MXBCSWkuVm13OVl4b1dBYTJSS3pHT1ozd2s2ZXBZ","scope":"openid profile email offline_access","userSessionStartedAt":"1743925201","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"MEhoZ342RzBqalpmR2E3MXBCSWkuVm13OVl4b1dBYTJSS3pHT1ozd2s2ZXBZ","code_challenge":"_BoGRQuh4yssSjYYzc_tux5w0JoYd5_JF2URJ2SEZxM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('f1ea317f-2ce3-4e6e-afbc-0078d57d248d', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743927848, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743927848","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Vm95Z2gxUTNON3NXZ1pSeGliSGJwQWlxdndYbDY4dTBaWW9ER35HWURjQ2Nx","scope":"openid profile email offline_access","userSessionStartedAt":"1743927848","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"Vm95Z2gxUTNON3NXZ1pSeGliSGJwQWlxdndYbDY4dTBaWW9ER35HWURjQ2Nx","code_challenge":"ZV23Ji-5Nprtxg90u_H2HozO9JKpJcGFUkoj5Jttf9k"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5a9b8cdc-3a27-46ce-96ba-e1fae0bfdb4a', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743929293, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743929292","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MmZhbm9IfmVPWHdVZkgwbHd6cl9ER2pUSGFYQ3ZMaDhpNXprbzlFSmFJNnVR","scope":"openid profile email offline_access","userSessionStartedAt":"1743929292","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"MmZhbm9IfmVPWHdVZkgwbHd6cl9ER2pUSGFYQ3ZMaDhpNXprbzlFSmFJNnVR","code_challenge":"YXmOMU2eCn9azpyS6Gr15qtwmvRuGjxn1cdgdn4scSo"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('59a7dc3b-7d53-4794-995e-ac96a67ad2f2', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743929296, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743929296","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WVhTQ3hyeFh5enRWRXhGcWNIVmhOfjRsMjJKZXV1aFREUnFlV0w0SWhQTElX","scope":"openid profile email offline_access","userSessionStartedAt":"1743929296","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"WVhTQ3hyeFh5enRWRXhGcWNIVmhOfjRsMjJKZXV1aFREUnFlV0w0SWhQTElX","code_challenge":"iGX_LoZzSG-A8BU62Evg2cd9bZqpP3Anb9c6c5zOBaM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('cdd3342b-1680-4d70-bb87-ac0e3a196816', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744554165, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744554164","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"LXZTc2dUa0NZb1VXYUtBT1NJU1cuTXJPaTFWVU5Iblp6VEgwYzE5X0VMaWZt","scope":"openid profile email offline_access","userSessionStartedAt":"1744554164","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"LXZTc2dUa0NZb1VXYUtBT1NJU1cuTXJPaTFWVU5Iblp6VEgwYzE5X0VMaWZt","code_challenge":"ZkQ0v2MV6JibtSeF5VuarI9IwLbPYqfOxD8tQHkemqw"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b56ad077-7119-4992-bc1d-6caf2b847e5e', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743930787, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743930786","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"OEh2Zk1yTnVaVW5ScWh6WTdZb2U5ZnFuYzJBeFlRfkdRUTFDSDQ0cnUxT2Nq","scope":"openid profile email offline_access","userSessionStartedAt":"1743930786","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"OEh2Zk1yTnVaVW5ScWh6WTdZb2U5ZnFuYzJBeFlRfkdRUTFDSDQ0cnUxT2Nq","code_challenge":"tMAjd2stp89GclL7eDMmdVESqeUHu-d7oEibQorWbyE"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('00b85fe4-627d-4121-a65e-217a2348fd6e', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743930792, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743930791","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"QmF3MmpJS3hfZ09iakkwdGpzVmJXSzM2TWZiM2FxakF5MXpJUFBscEhDVFpO","scope":"openid profile email offline_access","userSessionStartedAt":"1743930791","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"QmF3MmpJS3hfZ09iakkwdGpzVmJXSzM2TWZiM2FxakF5MXpJUFBscEhDVFpO","code_challenge":"fmf8AAxhWqQ34uHuvqVSFpXBBcarMYW3xl1ok4it5-w"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('fecce73c-6b08-459d-9216-6b674ac20266', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744554174, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744554173","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"S2RROWRHV3hyRVIucnR4am1ST1I4UnN2U0lafjZLSXdEaGNxbU1DVHg0TDZQ","scope":"openid profile email offline_access","userSessionStartedAt":"1744554173","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"S2RROWRHV3hyRVIucnR4am1ST1I4UnN2U0lafjZLSXdEaGNxbU1DVHg0TDZQ","code_challenge":"xZ_dAeijP-IvDzKWuPkBHA_x1xc1vGOtQwyKPksfnOs"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('47e632e9-6d1f-4c4d-b4f9-48092120127d', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743932338, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743932337","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"fmtYNmlrcUR3Vm84UnpkejJQVmJaMUtGS2FmVndHNVlNZUZXWVA4ZVNOdnhN","scope":"openid profile email offline_access","userSessionStartedAt":"1743932337","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"fmtYNmlrcUR3Vm84UnpkejJQVmJaMUtGS2FmVndHNVlNZUZXWVA4ZVNOdnhN","code_challenge":"Dd4bPAlQkVVaKBFPCw3Cx4gmSgd3MIQB4JgKUZigXvw"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('51ccd78f-b83c-4f7f-abbc-2f6183a0ebfb', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743932342, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743932341","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SkQtZkd5VnVyVkhVdnAxckt3c1VBVDNFa05SUU5SX0ZGd19DQXJhaUtZdXJV","scope":"openid profile email offline_access","userSessionStartedAt":"1743932341","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"SkQtZkd5VnVyVkhVdnAxckt3c1VBVDNFa05SUU5SX0ZGd19DQXJhaUtZdXJV","code_challenge":"kK4jWJ8ilG5p_NNKALrYzOVRNcNZSyeEd7BBFgRtyKk"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('51ccd78f-b83c-4f7f-abbc-2f6183a0ebfb', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743933197, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743932342","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743933197","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('e4869299-132d-43c4-9a73-4129ac58fc3e', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744555585, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744555585","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RVJDRnouM3pKeHRKTmVydi1aV09xTm9sNTJab3BLejE0NVJGRnR1eDFoRlBy","scope":"openid profile email offline_access","userSessionStartedAt":"1744555585","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"RVJDRnouM3pKeHRKTmVydi1aV09xTm9sNTJab3BLejE0NVJGRnR1eDFoRlBy","code_challenge":"HJgqvqj0ty9dUogbnLXPXT6EbrKL825EZr4h5fObHe0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('f722960a-6d00-4d66-8f31-601366ba9e0d', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743933740, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743933739","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WklTS3JQUzNYYk11TnRsdEZoX3ZUbX5aVVh5cUZmRlVxV29-ZXdPN3JPZzVI","scope":"openid profile email offline_access","userSessionStartedAt":"1743933739","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"WklTS3JQUzNYYk11TnRsdEZoX3ZUbX5aVVh5cUZmRlVxV29-ZXdPN3JPZzVI","code_challenge":"55b0MIjzP_DOow3vP9uXso_bdITEA5vnGSMNWQP7kYg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7f1c3a7f-8f3d-40ee-ab23-0843e426497a', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743933743, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743933743","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"eGppOFFFQi1lbjB-YmtkcjIuR1JpeFo0bi5PLmJiZnUxVmU1Z0NzLU5UbGJ6","scope":"openid profile email offline_access","userSessionStartedAt":"1743933743","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"eGppOFFFQi1lbjB-YmtkcjIuR1JpeFo0bi5PLmJiZnUxVmU1Z0NzLU5UbGJ6","code_challenge":"5Au9AHHQUY596_85a8TCLMuyIbdB_n81aZ-BBW9XAoI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7f1c3a7f-8f3d-40ee-ab23-0843e426497a', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1743933936, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1743933743","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743933936","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('57bf2f94-3e21-464a-937d-7376d31d4e28', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744555716, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744555715","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NTVFd2N6NFZnNzA5dFl5MG90fjJDU2d5TC5nRHdYS1VQSmFEdDFZeFdUfjdO","scope":"openid profile email offline_access","userSessionStartedAt":"1744555715","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"NTVFd2N6NFZnNzA5dFl5MG90fjJDU2d5TC5nRHdYS1VQSmFEdDFZeFdUfjdO","code_challenge":"Ty8vm2Ln3j-WS0M-1WsnTiWvr74n1uQ2XjK3ound4Rs"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('87fca5da-4bdf-4f0f-89f4-75977e66c48c', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745164852, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"6v64-QaociQLLcsYdcrQ3A","startedAt":"1745164849","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WWR0NWVCcy1GUy1CUklUTEZGbUIzZElyaWwzU1djM1hTdVpfT0dKQkVNdjFl","scope":"openid profile email offline_access","userSessionStartedAt":"1745164849","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"WWR0NWVCcy1GUy1CUklUTEZGbUIzZElyaWwzU1djM1hTdVpfT0dKQkVNdjFl","code_challenge":"gqzPb592NOGaA7mQFJOq8efKJwCs95xXk38Mo1eJjf0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('f168c0b7-7f6a-47b3-9de7-9d4a15a10323', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1743996931, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1743996931","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"YjFJakVUbks5MWhpQVc2dWwzeUNvM2VoUjR-ZDVSZ3UxYnlYamF6ckpTVH5w","scope":"openid profile email offline_access","userSessionStartedAt":"1743996931","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"YjFJakVUbks5MWhpQVc2dWwzeUNvM2VoUjR-ZDVSZ3UxYnlYamF6ckpTVH5w","code_challenge":"8ctP5TU8MC7UDHDt6g-93zFqhaE6nG0vQ_dpa8Q_hzA"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('ae32d3b3-a8d4-41f1-936e-d292decc97d2', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744004285, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744004285","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Z2xXX0NudXZpT2ZxdFRXZlNtSFM1WmtZaC1STXNFZEtlS01sSnRyWnN3MU5L","scope":"openid profile email offline_access","userSessionStartedAt":"1744004285","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"Z2xXX0NudXZpT2ZxdFRXZlNtSFM1WmtZaC1STXNFZEtlS01sSnRyWnN3MU5L","code_challenge":"UIESTcpXru2qDUoiM_mV9QPsL-mZs9lmGwYseueEqeY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('ae32d3b3-a8d4-41f1-936e-d292decc97d2', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1744004673, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1744004285","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744004673","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3d82aec7-05cc-4de5-9318-1e5422a02d52', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744004773, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744004772","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NDI3c1F2UnVHTkNRYS4ufkd2WlBDbndqWlVvdmVLWmFkdGJ5Yk16ZklrT0pQ","scope":"openid profile email offline_access","userSessionStartedAt":"1744004772","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"NDI3c1F2UnVHTkNRYS4ufkd2WlBDbndqWlVvdmVLWmFkdGJ5Yk16ZklrT0pQ","code_challenge":"aMkJPo_ZryoivA7bhWu2dybuWAnjFkkCSu_0kF2R0dM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('58b80a02-d823-46e0-a37f-bf01bb9c8ba7', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744562907, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744562906","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UjJ5MEVwdzI5ZjdQQTRRYXI2N3hOb0l1UXBFX3JkV2doTWd6ZlN0YUQ4RlBa","scope":"openid profile email offline_access","userSessionStartedAt":"1744562906","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"UjJ5MEVwdzI5ZjdQQTRRYXI2N3hOb0l1UXBFX3JkV2doTWd6ZlN0YUQ4RlBa","code_challenge":"pkh9w5FHI67g0eyoUmxQDmfyOMXlVGFQyKm6Q6_fvKw"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('58b80a02-d823-46e0-a37f-bf01bb9c8ba7', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1744563194, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1744562907","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744563194","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('64e01247-0a5a-49cd-ad06-c1fa9ed3a6df', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744564281, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744564281","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"blJfY2ppd2Qwc0ptRzNXeEtTUFR3N1dyT0x2Zno1OE9Pejd2cXp1dFhtS20z","scope":"openid profile email offline_access","userSessionStartedAt":"1744564281","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"blJfY2ppd2Qwc0ptRzNXeEtTUFR3N1dyT0x2Zno1OE9Pejd2cXp1dFhtS20z","code_challenge":"xO6xPjz2AuZn97-LmpXDOqU3P_8QBVh9ZPvTZ3GS8M0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('cf381f54-b0b5-4220-9c92-9608994dac6d', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745198417, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745198417","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"eVlFMGJad2U4VkJMMkVRWE5YalhxX3BCanJLdHNILTFBbHcyWlRQa29lRkgw","scope":"openid profile email offline_access","userSessionStartedAt":"1745198417","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"eVlFMGJad2U4VkJMMkVRWE5YalhxX3BCanJLdHNILTFBbHcyWlRQa29lRkgw","code_challenge":"5bYU3EXO0pqjUXn5fmvHVSf1_6I4gcTttHJSqau3ncQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('60b48e20-e74a-4f4d-9e15-df7a439a2937', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744024335, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744024333","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RWxydzV0Y2FTRWVERWx-NFBCamllQWZnNWkybUU3S3BrS3d3clFfOFFZSkJC","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1744024333","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"RWxydzV0Y2FTRWVERWx-NFBCamllQWZnNWkybUU3S3BrS3d3clFfOFFZSkJC","code_challenge":"sN4QXCW05wEJKNAUjHiAE8pXPr3CbK4mDMr22dtMfXc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('16c2ae86-2f8d-462e-9d7f-3455bf08ad16', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745202081, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745202081","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"VVVvN1Y3dFpFX042RHhPUXZIODBYdk40c2Z6azBZcDlnbExKN1lkb3k0Sld1","scope":"openid profile email offline_access","userSessionStartedAt":"1745202081","redirect_uri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","state":"VVVvN1Y3dFpFX042RHhPUXZIODBYdk40c2Z6azBZcDlnbExKN1lkb3k0Sld1","code_challenge":"91adaeOizfVawwDCo2AiPdpBah3XD1kH3B3JZzA_rWU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('4e027fc4-74e9-465c-885a-2e8c4bc61cc0', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745202715, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745202715","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"aURRcDhsQ3l0Y3RDOUhVSlU1WXRYUTBmUi5zQ2w4UGg0N28tU015aHNOX35a","scope":"openid profile email offline_access","userSessionStartedAt":"1745202715","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"aURRcDhsQ3l0Y3RDOUhVSlU1WXRYUTBmUi5zQ2w4UGg0N28tU015aHNOX35a","code_challenge":"tnx3W95Ck4fb3zkJQDoczBkwIH1XFZWFjGh9aOhB_eI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('318c4dfe-cb19-4b15-815c-b889fee3f66d', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744636556, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744636555","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SWI0RmxEbGZTNmxpbDN0ZTliSkN2Y25qcy5SOUlTZ0lIV3Bsdm45WkNISUV2","scope":"openid profile email offline_access","userSessionStartedAt":"1744636555","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"SWI0RmxEbGZTNmxpbDN0ZTliSkN2Y25qcy5SOUlTZ0lIV3Bsdm45WkNISUV2","code_challenge":"XKBbwsHZSdc3O59d7bgkA2J6n0K_1BWz6SN3KUC5L98"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7e440095-9d6d-43e7-b2db-a56c88e08798', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1744014295, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744014295","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZWpFVFdaTkJuSS5SdWI1X2Y3RGRKSXFMaHBuRmlZZHNmZmF1UnNyNWUuYU83","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1744005146","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"ZWpFVFdaTkJuSS5SdWI1X2Y3RGRKSXFMaHBuRmlZZHNmZmF1UnNyNWUuYU83","code_challenge":"MTZ-VkAubL5nodKsuKNQdCKnbCP6IG2VjU-a7gLraqc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('2c0292ba-539b-4fd6-8ec1-699af13b760f', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744182951, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/vi/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744182950","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cEktbWw3VnpqbjdGSFZNSk11bzNVcENCWUVHYkgyNzQ4d2xRelRtY25LWVEw","scope":"openid profile email offline_access","userSessionStartedAt":"1744182950","redirect_uri":"http://localhost:4200/vi/auth/oidc/callback","state":"cEktbWw3VnpqbjdGSFZNSk11bzNVcENCWUVHYkgyNzQ4d2xRelRtY25LWVEw","code_challenge":"gwXdx62kLCXCIPX0kucFAXBafeKyab_Xz7npbC0WfRY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('21ba6b4d-00d5-4d69-8858-b9b4bae26ed1', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744183267, '{"authMethod":"openid-connect","redirectUri":"http://localhost/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744183266","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NXB2eEhSNjFyY28zVG5hV2JEQWhvekxKVn4xUnV0Z3BNMi5HQXprfllrb1hi","scope":"openid profile email offline_access","userSessionStartedAt":"1744183266","redirect_uri":"http://localhost/en/auth/oidc/callback","state":"NXB2eEhSNjFyY28zVG5hV2JEQWhvekxKVn4xUnV0Z3BNMi5HQXprfllrb1hi","code_challenge":"gTxZlWqWj2CPpeTxs2oIEyeVR4SNjbwpYUsnX-_2Cgc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('21ba6b4d-00d5-4d69-8858-b9b4bae26ed1', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1744183334, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1744183267","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744183334","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('bc58a219-b939-4f6f-ba1c-08b9c866a0fc', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745208229, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745208228","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TVVJN2JHRjg5djNDYkJ3dkhmNmZvSEROUVpHTmxaQ0x2azMyeG05dDZSTzY2","scope":"openid profile email offline_access","userSessionStartedAt":"1745208228","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"TVVJN2JHRjg5djNDYkJ3dkhmNmZvSEROUVpHTmxaQ0x2azMyeG05dDZSTzY2","code_challenge":"7sNdO5qqqBK5Ws5YU7RpEpinL9wxoUTv6s5HPfsisUU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('01f44d61-03a6-409b-a9a4-37cfbb02396c', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744189742, '{"authMethod":"openid-connect","redirectUri":"http://localhost/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744189742","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"V0ZTeUlKOTkwXzI2QTRuZHdiT3hEZTB5aWtKaS1VaHkyMGhPY0duQk1HQ2oy","scope":"openid profile email offline_access","userSessionStartedAt":"1744189742","redirect_uri":"http://localhost/en/auth/oidc/callback","state":"V0ZTeUlKOTkwXzI2QTRuZHdiT3hEZTB5aWtKaS1VaHkyMGhPY0duQk1HQ2oy","code_challenge":"5Ya0Rmv8zxh88OWW6DjoLxqV94J5Q2W3OPQSEuFCnKM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7824f9ae-0c1c-4a78-afee-b0f41f6ec132', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744190865, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744190865","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bW93cFp0a2Rkb1RCNnhBQmJrZWhBb3FlRTJCdnRtMkNadEdmVkhkNmhfNVUu","scope":"openid profile email offline_access","userSessionStartedAt":"1744190865","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"bW93cFp0a2Rkb1RCNnhBQmJrZWhBb3FlRTJCdnRtMkNadEdmVkhkNmhfNVUu","code_challenge":"ZxkXC8wf-fmCogtZtmiW4ik8oR8GPcRRRfuUXuBsL-E"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('93ddbade-c6be-429b-b158-9a3408307035', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745395448, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745395448","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"R0Y0YnFYYXhsX08xWDNqOXlwaldNeUk1Q1J2ZjFsZ1FtdUV6VzNoazczby1L","scope":"openid profile email offline_access","userSessionStartedAt":"1745395448","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"R0Y0YnFYYXhsX08xWDNqOXlwaldNeUk1Q1J2ZjFsZ1FtdUV6VzNoazczby1L","code_challenge":"yiyTOMFr9YkwkJfLk0xppSbAc36aJpQfMbpfBnfzEfc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5249a455-081c-4417-89ee-9b09f46292be', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744190986, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744190986","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RVlUdkdSOUZFYjNZQ0F4ZXR1aE8xSGhGei1ZSzRJd0paT05iWmNQTGxuM3I2","scope":"openid profile email offline_access","userSessionStartedAt":"1744190986","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"RVlUdkdSOUZFYjNZQ0F4ZXR1aE8xSGhGei1ZSzRJd0paT05iWmNQTGxuM3I2","code_challenge":"Y7AlG526cPkRNiLtX3fNeY0KSKMnynzHiY3Ws1Cq_lw"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('929c6c03-7fc2-436c-ad20-44ddd6378dee', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745208941, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745208941","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"M2RPX1BaTERUN3BFQ0NMNnhFZ25iTGVEeE5BZTJkY1hobXZtN1pXNFhEWFJl","scope":"openid profile email offline_access","userSessionStartedAt":"1745208941","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"M2RPX1BaTERUN3BFQ0NMNnhFZ25iTGVEeE5BZTJkY1hobXZtN1pXNFhEWFJl","code_challenge":"LdGQTFuzW-kM5z5dsgr2P5KkBd1pqwDrwSiOJ7DzNTg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3afb8f04-929e-4e48-974c-24bfdf7e54c0', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745395547, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745395547","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WHJJeU9YSndFV3dhM2wzY0NJa2lTN3ZpUkk4UC1tSTFHeE5LMEZWekZpajFI","scope":"openid profile email offline_access","userSessionStartedAt":"1745395547","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"WHJJeU9YSndFV3dhM2wzY0NJa2lTN3ZpUkk4UC1tSTFHeE5LMEZWekZpajFI","code_challenge":"x5XO0DQe2nrONRSae9gi1ot1ZUwru2FX_efeMjGnSrk"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3afb8f04-929e-4e48-974c-24bfdf7e54c0', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745395621, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745395547","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745395621","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('72406faa-9554-4551-9d5d-89d33e5a3d8a', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745398790, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745398790","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"VERiSk5EVW5ELlhobEd0QkdFaHBiVUZTYW5kZFlIVU9tREVhd2JiNGRyTkpJ","scope":"openid profile email offline_access","userSessionStartedAt":"1745398790","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"VERiSk5EVW5ELlhobEd0QkdFaHBiVUZTYW5kZFlIVU9tREVhd2JiNGRyTkpJ","code_challenge":"kat_Xj6awQ_yvtlzwNmjavCcKgzdhQmL8ZEfH72EC3I"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c0718cd8-e8b5-4b35-918f-77a84e04839b', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744191096, '{"authMethod":"openid-connect","redirectUri":"http://localhost/vi/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744191095","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cWtuZk4zZkNMaXhkZ2R4SmZmS25NRE5uNDl6bFpYMzAwWXItVnlsV2Z-Qi5M","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1744191011","redirect_uri":"http://localhost/vi/auth/oidc/callback","state":"cWtuZk4zZkNMaXhkZ2R4SmZmS25NRE5uNDl6bFpYMzAwWXItVnlsV2Z-Qi5M","prompt":"none","code_challenge":"fi-cdLb9n6CiwKz8sadx5BgDLwNPv4AyXVS-Wj8vIn0"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('72406faa-9554-4551-9d5d-89d33e5a3d8a', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745398842, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745398790","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745398842","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('d9f0e246-50ce-40c5-824c-ceda7c142b01', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744378257, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744378256","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MXhXZ1FSeUF4SUx5NENvSzF4Rmp0d3RZaWZROUJzSy1aYmtyRC1Eb2NrQy5k","scope":"openid profile email offline_access","userSessionStartedAt":"1744378256","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"MXhXZ1FSeUF4SUx5NENvSzF4Rmp0d3RZaWZROUJzSy1aYmtyRC1Eb2NrQy5k","code_challenge":"imLCVnnwGbTKI0HDfYDhLZRi0bFcNj02Ev3e6dnqfdA"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c0718cd8-e8b5-4b35-918f-77a84e04839b', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1744192965, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744192965","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"d2gyajdab3NxVlpjcFBnQmdvflh4VkNTR2o1VFM2cE51N3VkZWZDaF9mekNh","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1744191011","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"d2gyajdab3NxVlpjcFBnQmdvflh4VkNTR2o1VFM2cE51N3VkZWZDaF9mekNh","code_challenge":"pX2hBmejOqfJD6BPrZ8jxY16v6PMmTjNNSp7IwhTX7A"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('51719ad0-649a-42a4-b9d0-5a0d9b83cd86', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744637157, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744637157","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cnpBRENSZ2VpTUt2UjhTYkMzck5CeFF3cFozTmJkNVJJMFhzWVdjUUNTSFVU","scope":"openid profile email offline_access","userSessionStartedAt":"1744637157","redirect_uri":"https://admin.echovibe.io.vn/vi/auth/oidc/callback","state":"cnpBRENSZ2VpTUt2UjhTYkMzck5CeFF3cFozTmJkNVJJMFhzWVdjUUNTSFVU","code_challenge":"id68Isf__lXbZkm_7z1GSC9mu2DFHAtB9r2aW3AfpTc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('f21dfa62-b9de-43dd-b13b-01ccba2dccbc', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745400737, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745400737","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Y250aEF4blJXfks4TFRCRHdkVDguZGo1bEpmX2dnMnJld2R0bENHQzl2bE13","scope":"openid profile email offline_access","userSessionStartedAt":"1745400736","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"Y250aEF4blJXfks4TFRCRHdkVDguZGo1bEpmX2dnMnJld2R0bENHQzl2bE13","code_challenge":"A8bZSxoGqlvR3x4ZkgkhVJa75YS9XnOf2x-RKDuguYU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('0d171d34-edca-485f-839b-08e0471242f8', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744431297, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744431297","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"dzRkNldBU35BODA2YV83NENGaWpPSUJzfllCWU9IbTJ0YzJReUl0Rm5hQ3ly","scope":"openid profile email offline_access","userSessionStartedAt":"1744431297","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"dzRkNldBU35BODA2YV83NENGaWpPSUJzfllCWU9IbTJ0YzJReUl0Rm5hQ3ly","code_challenge":"byt43GIofrqqXjX_Eq1QtfwqxjpwifLfcQt2_ovepQo"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7040ab5a-e8bf-477a-a959-4ec6b0db5605', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1744637173, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744637173","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"dE91bzZMOV9oMEthdU1xc1lUUnJacUF1ek5OLlUzUFNxVmppbnFiSlBkNDJZ","scope":"openid profile email offline_access","userSessionStartedAt":"1744637173","redirect_uri":"https://echovibe.io.vn/vi/auth/oidc/callback","state":"dE91bzZMOV9oMEthdU1xc1lUUnJacUF1ek5OLlUzUFNxVmppbnFiSlBkNDJZ","code_challenge":"ETEwg1XmxOygc9tb-wuz58DNS8GwiULilnW9LKnXV08"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('267fc1da-54da-4647-a0f2-8f756afc8f98', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745400741, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745400741","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RlgxOUpxeUdGckZrNHNoVVdHOWd2aFI2NzVrNHV6VEVZSm5iMmZsdmNSSFdB","scope":"openid profile email offline_access","userSessionStartedAt":"1745400741","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"RlgxOUpxeUdGckZrNHNoVVdHOWd2aFI2NzVrNHV6VEVZSm5iMmZsdmNSSFdB","code_challenge":"CneeKRqVNN8did9ajExNADyGk4zH2YgwWKifBgK57Yo"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3df45e6f-2f1b-4ab7-8832-8c6689f3cee8', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1744637638, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744637638","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MWd2U196SkZ6V2ZySTU1cG9xSk92flZfeGlPalBKZF9BNWxBN2pvcXEyfjNB","scope":"openid profile email offline_access","userSessionStartedAt":"1744637638","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"MWd2U196SkZ6V2ZySTU1cG9xSk92flZfeGlPalBKZF9BNWxBN2pvcXEyfjNB","code_challenge":"vGQIn-R2D3gqrpDZ5snLrcT-1uxSOn9444GGrpM5I9I"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3df45e6f-2f1b-4ab7-8832-8c6689f3cee8', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744637642, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744637642","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"R3QxRFBzYWdyRGNRbk02RFljQmNtMXdGM2VoR3pOYTAwZmotZGRIeFZXQTk4","scope":"openid profile email offline_access","userSessionStartedAt":"1744637642","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"R3QxRFBzYWdyRGNRbk02RFljQmNtMXdGM2VoR3pOYTAwZmotZGRIeFZXQTk4","code_challenge":"Z_yaVP4uo8t4-v8cCHvGLCVjoJUnnw2-wQKlRBYif08"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('cd2f9849-2aab-4009-83fc-b6df9171cb87', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745402385, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745402384","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"d2RTV3BWNV9ZWE5sLlZaZG5zREF1YWJzd1NCbXRiXzRMR1lZSnc1RHNRTkNJ","scope":"openid profile email offline_access","userSessionStartedAt":"1745402384","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"d2RTV3BWNV9ZWE5sLlZaZG5zREF1YWJzd1NCbXRiXzRMR1lZSnc1RHNRTkNJ","code_challenge":"YeoI2EMTtDj96Hdmcp4wVUS61p7mte7TjCY0ltBijuM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('0f119839-cc84-44db-8a15-bb4d2dc5faf8', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744874775, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744874775","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"eUFzQWd0b284OExqbDFtalZiUUxVU1RERkJtLTJ1Y3Y0OFJhaG13bmxKYkZM","scope":"openid profile email offline_access","userSessionStartedAt":"1744874775","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"eUFzQWd0b284OExqbDFtalZiUUxVU1RERkJtLTJ1Y3Y0OFJhaG13bmxKYkZM","code_challenge":"o_69CSd8mdtfuExr0E3Pe0g1NBgWigMIsFCt0hE2J3g"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('0f119839-cc84-44db-8a15-bb4d2dc5faf8', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1744875665, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1744874775","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744875665","level-of-authentication":"-1"}}', 'local', 'local', 1);
INSERT INTO public.offline_client_session VALUES ('4dc96619-b743-4cef-a75f-f802b8459408', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745140744, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745140743","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bW1XQmRJbzg0N2QxTG5LS1c1ZE1pYWNoVWxUUmdFUWRrUGNDM2VFdDFBQ0hZ","scope":"openid profile email offline_access","userSessionStartedAt":"1745140743","redirect_uri":"https://echovibe.io.vn/en/auth/oidc/callback","state":"bW1XQmRJbzg0N2QxTG5LS1c1ZE1pYWNoVWxUUmdFUWRrUGNDM2VFdDFBQ0hZ","code_challenge":"EmjQzA37aKyj25mXPN8YhD-VW4769yaMfCVuZGoZfro"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('dabb92b8-b9ca-4877-a6d6-6edd35c97e5f', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745141134, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745140615","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745141134","level-of-authentication":"-1"}}', 'local', 'local', 6);
INSERT INTO public.offline_client_session VALUES ('de511fb4-1108-4cf3-bbd4-7dbc13251800', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744876695, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744876694","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UnFxaWRxNjA5VW80RkRiVi1oeVNIWHlIc0Z0dS1haDlvU3ZvX2t0azVRUFhD","scope":"openid profile email offline_access","userSessionStartedAt":"1744876694","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"UnFxaWRxNjA5VW80RkRiVi1oeVNIWHlIc0Z0dS1haDlvU3ZvX2t0azVRUFhD","code_challenge":"NDtalYsTwt3CFUGD39cu0Zq6SUjaHx4MIcCiYf_Ndhk"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3620226a-516d-45ee-9e56-11dfa1fd9945', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745402389, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745402389","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"SzlTVHFEMk5TQXQzTjZmSWZpS3M0dmZCMHZHZXlUWVZsbGI0ckN4eVV4dl94","scope":"openid profile email offline_access","userSessionStartedAt":"1745402389","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"SzlTVHFEMk5TQXQzTjZmSWZpS3M0dmZCMHZHZXlUWVZsbGI0ckN4eVV4dl94","code_challenge":"rZpFWHwl7IeVl2WSrIdEN2Wv2BDyGa6EH3-fvrfcvU4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('66001e13-2756-44e6-befa-1a615ac676ae', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744876805, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744876805","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"LWhwaHJkck1ZfnpFYkhqLWZ4Ykwwdi1vX2VLc1RPY2F0YnR2eDg4Ukc0Qy1Z","scope":"openid profile email offline_access","userSessionStartedAt":"1744876805","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"LWhwaHJkck1ZfnpFYkhqLWZ4Ykwwdi1vX2VLc1RPY2F0YnR2eDg4Ukc0Qy1Z","code_challenge":"tHrd-2TS81IfZSCgPgLC4f8gpsgpl4nPDWh1zvMJOAY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('00d12999-52ea-4269-b0c9-a3ff37afb596', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744878784, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744878784","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bW16WlItNFg0UmN5MThGeXZ1VTE1MTV5WGZMLWsyakZSaEp2WlIzfnBGMmY0","scope":"openid profile email offline_access","userSessionStartedAt":"1744878784","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"bW16WlItNFg0UmN5MThGeXZ1VTE1MTV5WGZMLWsyakZSaEp2WlIzfnBGMmY0","code_challenge":"BglHiaWuOjMiWjukwvq4uWra7cwPYB-qGBfBedE0skE"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('4a6bf8d7-b50a-4490-a9ab-b741365e1fe7', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745405013, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745405013","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ZUJVWW9jXzQwejNZeDQtWHJjNkpJZmgzeVlIc21FV2lKcUtxfng1cWRndk1X","scope":"openid profile email offline_access","userSessionStartedAt":"1745405013","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"ZUJVWW9jXzQwejNZeDQtWHJjNkpJZmgzeVlIc21FV2lKcUtxfng1cWRndk1X","code_challenge":"84dMr6r25zHL9weA7f-yxXAsrXsSu2zNNjPUsmobGOA"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('00b25585-75a4-4168-957e-88c49995d755', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744878791, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744878791","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"N29OektNVkwyRzFsUkNyc2N-N3J4U2FNRFZvdkRTeWMtMDMtYUxnbHFrRVdV","scope":"openid profile email offline_access","userSessionStartedAt":"1744878791","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"N29OektNVkwyRzFsUkNyc2N-N3J4U2FNRFZvdkRTeWMtMDMtYUxnbHFrRVdV","code_challenge":"Z7QQsZQ6S4vBaOfVKeXOSOMjtZfF6jooe6DQgDcxbwU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('4a6bf8d7-b50a-4490-a9ab-b741365e1fe7', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745405560, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745405013","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745405560","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('6c7eac9e-283e-4650-883a-5729ca60cdd3', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744881668, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744881668","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"R1BtdTM3Z1BVeERmXzNVWWZGaWZyZXlSSGZaYVhJcjgtbFF2NTlEemp-aldq","scope":"openid profile email offline_access","userSessionStartedAt":"1744881668","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"R1BtdTM3Z1BVeERmXzNVWWZGaWZyZXlSSGZaYVhJcjgtbFF2NTlEemp-aldq","code_challenge":"dZjGJM3ECVfyjSyNKWyoMYx5VBpxA0vedtgJVQjpXjg"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('2c5456ae-80a1-4bf2-845c-bcce389dd14a', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745419102, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745419102","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TkpzV0I4Q015aWNKOUpWRk1XekM5NH4wR1NnbmpDTC1aaUdaLkFFX0NfcWd0","scope":"openid profile email offline_access","userSessionStartedAt":"1745419102","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"TkpzV0I4Q015aWNKOUpWRk1XekM5NH4wR1NnbmpDTC1aaUdaLkFFX0NfcWd0","code_challenge":"jmDctntxq9NwYp4KsJTUdHbx6zthlE5x1E_7qi4DOjw"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('f1c3a42a-cd88-4ffc-b1e1-f4eab5893f28', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745420952, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"64zQI-5EA43P3Z-aYJ9bTA","startedAt":"1745420950","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MDZzb05yNGNuVFhPYS5aan5sNF9Mdn5XSkxLb094ZXNVby5SNERwWTl3bEFk","scope":"openid profile email offline_access","userSessionStartedAt":"1745420950","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"MDZzb05yNGNuVFhPYS5aan5sNF9Mdn5XSkxLb094ZXNVby5SNERwWTl3bEFk","code_challenge":"bg_6TUvH1uezhKYpzCcsjZFc7UI08ntYugvSFIdskH8"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('933839b8-afe7-44ac-b1f0-b3347b57c910', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1744901207, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744901079","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bTE0flR6aWtWRmV-OElxam9PS2E4T2ozWlQ2SXNLSXg1OWVYRHkwVWwyQ3ou","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1744901079","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"bTE0flR6aWtWRmV-OElxam9PS2E4T2ozWlQ2SXNLSXg1OWVYRHkwVWwyQ3ou","code_challenge":"ckYjb582f-r52MbBjAtMaYGsatrIcU3CsWvJNWo-sOE"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('d7d22990-d62e-4bd7-82f7-6777880f06db', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745423073, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"Wxo6ndPAm3efmvvbH9edxw","startedAt":"1745423066","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NHEtcy5IVFNJaHlxMVY4RkJ6azR-a0JwUVFZQUd5blpwMENDY0ZRTEpBMllJ","scope":"openid profile email offline_access","userSessionStartedAt":"1745423066","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"NHEtcy5IVFNJaHlxMVY4RkJ6azR-a0JwUVFZQUd5blpwMENDY0ZRTEpBMllJ","code_challenge":"AI45o6bmpBs6udqOrUYGiFol9uW4ffOfxZ5pGQV5I_w"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c6e2045d-dcfe-46d2-a312-2295aca54a2b', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1744901261, '{"authMethod":"openid-connect","redirectUri":"https://echovibe.io.vn/vi/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744901260","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bHZ6WHJTU0FPS3IyT3FXdDFCa0hFandibU01WS5QMUhuQXRPSTk1ZlB-VVdj","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1744901238","redirect_uri":"https://echovibe.io.vn/vi/auth/oidc/callback","state":"bHZ6WHJTU0FPS3IyT3FXdDFCa0hFandibU01WS5QMUhuQXRPSTk1ZlB-VVdj","code_challenge":"L2SZO3lzSCQUWEe5Da1gSmUd93D_lIiYLKR7g2DzezE"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e96ae282-fb3d-48c4-9d15-798e2e8cf887', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745423087, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"Kc3_WGnUcr8-JLsQ3vHhMA","startedAt":"1745423084","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cFVzc0daeGR4WnJWV2NDLklRUmNWMWVLQXNlRm5CbS1wdVctOGdUMUFiXzlO","scope":"openid profile email offline_access","userSessionStartedAt":"1745423084","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"cFVzc0daeGR4WnJWV2NDLklRUmNWMWVLQXNlRm5CbS1wdVctOGdUMUFiXzlO","code_challenge":"Veg5MVx4Ui5nXur9V8-Y48WfPpHxfLWkijEE-itMs2c"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('dfd96ab6-dd39-46b1-b30b-0ed1cc815f05', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1744901399, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"EclNQCbo4CtYpnJa5bG48Q","startedAt":"1744899664","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TGJZbGZqSGFyeHRVYXBaVlN-Y0tZQnhLaWJycXNTUFB0U3ZtWlNPSWRUNGZT","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1744899664","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"TGJZbGZqSGFyeHRVYXBaVlN-Y0tZQnhLaWJycXNTUFB0U3ZtWlNPSWRUNGZT","code_challenge":"tKQfGbydBsXEP-IqTnJ-MN34J8ZcQ_7qeum0XagwcXM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('933839b8-afe7-44ac-b1f0-b3347b57c910', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744902260, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744902260","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cXZ6MlBiTXNDa2tDcElLRHhPM3hSRlQ2SG5zMVI0Z2Z3ejEwWnllTjVpMjJv","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1744901079","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"cXZ6MlBiTXNDa2tDcElLRHhPM3hSRlQ2SG5zMVI0Z2Z3ejEwWnllTjVpMjJv","code_challenge":"ZPSFz7Jdmv3fBnrTNGEJwCtVWqmwbm3IMGGLGh0Qv68"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('dd9ccd28-9792-4a82-84e5-c40f85ea2637', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745424462, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"uG1iAQ_RqchU8QVe-ejzxQ","startedAt":"1745424460","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bX5zdUdmOH40dGVScDNGUzdfcFNnVDl3Vnhsb0x0LlZxaFJRaEJnMk0yeXZw","scope":"openid profile email offline_access","userSessionStartedAt":"1745424460","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"bX5zdUdmOH40dGVScDNGUzdfcFNnVDl3Vnhsb0x0LlZxaFJRaEJnMk0yeXZw","code_challenge":"8s7-sL_zn8MhlHcO-41dokjCkdSUwFABIRT0zkDWkoY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('82cecea6-8f5d-4a76-b6ff-e1c432e09279', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745429373, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745429373","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WlBBay1xdm1uSkQxcVVFOFVDYmJ1RDhIb2VTb24zR3J6MFBFZ0V5M243aXdP","scope":"openid profile email offline_access","userSessionStartedAt":"1745429373","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"WlBBay1xdm1uSkQxcVVFOFVDYmJ1RDhIb2VTb24zR3J6MFBFZ0V5M243aXdP","code_challenge":"1-3zztwsTGmCD4W38tb2nkaJ7uKxxcbmZnAva3aKgao"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('9a5da714-5d92-4487-bf6d-7f382a72b407', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744902472, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"SCuMzFfkPuAOXlEir53RLg","startedAt":"1744902449","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"Qn5RYUs0NlpwNEZDYml2dWxkYS1TQ1NWblZUcmh2bVRPVlFlNU40Q3Mzbk1m","scope":"openid profile email offline_access","userSessionStartedAt":"1744902449","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"Qn5RYUs0NlpwNEZDYml2dWxkYS1TQ1NWblZUcmh2bVRPVlFlNU40Q3Mzbk1m","code_challenge":"ZMgenRRQL9btQkmwCpybPIfQnAZ3TSD6cUeyYqSRWOM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b897c60f-458d-496d-a16e-8b7c321dd6a0', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744904235, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"43Qu8zyZ8LZclT92_yJ88w","startedAt":"1744904234","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WnVPcm52NmRMRVMwNURwSE5jSVZtZGlUQ1EuanEuVE1FakFLNU1SdllYempk","scope":"openid profile email offline_access","userSessionStartedAt":"1744904234","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"WnVPcm52NmRMRVMwNURwSE5jSVZtZGlUQ1EuanEuVE1FakFLNU1SdllYempk","code_challenge":"q3emDg5h-l1fM3UDG7yl3lBriq-IUATdwl5NAQjPjbU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('c3ae712a-3438-4c2a-9163-b48ae398a255', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1744904244, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"mC981lh-TPX3wNawgXLfag","startedAt":"1744904243","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WHBMQ29kSzFIUjVFWXR1OUdpclB3TGtKMjROQlZJMGVlY3cyWWdoRFRocGhB","scope":"openid profile email offline_access","userSessionStartedAt":"1744904243","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"WHBMQ29kSzFIUjVFWXR1OUdpclB3TGtKMjROQlZJMGVlY3cyWWdoRFRocGhB","code_challenge":"I8BHFa9lNeywtdCes3QT2s7e69fTwq4Qhta_4ydWexY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b11c4d1e-d72c-4413-9ddb-90df2f438647', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1744951634, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1744951634","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"LTkzc0lnU3RRMVVCSlpJeDJocTRUNFp3ZkVhZ1FTNlZ0QUNhbG44bmEtdm5m","scope":"openid profile email offline_access","userSessionStartedAt":"1744951634","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"LTkzc0lnU3RRMVVCSlpJeDJocTRUNFp3ZkVhZ1FTNlZ0QUNhbG44bmEtdm5m","code_challenge":"9wM6VZEidO9pTnv4giTwvaznIJe8m8omkmiBjLBYgl4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('75de428a-2257-4f8b-a412-c28d8515eca2', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745032641, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745032641","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WGFNemNmTjR6M1Rlb08tLThYa1laNkNDLlUxZWx2anQ0UlN-UHFDNUltTksy","scope":"openid profile email offline_access","userSessionStartedAt":"1745032641","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"WGFNemNmTjR6M1Rlb08tLThYa1laNkNDLlUxZWx2anQ0UlN-UHFDNUltTksy","code_challenge":"tM3LlWjcMvC0E4Rph3fMQWRRkeDd8SFJJRKyTR5KZL4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('75de428a-2257-4f8b-a412-c28d8515eca2', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745032809, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745032641","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745032809","level-of-authentication":"-1"}}', 'local', 'local', 2);
INSERT INTO public.offline_client_session VALUES ('42cce9a2-513f-4f75-9d27-cb6ee9beeb06', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745034399, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745034399","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UlNabHlraWJjY3ExenNpSmRfYWlOUTVWSXo3NDNaVnV3QUZ2cVB2LXh1MHJX","scope":"openid profile email offline_access","userSessionStartedAt":"1745034399","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"UlNabHlraWJjY3ExenNpSmRfYWlOUTVWSXo3NDNaVnV3QUZ2cVB2LXh1MHJX","code_challenge":"gozgmBGCaj9XrGkMxgFeqGdVLyTciJmNkO167bNWVoQ"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3b3db657-9f39-43a8-8d1a-5356938ebc1e', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745036462, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"HWRkxZ5MvPnswhsytugUVg","startedAt":"1745036460","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MEtCS01BanhYQWVVR19fSzNhS343WWdDd01zTTVIQk5mSm5kNlVnSEhxTi5o","scope":"openid profile email offline_access","userSessionStartedAt":"1745036460","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"MEtCS01BanhYQWVVR19fSzNhS343WWdDd01zTTVIQk5mSm5kNlVnSEhxTi5o","code_challenge":"_9EBL65pGYbNBMCP9vGvs-oN6Jq55hZkiR0SA1Xg34k"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('77f6125d-780b-4533-b193-931aae10eaec', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745036515, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"NohAD0cAS6xbN2F9bma9kg","startedAt":"1745036514","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TnVoMTlKTFNRRWdSZXRKZm1UazFMN2xVMGxibWJvamV6ZFZCb2ZPeGNsajh5","scope":"openid profile email offline_access","userSessionStartedAt":"1745036514","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"TnVoMTlKTFNRRWdSZXRKZm1UazFMN2xVMGxibWJvamV6ZFZCb2ZPeGNsajh5","code_challenge":"-LCxjEs0uBCE6yxD_yKg4lgUEcSONz_OOIdwzeAjoas"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b14ab8d3-7e2f-45d4-a43e-a35d7e00cbdc', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745036791, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745036791","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ODc3and6LWFpa1R5OFdvS0JUWjhZdWlWemNkT3MxVDR4OTVmUHdoRzh2ZkRW","scope":"openid profile email offline_access","userSessionStartedAt":"1745036791","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"ODc3and6LWFpa1R5OFdvS0JUWjhZdWlWemNkT3MxVDR4OTVmUHdoRzh2ZkRW","code_challenge":"Mq9mMxOKNOfG0ktT8uuH7utv1eE0EQHzlm3dIV6Lktc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('d9a29f4d-b76c-4dcd-8719-ff17d8328648', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745036965, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745036965","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NlVLUDBIdUQyajNsYmlqb1ROTHBZSExhUHVneWQ2S2VfZUllbFZsYmZ5bUx-","scope":"openid profile email offline_access","userSessionStartedAt":"1745036965","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"NlVLUDBIdUQyajNsYmlqb1ROTHBZSExhUHVneWQ2S2VfZUllbFZsYmZ5bUx-","code_challenge":"l_t-Pq7NXIcfsxllE6flN2TE_cMSQlXbtaXazsv0tN8"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('8e9d52af-58ef-4d65-adca-1073c7caf738', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745037981, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"X7wb5Inko0A0lZx0WCkbhA","startedAt":"1745037978","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UnROWmdqc2dJWHpEY3h4WGpPZkliYXJlOUVqRzB5X09SaEJ2cXpKcU00ZEgx","scope":"openid profile email offline_access","userSessionStartedAt":"1745037978","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"UnROWmdqc2dJWHpEY3h4WGpPZkliYXJlOUVqRzB5X09SaEJ2cXpKcU00ZEgx","code_challenge":"bX0-q48NSo43sQL8VN2hemqNCHjrMzfarPiPVdJnQeo"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('41380a6f-1faf-4a99-bd5e-d6a4e6132cf3', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745038002, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"to_tUIz6dGPYP45me9zCWQ","startedAt":"1745038000","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MGd0VVRIaWdyTmppT1o1Y0dIRVMuNnE5RDV-b0p6VGlrb0ZqZjl0Y3VZdnk4","scope":"openid profile email offline_access","userSessionStartedAt":"1745038000","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"MGd0VVRIaWdyTmppT1o1Y0dIRVMuNnE5RDV-b0p6VGlrb0ZqZjl0Y3VZdnk4","code_challenge":"82G0JSkULn1lql32BCWsVGUeiK-PHmyOuVkchCY1RZc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('55f12bbf-06fd-4ba9-8141-712684762ca0', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745038014, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"vpyf77JC1ieO2B-8FsoMOg","startedAt":"1745038012","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WnNfQi1xbUJWUFVvQkNwNG5OTWJ4VmlWVG1NbG56cn44aTlublU1RWR0U3Uw","scope":"openid profile email offline_access","userSessionStartedAt":"1745038012","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"WnNfQi1xbUJWUFVvQkNwNG5OTWJ4VmlWVG1NbG56cn44aTlublU1RWR0U3Uw","code_challenge":"ysBZHorHvRi6dRVcwk59wYawfKA9rX2v6nL95Ss_vDA"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('0e854830-84b0-44c3-a3dd-ea469f32c832', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745038327, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745038326","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"MnVtNkluQ0YzZzE5cFczbmFaZU9wS1VtQVlHaHROSlFoeVRkS2tZYUFTUVRi","scope":"openid profile email offline_access","userSessionStartedAt":"1745038326","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"MnVtNkluQ0YzZzE5cFczbmFaZU9wS1VtQVlHaHROSlFoeVRkS2tZYUFTUVRi","code_challenge":"sOfkh7JALZR_415Rzw5hQTElCGs9zydE_BIiL2m8Bdo"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('ca796091-4610-403c-b68f-56510edeec5a', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745038331, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745038331","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"UzhSRG9Jbno3RW5VN35fdFlNdkdIS3FtX3BEZndlUXJHdWVndHZDa2dEfkJ4","scope":"openid profile email offline_access","userSessionStartedAt":"1745038331","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"UzhSRG9Jbno3RW5VN35fdFlNdkdIS3FtX3BEZndlUXJHdWVndHZDa2dEfkJ4","code_challenge":"18rBKcspZmDbITSQA8Fuea0aABscsUuUb6JKknfVArA"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('fba7fe13-67ff-4a7e-abf2-0a5a54f5274b', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745039709, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"s-HxdUDutHMepYg_0VJKvA","startedAt":"1745039708","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"WTJlclloUjdpWE92UVBHcDZveGVSci5zLnNjLTk3NzB0TGdtR2hDOUd3YkdN","scope":"openid profile email offline_access","userSessionStartedAt":"1745039708","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"WTJlclloUjdpWE92UVBHcDZveGVSci5zLnNjLTk3NzB0TGdtR2hDOUd3YkdN","code_challenge":"45VVatEpattVCVZZo4QiuEVZk3KZFrRYHzVZf3cspvc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('73f3e370-bf38-4441-94df-6e7e811c3b39', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745039947, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745039947","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"YmZhQmIzZ3psZ2RWc2VlbmxaaVNhRzRCd2xBfmpIVn51WG01djVqZXN0SlZi","scope":"openid profile email offline_access","userSessionStartedAt":"1745039947","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"YmZhQmIzZ3psZ2RWc2VlbmxaaVNhRzRCd2xBfmpIVn51WG01djVqZXN0SlZi","code_challenge":"C0eVcA0-LTVIa84KxBgMDOZWA1x0iiG2ZPWWEQQc498"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('7c0e69db-de0a-4d60-8686-0ddacbfb7a92', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745041469, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745041469","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"V1RGYTJrbmFuUUdnUXozSzFHSUF0QlRXTH5RNUJrSW9WaDRvQWhaSnVMUklj","scope":"openid profile email offline_access","userSessionStartedAt":"1745041469","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"V1RGYTJrbmFuUUdnUXozSzFHSUF0QlRXTH5RNUJrSW9WaDRvQWhaSnVMUklj","code_challenge":"FVJFAc6DjZpiqJhPdux4pO7i_HyoIjPUMPMqpk69vNc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5a2a5c64-42f5-47b4-bc50-52225d2879dd', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745041064, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"Pnaafi9SxoZbQw6DiLP3nQ","startedAt":"1745039719","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"a2dneVZERXZiRTFfd0F6cnl3UmJTazRQY2hQSWU2RE1WSE1hSEMwTjAwcDcx","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1745039719","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"a2dneVZERXZiRTFfd0F6cnl3UmJTazRQY2hQSWU2RE1WSE1hSEMwTjAwcDcx","prompt":"none","code_challenge":"fNAV5J5jlAFT-LC0kZlxqLDAHnnCPmec8oGymtwZcHU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('bb75afdd-1e49-450f-a2ce-a40bb8ba552a', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745041473, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745041473","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"QW5SMnVqTVM1OEhJb1kzU0dGRW01Qzd4UzJNX2MxcTZTXy14andhcFFsLWx2","scope":"openid profile email offline_access","userSessionStartedAt":"1745041473","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"QW5SMnVqTVM1OEhJb1kzU0dGRW01Qzd4UzJNX2MxcTZTXy14andhcFFsLWx2","code_challenge":"-ga3tsGV-P5cvEpTa3WBsvlVzgS7jnq077nXMEg5iYM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('efc7dd21-d5d1-4d24-895b-43d40518db65', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745042966, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745042966","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TmhORnpQLlVGeS1NVUR3b2dQOG0uNWZNUFJtTHFhbEJVbHBVaUhXeWw4VjVM","scope":"openid profile email offline_access","userSessionStartedAt":"1745042966","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"TmhORnpQLlVGeS1NVUR3b2dQOG0uNWZNUFJtTHFhbEJVbHBVaUhXeWw4VjVM","code_challenge":"jyxbgzqIKT-n3PM2yen45ZfeZRFrv9_US2u_Q2az9uo"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('efc7dd21-d5d1-4d24-895b-43d40518db65', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745043992, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745042966","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745043992","level-of-authentication":"-1"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5070a082-554c-4db4-ae61-d15f453d3a83', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745044193, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745044193","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"eFp0Vktud21pZWQweG9uNWF6UU1ndHJzWEZLdmdvQzNGc1VjTkNhXzY2X3Bf","scope":"openid profile email offline_access","userSessionStartedAt":"1745044193","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"eFp0Vktud21pZWQweG9uNWF6UU1ndHJzWEZLdmdvQzNGc1VjTkNhXzY2X3Bf","code_challenge":"qVM7sEmvAy1v7mMq_zQxUFOKvGEC8tmfPdlgX054MOs"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('01555d93-df23-471f-aff8-ab283a8793fb', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745044359, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745044359","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"bS1WcHJmV1UxUHo5Y00yNy5Qcll6dFkweDVVcm5kaHJVRXpMUWw1TXFZWUdM","scope":"openid profile email offline_access","userSessionStartedAt":"1745044359","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"bS1WcHJmV1UxUHo5Y00yNy5Qcll6dFkweDVVcm5kaHJVRXpMUWw1TXFZWUdM","code_challenge":"HBRGEZt9EnVPHh41a5ovmnpZKms1QPOnPJzA4lJGjEM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5638a74a-fd0d-4565-860e-a54538e9c034', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745044364, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745044364","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NFhZTjJDdXAudDR2bnVWckhOcXpLbm1zTVljUUJyYm9PRjlwOXNRR2xEcFd4","scope":"openid profile email offline_access","userSessionStartedAt":"1745044364","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"NFhZTjJDdXAudDR2bnVWckhOcXpLbm1zTVljUUJyYm9PRjlwOXNRR2xEcFd4","code_challenge":"kWSsCM8yEmfRPEW3p3v_8fPJf0F3ngJOlO9vLZfu2x8"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('5638a74a-fd0d-4565-860e-a54538e9c034', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745045239, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745044364","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745045239","level-of-authentication":"-1"}}', 'local', 'local', 3);
INSERT INTO public.offline_client_session VALUES ('eafc1299-a750-4913-9825-17053ddb9eee', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745046640, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745046640","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"YmRHcjVRQUFQUk5GS2NKekQ0ekc4c1ctb2hvT1ZxeVlISE84cUo5ajAyLm4w","scope":"openid profile email offline_access","userSessionStartedAt":"1745046640","redirect_uri":"http://localhost:4200/auth/oidc/callback","state":"YmRHcjVRQUFQUk5GS2NKekQ0ekc4c1ctb2hvT1ZxeVlISE84cUo5ajAyLm4w","code_challenge":"yorJ6sxpohE1t1QQpb9GSRVEsz6Gsct8VIJXAZ3pIH4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('3b2844d5-4faa-4546-9907-82690c5887cd', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745053695, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"FXi9b5svMl1oGsIC6qiC0Q","startedAt":"1745053694","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"emltS0hrdEF3UWVabHZKWmhMVEt3RjRZa29vZHlMTlFKVFlyX3lQM3hHU3p5","scope":"openid profile email offline_access","userSessionStartedAt":"1745053694","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"emltS0hrdEF3UWVabHZKWmhMVEt3RjRZa29vZHlMTlFKVFlyX3lQM3hHU3p5","code_challenge":"C4BwdDWOSXjv0aqLtHSTn7G-v6G7Gi4H0-TtSGDPDOU"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('6b169c3e-9dd6-455c-a24a-ccb64de84380', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745117971, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"Kz1EdtpDJHjorZ_NizPIDQ","startedAt":"1745117969","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"QVR1UkYyflZuR0hQNkFDbjVObDhXRFlZT0NadXc5bkNwTDJLRlpySXlzM2Rl","scope":"openid profile email offline_access","userSessionStartedAt":"1745117969","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"QVR1UkYyflZuR0hQNkFDbjVObDhXRFlZT0NadXc5bkNwTDJLRlpySXlzM2Rl","code_challenge":"28_wQlW1Kp5K1nObiirxijFIusvST8teohzNP26lhYY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b8902e79-1224-46e7-b497-79b5ecb1bc84', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745114241, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"a41ncJkl7aPaaulg6CnkKg","startedAt":"1745114240","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"X25GUlpZVXcuTm5ncGh2bkouVktNaDByNXFFNGo2cVVRczdRTm9sWjZSMjlh","scope":"openid profile email offline_access","userSessionStartedAt":"1745114240","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"X25GUlpZVXcuTm5ncGh2bkouVktNaDByNXFFNGo2cVVRczdRTm9sWjZSMjlh","code_challenge":"nCSb6OdGyFsDmEStCfr0KOE6gULTQw1wiwJ5GcbswqI"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('722127e0-d0ce-4987-9d34-a6467d61f66b', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745116221, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"w2fOsKgdV3xZZ1IQdASbXw","startedAt":"1745116220","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TkNHbnJ6RFVycldWN3d6ZF8tRVJ5SUhaWDJZU2xWV2ozaXNpd01NNTk3amd-","scope":"openid profile email offline_access","userSessionStartedAt":"1745116220","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"TkNHbnJ6RFVycldWN3d6ZF8tRVJ5SUhaWDJZU2xWV2ozaXNpd01NNTk3amd-","code_challenge":"ED-wXxQeZgPMuxtlS3eTEmXmpDceW0RG3DeHXD2y_WM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('00348ff6-3136-421d-b55e-8cfdfbda5ccb', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745116231, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"5X96i2llD5qC6DncDiYsAw","startedAt":"1745116229","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"NEEtQVVzeUI3YVZzU3l4dlhIbHMzLm1DU1BVTkYxOS5OUVZDMk8yMnBMYzBj","scope":"openid profile email offline_access","userSessionStartedAt":"1745116229","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"NEEtQVVzeUI3YVZzU3l4dlhIbHMzLm1DU1BVTkYxOS5OUVZDMk8yMnBMYzBj","code_challenge":"6sOWu98JK_Z3N9F3vbliYFgDhd6BnXqWJ0imhhgapN4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('215618be-cd28-4134-9e79-498647e9b825', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745117979, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"dRgJcoVxuomtI5PrDY0l1Q","startedAt":"1745117978","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"TXdEbFMuT34zSXR1aVk0Vjl-aXRudmlJbEozOGFRT3ZxQ3dmQ2FrT0tpbEh3","scope":"openid profile email offline_access","userSessionStartedAt":"1745117978","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"TXdEbFMuT34zSXR1aVk0Vjl-aXRudmlJbEozOGFRT3ZxQ3dmQ2FrT0tpbEh3","code_challenge":"_KBB-h5VPJMbvV6A387_6lbXNtZLHhG2uSpRxpk5Fa4"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('de3778eb-0374-412e-bf8e-b6eff6f20d6a', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745118009, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745118009","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RWk0UE12N0t4cWpZMXU1SElDfn5FYnRaaGtjMjd4V2NFMW5UMU1FM19yUkFC","scope":"openid profile email offline_access","userSessionStartedAt":"1745118009","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"RWk0UE12N0t4cWpZMXU1SElDfn5FYnRaaGtjMjd4V2NFMW5UMU1FM19yUkFC","code_challenge":"CCiRcnKgMBi-nebIAhBbjHrZ4gdGRAgNOkSxh_D0JuY"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('b39665ce-4908-44e2-abf0-91a56f815d64', 'a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '1', 1745119493, '{"authMethod":"openid-connect","redirectUri":"http://localhost:4300/auth/oidc/callback","notes":{"clientId":"a40eb3a2-ac4e-4496-bed0-32414c7c64c0","iss":"https://auth.echovibe.io.vn/realms/echovibe","BROKER_NONCE":"lOfsZan44Upd-p5vB12l5g","startedAt":"1745119377","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"aUZrflZLSFE0cDV2dTBYQXZQWnNQQW5BTGJ1X1plNnk3Rzl3blZwNi1QSDZr","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1745119377","redirect_uri":"http://localhost:4300/auth/oidc/callback","state":"aUZrflZLSFE0cDV2dTBYQXZQWnNQQW5BTGJ1X1plNnk3Rzl3blZwNi1QSDZr","prompt":"none","code_challenge":"Ms1kCP-bLwyEoYNQloNiRBksPtqEmVaZ22tfqI3fshc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('041dea7d-f3d9-4d19-884b-19fdaa442a1e', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745131437, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745131437","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"LV9HWVJkVnlQbzRtR1NNWEZUNERWOWNqcWdTUVdKREprQnVadkY1dUtxMHFH","scope":"openid profile email offline_access","userSessionStartedAt":"1745131437","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"LV9HWVJkVnlQbzRtR1NNWEZUNERWOWNqcWdTUVdKREprQnVadkY1dUtxMHFH","code_challenge":"jiPignfcynxhlXPIw-jik54jdfNhzXGqD6Z1pgHWdwo"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('24a95fd3-84c3-41ee-b2e6-49887ffa660b', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745139128, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745139128","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cXN2LS1PTDJ-SGREcmN5N29DbEc0ZHc2TTU4NllKTmdmQnYzVl8yTS5wYURa","scope":"openid profile email offline_access","userSessionStartedAt":"1745139128","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"cXN2LS1PTDJ-SGREcmN5N29DbEc0ZHc2TTU4NllKTmdmQnYzVl8yTS5wYURa","code_challenge":"tURjno39Ob66pjw3dlKKRmEI_J4_AeL7Y9mX7R4kfdc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('dabb92b8-b9ca-4877-a6d6-6edd35c97e5f', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745140615, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745140615","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"OWFicERsZFNRMWNxb0tEWU92TkdVakJOeGlQMkpodS50MWFMSkdYNHEzVTN6","scope":"openid profile email offline_access","userSessionStartedAt":"1745140615","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"OWFicERsZFNRMWNxb0tEWU92TkdVakJOeGlQMkpodS50MWFMSkdYNHEzVTN6","code_challenge":"qt37CZiUJU02O0ssMbzNNeQTR66ve9pWp2FU9WrROWs"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('24a95fd3-84c3-41ee-b2e6-49887ffa660b', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745140341, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745139128","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745140341","level-of-authentication":"-1"}}', 'local', 'local', 3);
INSERT INTO public.offline_client_session VALUES ('13c3aa2b-b252-4987-a8cd-61aefc6a7557', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745140611, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745140611","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"RHRPWnF-WWk3VVRjQ2tYSHZVVnowbWZmUktKRk0zLmpOeXlKMDhROGhmV21F","scope":"openid profile email offline_access","userSessionStartedAt":"1745140611","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"RHRPWnF-WWk3VVRjQ2tYSHZVVnowbWZmUktKRk0zLmpOeXlKMDhROGhmV21F","code_challenge":"jl3VdL7pE3VEPVVquuXjs9yysFiXCX3QizeVaQI3WoM"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('a4da7828-9c60-4bc8-bafb-b4c0143ce2a6', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745141976, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745141976","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"cHd5LmlYN1RYT1lUZjBVM09WZDdNUDVDcGNQaWFEMDg0Q1pmRjRFU2F2cHl1","scope":"openid profile email offline_access","userSessionStartedAt":"1745141976","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"cHd5LmlYN1RYT1lUZjBVM09WZDdNUDVDcGNQaWFEMDg0Q1pmRjRFU2F2cHl1","code_challenge":"7f7ZAohEWxul75irpZTDGm8yZfRBEqfIE-C31zQGXKc"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e9063e83-ed81-47ce-b86f-e8452e1cc64c', '169fdb62-3bb6-4c8f-a485-014473d18c75', '1', 1745141980, '{"authMethod":"openid-connect","redirectUri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","notes":{"clientId":"169fdb62-3bb6-4c8f-a485-014473d18c75","userSessionRememberMe":"true","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745141979","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"LmMyV2pQdkk2WnFvZUZiU3ltY2E3M0JseVdXZHBzTDhKYngydUV0RHBOb0xS","scope":"openid profile email offline_access","userSessionStartedAt":"1745141979","redirect_uri":"https://admin.echovibe.io.vn/en/auth/oidc/callback","state":"LmMyV2pQdkk2WnFvZUZiU3ltY2E3M0JseVdXZHBzTDhKYngydUV0RHBOb0xS","code_challenge":"ZOUOXzljvrFmsDl6n_1QjB8e921NRVQAnO0bhoomi68"}}', 'local', 'local', 0);
INSERT INTO public.offline_client_session VALUES ('e9063e83-ed81-47ce-b86f-e8452e1cc64c', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '0', 1745143275, '{"authMethod":"openid-connect","notes":{"clientId":"fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944","userSessionRememberMe":"true","userSessionStartedAt":"1745141980","iss":"https://auth.echovibe.io.vn/realms/echovibe","startedAt":"1745143275","level-of-authentication":"-1"}}', 'local', 'local', 6);


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.offline_user_session VALUES ('3b2844d5-4faa-4546-9907-82690c5887cd', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745053695, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745057293","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiWWZtX3J1aEVkUEpNbHZtckRWMnpNZyIsIm5vbmNlIjoiRlhpOWI1c3ZNbDFvR3NJQzZxaUMwUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTA1MzY5MywiZXhwIjoxNzQ1MDU3MjkzfQ.NGWDEY-nfcu3mg7cmUulVR4r1OVFHS9tjRXDplhtbLTr--6oxR9TXnKMTTKzzL8RHIxC-I55O003ZUQH9rVobfQSRhZQz3K6td0DjaQ398NoHlizY9XYXcVVwCvCbcCU4vO17Wyd_8mwkuunXj0kGtpjTUW0T0yzzXSrrjaBbusrgF6jHpAWvdWzqHbxWbiSjM1Eu8ByaKoXAg5ysy1HdIjlt2Id1ryHMbHHPZKtQOgbWEwpWDpHZhF3mza_tIwpyNbPQxfUfxcUORSaypAif4Wv3zf_HK69WR-AFNHDf8f-y2A3wiTOq7n-ErNuW9APxr3GnXIw1MGzRrpXKnJjxg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjwXUFl86lgpIztnmlI6ffDDFgH1JQKNdaJNV2IVkQrFCKhPEH7-ecV1yZ_ZkbIWMbKPnoMgFz3tr5bIOFc6f1hhxOEJ4xeQ31oWy7sYP2qdc1yk6vM-myrUlQjd5o9wLZ5hvkokovqEKfAfT5IJlyQqLSyFEiyArz_8UcaCgYKATsSARQSFQHGX2MirN__fr6ELnXr0wG1_LQKIw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745053694","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745053695, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('93ddbade-c6be-429b-b158-9a3408307035', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745395448, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiQW5kcm9pZCIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZSBNb2JpbGUvMTM1LjAuMCIsImRldmljZSI6IksiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOnRydWV9","AUTH_TIME":"1745395448","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745395448}"},"state":"LOGGED_IN"}', 1745395448, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('214dd239-9426-4454-ba43-585f838056eb', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745726827, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745726826","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745726826}"},"state":"LOGGED_IN"}', 1745726827, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('dbba74e8-5f87-4952-b207-72b2d031068c', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746282950, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746286547","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiUkhZcW4tdnYzcDJrQV85X0xnMFdoUSIsIm5vbmNlIjoieGJnaEItZEtxXzRWTGZ3OE5wYVktQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI4Mjk0OCwiZXhwIjoxNzQ2Mjg2NTQ4fQ.PtR6ekgMmFclJYJjF-QlXz-98T-iWJtGLUCI3zH8Zy-ANN9RL5Qr2njxVVxTlzqe7MF6B_fAZfIzpaDO5nEQ-UbwrmPh7L383BQPvTtgzH6tMxnMb83dDHWRvsQBYB3wkJrWjNDIq_6UW1GEeH8DMA9CdAwfRGQyvTFylDZFGH2Agj6jkDCXIENqkAcjDtJpwPRaE3u1E9iD8L2fvBzt9az_MMhDmNzrslQd3zY9ZY_eTiPEA7LJJxMRE5NE9fjE49K1Lg_ahrw3Ib2_vXaKswGCg2bg_IaxhxIEno1uzSBGviXuvb5xG1QcAUGRGhR035KwqfG8nS1G6dozyn-HBA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgXHJaLy5UTNANN94tSkjcZKO2-KZu6tyolHUbZRGcwY4Vmr7l_KeSz1X6_iRurRY5TqctLGHt_AXs71d_cuMY0NwbuZEiTVlbDJWVcso1iH66meiYK2zCqtuG09GAvsINYNeQ0WO-AXin5i80BffUkrWjmllFefYM-I5UaCgYKAcMSARQSFQHGX2MivcO4EeJZyvn_1Me9qsFuAQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746282948","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746282950, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('cd2d32e9-3d45-4c4f-ba7a-0eabfc49f3f9', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745726928, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745730525","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiOTFFUWpvLWo0STZLbUF1UnpGTzBHQSIsIm5vbmNlIjoiRFctdHNtbXplRDlCNzBqaUNqVnBfUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyNjkyNSwiZXhwIjoxNzQ1NzMwNTI1fQ.CTQyWXtA9rynf0Qh34jBAI22_-05twgk70uDcH_XIto4-vioWJOnitS5Z16yGploAhe0T-272QB-mk2c82jhdoRC5gSLAbfl-TJUn-7aemLP5nI4epMuKl02vhX-L6INsfD5T1IXw_RZK-1pTfjrpoZqmVOmyjh_QO370EARsag4AzCw2NaJ1M5o7CPmfVG0cSIj2FtDHhnzigcKED-OQBGeyc-YiVUoD_sTczT01ZW9UIO4nwXlC_f3Qu0XvgArhe7xQwPo5Gvos6QxIs1lvZAMxp87OGrBF2pzYc1L6387tMKsbwtGUBDRutjtzIkpCNpupQ-aOVyA3rfitXy0IQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjfcVCyJOlds-IgWQLa5JWNiITz1Coqsyey-fDua12qkOIjTwPflmvLPAzuJ6rwF-jds6fHujfMYsJowiiO-Bh06EgfHqqb4lq30y2Jpp2oU5Y0lyfeKDOVcdBiIwFXIbVoiwyttgaH0Y1m7roHkrA7AJGTjVr69qpjJlYaCgYKAZcSARQSFQHGX2Mib2hQJRoiVQ3cYyWd0RKoQA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745726926","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745726928, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('041dea7d-f3d9-4d19-884b-19fdaa442a1e', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745131437, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745131437","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745131437}"},"state":"LOGGED_IN"}', 1745131437, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('37e1adbc-20b9-418f-a8be-282c26b1cc80', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745144745, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745144745","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745144745}"},"state":"LOGGED_IN"}', 1745144745, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('543a5bfc-0819-40dc-a73d-e9e87a6a994d', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746284555, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746288152","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiNDB1TTJlXzdpZVhRZ0ZxNXRTc2p2ZyIsIm5vbmNlIjoiVWlKTHlhNzMyM1E1WnRwRU9qN0tlUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI4NDU1MywiZXhwIjoxNzQ2Mjg4MTUzfQ.Wki6cKsJ4zJEqZuV7SJIevAQYVwuyXLKeKuXXcADBaoGWpLOeqYe4Dd6LN5XP4kWPMHllmNa-znAE3Qq7vbjpS1GwAqNWvlQ6ZoxDMAjFydF-mHnqTg9jW0Jb28OsvQ51sW6lnYIACFSxOIgccBKe529KHH8Wv3sD0svv8txFzncOlSSf6QIKEi-iGb4YrKsiG-mhtEZSJaWDf7NqYqp6EF_Rt8qy4M4NNrxT7HApLpC3svd6MgT0FbtsgMhjHwJXedWQMXmHaTBhBtFhsQgQePowZ0u1JF0YplapgIfytrrIVYn6Zxwj4Jykend-sK_FLEUOungdBr0S6j6_XqE_g","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZiUQBzw9fvlPRfRY_f04gsPWzVMlaNz1fa2Uf6BtNavNje66A-nGL72dMgmNJS3quiFsLBLsxEFULeEYlsfbJDNOdKqkR8-pmDcN6UaShBR3-O1AjAFmBezE78fLLbNFAEh5bS_52zSAikH_UpiTaK2emsCJ9PHx2E5gUgaCgYKAQ8SARQSFQHGX2MitcuRH6jTmNlAnihebBjbrg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746284553","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746284555, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3afb8f04-929e-4e48-974c-24bfdf7e54c0', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745395547, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745395547","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745395547}"},"state":"LOGGED_IN"}', 1745395621, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('9ad9289e-ff65-4062-825a-1889f0433e64', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746284567, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746288164","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiZ1oyZHpyM3BOaF9kaFRIc05IZHFhZyIsIm5vbmNlIjoiaXloUGJrT3VDa0hIY0RzNUpHWkJIZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI4NDU2NSwiZXhwIjoxNzQ2Mjg4MTY1fQ.SoS2kDKnOrUQjHZsLPorEtoACTmbnBCGnY0opwV_QF5d4v3_ji2A3aiDuJoD6YtY8JtxuXM08a8qGiJsEDLXeP-n5TvF7-BIFzHnyrzQnLwxwl4bLksGVrhxu1-3zUdk64-SN7GDiC9qrRASQFcJi8Nywxe8B9rLnNGb3pRPMBmmDbuhyaPQkkQGYswo7XOZHDhevqnvjOdzXmotrg4kyL5jByi3b9eMpJ4_aB5_Y6YZeCFi8lMxBFzrBWhf7PedQD--o_yySYUHlX-Vcyjm4fKqjO2bazMVZSsjetIU1rUKHjIf3h2Nmm2XkUarWaU9Jgyw3U4Ls7VvCS26KUzhOQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhT-uLRFc5qIqjnfHXIDOKMI1im77_RlnUxxcvXDD0yupqJ_LAwe0eAPH4cyt0LtSBI1dU1twsbcL_8QGa6b9uk89ta2E-Mt3w-6nXjVILS2tbQN8rv5tqaUHrc92YI4X_6ZLpJD57gUu74pXOCmwztba16l8SRAEAHxDkaCgYKAccSARQSFQHGX2MicmxgcU1DGAdm-NRQhwkHsA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746284565","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746284567, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('24a95fd3-84c3-41ee-b2e6-49887ffa660b', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745139128, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745139128","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745139128}"},"state":"LOGGED_IN"}', 1745140341, NULL, 4);
INSERT INTO public.offline_user_session VALUES ('1ddf84ac-82fd-45f1-b18f-f704b30f64b2', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745144748, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745144748","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745144748}"},"state":"LOGGED_IN"}', 1745145679, NULL, 12);
INSERT INTO public.offline_user_session VALUES ('87fca5da-4bdf-4f0f-89f4-75977e66c48c', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745164852, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.25.15","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745168447","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMm91SXA1bVJvN29jMktFcVYxMkNVZyIsIm5vbmNlIjoiNnY2NC1RYW9jaVFMTGNzWWRjclEzQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTE2NDg0OSwiZXhwIjoxNzQ1MTY4NDQ5fQ.N6xZmUUxKNq4ikv3OIQLeoDghb1FfiTrRGPadGrG6MakqE_2k1KCTkLqYxLRrMHD67wed3xF6XTHmBa7ztLWMe1NHGtySksOBwW7ObxQ_lulQ5dneeycH6DSousLMnb2JcjriT9Grbl9NkADpM_Acu6XGKj81icfQlh_D0WOXGooQxhqk_KqMFUGzo1vNk3WPkwKtHgpA0vNrTu6zxL0sBg6AOLaBv_QCYfiulxyHqcZlJyUyMIqv5Sj0h1Ed9_XVlPApq--kVtSo-Zlh-oiE4aI7uqo1GOnGZ-1eYhWEb5zz5ZV4vDPMT7z8fmg2kk00E3cCWReCSP2z4HoU6Xbug","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgAX-egq-px8E1pE6f1DuQvlR7FOrB5XYVVJZB9hDvobI-L3559HVuhgdLuR4HfSYsLbBWkIVOO1XUW-d_3ymVtZVVrYo877oKBydAhmt7_S0HtVMgMSWyp5iKD25FxcxFnIM4oIvEL5b8s_ZlkjdVN5qmFHVV8V5ouPGEaCgYKAVISARQSFQHGX2MiowMBLu3VGEjcJ32xLWnRKg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMjUuMTUiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745164849","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745164852, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('cf381f54-b0b5-4220-9c92-9608994dac6d', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745198417, '1', '{"ipAddress":"123.20.155.86","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMTU1Ljg2Iiwib3MiOiJBbmRyb2lkIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lIE1vYmlsZS8xMzUuMC4wIiwiZGV2aWNlIjoiSyIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6dHJ1ZX0=","AUTH_TIME":"1745198417","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745198417}"},"state":"LOGGED_IN"}', 1745198417, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('16c2ae86-2f8d-462e-9d7f-3455bf08ad16', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745202081, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745202081","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745202081}"},"state":"LOGGED_IN"}', 1745202081, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('4e027fc4-74e9-465c-885a-2e8c4bc61cc0', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745202715, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745202715","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745202715}"},"state":"LOGGED_IN"}', 1745202715, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('bc58a219-b939-4f6f-ba1c-08b9c866a0fc', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745208229, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745208228","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745208228}"},"state":"LOGGED_IN"}', 1745208229, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3191a4ba-b10a-4175-bdb2-0a352c09188f', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745919086, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745919086","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745919086}"},"state":"LOGGED_IN"}', 1745919086, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('56af8b9f-944e-4d97-b2a9-80f632c21602', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745765736, '1', '{"ipAddress":"123.20.234.153","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjM0LjE1MyIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745765736","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745765736}"},"state":"LOGGED_IN"}', 1745765736, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('72a82fcf-0904-4878-9a9b-8b5319d31604', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746288082, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746288082","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1746288082}"},"state":"LOGGED_IN"}', 1746288082, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('72406faa-9554-4551-9d5d-89d33e5a3d8a', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745398790, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745398790","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745398790}"},"state":"LOGGED_IN"}', 1745398842, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('8aa5f3e1-ad93-4b2f-b267-c12f50426351', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745566757, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745566757","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745566757}"},"state":"LOGGED_IN"}', 1745566757, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('20180017-abf4-4e31-abc3-e23038682962', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745728549, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745732146","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiY2Z3MWZnNDMyMnJaNEloaTgwbEJ0dyIsIm5vbmNlIjoibW1haXBOTDU3S1AwUmZpWkpCWXNrUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyODU0OCwiZXhwIjoxNzQ1NzMyMTQ4fQ.EDPmcWkIEstyEWpcRfya4b-iT5GnIT49Yd-uH8GieSceWsuK5y1UD5QC-w7WbyqYkJ3Kmb7lgLvQ6PhFa2_h_IIhsJryehKAYidOFJGkUsfmeecVKE_z-KqXQp-TWrcjBuZBUsRcP0aGLfO2GaXuToLefnl00jcS8MRupfjyVNR8oVGsU7QZXFvEAJL9jxlKQdJtLzkKt64FqJv9SnDdl0FejHTUaTViaeplXRQtqkkNoI4zX8CYiBSZuDLkAysWzKdten6Ot_H9G_jDiw-EEJ0zlLr2xTFQC9z_koqGZJ0DWfe0GJq_K6gjex979ty7idc-LzgqgSm_BKS6ERB2rg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjBneehGJngtYHTogAS0UEz7vZh8DlcUE7IQWaY8_SPf5a7OFuVx-kU4MtLL-H8MkwxuahIlNoSleljgggei19UYD8guy7yYubs7BedwdtqdVuj2ktGO-833rkkAIgDLDRkBHq4zrteqBxNEw2kriYM2SRyiwwgoEJyMpwaCgYKAbwSARQSFQHGX2MiR7PICwJaApYaoOXrIWhFfQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745728548","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745728549, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('6db2c99e-ce85-4702-bacd-eab0ab592e1c', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745728558, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745732156","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoienFWMW9rNUdiVDRlSkFac2VZQm5CQSIsIm5vbmNlIjoiODNZUTVrY2dReXZTbnRNZ3RMaVYydyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyODU1NywiZXhwIjoxNzQ1NzMyMTU3fQ.g8OwhPtUmw9i0eZyIj5_yGEBPoVR66PPrTnPrtmrNDIooxVbHMs1O9QxQQMXkzPDFTbLgurCDM6tumzTT9oyIoN6xc3W2uEOxQi7Zgb-NuPdebeNEhvypjaWrkABUdMzEAQ_-aKb4Jta3djsgRLRTRA3WfJO5uyEfN4jUS_B7QDzXrT6l3lxyBPsEkEuD47ElRENVe4036escjnWfy3LesaF5jAWZgn9Ge8vMMcsgC26IbY9tprw7WfRaWfJEZmaljOz0O3-GuEyhi269fV28s7wPTrgFeLUB9DEtXYN9IuuW42GrjuYT_W00WpNQ3ryG1teOs4x5xWSyw1J94yKNA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjRFH5Vez5IjQQ-oR2SyaycesOXoWJEIUvgWBFs9hKJjyf90Ec9g9sF7V4V6JNbZ_wSTQ8AKDAe5ZxfDeSTXdVRndhN6jrgKOsXPK0ILKj32_6ZyHUgAXmk3rpiqaIVS4my56ldOS85jOGp20HFPn5BHUW2kRCeKioEkYoaCgYKAZMSARQSFQHGX2MiqXTC0kOXrHSDf5fmfOIRRQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745728557","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745728558, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('bc428509-b5c1-4df6-809d-ff205d7d0071', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745727977, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745727976","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745727976}"},"state":"LOGGED_IN"}', 1745728949, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('bada835c-978c-4350-86c4-3773bdde63bd', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745729928, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745733525","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiRjMtMkZZUE9tLWtDd0hnVG9pNE01USIsIm5vbmNlIjoiQlljOUtlVzdkcW5oTWM2a3NkUnh6QSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyOTkyNiwiZXhwIjoxNzQ1NzMzNTI2fQ.TBJhEOA9fw7234_XhNk-bTV9UrQ7m17Avqwf_ux-A3JABG4nR0hbp-u_zoyWVru8hLJPI6rJ-zKclHtcDFXd0XO9so9tWFc_sqkG8dnwCMpadknIf7gz2SEH2-N8y-C0AzJ1ObukwCJ7oazniIRrGYP6eXZTezdfi6twRL9v1Yse_8ozS9WGGSxpX5Pe9Wm9w2IHPNbXw2_HTAL4-l_UiMXnh348QIs6M0Hl7ZEhWEugXTusJ-swawS0u3JtkNMOp-kp--ZLSOyht9Uf_MLWpy5xA0JT1TtvJvii0DbrcRChIWrE2PLO9PiefEk2Jo12XMCBUzMaW9ov-MijSRelNQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhDgcQ4lO5-ShQyV1OQqYpkNqX2T9opchsPxTdFkul2ZLXR2-eDEbm9e_TMO5_lLHRry6Fr1ZHJTLIKp5FX0uEiu8j6EmXpoGYL8rUcjTkvjzaK3HcjBbf8uWd5RS1N6OmoxTn3re_oAJX-SpZPHKC8Mw0S4LvnPr7ewmMaCgYKAVgSARQSFQHGX2MiOcmvxUF9z69umSY542ZMJg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745729926","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745729928, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('bb61cb70-b6dd-497d-b07b-c1ef2e88bb45', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745729942, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745733539","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiQTZhWHJTUXQ4ZV9rbnQ0TUlIc3JFQSIsIm5vbmNlIjoic3JxWjl1ME4tcHEzZXZibFpHZ3ItZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyOTk0MCwiZXhwIjoxNzQ1NzMzNTQwfQ.Ztt5CO1ziEAQLCLBmUAwEACD5s8xLskGYrYfWnp3x0KmYx8_YNC7niXXtvRNCCK3WljGrlHge5qzokl2DODxSr7mlMZiO-286xFKH20DpMirueEGCKOIYE-T0jEpPB2Pwm62ME7h5TG0bld23o-4ycQEngWXfR0O8AzanASkMYwJ1g-7ME93aV59pM9PPh0yiQooJ-LiPJEqI64qKhS2lTex1DJWlOk6ZaZChTPhnREIhsMgWfTHZ0kcgfHze8zadbReZc32DZ85koJO79wMt0nvOyb6yTMCywYsk4u-6aeeb9k1GhgSBzsdBuFBCgmuL3uiTCcut0kgOYcG9cU1wA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZi3HzrVR13HicAoL1hY1qUjb9T6B5s7STfMltNMooaW1TilNXXbcaG8oqwNdNm8_4ER94iqgF1LV3vvECMMz4nl4wqeAtDKQgnfEcCfAuP3ludBei8xcs4cHT711JBiGhv7u8bUfSl31f7N7eDEoIjcpNfQFKlUa33IQK4aCgYKAQgSARQSFQHGX2MiRbtjUn0r7g_edjm74Av2Sw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745729940","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745729942, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('94ef9b88-2f81-45a2-96f5-153651128601', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745730086, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745733684","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiT2dfN2RNWk04bFhJMHVXWUZGcTNaZyIsIm5vbmNlIjoid25LbFpuVlZXa2ttcWRjSnJkYUxXZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTczMDA4NSwiZXhwIjoxNzQ1NzMzNjg1fQ.i1UXx9zKz7iIAzF81NWyo1zeYOVPnNhnQMZ5b4hRXiBmyYRhEPJaCFi9QT8lHczJiPjbtkMlvjxm2iux0stSyNPCp6kWLlsl2yjIxRuh4UTVaJnwhgOGISdWmWqDm_NVEoZIxEI18Jg3dsMC-CZgVLL1tZOL83LOgnfyQbvYqxgtx3ccSj8ycRDYvlKtKxH_pbus2iPyvtfXTnBjruB3kBjtzdm_DjFzxdy7L_ImGSL_r36zlLS3a-t5TuciPfGt35qHjBLFbh1_leCH9ZoZuc276GpWT5c89KR5vX2m6ME148CR7SqGPthNH0uB4oTgPCMMpOPAwd2B4cVjZ2sn5A","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhEFRCqNb-42jgvdiz7Ka5nETX4JR6YQ6kZewINB6ANh1jQ94eIGN_hKvvrY2Pe-SvH6OMd9rYGpVOM1zjCtdG4BOr2dWonT_E0dKc4fJoEoD0BCyvzL1kwQUSAxk3zIjXHN5uhZbNvXM92OrfjQwxaRE2O2J6Smp4aim0aCgYKAaESARQSFQHGX2MirkrUgyYoApao1YKmN7IjzQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745730085","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745730086, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3e437c58-be24-4961-9ec8-874b90199709', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745731338, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745734935","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiR3FUUjNZamduS0RoNTFCenFnN0hRQSIsIm5vbmNlIjoiM2hXTDBxNDh3VjMtRlBTMmFteGRhQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTczMTMzNiwiZXhwIjoxNzQ1NzM0OTM2fQ.QTVBD0dcsb7kdgdTUULE5RpjkRxlT7CnktyudGSr4QrBUuz7fwbryFpH57TunBq6VUAcLoAMd_gP6bRQYfdXMSu2K0ugjJ-wmRcmHeKNdBXSM2bDpPrRCUbInXvIat9R8yxuYN0DLIDPPUYK42qaB6FMa8CP_PZsN5UW_3kpcCRO32PvbQmAXZF2AdYExhkE2JWWMxV41mNkKW_lhvha2gSFyP0jyNALj2iD90iLjnIxJ4YytJp3SZ3XU8LGF7tGv_gAPsQANr-XcH8SqICYmjmEPlTYRZPSwa5asrgWBtgjpqt6oM1mcKBn071SZESetTgVRX1Q8pwJfcjKSt5IDg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjfJEii8ODm7BrJ9xm-UrkXOeq4aEsyjOjRLAfmdo93Cw_4kVEvkL3lgj3P2ELIiTOE1RdsoES0djSawvdrjUTfFtb5SZaAGHZOvEtRnQltHNuRlDyg-Wn3sqUgQ5ZOh6qKlvCoLPKoO-Vj9CEEMEGy8XzcEEQN05zgQjUaCgYKAZISARQSFQHGX2MiUrUlWeNX5zyFipnyNUNpRQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745731336","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745731338, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('85ce417a-64d6-403c-8d1f-5465f7e0b21a', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745731345, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745734943","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoicUd1RkhwUjIyZU8yV0xlc2NKbG82QSIsIm5vbmNlIjoibVNwaXdKdEY0OW1fYUlsbWVlMDZrUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTczMTM0NCwiZXhwIjoxNzQ1NzM0OTQ0fQ.L9kj-7Y2OiDOyiJjXfj1bcO7VI8Cn_aX4mfPNLJRp6K3x2EqFh-JY07e23nv60KRn1lr9hj2Sp_Kba53w8wt8XvgfDnMU4JFJYvDxxyfdyLKpd3dzm8kIlhEbKyJjyHgXA-u6VZUvsH_sCqpjVCqMOLtfhGKitiqDRsd9ht-LeVIxO1bZoKqHXBD92YXIfSTPQEJOtmWseJRpeIO9Ie2vLaWLGZF9g4kwpPa43eLV2U6ZlMCzgiy4lNaYY6MvkROTcHNVgWM-IlpO1NrxDwK2G5awQv8fde2x4M1DtyED0zQ2p0iiweO0wn5XbBBZNZB-ZSBDuebVXayBnIDKB3qog","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZi8xi0s-9DNqU7KmTxGTRnMloqA6vTRUvILSaT6r_j2Jxaj140U6TpkNbIIJTsdqn8ibTrHslWoirfYGQLb8gzt_2nsZx6VaJ0rBfrCCk9-5j6K3LbDssMTtCOrnbdKBpT-jT0vv2qRWGvVHklPRYwvy0sW4vDC2GN-IkgaCgYKAdoSARQSFQHGX2MiMCZYYXAPys6dNHZbmREU-A0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745731344","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745731345, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('07fc4b47-6900-4a26-bdf8-55deff92fe49', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745732851, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745736448","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoicDNSZUh1X0Jaa3RlMnczamNCNUY5dyIsIm5vbmNlIjoiZ1F1UldLR3FRXzlYc3YtUXhzLVg5ZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTczMjg1MCwiZXhwIjoxNzQ1NzM2NDUwfQ.HnAB__CoMxV3qpw7xYA9oqdCMqhHI0XecfCvanQxSks9wXRiA86LWUjcs0kq_WctG3TZUWBeLw89Ta2ZCgvY2f_t57OIn_DmB3kR2eeeA95TlKUPl9uEeVMAY6vg5K8hFv_jOGDordPVp9Qsmaq6EddZQPzksoFe3L0P8B7x7wtOp1IQxuOwHOgwBII6XnxId1bb41jbkUj311MavuXjtz18uwcuiF2EgGUMG16DfbDY-1lGf8vkm5IUmmp4pO9MFw2mWT8nDpFO7FA2G0OR3VpfAKkz-WRRsUkeawT6Q2w6GrCXp8biv4sfZKGp5GrvkbGG_7teDTPbsusxoYIYyA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhgAZbEwgwBxWeglogUA8c6qQAyYSPX46aSU-GT2IMq0D5XEJBnAw1fK8X6UYzv32g8HA2LYVUeS8_VmXvguZkpVDxeaVp76QSFhO0cL4_dIg3VXE8mRUoeFRahaCQS4wvrojccGmJlOLZsp9jYJdWFMZxNjaweUVr_qTMaCgYKAawSARQSFQHGX2Mii7oQ3CGUbkhn7XsABTIXHw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745732850","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745732862, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('f68505f8-eb23-4520-b960-3ce591287568', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745568252, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745568252","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745568252}"},"state":"LOGGED_IN"}', 1745571424, NULL, 4);
INSERT INTO public.offline_user_session VALUES ('6a09ef1e-0304-44bc-960b-08a6481cf928', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745574247, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745574246","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745574246}"},"state":"LOGGED_IN"}', 1745576374, NULL, 5);
INSERT INTO public.offline_user_session VALUES ('9f26c794-a0eb-444c-a95c-b1d7b01bc30c', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745571428, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745571428","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745571428}"},"state":"LOGGED_IN"}', 1745571428, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('dc05b564-4df8-4a1d-a469-54263bd7f077', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745591104, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.36.79","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745594702","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiUlpsOHdjX3hudE5SdkNFUFVoS1BidyIsIm5vbmNlIjoiWHRiUFllbDhiTXZEQnBJOVZFZk1HUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTU5MTEwMywiZXhwIjoxNzQ1NTk0NzAzfQ.jGvxj0n7XlefZsLuGFcr9nugO3X_qhMrMTdILY362jdcLvr9uZ5I8vRQEP14TLjp2DN0ArIZmjnb1NnQ3dvXw2ks2dTHBMpJANzMxQeuFZMClRzjeRqjYCtI39c1krMYcg-kn_jIg-bR4G9yx3ZUpc228Bys5_6VyUIIHPMujqZbcUjj0GOBzsKG2p4QgM2rCStsZP45xWVciIuszlFeKKiDPZ6aJHAkHX0VhPm51GwKeYfku9RzLgrT5MdRIphoTw8DHBJMim7L2eGLSvaLhHfX-38rrNRi_Sanu2B0MdEaOzOLBSD8pwTe7b2uGJ3HMZKhIXeylcM6Krduk52gzw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZifcBktV60P6ZTDJTb_ugJ3H-KFj76PWodLpFPuFkWh-aZlJNeHXbfOmwc6Di6MZiCcKZgK3Omv44dWwE4XGgZF_4daApLE9h5Qms4rOe8-eZnkHqd_TeSDG7lZ-QgAHjJliJ2Dx9VO0ULbHcfN0qF6wagbkAumNlmRh50aCgYKAdQSARQSFQHGX2Mi7nMYGVe28X1zX27pnOFW1A0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMzYuNzkiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745591103","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745591104, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('099f7617-5288-445b-b628-7b9d942addc5', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745596967, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.36.79","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745600564","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiUFBSZ0JjSDUxNV9IN1RiQnh0VXR2dyIsIm5vbmNlIjoiSmx0cUlYVUNZWERlWGJiWHBnMkZCdyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTU5Njk2NSwiZXhwIjoxNzQ1NjAwNTY1fQ.NDfcBG5nvb41kAUS8kSXvvqvP68BOkdJKVtCsgarfCY4Q1QOjY8B0GfHOK0W32RTasTZuGegzYOOmoLXPgXBq72v3fkGkwt2QOCpph2XdxeYJG5QqhpQPuNKZgVqUbnnbOpvwhGu9HgjRURcUUVAXShQ0bJbwCFdgq4DRhu6K3lCy6Uq3QwgylWxYormifo5CyFg4igwGhTCebHlREgE4SSmej_MMHnXYPWMLnYFuxZSYgVTZB9Q_lawcX8FodFKruhKnxj5o_bHfx3kdFrV2ITXTsblxUgZ8OnuTCpJHcqzBZgk21Q9okPlD8ihZnsAHgll_jQKWBwT7MZVWrU1hA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgkeYl_IpR2KqLq_2I98o4v7quqJ-7a6I6UqFwTg60f2VT26L_GmptPjq7uaI7PD8gb6EVFfNBLjegvKTghXxy8EC0j6sgwSUuD2ms-pfR8ss5wSUB_YAO5IgwaVhydKolPV7t0yGBPjur7pp6hY9-CqIH3hACw0xv7RygaCgYKAfUSARQSFQHGX2MiSc4cpAkhcSOfJpMvVq0QOg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMzYuNzkiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745596965","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745596967, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('aaeeb0e4-4fc1-457e-9dae-f13c8b6d3792', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745601122, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.36.79","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745604720","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoidnZpSENqeUpOZkRlTDNDYURwbWUtZyIsIm5vbmNlIjoiMHNKWGgtN3Uwc3lvNkNHQWlmcGhydyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTYwMTEyMSwiZXhwIjoxNzQ1NjA0NzIxfQ.U3QLPTTyoOhPMJaIURlEwUyJG4pnKdM0U3HG9yxXhehL6PSpy1OMvRt8SMdyn9gnMALvackIqk4RwCzYbTng6UJe6UbyTGa7p54p2Bdt1J8RqnLOyTd6xn5ktl7N5afGoQ0kRP9aUk-lXtyP57fOLXlyx7sQjw2YLkOJIkdBJ0OVImjDN9Yo_VpnZoqdW7ThddF7V5M0tkh3v51__SD8RxvZmcF0Ul9oVGxonv7L5ZJcuimsXGgnbNL6pv-zFRpRu7bBDbiYDLoPRdcURgq6Xmh29JUGksx7WcCHFZ094PyaKs4NWIIShqPH5lVrPx-K9Zn8JN3Pa3SBrSypa4Gcag","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgM9ICZFeddEJch_35_4r2R_FtgwkLAts7cVD1tl5VVChM0rxB4JPqp0X0BT9Mx2qRb1YvznxIYiHUCQpI2qdxndulZ7BItfzH1Vs8n1oaJBL4VQKtC3opDiykr1RNcY9IWffxnNEkCQvPcypFkpmctKvaN1vPQx-OzVUEaCgYKAZYSARQSFQHGX2Mi7UnUjZb82ppC87KfGj5Iog0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMzYuNzkiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745601121","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745601122, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('782cdf79-9343-417b-b1a1-c56da7476767', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745643748, '1', '{"ipAddress":"103.199.57.40","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU3LjQwIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745643747","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745643747}"},"state":"LOGGED_IN"}', 1745643924, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('752f811f-b47e-499e-a5f5-a3aa300ce555', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745644324, '1', '{"ipAddress":"103.199.57.40","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU3LjQwIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745644323","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745644323}"},"state":"LOGGED_IN"}', 1745644324, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('9c26345f-a92f-45f8-ab7f-81ea746fd852', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745645837, '1', '{"ipAddress":"103.199.57.40","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU3LjQwIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745645837","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745645837}"},"state":"LOGGED_IN"}', 1745645837, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('51dbc34b-23ab-4063-b2c8-e25324890819', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745645850, '1', '{"ipAddress":"103.199.57.40","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU3LjQwIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745645849","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745645849}"},"state":"LOGGED_IN"}', 1745645850, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('0a395635-f343-4b48-ada7-5a1e36bc97ce', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745646165, '1', '{"ipAddress":"103.199.57.40","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU3LjQwIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745646164","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745646164}"},"state":"LOGGED_IN"}', 1745646165, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('21437fe2-51ed-4205-b867-dbac2fd077d8', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745647536, '1', '{"ipAddress":"103.199.57.40","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU3LjQwIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745647536","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745647536}"},"state":"LOGGED_IN"}', 1745647536, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('6e809142-b150-477b-b719-e56b9df4643b', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745647541, '1', '{"ipAddress":"103.199.57.40","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU3LjQwIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745647541","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745647541}"},"state":"LOGGED_IN"}', 1745647541, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('79786345-fad9-4a36-8959-89ecbd8e9ef3', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745651267, '1', '{"ipAddress":"123.20.248.51","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjQ4LjUxIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745651267","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745651267}"},"state":"LOGGED_IN"}', 1745651267, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('4a6fd55f-9acb-437b-bbf9-b4eb8328eec2', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745653228, '1', '{"ipAddress":"123.20.248.51","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjQ4LjUxIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745653227","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745653227}"},"state":"LOGGED_IN"}', 1745653228, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('461eec9c-15f6-475a-a9c0-24610d778a19', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745653237, '1', '{"ipAddress":"123.20.248.51","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjQ4LjUxIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745653237","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745653237}"},"state":"LOGGED_IN"}', 1745653237, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('df681716-d2bb-4dc2-93e5-08beacdc4ae8', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745659558, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.233.148.76","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745663156","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoia054MkNaTUNPOVNOMkRiV2ZqekhhdyIsIm5vbmNlIjoiaUdPM3F3d25TZENoQTN6akdmRE1RUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTY1OTU1NiwiZXhwIjoxNzQ1NjYzMTU2fQ.cqv16TUUMY2aLfsAsLjn7SPP6PSs3-PhMLXBFOoRblh-ewtbklkseDCHPU9Hqt_Ex-j0PlBBMt40aXp_lnIJb-CXdxppkXNnlJ-efRmJ8wvXVEXPsC_0EdXShNmq0-4plHHD4Gh4ure_dpfWMBVUfR6Nua0ip_wi08K2DU85ilCp7VJyZRlKDSkvlZsE6mZcaRGoFt-Enf36JLaWJGG2biTdHgY-w8FM7RCbKShaaIElcRD0B9mUNlXAJrgkYQ3JLIPqKkxLAuYhQbl98Oo6SQk9UwaN1yQTWJ8q8uuNU3Xd3e8d2RfUeV_XURlZfKpLM1UK_8ZJlgGPbv90wS5BZQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjQC4ffblRcwqz9UWljxx2WU6rNjSiY5oMDSLTx1-MUeDqfjUZJ_fhu6EG_uXGoZDzu_5TeVk13M_SPSczsYrZq3rlOa2cF1XBxOfIx7RV39IBMdVQdgNvj2f26Vrhcky9FWb894tYMQ2eYThDUMXfVaK83FJ9Sifd9YQsaCgYKAbkSARQSFQHGX2MivofFnl6hY1Yjn2xff4HP1Q0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMzLjE0OC43NiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745659557","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745659558, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('755a3c8b-fb9b-4683-a992-e92ae55401b2', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745659932, '1', '{"ipAddress":"123.20.248.51","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjQ4LjUxIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745659931","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745659931}"},"state":"LOGGED_IN"}', 1745659932, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('12a3bbce-f3bf-419b-bd5b-4dcca896cf8e', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745719512, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745719512","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745719512}"},"state":"LOGGED_IN"}', 1745719512, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('c468666b-c57d-4707-aae3-3831846f185b', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745733000, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745732999","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745732999}"},"state":"LOGGED_IN"}', 1745733000, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('ab70b74a-06ab-47a0-8d49-bfec689811ab', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745720869, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745720869","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745720869}"},"state":"LOGGED_IN"}', 1745720869, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('1591e4fb-8cde-4a3c-a917-eccec849059e', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745894672, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745894672","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745894672}"},"state":"LOGGED_IN"}', 1745894672, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('36379249-5fd1-42e0-8b64-f07731f4081e', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745720873, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745720873","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745720873}"},"state":"LOGGED_IN"}', 1745720873, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('8cf98b40-244d-4238-ae12-4e25394aa296', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745896623, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745896622","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745896622}"},"state":"LOGGED_IN"}', 1745896623, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7305aaeb-85c0-4e1e-8ba2-ea888282ab0a', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745720877, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745724474","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoicWZ4N1BhZmhYUTVPWTNpMGZ1dTM1QSIsIm5vbmNlIjoiOHUwdGdRSGVjTW1xUVlhc0hpQ1QydyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyMDg3NiwiZXhwIjoxNzQ1NzI0NDc2fQ.exOSxJIT2a29hNqH-z4e6HeRquSuygc8Km6PA-qX669NFq6nu7-plOtZNeyYJMTD6U8eQf8TJwMDvNrI2X63obzNz-1a8xLsS4f8BcodRYLceRoikq11hPwuFnCpnxH-SPf4IS3XahtpKsEHae07QR3WmtohBXhYer58ZEATh91BI0WTI-jiuP8QkRUX1blwwFQcYyUO-6J_m4Dq99uU4EMWm9I6plE4V4GXO-AJzEpZ40M-YeoJbY_4gkkSDXk7Vp18AusR7YJTSJbhEemA1RIPqfJIUcTTM-V4N7R1xeJ4R8n41YiXOJErKwdcBBCKxyxa3vt-alU1EPDsOYJE3Q","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjRMTXMWx83fNWbwdntZne3lkth1Be1V5SAdOiEiO619clkdhdAuIgyftMxlS3zgQoCu0C3C_UvnrCCHhrCrppmARaGo0en4EDykgBVHP9ORfrsHCWTFtZOLwrFdRl6CFVwxDUQJY6P8V3DtjZkVlcyejcRbe6_bCBjeIUaCgYKAfASARQSFQHGX2MiJz162t3bz59RHDNrli-x-w0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745720876","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745720877, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('1341bfae-dec6-456f-bda3-d6cebc235637', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745734958, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745738555","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiZXJtMU5mYnBfdWlHd0FUZmtsdXViZyIsIm5vbmNlIjoid0Q5X09WU2VLN05BQmM0Q0VNdzIxUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTczNDk1NywiZXhwIjoxNzQ1NzM4NTU3fQ.KsyPmosZaGSlOVLUzjPOPN0vCedyWtGwSsczmdJKfM6Ix0YUNI9uyBIPRKC7rhxxekuUPr3uNHyAAAeNX-A3G5TU9sm2P7isGLyzkPSN1Hmu_Oowyk1NJIzcCYhfjjo9zLv70CI3X5Lt4N5w5xipMqXOCZx-yOfVYObyrOItto4yI7eCPi-wro4gdtgBnQAMyxeiTCTmtPlKbUsYqA26IF0PHZYLTb2xJTC52yPl4CmevcIC9JS0prfV0OU8Yfg-uNbXCe034VFPhSCCFGCVgW3dotmvlXZKS8Amq-iTStx2kDePQb0HDs7ZU-S1umJwYtmf6aL3Uo-PReGde8EtTQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZiOB7TilVmmaCAMuTqmhp350Jd_J5y_3meP3ilkvlHzRWiACBKKq1kRr5Gy9RjIGQkJAG1cdmX-oyfBc2tWwJjkjdO1JyJtYjEjA9IbX7unkIj_PVUuYM9BgSpRJxPNy-s30QSGMYMrDSG79rICSOYVq_eC7yMTw_4lWjIaCgYKAWQSARQSFQHGX2MijOhsNM8mCYJuWB93SA2frg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745734957","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745734958, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('c444bd96-042a-45c4-ae23-d112187995c5', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745896627, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745896626","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745896626}"},"state":"LOGGED_IN"}', 1745896627, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('80851030-d0c6-465a-89a5-1c6969e77095', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745721029, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745724627","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiTC05OE4yWjFuY2NzWm43SVZiLVNRQSIsIm5vbmNlIjoiRzhnSmEyVlgya19mZzZHT1RFSzFxZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyMTAyOCwiZXhwIjoxNzQ1NzI0NjI4fQ.BoL609EnaYgJIPmpjKIT5I55UzhxMqPplx1iCfcld62XFIcFVsEHUVWjTGSbsHSTTz6c41YQRJ5Mtaf4KOx3k-AkbrLh5u9kfVH6c5ADrq9hA0hE7CnHdg5ZciSjzLPGV7dgr0KHm8F34jrfwPcmydTeN2hVrxr746INyD74aRhs5qBheUciibtlA55MgB9SMdPugTgCtcicAHQMydxlBsk7WH8YxkXM7peZtCwj-QLrP_xLxyT3HBsLFI-zUSXfNV8axkGO59y0gQmTPQCZ7CxUdosBEUSsySHpGOWsdQESqfZnK1_SSz7gdVA1MiPVjd9IhrCf4wd8E8mk-9oADg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhnNMHAMIYND0M5bziErpDtJHBHtQu1wU37aUs2S9959U8B-nblO463NyilqtsouAHw0QqxYv-mMR0RtnyNGx6nUKadPcsZslHPWp_tNeipb30x9Dwzy9fePYNRddLPPNMdbNjCBKn3ja_Y_4EP3FfEBmWgUbgml4nRz7oaCgYKAWsSARQSFQHGX2MiAEdAVwOCcgqoP6tT9AbjvA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745721028","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745721139, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('4911baa6-9457-47c0-9f49-09bbabab0615', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745734966, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745738564","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiWnRiWDM5U1JYa1QwVHZTalUza1d3USIsIm5vbmNlIjoiM3hHb0Q4RG92Q3lheGZzVk1GWmQ0ZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTczNDk2NSwiZXhwIjoxNzQ1NzM4NTY1fQ.fbzKhGqVxs1Cq8mHtH8wGKfEaTAyEmDstKCRfQEkGHjf8u8PwyyMpnJ-uI9mhSnMQ8V4WVpksrLV21Eip2tSxeNm5dnXmSkazPGNbkvaAkeKnapNBBZLdmxFHGO7SEIvIn3fjvSG1bK-PlaY_-47DZlBBhr7FPYeGOLd777zd5INH2kJtMaueaLC1qnNz-ooJ3CAy4-7oPxg7pLK2Pkzjf1aSnIq84k0ldGeBxaOXcm6vn4NK5G6Qtz5uguT3buHJ2v-PTj-wpIHnxbwVEXs-6UvQhVPhaXqQm0lretcFWDdlGfbnDn6O3xCGeKFltMvwDfkZdk_6XOR1tgDKCV3nQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhZtbxbf_s97BBCWr0Nf6LqqxQ8alERMlyFkHHa62UY-_eUCdGPhYDSZBpxAf52XEmbt0VVicFBeblyHVbeIla1x0zO2g41wleLaVEiv2WPzoFBRhiL2tN8Re2MbEy4PUCOFYY3WsDSeja3L_YBcinYjaPuAIdlQq_eqokaCgYKASASARQSFQHGX2Mi8MxlONtbOWmHN_PFq4-S8A0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745734965","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745734966, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('09d49866-8a30-4964-a31a-70153315a951', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745898246, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745898246","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745898246}"},"state":"LOGGED_IN"}', 1745898246, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('5cdff061-5010-4a72-a235-0888d1ee9ece', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745736509, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745740106","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiWTBwb1BKcnp6QTQtMVVoaW5iQ1RXUSIsIm5vbmNlIjoic3hXQm5lVTJLR1J0ZkZqVjVYU3dKQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTczNjUwOCwiZXhwIjoxNzQ1NzQwMTA4fQ.abMOEABUt1SBexIxdMtMzNalrmFXUmSgqYY1UP_-rntPU5972yhWtQ8G96c8GaGs-RMykJSgZpTJQ0LuIvk0KUDCH6JvhjPgjbIJx3qB6XU342gswuR--ZqVsAccYS6NLXoe26GjGjxA6R8nQ4fhVqvkZ511APhz6NebHU_18oaXclo_WtYEiUuL_5JmGWPC_le_0nDjL9PzuOcTlm-UHfE4DmBXJ7ZSa1W1bTiYEac_CAtxEzB-q6YSdmpz-tWlSC7mWtBjl4Yl_zca_QMOYlDKnVz7BFP-SCqnGz15rVI6uSLcpRXge3cYBNDQORW7RvgpKkD3KCajbvHXnUiGYA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZg8Z4j9FT7Q21QWYHgDB5AS8G28kXEgZGiTMewx7_BOVHPG0Ctp3M7jSz4WHibZiLTHruSlF-fMIrcF1cpFJ5k3f2JHHP75p6jWZP08OAzWAYC_3sDlHs4rmVk3FZ00oGU9tu0k4rG3dSark4-HnHqMIZ1X-BHlKfwYowsaCgYKAVASARQSFQHGX2MiUlwqSk2q2AGLQcwHBQDwSg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745736508","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745736509, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('5fb231b5-271a-433c-865c-94aa8bfd3776', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745737868, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745741466","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiRDJNdHhybzZnWlZfMkY5d1JFdkJWUSIsIm5vbmNlIjoiZmNZeGxodV9GZEFDeE9nVlluaDRNZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTczNzg2NywiZXhwIjoxNzQ1NzQxNDY3fQ.MobCz0_tbGIwQPM7LuOufL1vA0MtqoVEqUxbULdq3JfAPrvCaFDsIB8Fa17nUF5zbTYyDv2hJs6QIbGEtdNg6S1yqa3pEYs5-bGf3cCQsWar9gZhGUFQ-jNAO9fXGUnGZkI6kzdgLNP8rxfmAmd4qFLI-iHFf2p2RYSwFYFU-_yN4j9PM0c1Jr2DV9a7Jnia2E678U5MVJ23Hnm1s6VhCFJVvY3-XaIrm8JZanoEkWM00bNhKm8BUUUYEqjuVDf1rDWBZH5MTbgveWZNPo3vBixum-fjKNzu-voI5JtkR86gHWxagEyhLkeiODfqDihJpL-dTgVb_CYaT9ZzpUqpmA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjW6uFMgIuomAqvcqHHFqGPN6AMWKSJbBpdrJQTVjPA7YU6SuhuZfxZ4FMvALV0RtrPoln6EBZS-A7SKGeBJ_cTJP68-5emPgs85XyVPT4EADXzLZTSM_bmad78EBikCmC4zEP9REZyLTsv-XPdVZHNYGHLmk4FVXqprB8aCgYKAXsSARQSFQHGX2Mi4XkDlIO8psw5318xAw6V6w0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745737867","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745737868, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('2d7298d0-8bc7-4c8a-ab8a-acbc69fad2c8', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745737901, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745741499","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiOVJzWmRKUTV1QXRDcGNTbkJSakx1USIsIm5vbmNlIjoiVV9qOFAwMGs2anRfVWN6NGU0OEw0dyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTczNzkwMCwiZXhwIjoxNzQ1NzQxNTAwfQ.QM8Aoj2nJXyZrxHOZyLnh9zoi49_sYen0NZWM3qp99g7mDBjI4cKqR8kOiFCTNdFdbmBo6SRtQsGiOdselmm8HFoz2_G44NFF0BWffcPuZQHS_e9k8VXitye23eW2zOyNl1FvMORBVDd-RHD3qjxVjKVDK03w0vmd7mmNt39d6d8alh-05HuLde3vI1fDNwvCFTqRuVn84Zrl_BdDBB1dNnYzA1evsoSQL_DHx6Hx3YKPIa1J7E8hUc2RdwYola2IG2pNjEJd3AujWM7JOn2zS5hsGTv6ZhjwsNAcMTJowcawFh24y7AQxzGWQwhWmTUgmjah4Z1T8845XPi1RY9dg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZh9oalG-khCAmL0bQXofitZXMbov2BpIiW27iHHWSRMIPb6xDtjuloHAjgvVotL8SUA6G2c5-x7Cyx2XU16dQ_9SJuofw5hVvNbo5h81LQLZQcaRcqT1SEuewWpN5hrPluKdFSAd8Py-3W5SSP8wQU5vvbaNSpSxqD_qpcaCgYKAUMSARQSFQHGX2Mi78yoZM40aCMUPflVATuoWw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745737900","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745737901, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('f75a7605-4a43-4acd-899b-637276aa7f86', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745734559, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745734559","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745734559}"},"state":"LOGGED_IN"}', 1745740013, NULL, 11);
INSERT INTO public.offline_user_session VALUES ('0b18f5a5-538f-4719-a37a-390792d567bc', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745746845, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.36.79","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745750443","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiVGdGQ1NkSWYyT0J5dmp3REVxXzhYdyIsIm5vbmNlIjoiNE9lQU1INnlpYzJoTVl1UEdvM2JzUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTc0Njg0MywiZXhwIjoxNzQ1NzUwNDQzfQ.Fu3Y6onhH7Pg5Z_D8wAG383XndPyrpxz7weFHq87MQuIWDoqU0EXKJVbpIW2duWoBihCjiEo0NtVa_hf2e7bdUPsFTUzrAM0msOCGEc8uAsNK7kflGHZPDl5jnQxouBy6VTdtgB5cnUigS2sDOuH0ZMdPJOcznRMAI8aD1ER_njfTH1pQ0GzuWizdmIvyjEyqES7nkMydx0ALsrrfawdP33svc6iNj88iQoaGeP_luER5nvOSS70xEOVKHkRQuXx5HtVsMpFLZ9cHww6ueRecgUwvyPxYCD3ZBYWMQ08hUAR9hcCViBxy5SLeksseRcERdR-0BtBLGnXniqBG_-pZQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgS3gCnStmhnthYrQIVodgv-4FSUtoNpIBRoU9149YTZRu1nhKMi-hNJqY131Gv9Tr0cynKM7OOgbtNP_ite3w4LPf1hJYsgHCvBUvYYHPNfLPOSGk9V7Kboon67DBTgGSz7lbrAABorMa1a8pYG1AorKaFOg6tpcoBXuYaCgYKAbASARQSFQHGX2MiNxbTuqDMqfwvw8OMMhO7gA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMzYuNzkiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745746844","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745746845, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('de214adb-259e-4cfd-acb4-6b18fcf6a53d', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745748264, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.36.79","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745751854","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiOWpicjB4MEVnS0xJQ0gzSktSM2QwQSIsIm5vbmNlIjoiRGllclFqaGZqdnczU0JhOTBZWHRmUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTc0ODI1NSwiZXhwIjoxNzQ1NzUxODU1fQ.YK9KdNaNMOynXUZX8zLPDSvmPzBrj-Zjmsx1-0xseJ-o4oR0iK1rkR7T7OUSSxnddo1IQt-5BVUg7Re-tVwI2cCRcLNbuif4Ioc0_JbzshUcldftAY0uXPP9lAMXT_cjyvnPIrL9lzvSSuLsXT36L3YMxQHCL04xjIY_QFEnnE1oCDyYiOjAHtOwE-Z0qC-1Yc69qFQXKhu7RocAXCjPgDnBl7hCa8blXIzcyEd_H7eIwiZH6W6e81rgxpnPlHmQTTyLPmj2XMfA4AoGbtWStyBPeJ9RGr6kPs0VD0TEog6b8gN3vv0G4qP7-dBAD8kQwafU47sq4i-NG9HyjG7gpg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgKh03sLppfPi2cksyiYRAgFTb2uewUGipW5ud0-dtm9peWE1Ue2w4sN8tHW_TzOTrdJTn-dxpxefTtJIXVaFkpUsHk8xNdCFxbKIK4RzRq0uttq25zITpG0r4QO0NqmGi0iHfPawemHPiFi04zQUv7YNCFQ1q5L1SrSfwaCgYKAZ8SARQSFQHGX2MiqNnw1hk70KxRqQs3ZaPV5A0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMzYuNzkiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745748255","identity_provider_identity":"ptung230801@gmail.com","authenticators-completed":"{\"599f25e9-d149-4585-a620-ceba48d62b12\":1745748262}"},"state":"LOGGED_IN"}', 1745772623, NULL, 36);
INSERT INTO public.offline_user_session VALUES ('1f76ec93-d2dd-451a-8250-cd3ef4dadc48', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745898254, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745898254","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745898254}"},"state":"LOGGED_IN"}', 1745898254, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('835bb029-3c67-4da2-8e5d-305bea39100d', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745721266, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745721266","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745721266}"},"state":"LOGGED_IN"}', 1745721266, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('8d9df0e8-f85e-481f-9881-c0d76bc7f3d5', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745899611, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745899611","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745899611}"},"state":"LOGGED_IN"}', 1745899611, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('0727a901-592d-448c-82f3-3003bfad9520', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745722243, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745725839","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiYlMwSVVMSnljQ0hrRXZXTTNnc05MQSIsIm5vbmNlIjoibnk1WmNKRG9JMVJuVTJTOXJ0M0NRdyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyMjI0MSwiZXhwIjoxNzQ1NzI1ODQxfQ.JFze_8IFzDhvSqqwisHcPyqG1UABQclQrHxFtg6pJtNmcpUYyFg98g5LGuLoqai0HsF0BykGdxzTSm8hdt5Oh9MHxc4yM7gv3H0-ZzgiadzuFn7RYfLYhbnoWvs4BZOcwZHQNK7pHy9ssrosLm62q_k0FzBhPhHM-O0LP04nTUSFxET91wMo448YR98HeOiwOvzdq46DOvIbybbs4AfduSHIHucqE3PtmPzRnY--nLWUfDGLZlaOsxx1RdwcrfkVkgRNcfk-FRopJ2DGTBqR5NRuYpOym3Smi39JK--VzJTIJVn79N3XvQykDeFyS2IWwLsHZn6TbU4wTNfWgsGy_g","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZg61cdS_RLFzUNRPcPF8azE5BrpTBmR25EZgYuOf3ptrIUqjYokk5VyfbgI5WYfTDDVCIKtxKiyI__fjmB7VkU9kBRKPhZaKD57M38HWpiwRaNeWxagZ3KM1U00dQmv7A2NUmHYchI5uK6Nxoq19pggCaqs4FimHIWGC_kaCgYKAfISARQSFQHGX2Mizha1KF37BSYPvuUmo_f5Kg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745722241","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745722243, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('237ea8f7-1d31-4f46-a595-2666018f7f5c', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745899629, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745899629","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745899629}"},"state":"LOGGED_IN"}', 1745899681, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('4bf5cd29-e79f-4164-af9d-ec62f8250391', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745722256, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745725853","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiWTlfR3BpRUJuOGhtYUg5Z0xNTWVBdyIsIm5vbmNlIjoibFdLMl9ZdTBraWhtcEw2TmhpYTljUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyMjI1NCwiZXhwIjoxNzQ1NzI1ODU0fQ.FVyllnH4MU6M6SH43oz2q2uIYAY7KrU415-FDxYP8LPf20HfecW2qDMnVhfcziNhLrjktOEd6aoDRcppLK_e6DgNQ9oiYETFEWIJ2bphKjdvEV_lNgQNqT7okChksoW2h8-VQFM8d_ABRSJQWlDKVWUdnK27qobuN-8ZqhS5dQQRs16NkNXsNkAkc4prDSJbZhM1790o3D6nyX5jcyCTSxUaMsG70bbwbiHcZhkR1gvUtdD8tOlRw2G2CbDvMjvir8XUnwk_xeGhWRn8isyBz0zCCD6qIK1x19-r0PGHcLbUjt_sSIuCPS9bfs-LyrFquLMjL4TBJu5Ch6Q4n772tA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZiQGmtXtSYaE_SC88NCT9sW3Vls7zhZt0Qxo3d9DtYyZBy06i-4YMHwEJykiQFWYr-UgbOp_aCo9rQbpN_FeAfJkVg2SG1swiSmaCxES6PKZpac5aqdk6CzG1T_DfoNa7Nlsl8cRjxy3MIpqSV5EJzDfOVJDXVkzIqNYoMaCgYKAUMSARQSFQHGX2MiE3EdJOdTkI7gmvkdPcQTmA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745722254","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745722256, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('0a5e89d1-cedf-43f2-9f74-2921d6b29cf4', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745722550, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745726148","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiVl90SlRPNUdvMGFjM1B5R0hFN2JvUSIsIm5vbmNlIjoicTd4d25POGdvbjFodENPNnZ0Z3dFQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyMjU0OSwiZXhwIjoxNzQ1NzI2MTQ5fQ.HY4R_r_b1i9bbQgEXJ7IgXPE8rJEQ79gbPgFVPaU1UfOBdt_iqmydFs4UTR5Q38_7qhw_yxFb0GIKIE_kSx5zm0BTR8qN6OJTGTszdfIf4QZJAELS6q5ITlxZzJT0bIuaoLaZkwOY7Urw_E-Qmw3FLTg9ZzJk22ktkHhy76Zlfbq3625oReoQv5qMPBV9CqyRLjNTvSUUiZr9-kgaEnKqjOAz13V2iXOSxEuiN9R_iJ4BPOnD71wnAQzpKNed6I1IeXRtMlj8jvzEmOzlbUGliDu7IJrpPWD7Rtq9fumvPe2znOhPqTUFZReN31NR9yoyxubNqEce9bJ0RDdem2ORg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZiXLy9Xsdlo9F2SEl3T0cPvvfdkqm5J5mqbqF6-ulQaLuih4bEjYgGnQAn0V1euBS7Q9qtW1vje9NVyqt50dXZTGXKZDCwYBaec01DrvAw84Xd1t1haSV7edH6tyGmD9_dU-4SH8rb-ti1F6KnUh_Y1nEnc91g3S-kR4AYaCgYKAWwSARQSFQHGX2MiDZs3cbA9AXJNdX1xdH4--w0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745722549","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745722550, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('00d77880-c719-41c6-a5e9-66bc5a261353', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745722558, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745726156","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoieDBBaVZjUE5SMVVwcWg4X3ZjWTRTZyIsIm5vbmNlIjoieDRLVTZlamNza0Y5WEJVd0t1RVMtdyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyMjU1NywiZXhwIjoxNzQ1NzI2MTU3fQ.ef5ObHLxK-s1NzUa9jRL3RuDNFWu8yVtZhWovy94LE2gX7XOk_1flJZJOy7MbIBT2d4fY8urlUcn1FRnuvw4s-pzOnWmtbUGXH1OwWJZmJoXELyVIiwfcSMs6IdRhAoiXfUhtQfoL-b2aXNfcXe8swF9b5D5JUUn_VUNRGVbSEfwy9MJBbuqA1Fi7dBtNFA7S1YiHl6tOQ9JN2jAM5VDHJKmm7AjrHfu4VytRDlQCS-8CVs6ixrtUoAz2Zy2C5It8m4GgP8XQLcsuhvEq5HfOsF-Q5ATEpYcS_ISF2WkWHf_9nbwAstiXhqkrlWU0AtISGo64y5iW84YAjm2qaepkw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZh-cAlVFHFx40CAJEl7l8XxQTEz1VPTWQF9_n0Pmis4ZOHw8kZloPcuE0CwleaEfz8D44pZTf5SPF3J8QpIO_05r8HPlaAuzs5WL8ZOY3munJ37nF3OFnpv-WWy3c-Ki-1kdQXVyxkbkvbynDVT0rDk-QaEwdgZUTa4wCQaCgYKAY8SARQSFQHGX2MiqwhJJf-HXQetNNPwoyFn4g0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745722557","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745722558, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7262aa7e-f6ce-4ae4-8d21-ff91958f02b9', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745900604, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745900604","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745900604}"},"state":"LOGGED_IN"}', 1745901921, NULL, 4);
INSERT INTO public.offline_user_session VALUES ('958215da-b7a0-4e55-8884-0f43029b158f', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745901961, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745901961","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745901961}"},"state":"LOGGED_IN"}', 1745901961, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('9b09b151-5f4b-48fc-96a1-41346ea8ccb5', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745722821, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745722821","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745722821}"},"state":"LOGGED_IN"}', 1745722898, NULL, 3);
INSERT INTO public.offline_user_session VALUES ('b2a366fe-1ba5-4e0f-b81e-37fdbca11e9e', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745723270, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745726868","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiVE5jNVFPUUhVdF81dDlWS2g1ZHA2USIsIm5vbmNlIjoiNWFnaWgzS3RseHRVUEhNU3I5U0NNUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyMzI2OSwiZXhwIjoxNzQ1NzI2ODY5fQ.eySbKhtkCKhYS736qACF3cSGw8PxMqYpNWLB4HFXXstPqI9EnReUs1V0UFMdLeK68TADQbduGJD7URkQx66njQcsg1Aramsmz-LK-aNNTxgYI4at33VyTW18KMiu7SBQMNq54nrxZubdp5oEl5AofDQ4RrP2EUhjSvybr4VuwRJMg-u0_cmN59X9sRqB1VTOqS8sgVF9wb2YZ8uV-11OcDzqFKQw4jNOxehgryGU9CE3hU9lPX4K-E76jAFTQYSm-k4VzUKFi-HJPTid0yLUJAH1TBBQZ3nx6tWEpWHs_4gXIj0BnygzDXCw1ySuKgSlZQHZGg5Co5oWni3tW9PgAQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhKsrVv1aDi3nq2vEOBqpblJYzz_YEDbZmSOsEuCH_HNym2V1SRo4eIN5JOhx7a1tYwmVrCqdqh506bPjfUwUROzu5mslyQTrVKotMJ2us2qpXNmBy6Evv1gkCNNGgupG6nyAux9bGcOYwb81neS8txiuRF2F0PMDbOd0oaCgYKAVYSARQSFQHGX2MiPt_K16Ab2XQXcEvxUhUCfA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745723269","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745723270, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('32d649fa-b6a5-4dbc-a61a-3292bd831e20', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745901965, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745901965","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745901965}"},"state":"LOGGED_IN"}', 1745901965, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('0ba34d35-712e-4dbc-b6b4-c374406f653b', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745902122, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745902121","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745902121}"},"state":"LOGGED_IN"}', 1745902122, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('91fcbbff-9fa2-4087-9c02-875c2304a7f1', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745723423, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745727021","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiQW55MHhkeDg4WDdFYW5OQzFLTVc1ZyIsIm5vbmNlIjoia0NBMVBVRm12THZycmZYcUZ3RnYzUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyMzQyMiwiZXhwIjoxNzQ1NzI3MDIyfQ.QpT-szj0DAB22-VZZ8eypVC_CoVOSyAhUEoXrNZNlAZCrb6b4XsAudkBhiDZUmvxSkvUrzoaumosstfTXqxhwYTC6aZpLnAFfjSLQNBCjc_xinA1BfX07ihzG1b1Gl7cjGHnqi8SkWnwobwrXod1yYbaJlPYMPeSPizllYrhyahXr4mhnowNtD84vKGMB4Az4H_bpQbHylHs1uoxt73n7_lw_kCnd2nexX9uqDS5zKB1xu0cD00ALgB5V20Imo4JK-6umcrF5N-GWNOWtcbruvcFmdXe49ltz6DDGugRX1VhD6DrBzWTbgrdQD0V6FXbJvDj5duAVN-zr63_O_gLfw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhA18za4sLEofhEbc8tpIJu0wIyylviq5XkHyisMbsjjqm7-s11_LkXSZRsYij8QmoAQMB7WwcN6-CJE-NLHd5ZWXh6uJN97h3imbs652o0g2CxE5KCSuS6PObgngdFn_Di6HMyI9OsD5o_I7WkYY5Gb_mzVOo_ZQee1GsaCgYKAdkSARQSFQHGX2MiYlBK_PwKIi_oGYbscM1JXw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745723422","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745723423, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('8bd272fe-4add-42c4-b755-f1fbb3bde124', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745723325, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745723325","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745723325}"},"state":"LOGGED_IN"}', 1745723580, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('e0ab0b0e-f56f-4f0e-a905-50b3c5b588d7', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745723845, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745727442","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiUkE3TFhsSEdHcGtJSnJKaXI3R2tDZyIsIm5vbmNlIjoiUVlxX2FoaEFEQ2dsMC0tN2RBVTNfQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyMzg0NCwiZXhwIjoxNzQ1NzI3NDQ0fQ.TnxEdGmZv7eG2IJUb0S32V-MwS9-Q462hFIIWr4zYdJIooRFluWr99cVbNeCY7SahpoGEfpmlkog58TyfO89S69gS2fEKS_ox6lQRbk0r9fMIeIvYZFdHB2MvjmQi382zENZDgXpieaTaQV8P7659iwxy4wF30WkvOGepfdYYQB-3TL7jAvNa90DjgFqVZwiylLYYzvhT9pZTtbVSRDkdh4uekySGo8Gux70WdlaMthDWB0ku6w95crSj38l9hh1-x7kFO31JymJG764i-6HQlZylUvjs1sp_0UENgZ2qsChLwe4LmR9l3FEKNHh5QTaBLZMLDDR-KBdhrO1Z9KNDw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgOA_2KFdz_rvfD-VBZ8ytiHisvZLyCInikBGmhXZKgC5CTzwJVClljiWpRbi_OKYUOdKtAf-XFascBDkYOtGBTVW4KegfRjA3ZG6pBSlqAaLB6tBsD9OfEaxFteezYtu9TbzpuSXyNK__2BZjOTutIudLEeJmtFI2y_dMaCgYKAXISARQSFQHGX2MipEtzcxqQoL4sF2JabQyPMA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745723844","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745723845, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('dcc408f3-615b-4ec5-b240-d20a37812484', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745723856, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745727453","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiOHd5YzB5SWhFbHlsaWtvWHk0ckdnZyIsIm5vbmNlIjoiZk91bDFkRmk1QVctdnZ2M0tvS0p5ZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTcyMzg1NCwiZXhwIjoxNzQ1NzI3NDU0fQ.OEu197flzZXJ5nF1jUmxA58EpLZfIOcHud7p_zEr1BlfLBvd4koMdb5TGyOR3ib0IBkrJU5taGYhVhyjUyC3o89uex4p00oKr3ITDayv3ymT6Vpgf08yIMekThgij56DeySBEvgla0QZPeo1mO9G3OJHXrYShcgNn0ObKIucv4hvNKZpLWxntiVYF-G8YrGchzEJuN1kKqL4UREu4eXDk6ofg69HTiIpI8ts1R2tKCAJULXzvPJVqrrlbpSy-tDMg2mtWGpYZ6bhYRizSceGF5e7uNU-i88Py6XXOD0h3gwziH183yyVm_WHSs-VD2cn4TSySap0WzLqzTwFq9dExg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZimshclw3kib8XPPiIugf77YyHgML4xLI8C6tSqaAE0tRZFEtSKGexSnuIJIv4I_TAlfI_Too5e-4dNjJ-LcwiyzljhX143cLOft4adRBSi8Z9bJ4UkYBeGfecDoHkuf1RTzIinIIf43pnkKkeNI80Rk_EQR4zLg-GYY5oaCgYKAZ0SARQSFQHGX2Mietsapv-iwVgnERoa0DEpnA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745723854","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745723856, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('bc02beaf-d3e2-499d-8836-8d908d599f00', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745902414, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745902414","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745902414}"},"state":"LOGGED_IN"}', 1745902414, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('b1f08e66-1b7e-449d-aaf2-e3adedf48e90', '4c50b1e9-e68d-4dcc-af55-90239c585a43', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745902547, '1', '{"brokerUserId":"google.111360646318490639273","ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745906146","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTEzNjA2NDYzMTg0OTA2MzkyNzMiLCJlbWFpbCI6InZ1dGllbi5kYXQuMzYwMUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6IjkzM2c2Q21pd3FWWmFjdmxiY1dhcnciLCJub25jZSI6IkhWVkVXYVJReTJ3ZVFiRE5uR3lTV0EiLCJuYW1lIjoiRGF0IFZ1IiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0tyOExRNVlIS1p4NFVMZ3l2ZkxBek1SNnZqQ1U3a2hsc08xUHVnTHZSSFhWU1AxeWRZWHc9czk2LWMiLCJnaXZlbl9uYW1lIjoiRGF0IiwiZmFtaWx5X25hbWUiOiJWdSIsImlhdCI6MTc0NTkwMjU0NiwiZXhwIjoxNzQ1OTA2MTQ2fQ.AH7s6e8auTRc4wiuCsIExmtxY2sHarsZSozw-IrhvGQTuFv6j1gl_UZwortzJTQTPbA-j5LVUXoyxPuGvCctQ-_bucPkSkEBSQ3o3hXvmZ41vycWGVCtxad0dtBx31lQFKhXU3Bxa_RAwq2sR7lKBhPHGa-vkLmpL_uIyYve-pzyxaVzcqqoiA2Wl2WIvd0r5zq3ymYys3_LhBDGzYFZbk-oElqpNDO8zcOJSuXOta-ysNTVbpD7qV560-rI66wC75mm69hXIsN4jEQ_6apSzfzZ3HEkvTzqjdjebZUy_Cs7AabZltWCZScUn9HeGVbT-jdQs3uVyJWMmk6T-d9f7w","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZi3iwpORfvKSMzqez26EfgfIrln-J9NiCUycgyzk8Vq6c_HbvmvYeY8GIswCdStfwRTrGlwGFNg2IXH5bgDpRixn3zB62Ver_eYRnLD9_FKEas0FqcVrCC6Cp41bVJE7zo3vT8cRMLmrGSkFTbYg71Iy_M3y02CG1VOtiUaCgYKAWESARYSFQHGX2Mi21tQRk3oihjIfDEZFc9zyA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745902547","identity_provider_identity":"vutien.dat.3601@gmail.com"},"state":"LOGGED_IN"}', 1745902547, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('879c7bf8-7522-4f86-8ede-3c3bec191043', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745907116, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745907116","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745907116}"},"state":"LOGGED_IN"}', 1745907116, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('132aba6b-9458-4725-90df-d276f1099be8', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745923977, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745923976","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745923976,\"599f25e9-d149-4585-a620-ceba48d62b12\":1745923977}"},"state":"LOGGED_IN"}', 1745924022, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('c973df58-d56e-4a30-9877-9f630e04a9fc', '82e87c6a-1ad1-4fa3-98d3-f8cc366b030b', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745902836, '1', '{"brokerUserId":"google.116149246634223445701","ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745906383","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTYxNDkyNDY2MzQyMjM0NDU3MDEiLCJlbWFpbCI6InRydW9uZ2xhbS4xMTMuMTQ3QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiUmJQWXpCc0s4bC1RRlUtaldIX3RzQSIsIm5vbmNlIjoiQWd0ZWNEU25IUUFnU0Q2Sm5lNDAxZyIsIm5hbWUiOiJMYW0gVm8iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jS3dCNTlIV2gyVFlvY0lYSE1KUnhjc2lPZHVOY2FFbVIxRThCZ1hzNWtHekNmTkppaGg9czk2LWMiLCJnaXZlbl9uYW1lIjoiTGFtIiwiZmFtaWx5X25hbWUiOiJWbyIsImlhdCI6MTc0NTkwMjc4MywiZXhwIjoxNzQ1OTA2MzgzfQ.OYzuVP8cQMltWRnR5_Ew8YjF3z7tyFLFUzfFJiH-gqJzYdZ1ZiLHyQeWenXsNcCSSPiJh4xIG2nzTLE-rRhduRV_HyRZza2RvFp3p4Icq0DogVlFTejh8GRJjyAh4QlJOrCqM2u8THLS1OVd5aq_NJyK-cIE4nsYTVR3bi4kmAp_1jSnyw9s3CRtjW0ueWajZg9kL0_wGKVOqjfnUUPZfjFeoe7NewI4ppjeKAjvMYwrVWWPb1gnq2Bm4tGAw5HI22csCPyTTT80RA1C639lWCun2pKmkbbfg3uJWOBGcVjZP_sKXvUh1_M8TBsaMlEA5ArGXoTwJJNJ45rIG2wThw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZji2orKjg345iXaIvIPB4ROcY23en42h_ak62BQVlBtO_Pg-G7krEyJewEnFiE2ZkC5O5j4WfbzssYUSb1IFC9VriKMRnlak87vMDwAFHA3_a-dGlUGltMi1pvND-8EmOAnt5BnP05ShOh6EVDghgdd_Z_Jhvs_1ZnuaCgYKAVYSARcSFQHGX2MiOJZHD2lZxNic1ImP7fi1EQ0175","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745902835","identity_provider_identity":"truonglam.113.147@gmail.com","authenticators-completed":"{\"909cd268-e0a9-4015-b0ba-26a240f79d80\":1745902784,\"98296aa5-267e-4c3a-9723-e8d030ccd843\":1745902784,\"599f25e9-d149-4585-a620-ceba48d62b12\":1745902836}"},"state":"LOGGED_IN"}', 1745902838, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('4d582828-383b-4fa4-837d-d3c3ffc8acd4', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745903573, '1', '{"ipAddress":"103.199.56.170","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU2LjE3MCIsIm9zIjoiQW5kcm9pZCIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZSBNb2JpbGUvMTM1LjAuMCIsImRldmljZSI6IksiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOnRydWV9","AUTH_TIME":"1745903572","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745903572}"},"state":"LOGGED_IN"}', 1745903573, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7b8c420e-df78-4f1d-8c09-9ef0b510795c', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745903588, '1', '{"ipAddress":"103.199.56.170","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU2LjE3MCIsIm9zIjoiQW5kcm9pZCIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZSBNb2JpbGUvMTM1LjAuMCIsImRldmljZSI6IksiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOnRydWV9","AUTH_TIME":"1745903588","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745903588}"},"state":"LOGGED_IN"}', 1745903588, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('d8be33c5-cf18-4766-986c-7049eecc3408', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745907088, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745907087","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745907087}"},"state":"LOGGED_IN"}', 1745907088, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('ddba2025-f0b2-4c20-a106-c3ec396fa9d3', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745942871, '1', '{"ipAddress":"104.28.205.71","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDQuMjguMjA1LjcxIiwib3MiOiJBbmRyb2lkIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lIE1vYmlsZS8xMzUuMC4wIiwiZGV2aWNlIjoiSyIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6dHJ1ZX0=","AUTH_TIME":"1745942869","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745942869}"},"state":"LOGGED_IN"}', 1745942925, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('29175639-74c1-450f-93b2-dc02f39fcb5f', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746061957, '1', '{"ipAddress":"14.187.114.104","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNC4xODcuMTE0LjEwNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746061955","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1746061955,\"599f25e9-d149-4585-a620-ceba48d62b12\":1746061957}"},"state":"LOGGED_IN"}', 1746063370, NULL, 3);
INSERT INTO public.offline_user_session VALUES ('1480741f-df1b-47df-9365-e84d6406738b', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746065609, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746069206","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoieXlnb3V6M3kyLXZidTlwM3lKVzlldyIsIm5vbmNlIjoiLTd4VVJpdkk5VURZTGo4QkpkM1J4QSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjA2NTYwOCwiZXhwIjoxNzQ2MDY5MjA4fQ.WALkpt_gNGDSoi1DjjXWYeV0RhUkrsJ8hw5zaHr1Otxp1fw9J9-EamJAnXmGK1HLQqy7X88_w-R7KYhKBKL0BwqNhaf_hHXyLyK8y9wvgXUP7fVoh0xxKGP5663zx1awYAR6oCsWMpfYf9z-W_6XyU60ucdHCRRXu-p6pAWpDSSbjJQQP8h8Vw9yjO6VrLPNocDdDpCS7DAI2l2FG5jq2zcBNoDi2yYVx8iEhJ1KrwUJIWAsGt_bSAidGl8m0Gbsu9OFRtcIGw3aUbX8Lh2TtF6ZHOFJo7-XXsNv6iU5QyEzH0fCZPpu49kMolzNwYWNfqmAgw8k9oj7s6R21eb82g","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZh-Q-bpOTPY0NkoUcsdrAUD4EThJpS8y5sMrMHOWcs37jA6wj6gDG2tyqFtaPt0CNPNlIF-DeXw21Gy3-1CXATwKEKEgI_iWa9XY6ZOCbkDbXT51sEUxHAPtykkyNTLRP-bK6UvCZi4P0bnv3wgrih_xjgvfyqPHQFpW2AaCgYKAbkSARQSFQHGX2MiYP_KAx0KB0pXGs-RN8H57A0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746065608","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746065609, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('065a9914-0ed1-487f-a03b-e4336229136a', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746067082, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746070679","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiZGtCMkFlX2VLYjhOeVhKc0EzS3Z4ZyIsIm5vbmNlIjoiY1ljNlZqaF9DZDc4LXItdl9NUzR0dyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjA2NzA4MCwiZXhwIjoxNzQ2MDcwNjgwfQ.Q_ULC9dC03WM7CJnVW4ts8S6srQS5BVYjYRUNhthoJ2MiKYNUzCLnlkyuCbOMStO1KopsjVu07OW367Mij4rJ0N2exaeC6INr1pu_SUjMHfwGTPBBLXitxt23N3GlT8IIhqzJBtvJSg55D6wVqD3tHujGNZxbJBHWcFmgFMsT6oPMzDhs2ETIYlpaWlg2wX5kXnHVqBd7QGc3jPcRBuQSZcVwGgwfAuw61O4HR0DrQ9rLk71x2MDaSA-egLKcviEwRQ1FSkeep_SahAMhZQ14H44nhjEcXZfNeVSQOhJptZidXJLDKerwifEccptXHvi_Pf-YgGGp2AnjnX7Su2tfA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjwiKB79QXFwoDQ28zhnH7lSLfY8pEv28fiN84mFsFDakyTHs6KS8OMTlBQ09ttmsT0OSosVHnIg3m2pv66WPIc3W5o94PLsdzJXVRbFikVLB5okcbkQSSL2abNcgTJBewQ3yoQSUjDHItDdII7ZskPiI2kVseJD9jDa7oaCgYKAe4SARQSFQHGX2Mi1Q-pHLv5hnDbgogH3UzkjA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746067080","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746067082, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('423d5439-87e5-4cad-b479-96571eb066b7', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746067102, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746070699","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiNDE5ZENxQjl4b3g5NzI1QVNJT29LQSIsIm5vbmNlIjoiUTRfQUMwb0FZaC13NEJqTThOREd3dyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjA2NzEwMCwiZXhwIjoxNzQ2MDcwNzAwfQ.XGJvQGnyuiCRMnGk9rdsbro_8tvnSYCVAgx6vbO6DqThzj5WtBETfYnOSf-A1OrykTLDEVv1o8Ia2hoawGWQmJzOo0mfz-CgxfhGVNyZeencuxTnBhyKwjumKSlgiEKUYlKN0I1auQS1EpQBytDPOJgyx4xJVzOZQn6prpeS_jpuuFABqtVCyzMdB8qqNqoygLG4UBg2e7PBiLO2CINoWXSkqh43gvsysGiMDWAzMhd7aWhen-Y_WZ9B3ucSyxkPTQWcYAgX1987qQnNZzRTASTVKlkHCx_luZ_O7yLTOBYrx5K0AEzmziVCuu8HyAYhrQ77l7hTsn0fahnygzbiHw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZh2Xlfev1tBl596i7q-LMovniFG0bO2EH6oPQ7FHXtlB1QM-uSBRrNsX778r7FtvPkkg1gN_aC37hVH4tRi0gYcKS7Pc9-qgZ9kGTZAXn2XnMw2_H_NVLTEiS5Hi_RauBFaEElcZXXOG3xjmFOxrlYaF65slmgrieU1fnEaCgYKAXQSARQSFQHGX2MiG8xCU_F19gkUXaJ5-BfVVg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746067101","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746067102, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('b5f3f9ed-0296-4b42-b013-f936ff9a9088', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746068633, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746072231","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiOF9OMkFHbVI2LTNadUlBSHBOY3pyQSIsIm5vbmNlIjoiRElyN2diSTROZjZSaEhYdFNVY1VtZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjA2ODYzMiwiZXhwIjoxNzQ2MDcyMjMyfQ.R9_0mFpe4PsMW1q1EU14U_29D9oCMFjjP9sG84c3OOEP4BzpXgm38tVjP76agT0_GSmTpBpp_mvuQ7n2s4QBwHk4j-25WegFRvrqC5A5zL468KGzUKmPfxnADSAliwqDqeF6IbKzE20LwxwemGktnx1I5AEpY0YZA1JD1TYfRf0nLl8XGl0gB0n01LYEI244egYLXL855NVN3Vt14ku3y_W46JrqEDH3ov5HxBPGrJTh-PPiB78c4xnV32mmy2u9pdv2yT5Y4llSfFxGw71w_vON6_3kynoHRSaCN0ViDLlasaxGgAtyrNZuJUE6TF-xSjubXJ4WZL8Jow4Hkg8xWw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgD2pV-55YwRjbKNKWdj89D4ghpTz6KTj58zQHVPK-1RL8HLZ1KYxufBD4SQGH5UhVFWj40R3bkFFIqEzqkvbeYNfaLoEIB_wCAZRMRuCFXfkxdESWP3b8eWHpDNj9HBLQQQN18iXyqKANg_8a_EE5wcY8H8T9zbUBHdvMaCgYKAdwSARQSFQHGX2MirOE_v69sXl7F6FdSjLivrQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746068632","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746068633, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('98da45ef-62c2-457e-bf6e-9c2a63aa0957', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746068641, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746072239","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMmJfVkpOdEhGMXl0S1R3Q01Xc0k1QSIsIm5vbmNlIjoiM0FMVTk3YUFHcUVUU182YVNNTjYwQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjA2ODY0MSwiZXhwIjoxNzQ2MDcyMjQxfQ.U5lDBoiigLNsJAcS_Nc6bK3HRWK9R4H32nzAB_VWXd_JNMO6Z8f5HTvhQCZpWm1c85VWN5VOuvsqEmppG1iWBJr-aoZmqCYtbumFdofh-2hM7RzM3tfqTBUsZMkqyti2GF4ZXpZX_skjkYDmJ0SAx0W9QZdifpRF_Fh-Td9H2vPWCvI9h3enMh7iQuyTAO94hDoumudRj0HIPQplUzBi1yuEreVQs_jMjU4xV4nSqyyPQAAosutueCmAaTNuAmU2uPFdk6YxgwV9I4QTK7EMteCuV5mhixMhpClp1zKeLfDTm4XLzesSgg75Ksh7hJD3JBU0IUHIKNe77u2OTtNHXg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjyY0DQh6LIA42_W48xNHKufF2PgeqBhspokPVfmRwRyKrEfk3rOHyVjYgeY-w9qvYop_zIFEzvZUAYw_tPZ_qW6-FHxhw3mjErhyYryMAXRElOr166JUDtbRl-5YIS7DxRLpaDJS27ArTs9KnXlalZvcWE7NUtUZwZYFEaCgYKARQSARQSFQHGX2MiaFp8OBeEBGwQmywiEJGLHQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746068641","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746068641, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7cb44162-fcac-49e7-83da-4bf184584d78', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745908564, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745908563","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745908563,\"599f25e9-d149-4585-a620-ceba48d62b12\":1745908564}"},"state":"LOGGED_IN"}', 1745914011, NULL, 19);
INSERT INTO public.offline_user_session VALUES ('b6f6a60a-36dd-4516-8cad-2c31fbcadb46', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745919036, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745919036","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745919036}"},"state":"LOGGED_IN"}', 1745919082, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('fcfcf91d-e0db-4c7a-8d21-5fef7ce90deb', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745919020, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745919020","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745919020}"},"state":"LOGGED_IN"}', 1745919180, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('c3f50521-247a-496b-9c9f-2fedd6e7ac5e', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745917672, '1', '{"ipAddress":"171.232.56.134","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU2LjEzNCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745917672","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745917671}"},"state":"LOGGED_IN"}', 1745918956, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('9cfb58de-f592-420a-ba76-db283c71ac3f', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746093493, '1', '{"ipAddress":"27.74.116.198","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIyNy43NC4xMTYuMTk4Iiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1746093493","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1746093493}"},"state":"LOGGED_IN"}', 1746093493, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('b2de0bfc-a7e1-4d3d-b28f-dcf1cbd8e7fb', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746239705, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746243293","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoidHpEUFFSbUxRNTJMTWc3aFZHc09WQSIsIm5vbmNlIjoiWWstZzh3TjEzUThGRnJabWV0M1loZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjIzOTY5NCwiZXhwIjoxNzQ2MjQzMjk0fQ.tch7lwLQlkRpRShlpAABqhTcgCxvZkNSK2e3FQzmWLg43SP0wVZF1VBmJkZJ0Cwm98BccSMqG7HKPeOEyAJybr545JX3dLJzNUG2Sd7Vi9VMOeXJyk3V6j8u43mxsgZ1xwlMvBWWpTUOfGNaC_qrNZ7jLapPeOFnNTRGMne5bxvJYH1liOo1o3a5kLOl0Ug1kIRf0LvmyOtzeIWlISmG1IZYLI8VKt6NRk5AZj-4CsLku_mm17U-sumddqwWkCH-7JZeYwpoFb_j7EOaW-n3FZ2xMKFZ_kcK5r77sQ9ZeJOxkgI37OFOBsnNbOKavB2cRqwcgR_kmnX62jk7ZJjT3A","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZg4v0SoNB3Dw7We_QjR8seBMpF5OCGuJ_NBsRip0LvuTJIuf8s61dIClde7Pgzi2pOOR32QWVR-twU6LWgL0dynYIUSn1_gQ3ADRjMr4q47-gaBU53gQa8NS7K0tib6FDFTEcPQjPzg_4girvXIlZ-3xp988ujXN3PXQS4aCgYKAZoSARQSFQHGX2MiPFURFAk04ht0Jcyqh3vo5Q0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746239694","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746239705, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('232ce661-d383-42f5-917a-a2b94ec34532', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746241083, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746244680","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoibHpBcGNlU2pQVmV0ajkzb2xab0VRQSIsIm5vbmNlIjoicnV1S2VMQVduekNPMWtkRXR2RUVDdyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI0MTA4MiwiZXhwIjoxNzQ2MjQ0NjgyfQ.yW6Kig0d7J9rGZkMEZ_IdtSIw0pDt-g5mGkcA_3WS8l99jVL28bSUW_JaCq0BHH9mwtuQ9UZnv6j7Dm-jto831nxVCXv6I4FFH3MaO78TlmxwM7TDs4B2F-m0R8xYv_e9gAnSCpdm0VaUvtOHEpDpDrcSO2irTy0FcKHWvgPk_eSFr2OrZ8O-kdv8DrylVlAlIFXYruTNyEzf6aJ9FOuUuK7j-gzwBrnFoxh5S3PMDFfeDcsi_xHS3FX0gqxTvX2LwPE6y82AAuneRDgWrqzNJV8CbRrddo1afPUtE0PLGQYry77s-1HaVdSuRrQYeYESAF3vM54ZSpelQjKftzXkw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhZvzY6dO3DPetJ5wkgLRnj8I8uLXHDvvySDlJ7mTJuKACdD1PrafHv9vsxMePCSFeud4-_K_56EM7cUpu5gDmc6Eak3Ra83DncTG-GoaRU7A6zyLoctHxW7mwkYfRNOy6CeQx6xs0ggb_nCLdZXVdGwc77oAFiCY2FqywaCgYKAbYSARQSFQHGX2MithqdHjA59PE0Wn4ZbUVvvQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746241082","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746241083, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('c176b22c-210b-4fd0-b3ff-4f438c3a6b81', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746241090, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746244688","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoia2t2VmlZejZMUkhScnczam5rZkpQQSIsIm5vbmNlIjoiQ1NzaDRSdmxxUEJXdFRLN05hdi01USIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI0MTA4OSwiZXhwIjoxNzQ2MjQ0Njg5fQ.iKgE3vl8CXvDZYoUcU-yMYTheOrpkV3dFowUaEWCwlZDx42sox3fWoaPaaDDy2SymVTqsmjZvaQUGxoEDdWWdBtpdtuxmxe--1YXxFJ24rtp_6bFn4EQfd7L_TrPms46zEWsMFPfUtiBb7iL_n87MepCJbzcff7WPgin3W9F1Bpbz6w4KzEazlIG-vixFD3BnynVnBr6dA0TyDCN3FN7ohGvRrOFZ2ZjBut_s5Kl_MaCXXxN9OPddlbz3UoqyJCGITkhWQsbTTPvk2mrmkS5S_IiF226EMyMMxbOoPj1T9AXpn6tyWCLk79wgwdA_OlLQYmhcgJc8P3wZNbn4huTiw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZi67mwsY4Fn8ZvsjVLMbiJTf907rXrjyJCLu81ZK0kzhVGNrgbqw4FQIa7TQmvTa5SW9E169HHYZTNAJKi0V_aE35AHtpF665Qa7JMyt1k57ocKk44d7NS0fr5Erol8l7_Xc0IaKNNqV0K_mTefX4EeRzAS78TfyLLxdDcaCgYKAWQSARQSFQHGX2MiD6q55d1syB5F4qzYnkN1QA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746241089","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746241090, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('d5fee6d0-16d2-4777-beca-9dd5f8c25226', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746252657, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746256252","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoidUtkVDhCS2xseU5rRDk2UFdzTEVmZyIsIm5vbmNlIjoibjBwV0hWbERQWHVydEtOY3FtZ2FKQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI1MjY1MywiZXhwIjoxNzQ2MjU2MjUzfQ.NYJVcg1-FicbdYOu6PfnYK4JvaU-fQAENE3bIti--GHSAI47yxq0YqloCixayGJkqeGKZiNEHNufV2q4gy8uk1-2m6jsoZqodmWTxRe2Qemey-AHFSQeKTYyurv5ocAhbBcoc8VFvl8I1zQsmCx89pdjycdeIh53JTvYrWKVS_dCzg4qVidxEZ3SbKrdGv5GNjzESlErIPzez2BCXvBXR2UAI55x4wxhzB6oQKteZ0iSdaOovWVATvSrmDvQu30cYKGohPa-wUCL6-Q5lvaZ-c9fHI5Yp0cmlkXY0H0w11FpTWoMiOCtGL3eOIW24w5u1doSYNyImv798oxubC8RSg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjzzE4ElENhpWCpousGIRVyVP0kkGO_kChLeiOO1DrGq73VlVavZf7ycRNQtdJhgnU2DDt1JoLVVdEDuG3AR2AWMlkLcOxHaBcp3RbmK9wG9jPDK9K-sIRX782NvGCm32Bd_2ykT-uA5DtXHkvZcAJi5nJagSUHmytmNeQaCgYKAdcSARQSFQHGX2MiZ0DRa8VIZ7ppWxUJyZtnww0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746252653","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746252657, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3446ec6f-5e6c-4cb9-9361-25ff6ee80992', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746254045, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746257642","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMlY5ZXY4N0M0cHZwX3pyZUFxNmp2dyIsIm5vbmNlIjoiNlRzSktBSzJxMTZrUWdfRkgzOVRIdyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI1NDA0MiwiZXhwIjoxNzQ2MjU3NjQyfQ.UjoVRKQ-ZiOiYOHn1DvJbBPFcK5im7hepzCMIVlWZDlKa8s79WXJpQjPC2uJmbvsY8HFY4CkLLsoOENFnbXSf9ljp_HOdeMOMZ5KF68y1qd_POtH3D55SA2Y48koa12zoi56-_XWMa7wLb4g4fjVEYksXWFBansQA_LLWBYh8ZlVp5OaYLgpfxMbIJExnF1o4L31XGIpK2tlRhalkG16J_Fgtl0kmwfOWV99GE934UpJb87QdTVi9421-c1fqFCmEGWDenPhQnvkhyCFVJ4Mw-iqBSa8cvREYm2dF-wJ8oUfkPBqZS5UuW7FvM1ykaBZDcRcTqQs42hByVlxUd0J1A","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhAxQLiPhxDgydqelIZbbh79L0r_fJKn4wgTFo_GziqIN6CTLQgt8wfs9_hWis0lNTXJxLSwfGITXIxhd8L0hQvtkYrSog6iUrQ6teuR-OABkxOt-NuusvrPOqBmxx71KJiWtJ0CuNsmqTi_T1tM9W0NDiuMGyhyCkgo4caCgYKAa8SARQSFQHGX2MiovZKwM_0t-tRwvUQrdRFrA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746254043","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746254045, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('a32dfb3f-40f4-4b4e-b855-e779143b5c6f', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746254056, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746257652","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiVDhJQ2ZYRV9LRWQwMXZ3eW1DQWpZZyIsIm5vbmNlIjoiTm54NjFLMzVlN2gybVg0YnJ2VHZadyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI1NDA1MywiZXhwIjoxNzQ2MjU3NjUzfQ.QnLicMAsrx8a6suIOj6p985bsFRe0ujh0e_sI-2CprBjyowioGz9sIxJXJxJ2I2jBpyxDHH7zLf43lM4Z86mf1Bp_zUds2rlOt68OcS7ZWztXNMFj_RUUh0zCluGOfuBI2Vd6-A8Djtrr6b0fdOSuRedj2V1w_HrNQujeP7y6gV5fIheZMi4pC4amE7ALJggH6xfqMO48qvll6fiSOVXBCsvzG4ccc8Z8qqDRlGh4nzyjVtmMcxvOJfGYZPeRf1QQTbb-LX5DjYqjKthyZvEK3EPiO7Tyqn8noxKIDOzy_sxz3INJHCw0Qh93hmIr5muBfoSxPDrbvE0J6Qkc2gC-w","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjRdEJWQ0HKBMtzdim4qPdKTFMdTeHp8Q6YDmyIMHYFgRar5kMBxsDAtoYORWHgjXKyKfkSSa9C6NilOp5BLYF_AbNxHc05woI-RRlZ-M3RRhvKTeNvjnDozV2VUKm0gq_VcMSSibao3C31-28MODwBK1wHTlT9AquNUiwaCgYKAUESARQSFQHGX2Mi4z3gpO3JIol9iJUGSCavDg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746254053","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746254056, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('a27c132d-32bf-440e-a227-ce45e10c6768', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746256320, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746259916","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiQjRRcGc3U1p1bUZUWExKUnBqOElUZyIsIm5vbmNlIjoiVFhySlFuTjBoUVFlY1FKWXFxUlh1ZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI1NjMxOCwiZXhwIjoxNzQ2MjU5OTE4fQ.OaTGR3JqHMkbuetNCasDKE1bz5pkH_ACnrhYeyoZ69sNNIWoj6V16Q_TLs0c805c1kwLTccMBVbNHPNaaqDZHyP0kCxHDB0IQC6Nh2ukjAp-dZutkjz2MlN5UgIGhnD9PWbAx_RnRnnN_alJOW_zNhyXbh6SNHOOkq16YA-eMoUwtJU6KAHWjM4j8fNYWPe1tuD8-o2Gp-GuydUYBPbbUQr50FDizOLrnsKpJ9JhzEQF3Zdre4FQ-kfB8YH1s6LD4fqmu0V4WE_cJS0HBzEHmy92Akv8LRdvhXdAGY8EOu4GvI0NwkTmrl_tw_mNH4jGX08jb3gaw4k5HJwOtUiAXQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZi3XloIyYJY-vSO8W8Rvr3DbtXRClvHpNs0ghHSJF6YpDye7QUa7tKNaIsvvJW99FIGXP5GitcB-VZTemPD9G84X2GqDWrcq46vD_x_3KvLp0bOZDjgpseajhbwhSj0Uapiyh-GUavlOsqZe0BFtMhJu5yQQyye8DowtBQaCgYKAXYSARQSFQHGX2MihhpVtyMCRwBH_nwU34DFng0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746256318","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746256320, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('28095c57-24c4-413e-bd23-635ea3ada920', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746256328, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746259926","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiYUV2UkcxN2JFRm10WG5nMWdGaldNQSIsIm5vbmNlIjoiRXhxbFFTVUhjcTRMRDJkbHY3akExQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI1NjMyNywiZXhwIjoxNzQ2MjU5OTI3fQ.tknHEnYwfW9VsaEXXylNK67DnZ1BfA2tuVB0ymDiqmQOrpL1XQaWtmVtN6cSW2D-SbYXDiv-kEQwtx_zyBlKa0rbFkrfb0-p8fyP-7RsPbNvBXnPIgTIh1G4BZZBo9-Udu9g0aitdAMvPD0Oeum5H6ixXL1Bi7OU23XAEWLEY-o984NHSe72RzF23cevBIFIB551bgtuK3iNlvRtABAUv0qHZX0DeNv8QSiFRMFD8bXmH6ctsrzM8PSzRo4BdbebZOVvSI6r8SbuntJ2ogY5yBmWqeVE0eTf4F1KBN7KOz-I2IAzjjfg8l74ZuvO_2mcOBnGLm049yJSUNfNtt__PA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhM3qBTya-u-p7lr4hHUxEW8HLnMHB1L8MAc5oZKilz03NPNwrscrXZZwX4oYxTD9IN7zDTZ30bfZjDjSA6xWE3qNid1cGtkGQNyum7RarZJrbqVE2wOZpWh77rZIcUiUpE6nbgKtPE9vZ05oRsFpVoeAMes-oejfM6eU4aCgYKAQUSARQSFQHGX2MiQgaM7fE5AWOPyohlNIci9g0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746256327","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746256328, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('437d0479-7c12-460e-b78d-cdf1caa908bf', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746257971, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746261568","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoidWkwR05iYmNrcVpESDMzdTRBcFdHZyIsIm5vbmNlIjoiX2M3Q296NDc0bkZSM0UtMTBLWk41ZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI1Nzk3MCwiZXhwIjoxNzQ2MjYxNTcwfQ.ucq-vq0I07lD8Bj71FPdzFiVfpd14lwpCyQVr5HvyY4Jgnh92Ap7-5xT2ulPGmxr1-EFc5XIEhlARR9gvrqFJ3-2Wz8ZI0Yslqomzgo7lJcpNw5u0H8SubCKuFExQhVj4mvZgHOtIacVq6nIqqmGToN1eZ6VEfaCgg02WW4NFaGbr7EdAPVPpYBgkfL__bgRqpCoTSYQB4s6O1xjU9pw41wiHksluPkIBdOq4ft5pC2peWu1EZvGjVLo2ZxbibFlIz0tnr9TJmysXIUwzZ1kbnBes031DIjhrrAbj_uYF-o2h88m25SCO3SvARAsGG7MfCWAa3gIG6f7wdW86QzkKw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgJU23kWDAuRETPqSKTBcpeDZwuwOZfjATiuKfmMKIA4G7MKTLNrIfH1JzJxPVHA8kJ9fzq3Sc9QqcVYU6sn0MNIlLYMOhP_Z_Vi6wpecZff-88PJauXUSXw6EyIlCkos5SxRWaxuf_wZGfhT7uw670Qoo4LbG6o6kA8IoaCgYKAXoSARQSFQHGX2Mivy3FfiJ7hoEpbPj6Zgt9Bw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746257970","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746257971, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('a399e955-095a-4a80-803f-73517e97c883', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746257978, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746261576","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiM0pMWW11THRadVpvbWljVnM5LVNOZyIsIm5vbmNlIjoicnd3VUNRTmMyUVlmVzVpdzJ1RDA1ZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI1Nzk3NywiZXhwIjoxNzQ2MjYxNTc3fQ.UHJcJxFBFv7suNO9a-m-FHnzcIeoxM51slG3PKaJBoY8rWfhGFJ4qGXmJdPM1q2Au9gZuhJP-Tm2l4B9TSSef4hzoE7inbPsO49VXXnMrFrPLUCZsaUXSuaTKg4RbadPLxIL4UEvcd5egYitR650IEdzv2KoNUa_tBgI3dP82s05SPGQni6_ZBbzwssrLRuL4sFLDYLtjIbm7UXY9PTQgqnBOZCZABGIiI8ptjJ2pUoxPMBy06lG76O7RyId-BCnTOGBcUb94ZAsaBKW8wG9pGpW2cgpK_PE7bgRnRVlgLXZ_SRRxhgTNtkA1cS9pElVyM9qtIfVkwQOgveJ_qRQTg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZi5RQNJmNRyaEzYVIOP8sZ84IEeoQVqrzACiaYakwgvln3Bak430sKk3w7Ap6IFoShHIEWhh1IkpR1MUV-av3LjwFBggNNVpgM3cqeFjuWz0qEencUY_0cziElXMFYVUZTo0Z3BEpcY07_kylOiGVtQfkpTL53_tAavlmsaCgYKAU0SARQSFQHGX2MiVRMkp3AMqye_fKZAom2Giw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746257977","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746257978, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3ed3b402-6131-4cc7-8f00-58f3e8ffacb3', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746259770, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746263368","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiX2xIR3hlMTVCUVc2QTdKbWJHYUhaUSIsIm5vbmNlIjoiMFpZdmxVcVZ0NHU1OVJMNHY4czlOUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI1OTc2OCwiZXhwIjoxNzQ2MjYzMzY4fQ.gP2NIpZgDJax68P4Y8kND_qFjSoljaersPlZKryHg1_MYeOTifLU6L_9-YNrtIJcovFriWEQo8VPbbGo8gYM6VhPEPMMOKLW1wiWYe7MC7a8YFAl0uDfgNxgiCgmfvvUmtVct-KhYuPhabvuHkySAtExrATrI8Ky5Siww_7eU1AVjlzqsYHA-_gRMflvv5VuEfiZ-_r4vD3_tG0AjCmOkqJq0I-K4HdxA4PptW4uuO4KPf9lhbinSAT77dNQ4oR0nvbbguDy4NSeAzAnZEtDEBCM3t4Ze-Gn_ANr15xEgF2a9G6pCHq8Vkm42w-x9--tKvJAfTb8aHt3QqPR_5d4Pw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZiWs1mQlvqFnxU-qUhBFYV-bLmlyMhHUbtQ2OvYQCuSEJ2IHnERtc8AHzQZBCkgfiv673QPdKSp-s_-L2wi3CPLfMhXQElhv-5F9Xw_4SRPM8EYGUtE1zApj2eWOJ5XuYr80R_Nqk-A5MLA-emhCX_pywyeeerjCkC_nwYaCgYKAb8SARQSFQHGX2Mixgjr27gdulNzcnEkLNiWjg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746259769","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746259770, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7f9bf90c-ecf9-4900-a1d5-84615f7d14ac', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746259781, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746263380","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiaEpWUkdYSlVnRTRTemVDUVViRXktQSIsIm5vbmNlIjoiUlJpNkpwUXU0Vi02Z0UzaXFnZ2ZDUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI1OTc4MCwiZXhwIjoxNzQ2MjYzMzgwfQ.lry89tBtVnsjpB3tpVEeogARzgk15bNy2kZ7G0nEWScRV1qJK-SHemvrA-c52Kk1YaOjuDqvunUQH1LUp70JNnCgT-R-MA3jQxa-bVyclQEMxD0nvZOeSEzxRuZRLU1USy7sIW7oX51uzB3bmpdBOJK1JU2sQUJrV-5D09wi-5SD94GI-nIT-1y7zeuj5U6oQn_fDMS4KzWZsQpcjRQbeX0425n7_IyFLskYP3P2oHVzm4q8MZUyGAenvMIZ-Y0aLEBjnNvchQr3sDpoKBbyT9X0lMzP8i5zPGH1tKjkZ_8jgrvdRSQcDXOjUgwiX2zYuzTUcsDvSESnYZ0O2Iq_zw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgxZNleJvldevYIwby0-c6znIP2SThQ_Am5iWOPevrCZOKgtGBGk2vpd9ZWXPbl0qmhmnQQqOAvHqYIsxmYBJHXelE7ed76ISlPqY-_WY_ZxzzlzL4sy3CZedcb2qQBVlnmhRi8ufrY9KAsGsZoDg90qmVuakFbCVM19xkaCgYKAU0SARQSFQHGX2MiQM79f_geUkq2bWKeH7vepw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746259781","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746259781, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('ad134269-208c-4414-b282-e4d8236967cd', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746262314, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746265912","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiOVo2alppaDJZY0VDMmdVN3pvczlrUSIsIm5vbmNlIjoidmhkb3NxN0VicFFXeXBkMjgzS1p5QSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI2MjMxMiwiZXhwIjoxNzQ2MjY1OTEyfQ.dqVp0nc8hmOYEON1pxAQoFS_IkUkqoyuT3qdrdQrcoXDeX2_A1rhF9DDMqlvPXQTdHgC1VFx2k96UQMpHJesy0CQl-x_sK4mqdPh-YUAz9oq0165dxVcqaJoA0KohaHjLtflL37Blh7jxCTu3-JSE5lH6pPt1L8oRVNtN25S2JJfj4gtoi6nlE1Xx9tUk9JeF8Te8WIdeOGhd_TuqywcmTCzKxmvLCEwg_Mdu9-iCNGvcCJvS_YxioKSXAK0UzSm15Z14hi-4ywAX5F8HJU0rGs8KpDmPK-g0EarunzoPV1jumpCCFrSoW8VWKSgXs3f3YWcPxc4p1iuR0a-_izMJQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhXOVY_aeKrBzmPRb0VpV3tAI9FnrV8gSwCq5DUbwtxPpu3V1yrPiT9JIsRx3DBmK1TkJEZjaFocJKC23AyLrrEgcOwFBp_BVWXRBS_IX7ll7T3NlnHclHfkIvqINjECAu5b7yWqN2Mbh0pF79XMHp6otUSyTSmdxfU3bAaCgYKAdoSARQSFQHGX2MiXCMASFws3q9DKnZjvHNOqA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746262313","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746262314, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('4c0935f4-8e0a-47f5-bcd8-649f6ac57988', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746278503, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746282101","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiZkJtMjhMLUJxS3Y3UGVqeGx5ME1uUSIsIm5vbmNlIjoiSi10cEFmLWNjQWktTDVIYVA0MWo3dyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI3ODUwMSwiZXhwIjoxNzQ2MjgyMTAxfQ.I0FD-NBMpvEQD04wf0jHip88faOlSIbf7NSOSiaGhZHqJe2uFTeNXQUCRPEqwfDnfAx8EEcdbKc24qaSWmgO3_ujX4D_qvFVsmes4fODpKBSlZ1ALgiMcDq6h3H43lFF5FDGdhzr9Rd-vseWfs0YnTPqj-IyoZZgV_sql-UdafRkwWXAROwaNTRXJ49YuVgV0xFswYGAc6EzIBc-VEXJ03gQA-mDdplhtLvL475y3ex63i5tJD6rrsVZc_ftmh3RDIsACbPf3tWGdVGC0K0bbPHrM5bRZKFEHeb4mETi85snkkrHm2cbxPN5DtLixUudVMLIdIhgoBPtYl_CHIrp2w","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZik3A_sdpLGYCrlHKbfWCmtqUtHw--uKoM3BjLapts64B_imXzAW5cU_fOF50a76hypc8qSkr_0YFhN-xYPb8a6lSxk-oJ5cFU4y2zaxgfnAWU1XgHXGKshg1EaNJ5Mw1Lb6ZMeglMtxABCS0QhVIJiZNDeJGRxKhBc_s8aCgYKAXkSARQSFQHGX2MiDK8Z96kodgOCTX3DhZhV4w0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746278502","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746278503, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('23848223-fe89-48b6-a958-1c712bf43148', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746280130, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746283727","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiZjB2UEdpVGsyMjNzTUlHTVA0NXE0dyIsIm5vbmNlIjoiMi00QjRyOEhocnJhLVFINFROTS1WdyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI4MDEyOSwiZXhwIjoxNzQ2MjgzNzI5fQ.tb5xxi1TGXJ6bf-y74mRHpN_Q99kpzwmPwLzdQhuMexPW0vSlv3kpKOOIdfLa3U8CBi6sz6q-0-d9JnX4lwgs8xD8PitcMgdv6-W8RU2tM_TVRhZVKU9Vir86AwRAfrp-3h8K9k-XAhdZ9mNqodNXTIBAQKo8FYAehUkMbp2wl0dJMjfmqf-eNQvxTPjXuxYks0IvVWHU2dMmWMWD_X0mAcUcIBC2lqUutpjOuCdFMhirtOKLAS_kkxV6HgSS-A6hAxLYRl6edLfiN-74b7QE2ZKPjeBFmuQjbRWatQF7-HfUTqC0PR3Gsd-2idYYCsPsm-sIHlkuaKfMbvgFXjlDw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZihQGb9yPpgf9opr3GokkhHV1vAdBXwiiJhCW7HfkWpxrU4LcfdYPPixNl0PLEqNsAmYwl-AxtvtB3M6fW7E22ccWV12xD41zJAL1gGepgeN2j6hH6jh5JLpl-aArvtPZdva0sCf2PEK0csbEtGMxUsh1UjOh2ynHgLSXkaCgYKAa0SARQSFQHGX2MifkIpN7moVDaUfiXLDuaSyw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746280129","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746280130, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3b8933e5-ceb6-4d47-87b6-f7468941969a', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746280138, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746283735","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiT0VWc2p0S3dUVVNPU3UzVmYzTWl1QSIsIm5vbmNlIjoiT3BZQ1RXOUJ4ZnlPd0paekJKWjd6ZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI4MDEzNywiZXhwIjoxNzQ2MjgzNzM3fQ.SYXBFuSPm-os3osb8xiWJ5Vf4PGe5O4bu9GQIt5FZgcwWMV4p_YZwEzLRV63XJwk0cuLycCs0OepZoI3LGasUOiz2YTGnzZjDerzhwdISLcHI8afr2imbTLYqeOBnTgh_hyCeVybPvPMu8AbnT_K01aBG9Ax5koYRAIyMjxImmXoK97CdZ-YTtLsKOBRfp5zGnM86RWmMOdb4in-MknGWy42J9jhMBRbFMFvsHLV2WKSxrYXdPc2uXu76py92bKSpdmkml9ipwbYAqot56AaFG6fFYRMGm20aOki-DKAwyBX3dGadxo5_5MYn6Cw18isKvLXBz-cqZciqo6VcG82Ug","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZg8RoQbS4dCquGrvCte45OBPw7Ewp5wVWR0XvB_TT0BcQKyLUpwd80XZhx2Pl9q7Nm_SAa9VoyHfopr9u-fRgSjgRgmARo8aPDMNXF791EWWnsPeXmtESLZOMrVNasHHuTxuFU7v-2TI9TnwGQFXRrJo5BewzxPLxOi3z8aCgYKARUSARQSFQHGX2MiZ12z8LYoVN1UAfYQXx9lEg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746280137","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746280138, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('11ef36d6-483c-4521-80ac-5272daeefbe7', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746281576, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746285173","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiOHB3aVZiRWZwY1liZ0pJUUktNU5EQSIsIm5vbmNlIjoiVl9TX1ZrMWdlOVppTzJUbHU3aTR0QSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI4MTU3NCwiZXhwIjoxNzQ2Mjg1MTc0fQ.bz8ycZIUwj254pjd6SONEN0uZ8-ITGocQOHzHl_zaO-tNUxw4lXicBaq_ZbIeEfr6eHxMBIMiUijXxq_xJosHNO1asW4sgmC6EKkoIZg37e23Wi6MH5kKLiYseJF4rrPYaSY9ZEcch42dEvW-GHQjq6H5DJ7DclzQ93c6Ap7yiIEFloRcVjh2Nzxo9rRX0L_Z6TZ4neyaV0dDrn3MXI0OMnclqe5yXJtGyhP4O1qA5j-ZiEBh0N-eU17zTc5NAfwCRjHVFKPbILctpMikWVu83zPh0HcH3XRSA4Bn6Y9g_HGJAbO7-Sj1B44QpaFBNczsxdtipvGWegK4myYCoJEYw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjrX9B8ojM2X5GBCKRA1-71Ha8eJVgGLyFK2xj3MXWjymyQ7_g_8SjCTn6G1ME2c-GlEPFvZ8EGIz__5cLRyGkQ4j15xyNetzdeTyuQ85k2dm548LGi47zj7FuWWQrPMQr1QhbsO2_jNGIjPTImGCaxIWjDfNLm4hljLCgaCgYKAToSARQSFQHGX2MiqiZSm691-9W_F92xmBqTrw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746281574","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746281576, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('ce374e6a-1030-4be4-a65f-6c6737ed75ed', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746281582, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746285180","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoic2stMUh3cDV6SDg1RmxFUFBNQ3BHdyIsIm5vbmNlIjoibDhNbUVQVEZMajJHMjNDdmFhRkJBZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI4MTU4MSwiZXhwIjoxNzQ2Mjg1MTgxfQ.NmFgntzmFJljRRgQUlJmHanUGOWezGYTJH45MfXZOwoJVrbpe6nxLb9bxxnpbQ0vkXd259-p0pb2s7Xnd7YOgsDXF964VXHIoNh0bf4Sx0FidJjNJdySvF8Eky0HAuVC8ZmfV6Mthcaq9DEgJr5_GEalWxrx2XneIAWuf30kGaimlsWJDlta_wQAKy-3tlvoCsPVgPluIq_5sZ113fJzBJS1WnveMvJxl09yLdYGTpgj1KBIIuG2wgnJwSyEi5ReoA0R2C3Wui2Dfw6bFwzQddVW9oqYQ0NVYlT__h8ltRN8jzNkIYVOOGG7Kqe37A-64DkAKfByMwRx6JOYDjvEhg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZiGW0A1zP4PVp7IvbI1Ogw8ni9Uvr9lQzF9hLwkgptHAPEOxcAGu6SPcpwB78z93sYzIZtS2dGyZjHRG2a8t7BPr9JqwiU0bDj5HHjx1zWmrnDWafAk_K96iqOv4f1KktOtD5G9FOEOHKXsbono-fu06p8H9M8HezPE0uQaCgYKAccSARQSFQHGX2MikfPuHbtzxFLnu-ba5c_oVA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746281581","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746281582, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7fddfdf1-aca5-417a-bafc-8b2093989bfb', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1746282940, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.251.234.142","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1746286538","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3YjgwYTM2NTQyODUyNWY4YmY3Y2QwODQ2ZDc0YThlZTRlZjM2MjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiakVfRWJSalYxQmdVaHJ1NDR1TmZhQSIsIm5vbmNlIjoiMWhQWE1kWVVNN2JCZF9NR2RxVXlzdyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NjI4MjkzOCwiZXhwIjoxNzQ2Mjg2NTM4fQ.zu-5ZgmMKxJtYdOQIv4QMMhTV11d4EGm7SPvuKdiLw82URD_i6YupMgsrLmKn5uso7UuQaQXJKiZdb-kN1tV-EQq8BEugD9S56n8tzKFvyita6Ep8TtzdxM5TbmHDJE798UwHEecdRnq_FYeBlTZkgyfx5oRMXQh1Ahp7o3uLMXBlyO0rZMXsHBTEdJ33rU4l9g9BYeKD7AGhq6WEtrzirkhHH-4hokvZsG_YyrKzi4Ej1Nt4u2Y8xdm7G5R5lUvWbAyG_BIR2P894G5HjSk5lgGf6gszYop3lRveCRir-ONh41mnCbOK64RBUCyoqLS6s6cFZ9BCLGzAIlMmXpnNQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhs1hjigRjKHozXca1RD5nW9uPpeXBhhHzy3gJsXmMvCYBvTd7gaJ5ZETvrlcbWAvjkyKDNotJGTQlPAJ_u6lQyVyM0A_Ux3v3OxCd88xSUP_heIJQeFF5ykLO2tejKHltf_XspBTxwZ0nAYDF05gNZKDmAUPhMwi7HdAUaCgYKAS4SARQSFQHGX2MiqmBdM7-M_PzaE0dXBrXM9w0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjUxLjIzNC4xNDIiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1746282939","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1746282940, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('b8902e79-1224-46e7-b497-79b5ecb1bc84', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745114241, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745117839","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoieGN5b2tzWDgybHk4am5QSVNkYTFKdyIsIm5vbmNlIjoiYTQxbmNKa2w3YVBhYXVsZzZDbmtLZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTExNDI0MCwiZXhwIjoxNzQ1MTE3ODQwfQ.nGvvXIeFqQ7_5QEi6EfT-h3CxHJ_wkOjVqhKuWmgepfw_naRLn7cOBqinsu4QqmMysLdCj2AI6Oh93_RjSnkpZwhyjGXU4FWe0ZbjuHaLA6EGSDFCUgnPLF6KSqsnQN2KElgJM3Rk_-0a_drNZSnBRGFuBUFtM_aUrv3ixuHOsnTRdV1BBPwqZM5QRNt9d16ynFxJ3Vhx2KCRRgz0EERbry35XRKUmHSEM1jhxF2Vusrq2MaKhm4RxmQIfQoy91nOTkm9kpDBAzmTHg0I2epsF0rUeK-rjF8KBkhYUOqFq7ZUWPHCgjbOUfWjl6-30WP2tqAjekaTKAe2IyVf-ODNg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhyERjJaQ_VNo1GevQ4ec9R-ftvrjTOSTN87cIPnP2GPydzwoe84xgzqzxvrBRm2Hin9QSLDS5Aelda8zvRCAZLPFTM0hbaOxeVRjEDMdGEMu3Mm_nDOI33Tb7rA07YMUm3on08G_tUZcvXu8bv0pbEtEifsMBGz_pWqX0aCgYKAeMSARQSFQHGX2MiX_i3auYoy0MOSKLw73ItlQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745114240","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745114241, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('b11c4d1e-d72c-4413-9ddb-90df2f438647', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744951634, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744951634","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744951634}"},"state":"LOGGED_IN"}', 1744951634, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('722127e0-d0ce-4987-9d34-a6467d61f66b', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745116221, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745119819","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMG41dGw0LWVNYnY5dHZyZzM2b1d2QSIsIm5vbmNlIjoidzJmT3NLZ2RWM3haWjFJUWRBU2JYdyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTExNjIxOSwiZXhwIjoxNzQ1MTE5ODE5fQ.AJf7NbMcBxGq6HPDgbNPcpaL5zRd7TRJ1y6WQfSNShfrQhlyBkd-FljFOLVn6IDu-iSCJz-QtTKbCwcDMMjpVRCm_ND6-t3KLXjnxrBXKcWfozhj4CBsJiluACcdlK8gIO9fsxNsX1fszf1d8tIMu3t4h4k3UyaJOuMhBD_jO1zkjHpSXdJF8QC94eQGhDCWM9aTlHon-TeSV9FetrmqWUwZgxA6gY4tfa2i6tnKiZU2Ewf2muOM4BEW60_N3uHAvpO2l9FD7gC-lrjOfL4mQkkzJ4MPh9VrCbZcHp2Idj0DcNV2pXmuE2tV2n70Mn5e6RELTIunU04gE-2gENvI2Q","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZiXwV_bziWjnEuqku0g_K_wcBeZjYe0-w5T3ocOZ_h4OQ8Y1GUka5NKjZjBnMtI5xdyGOYWHRhIRcrbLzmIRuAh8JxkNLBf7dWvvd7971DLwTc8hjuYSKoxkmrFi8kOqEGBsBxvVS3cgMtMurICS12cwmI08auXHCW-SVEaCgYKASgSARQSFQHGX2MiICTXUE_Jhf1IoySsyZP7Lw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745116220","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745116221, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3dc2d36d-23fe-4d23-bd1c-04305bf562d1', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743831833, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743831831","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743831831}"},"state":"LOGGED_IN"}', 1743831833, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('e47d4ab1-2d68-4dcb-9517-ce64cd306d77', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743923046, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743923046","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743923046}"},"state":"LOGGED_IN"}', 1743923046, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('cdba9c02-6104-41e2-a0dd-3088f13f1737', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743831844, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743831843","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743831843}"},"state":"LOGGED_IN"}', 1743831844, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('8da602d7-4e0b-4cf3-8801-6801ffe35419', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743833924, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743833923","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743833923}"},"state":"LOGGED_IN"}', 1743833924, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('d9f0e246-50ce-40c5-824c-ceda7c142b01', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744378257, '1', '{"ipAddress":"123.20.158.13","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMTU4LjEzIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744378256","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744378253}"},"state":"LOGGED_IN"}', 1744378257, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('fda12cd8-70a1-4117-a633-70472f2b5ecb', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743834457, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743834456","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743834456}"},"state":"LOGGED_IN"}', 1743834457, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('00348ff6-3136-421d-b55e-8cfdfbda5ccb', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745116231, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745119828","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiTlYxNGFtQ1o5ZFBXSGpjb2plR2pGUSIsIm5vbmNlIjoiNVg5NmkybGxENXFDNkRuY0RpWXNBdyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTExNjIyOSwiZXhwIjoxNzQ1MTE5ODI5fQ.U0mY75yZ2my1uwMxaR8fpYOg4vB5B1TFB8DdXdPFsntPCXKMTfjrmKqh75YClP7Pnz-uuQUvqHI0hQPfZB4CJjupBDvHfe6uE2U1N49SfdwnaokQzjII_HFSdTrak6MR5OnYajZSxEOuQ7KG8XPbOKuXfXapRt8NvHDtXGTwrID5ePgTC5ElWZw6BX4bQoPM9m2cIaMWLa3IoFsapjGb190HWghsosuUTodFWM-jtCkEFOhBaTGQd8sZaLLNjg5tW4bGY2aqItDeBrkdtcHyrkymiWNokPc9wrDOmr2MHdqevJaqOTKNRSSEANb2ipBCkmqlvvsOdD3XhvxwqcclnA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZg74C6fyaiMEtyaTUV0rk5DKqZXSZ2oyfb44mhFVWIFKW2et8OcsiscfHqKnNtFEtNWQBM2bysxKrFhTARoSbUQCOYfA_MLDqxUhTnAztj4TAq1lb261VaTFbHcg4bcaWfQZQQCRljOyTOXneUb5Ocu8XX-zjZS23O4CeQaCgYKAc4SARQSFQHGX2MiY3Vy3IcGXstCi0IQe4GHQQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745116229","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745116231, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('35d7eafb-9bf6-4286-b1d3-66dc5e7fdc53', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743835337, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743835336","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743835336}"},"state":"LOGGED_IN"}', 1743835337, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('c3c67efc-5066-4c6f-b43c-351d26f33fcb', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743826739, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743826739","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743826739}"},"state":"LOGGED_IN"}', 1743826739, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('d3046a04-2c14-4eaa-9d9e-fe1cc682ae38', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743828283, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743828282","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743828282}"},"state":"LOGGED_IN"}', 1743828289, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('888debb6-2dd1-4c5b-8a5a-f742cc45623b', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743830143, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743830098","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743830098}"},"state":"LOGGED_IN"}', 1743830143, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('914a52b5-8867-4b12-9fc8-3fefe39b6af5', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743830148, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743830148","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743830148}"},"state":"LOGGED_IN"}', 1743830148, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('f2ffd927-c464-4acc-b15b-a655e0e43cae', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743835345, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743835344","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743835344}"},"state":"LOGGED_IN"}', 1743835345, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('e34d32e8-72d9-4b4b-b8de-ac627d1ce191', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744591587, '1', '{"ipAddress":"123.20.158.13","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMTU4LjEzIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744591587","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744591587}"},"state":"LOGGED_IN"}', 1744591587, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('2130d0f0-9af3-4384-9c56-a27858057f53', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743836432, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743836432","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743836432}"},"state":"LOGGED_IN"}', 1743836432, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('fd9b8daf-6786-4d5b-b3fa-e5a8a710d828', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743923767, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743923766","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743923766}"},"state":"LOGGED_IN"}', 1743923767, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('d1eb15de-6baf-4ffb-89da-41d20dfcffdc', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743836437, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743836436","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743836436}"},"state":"LOGGED_IN"}', 1743836437, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('58b80a02-d823-46e0-a37f-bf01bb9c8ba7', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744562907, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744562906","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744562906}"},"state":"LOGGED_IN"}', 1744563194, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('57ea1bab-1205-4012-ba1b-9406c943217e', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743836731, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743836731","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743836731}"},"state":"LOGGED_IN"}', 1743836731, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('e0e5ddb9-0dd0-4045-81a5-2ec6dac23d81', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743836736, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743836736","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743836736}"},"state":"LOGGED_IN"}', 1743836736, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('d7d64d55-0024-4d2c-8411-61194336a1c7', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743838026, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743838026","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743838026}"},"state":"LOGGED_IN"}', 1743838026, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('5ab7dd9b-95d0-44ae-b8c1-82637a2f40dc', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743838059, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743838058","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743838058}"},"state":"LOGGED_IN"}', 1743838059, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('98242c8b-a506-4c1f-a066-55aece6bad95', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743838093, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743838092","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743838092}"},"state":"LOGGED_IN"}', 1743838093, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('29cd46a2-6a0e-49c0-bf49-cfc02cbe34e8', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743838098, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743838097","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743838097}"},"state":"LOGGED_IN"}', 1743838098, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('03714131-8e92-4ab0-9ac3-2b04c43ba466', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743839694, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743839693","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743839693}"},"state":"LOGGED_IN"}', 1743839819, NULL, 3);
INSERT INTO public.offline_user_session VALUES ('6b169c3e-9dd6-455c-a24a-ccb64de84380', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745117971, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745121568","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiTzNndHdpNEJTMXlPQkNweXg0T3RqdyIsIm5vbmNlIjoiS3oxRWR0cERKSGpvclpfTml6UElEUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTExNzk2OSwiZXhwIjoxNzQ1MTIxNTY5fQ.h1-ux_6xT6TS0trbQ0t0eP6ihQC16I3nVYBe1TW2hWgIVw8zhdTphU5hv56YyLvWqbwzoEwoOo97BCfYcqxKi1jkIVovIUi3lhOJ2rl522vL5e-I0nkQnlWulwhtebu6Oo5kvjnuSZCOfeu7RvzwpFS58AOz2lzHJrWuQgax0FauXRb4h2oUpXail9BFicCjJjM3-5t39bC1YSy8ufxh9S-Sb1j9RsJzp5wV8sU4LGilMKDilow1D5F2qQKvuhBTRRZRsSlGY1567NwSmmXI2PGCCsNUHFZ9jmouabZGud75MJWHDq8M1DzIFU25ENEAJCEMwywhBWak-wlrEwkDiw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZixSukyDQx5BHrr3B6SyVSW8eTs_nz_VqFgb5G2kS24LYlUtmcm_D9njhNw4quIoXzbslRn-mgnZ3VKdP-acMYf9WtETwYVf8tVc0NZbKFM-s2IHTQLDPOknaabt6PGgdDQlxSv--3cUBUUS2dJkN699lBMMsCYcWCyfx4aCgYKAaASARQSFQHGX2Mizg0KLi009ctDlD-L7xMYmA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745117969","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745117971, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('215618be-cd28-4134-9e79-498647e9b825', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745117979, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745121577","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiNXU5Q0ZIOV9UYU1zNkNsVmlBV0R3QSIsIm5vbmNlIjoiZFJnSmNvVnh1b210STVQckRZMGwxUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTExNzk3OCwiZXhwIjoxNzQ1MTIxNTc4fQ.an9crAd3aV8H4C4LsaHRbb8AV7bdWigWYKUpiaGDiZWFkh0WkdZ1CQaBTAaYNbOvxFW_RgA7k6k9nhN9zyOSFdTOfoxWwR-gwm4WWqQijk6ep-9Vh-ahg8cZ3SaTULAH6IWBZBQVaDh8gzXSb-Udb-bdamjrk-fpbGfhldUXHI9HpxqN39o7SPUziEjjUS9p8rPuZYWoktY3WVxc77ZXYLioWYRSKvwVHtQoElWKMqko5oCH01oBg0gjE3IKoBaf5UOOia3JCghow09iWDYRB9Bwx29bYHL0zSDjZRIRp_vuOdhKPrPrhqk0nvkGH1NpJ3aVZ9UoKKzqXQvdFuUUnw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhnHpzorPPIDaEHdat9xztnyjetoQG11XnA5fBtgqFqwargWLtsKkRdMFlQzw9xuQafVelXrgVLWbQuQozer8ijVPuYsVj-IcNhiBjwxACqkciMGdvYd6cKqg9h5MCHlA30HORDIMB34k0qRgibqXkgfjcEMJNb_LM2-qIaCgYKAUcSARQSFQHGX2Mi6vDulU8gl0nGMsAS2NvHNA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745117978","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745117979, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('f1ea317f-2ce3-4e6e-afbc-0078d57d248d', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743925202, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743925201","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743925201}"},"state":"LOGGED_IN"}', 1743927848, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('5a9b8cdc-3a27-46ce-96ba-e1fae0bfdb4a', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743929293, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743929292","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743929292}"},"state":"LOGGED_IN"}', 1743929293, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('59a7dc3b-7d53-4794-995e-ac96a67ad2f2', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743929296, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743929296","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743929296}"},"state":"LOGGED_IN"}', 1743929296, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('b56ad077-7119-4992-bc1d-6caf2b847e5e', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743930787, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743930786","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743930786}"},"state":"LOGGED_IN"}', 1743930787, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('00b85fe4-627d-4121-a65e-217a2348fd6e', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743930792, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743930791","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743930791}"},"state":"LOGGED_IN"}', 1743930792, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('47e632e9-6d1f-4c4d-b4f9-48092120127d', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743932338, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743932337","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743932337}"},"state":"LOGGED_IN"}', 1743932338, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('51ccd78f-b83c-4f7f-abbc-2f6183a0ebfb', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743932342, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743932341","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743932341}"},"state":"LOGGED_IN"}', 1743933197, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('1ba98ec5-e8cb-49de-a37d-79dd59e5aa9c', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743841031, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743841029","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743841028,\"599f25e9-d149-4585-a620-ceba48d62b12\":1743841031}"},"state":"LOGGED_IN"}', 1743850768, NULL, 19);
INSERT INTO public.offline_user_session VALUES ('f722960a-6d00-4d66-8f31-601366ba9e0d', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743933740, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743933739","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743933739}"},"state":"LOGGED_IN"}', 1743933740, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7f1c3a7f-8f3d-40ee-ab23-0843e426497a', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743933743, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743933743","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743933743}"},"state":"LOGGED_IN"}', 1743933936, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('f168c0b7-7f6a-47b3-9de7-9d4a15a10323', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1743996931, '1', '{"ipAddress":"123.20.158.13","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMTU4LjEzIiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lLzEzNC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1743996931","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1743996931}"},"state":"LOGGED_IN"}', 1743996931, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('ae32d3b3-a8d4-41f1-936e-d292decc97d2', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744004285, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744004285","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744004285}"},"state":"LOGGED_IN"}', 1744004673, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('fa69e4cc-5008-4569-a63f-00b8a1d6d72d', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744636413, '1', '{"ipAddress":"123.20.228.245","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjI4LjI0NSIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744636413","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744636413}"},"state":"LOGGED_IN"}', 1744636413, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3d82aec7-05cc-4de5-9318-1e5422a02d52', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744004773, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744004772","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744004772}"},"state":"LOGGED_IN"}', 1744004773, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('2c0292ba-539b-4fd6-8ec1-699af13b760f', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744182951, '1', '{"ipAddress":"171.232.55.79","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU1Ljc5Iiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1744182950","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744182950}"},"state":"LOGGED_IN"}', 1744182951, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('21ba6b4d-00d5-4d69-8858-b9b4bae26ed1', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744183267, '1', '{"ipAddress":"171.232.55.79","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU1Ljc5Iiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1744183266","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744183266}"},"state":"LOGGED_IN"}', 1744183334, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('01f44d61-03a6-409b-a9a4-37cfbb02396c', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744189742, '1', '{"ipAddress":"171.232.55.79","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU1Ljc5Iiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1744189742","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744189742}"},"state":"LOGGED_IN"}', 1744189742, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7824f9ae-0c1c-4a78-afee-b0f41f6ec132', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744190865, '1', '{"ipAddress":"171.232.55.79","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU1Ljc5Iiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1744190865","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744190865}"},"state":"LOGGED_IN"}', 1744190865, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('5249a455-081c-4417-89ee-9b09f46292be', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744190986, '1', '{"ipAddress":"171.232.55.79","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU1Ljc5Iiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1744190986","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744190986}"},"state":"LOGGED_IN"}', 1744190986, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('e65486bb-4bb5-45aa-a92e-848bc8258bd6', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744445038, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744444879","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744444879,\"599f25e9-d149-4585-a620-ceba48d62b12\":1744445038}"},"state":"LOGGED_IN"}', 1744449094, NULL, 6);
INSERT INTO public.offline_user_session VALUES ('fb026717-466c-4047-a5a7-7676689a6b20', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744458552, '1', '{"ipAddress":"27.74.116.198","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIyNy43NC4xMTYuMTk4Iiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744458552","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744458552}"},"state":"LOGGED_IN"}', 1744458552, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('0d171d34-edca-485f-839b-08e0471242f8', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744431297, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744431297","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744431297}"},"state":"LOGGED_IN"}', 1744431297, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7e440095-9d6d-43e7-b2db-a56c88e08798', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744005639, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744005146","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744005146,\"599f25e9-d149-4585-a620-ceba48d62b12\":1744005638}"},"state":"LOGGED_IN"}', 1744023454, NULL, 28);
INSERT INTO public.offline_user_session VALUES ('60b48e20-e74a-4f4d-9e15-df7a439a2937', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744024335, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744024333","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744024330,\"599f25e9-d149-4585-a620-ceba48d62b12\":1744024335}"},"state":"LOGGED_IN"}', 1744029751, NULL, 9);
INSERT INTO public.offline_user_session VALUES ('ecd7d7ae-39af-43a4-b26d-b515d4461de3', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744458593, '1', '{"ipAddress":"27.74.116.198","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIyNy43NC4xMTYuMTk4Iiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744458592","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744458592}"},"state":"LOGGED_IN"}', 1744458593, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('d58521be-9a64-4af6-82ee-21308683796f', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744459665, '1', '{"ipAddress":"27.74.116.198","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIyNy43NC4xMTYuMTk4Iiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744459665","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744459665}"},"state":"LOGGED_IN"}', 1744459665, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('64e01247-0a5a-49cd-ad06-c1fa9ed3a6df', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744564281, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744564281","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744564281}"},"state":"LOGGED_IN"}', 1744572998, NULL, 28);
INSERT INTO public.offline_user_session VALUES ('d78082df-7a67-4004-bf66-a73840f42e0c', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744466211, '1', '{"ipAddress":"27.74.116.198","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIyNy43NC4xMTYuMTk4Iiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744466211","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744466211}"},"state":"LOGGED_IN"}', 1744466211, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('c0718cd8-e8b5-4b35-918f-77a84e04839b', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744191096, '1', '{"ipAddress":"171.232.55.79","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjU1Ljc5Iiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1744191011","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744191011,\"599f25e9-d149-4585-a620-ceba48d62b12\":1744191095}"},"state":"LOGGED_IN"}', 1744196515, NULL, 31);
INSERT INTO public.offline_user_session VALUES ('80535829-f106-4d32-9ed6-ed3fc4aaedf1', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744516146, '1', '{"ipAddress":"123.20.158.13","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMTU4LjEzIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744516146","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744516146}"},"state":"LOGGED_IN"}', 1744517508, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('942d097b-fb79-4432-895f-0f1e124e3bb4', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744526678, '1', '{"ipAddress":"123.20.158.13","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMTU4LjEzIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744526677","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744526677}"},"state":"LOGGED_IN"}', 1744527928, NULL, 3);
INSERT INTO public.offline_user_session VALUES ('aff8bb37-002a-4b3d-9170-ab5cb9298309', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744528039, '1', '{"ipAddress":"123.20.158.13","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMTU4LjEzIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744528038","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744528038}"},"state":"LOGGED_IN"}', 1744528063, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('4a7c6f26-d684-42a3-a6ad-d7fea0f715c0', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744529411, '1', '{"ipAddress":"123.20.158.13","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMTU4LjEzIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1744529411","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744529411}"},"state":"LOGGED_IN"}', 1744529415, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('422354a6-c125-4040-9523-3ca4daba61e2', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744552804, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744552804","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744552804}"},"state":"LOGGED_IN"}', 1744552804, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('cdd3342b-1680-4d70-bb87-ac0e3a196816', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744554165, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744554164","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744554164}"},"state":"LOGGED_IN"}', 1744554165, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('fecce73c-6b08-459d-9216-6b674ac20266', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744554174, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744554173","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744554173}"},"state":"LOGGED_IN"}', 1744554174, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('e4869299-132d-43c4-9a73-4129ac58fc3e', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744555585, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744555585","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744555585}"},"state":"LOGGED_IN"}', 1744555585, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('de3778eb-0374-412e-bf8e-b6eff6f20d6a', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745118009, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745118009","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745118009}"},"state":"LOGGED_IN"}', 1745118009, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('57bf2f94-3e21-464a-937d-7376d31d4e28', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744555716, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744555715","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744555715}"},"state":"LOGGED_IN"}', 1744555716, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('318c4dfe-cb19-4b15-815c-b889fee3f66d', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744636556, '1', '{"ipAddress":"123.20.228.245","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjI4LjI0NSIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744636555","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744636555}"},"state":"LOGGED_IN"}', 1744636556, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('51719ad0-649a-42a4-b9d0-5a0d9b83cd86', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744637157, '1', '{"ipAddress":"123.20.228.245","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjI4LjI0NSIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744637157","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744637157}"},"state":"LOGGED_IN"}', 1744637157, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7040ab5a-e8bf-477a-a959-4ec6b0db5605', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744637173, '1', '{"ipAddress":"123.20.228.245","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjI4LjI0NSIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744637173","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744637173}"},"state":"LOGGED_IN"}', 1744637173, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3df45e6f-2f1b-4ab7-8832-8c6689f3cee8', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744637638, '1', '{"ipAddress":"123.20.228.245","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjI4LjI0NSIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744637638","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744637638}"},"state":"LOGGED_IN"}', 1744637642, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('0f119839-cc84-44db-8a15-bb4d2dc5faf8', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744874775, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744874775","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744874775}"},"state":"LOGGED_IN"}', 1744875665, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('de511fb4-1108-4cf3-bbd4-7dbc13251800', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744876695, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744876694","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744876694}"},"state":"LOGGED_IN"}', 1744876695, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('66001e13-2756-44e6-befa-1a615ac676ae', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744876805, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744876805","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744876805}"},"state":"LOGGED_IN"}', 1744876805, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('00d12999-52ea-4269-b0c9-a3ff37afb596', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744878784, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744878784","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744878784}"},"state":"LOGGED_IN"}', 1744878784, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('00b25585-75a4-4168-957e-88c49995d755', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744878791, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744878791","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744878791}"},"state":"LOGGED_IN"}', 1744878791, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('6c7eac9e-283e-4650-883a-5729ca60cdd3', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744881668, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744881668","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744881668}"},"state":"LOGGED_IN"}', 1744881668, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('f21dfa62-b9de-43dd-b13b-01ccba2dccbc', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745400737, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745400737","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745400736}"},"state":"LOGGED_IN"}', 1745400737, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('dfd96ab6-dd39-46b1-b30b-0ed1cc815f05', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744901399, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.25.15","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1744903263","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiblN6blBKeVF5OVRkS2h5alI2dUw4dyIsIm5vbmNlIjoiRWNsTlFDYm80Q3RZcG5KYTViRzQ4USIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NDg5OTY2NCwiZXhwIjoxNzQ0OTAzMjY0fQ.cHdYNOmGHlAfR1LXmGK0dhwWQ63JTdgwZmpKtm-nITw3DWzhsfDGrWVosWWPXAJF1lZsRp27RwPfq3be8qsOsMbHC8npQ0evuqQH86hK_PC8JAiaLkn91u3RJUoHW4LOFEhaS2TdK8sggAOBUkAspIohAJtpNTnrJS6X19HHScQ_dp5fbdywwytzvTG71TY1ppOimH-h8UP2whn9RK3nqbxhMNphc2U-OPwvkAD7wItf6A3wdBG8bnZiQCDX5mudMuvKeCq3RoYQtufjWTVQgICFzCMnn6LYjG9APZzeWohKlYNtGYJ6GDgw6v0pa5USIUkeCfFKAhI2jThx7Fb5rQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjye3DxfewxlGxc526xD_4qkePkgb75I52Dee3hjI6gm6ywB5jHDBb3lbZPHs3VaFbleB_TXAZoN5NZ0BuZAxPvl6hZTZqdw5LtzC9lrbaBODBmg4X1PXPBO4ynMsLYddze_7wO2sGEijR8W8Bh48sXzFI7octMKohQCJYaCgYKASUSARQSFQHGX2Mig5EcHgb2c7KrqvwYo7HLpg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMjUuMTUiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744899664","identity_provider_identity":"ptung230801@gmail.com","authenticators-completed":"{\"599f25e9-d149-4585-a620-ceba48d62b12\":1744901398}"},"state":"LOGGED_IN"}', 1744909551, NULL, 12);
INSERT INTO public.offline_user_session VALUES ('75de428a-2257-4f8b-a412-c28d8515eca2', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745032641, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745032641","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745032641}"},"state":"LOGGED_IN"}', 1745032809, NULL, 3);
INSERT INTO public.offline_user_session VALUES ('42cce9a2-513f-4f75-9d27-cb6ee9beeb06', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745034399, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745034399","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745034399}"},"state":"LOGGED_IN"}', 1745034399, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3b3db657-9f39-43a8-8d1a-5356938ebc1e', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745036462, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745040059","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiM2VGMTA0czdOeXl5SmF6cjQ1dmJTUSIsIm5vbmNlIjoiSFdSa3haNU12UG5zd2hzeXR1Z1VWZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTAzNjQ2MCwiZXhwIjoxNzQ1MDQwMDYwfQ.DVFt6HOgy749PLkNf-O8sQPbaKpwb1fgyEPp0b5_bF3obG536OzNXc1_4JIZep8utR19fyC49U5MJAtJJfNwK9yShcSDMaVdjswmjC4kwRWUyzH78yAqe4YoUPHcY3jqRYdXzTJOqOV9YRtsBmmiahgjjmiUgbUo0PFZWH2csyW7iTGcvyz6dcazfpdPhMu-vzntZAk_q0-B_xOE7ScoqCEW5sGlBI_lKpH-t66E2WXNhyFGg0APzTuVAnxH-g1zhAClOdBb_t2UoSJ6eQNvidYGelaOO271x__NR3pdsXX28hFRrw3Jg99O-LEdgChlt0-_vTnm0Basb3lZeTvUXw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjbqnMU6grTjzJ6Rubv_lg-aLK9pelV5qmc_f90lptkYmaUTBaNsiFJB_xiHoN3xMENZjg2MccV9_Hxs8bjowdgrzMXb8a7XK7_tNnzulMwqL40KtxVxuOrdcC_AwcPzVF6-xSXNoUzGXFugYz0h08Qaz-LuV1QYmzh34kaCgYKAV0SARQSFQHGX2MiMeFxd_LRgCT1aXd12JEkUQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745036460","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745036462, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('77f6125d-780b-4533-b193-931aae10eaec', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745036515, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745040113","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiX0h5MkFIakhqVnRmMWc4Y0VKV2htUSIsIm5vbmNlIjoiTm9oQUQwY0FTNnhiTjJGOWJtYTlrZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTAzNjUxNCwiZXhwIjoxNzQ1MDQwMTE0fQ.rsjtErk8NfnBCRYEfmorUs-476YZ-z-sulV48cRZPVNHtw_GgNch9uJOKKINsVJZGmcoaXD69zVPD0xVs1YTFIvqZMu4-vQcfMftf99skTkig3-OwWSmJrmS8bM-MusY4Q4IukLEPhis508tQvBj0kNb5YVpeAX9jXsN-V3nuFwkB1yJDSXyXdNc28cjqWnyu_ZhpVXMRwZCLFZIRU5o4lpB6fdJXWVRPrYfPeSme-eB7kXailSj0NGHZFKpyLQnrT8i0Ge2P4cTZ8Suc2gvh36MFzmRFA78Ay2UvPTlvtsuuMhzkxCZ41UyY98CtjXGmQflF1UD2ZxjFtfhKTIsJA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZi_TTrwQBXaBFxfgjVM-_TSOV_RDTWeS65R_23QY3SlM2RhBD4iFO3rlXok90IeBKtFtBz2Rj7IjMfqMqB0CpygLFrHTfWYWOyZ0A9JH1dDRqHaVyfAdwqHoFCbGQtQLGbY-WrVBivRGJj60Sth5JwF89PRVpk1vt3Ky98aCgYKAd0SARQSFQHGX2MiIiEGsVKCff6MBg-vNdMzvw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745036514","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745036515, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('b14ab8d3-7e2f-45d4-a43e-a35d7e00cbdc', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745036791, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745036791","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745036791}"},"state":"LOGGED_IN"}', 1745036791, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('d9a29f4d-b76c-4dcd-8719-ff17d8328648', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745036965, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745036965","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745036965}"},"state":"LOGGED_IN"}', 1745036965, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('8e9d52af-58ef-4d65-adca-1073c7caf738', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745037981, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745041577","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiTG1CanR1WWNyQkcyYUU5RjVZNWtuZyIsIm5vbmNlIjoiWDd3YjVJbmtvMEEwbFp4MFdDa2JoQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTAzNzk3OCwiZXhwIjoxNzQ1MDQxNTc4fQ.eLz0iigNXdZC70D2rD5usQUc2kQqOXVo2GZDZclgg3HoNhfWzdmmbY8zs1xVo5qr7xcYuJyfksqaS76rZ4jWoXK02_BZJp9BhRlIPi-qM44s6_T-x7Qaj-WbAqKYdhn_a-mqzvBp9iRS3zJV_W9jJf_sJwvlIgvzokNvzz_4CXVFSEpAuUfWxAMT5bN0paaD6N5X2RIjQUWkeXCjWNjJJhTxYyS4IiMhmuEr-gB6xQoyu83aS27bdL_TbWEdN1TonWF68uLfhfji8h5N8r7eBvPWr98QR2aTDcvpUZVPj_qqE4prHudJo7a2967MN4dibmsH_NxND5idev8WOz-JEQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZg4b3Bjzu_ZO5vFXqhwZ7QYbt-Jv6iF7P88aEo0YA5V166Tb52qwEn62w9qogzqoZTLXNfZUYmzpjJuiddvR79UzxMNpyqvqYKVEdmVM3UQogtek9K-xRGAicFEwao1ohOCYi0Fqz-JBrG0OkCCgVVKnuNPS2zkRv1lEkIaCgYKASQSARQSFQHGX2Miogw_RA5vZqDKWu7IcZ45Mg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745037978","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745037981, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('41380a6f-1faf-4a99-bd5e-d6a4e6132cf3', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745038002, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745041599","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiTDcxcHp3WDFBSzV1NWJydkJudmNxQSIsIm5vbmNlIjoidG9fdFVJejZkR1BZUDQ1bWU5ekNXUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTAzODAwMCwiZXhwIjoxNzQ1MDQxNjAwfQ.oHguRNStIpw6wncfLKvvgXaphdOEfJiiIkiuNiyrZ3WXuDcxeZTflwgXJ2HriXUSNqVahAa6dJv6DPo7yj5swdlNbJS8eg4knX9rKQXeQm6vNJFIqqwIZQPrDFR2QU33dIMHl8JRuRpESIRjZWZqqE6AYi51igdRMUkZTA7d4-t65J7DObDuxhYXyY-NoJsJUjmjqELqo8Z52fSN9jNMRHrwMMlcybAb7gpR_gtPvyzd8TMfqGr_4og0z8bFhCkDhZuCJmG1vKOqBrf8c1jJvWnkXKazwDq88XSXSXyOKhM6b6D-tT4TTf1L19B4E_f2WhPZIYsF9dWpcZFNhBbmdg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgD13nAG-jVCxLIPiUMuxlTFW6f91XzCHPfUxbXZfgewYc1O604sq7pBaYrym-tbsSJ-YHdJS6T1P5_GYVG_ic46-qLdYW4dOWAVcQ89O5u9_0EYLschX2IW9r6vsLEjfcxezmziwabwQjaG3cGh4PrKIFLl5FLVtef_wEaCgYKAV8SARQSFQHGX2MiagWLUQI6ypT-5xMoM3tMyA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745038000","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745038002, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('c6e2045d-dcfe-46d2-a312-2295aca54a2b', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744901261, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.25.15","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1744904837","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiWmxBaTJreHR2T1FEdGtaSTRlajhQZyIsIm5vbmNlIjoiQ0M5cTFvTTdSU1RtdEdCR29XdzVfQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NDkwMTIzNywiZXhwIjoxNzQ0OTA0ODM3fQ.FW9v-bEoJaX1zQ9RLUUKaAAuOTX4Etg79Zahx8IMaNrDgo-3XRA58keYHYEkLzXwuxHoRLIDOIJ5ngiU2jWqVGSVZDRkrKnLRnXkfh43KOqqE4LcgMQYwO-LfG663MNPJwk-mjSbZyfYF11tEqDeMp1Di1iAaVqFnhHFVCOXRqvKcVzp6O9z_VEXfO8Kg4ZqkPynZLru-wh8OW8UFwDSxR4KeMvwGckvumUAStF2tC9ESyEtnV9UZCyETnbhkidDLljOacuAW992mJ-LY-U2ZSoRdbuIeHJ11t0fDXVM-NY0E6MhfMoN3skrsFKpPFsrppYpxmAY2hqN-vTbQMpzCw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgvLkPepLWP3ePsOuF08EQEIxxXCjZwATfBpwubgma2nZPY6fzYlBsUstTbgcVXIAi7OVMxBKFy7Byj4aDWsLqukIqC4bMFbYjQo4bBgoO4m9ZRaR94h6JBDBx0d1TQH_3DJQkQOztnY6oolPyIpw0mQ-G5_03Efqvw2wEaCgYKAdYSARQSFQHGX2MiNgwz28XtDx7Em4XYncEL8g0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMjUuMTUiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744901238","identity_provider_identity":"ptung230801@gmail.com","authenticators-completed":"{\"599f25e9-d149-4585-a620-ceba48d62b12\":1744901260}"},"state":"LOGGED_IN"}', 1744901261, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('55f12bbf-06fd-4ba9-8141-712684762ca0', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745038014, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745041611","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMThwUXZ0MUowRU5YS3NYeWx3ZXpadyIsIm5vbmNlIjoidnB5Zjc3SkMxaWVPMkItOEZzb01PZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTAzODAxMiwiZXhwIjoxNzQ1MDQxNjEyfQ.fuINRQ7JTRrEZG4Je4oitwyeLAlPlNhPSlzi4jQjGmbmxR-8aUVnBxPRt-leH9YLMNTttKSq_aznC0rIMGBkrAqTFsr_YY9ou7snmXfhWGW8hoNT5DuU757khTMNbcJR8031Pa_ttY6Jf_593Xn5Op8ucErcv-grtT-Tpb7y_N60NnNp0AJNw0vVzTp6mLvWoEqSDjrECYeMKyNAZ5UKXrMQt4WIK-rTYx5FlssvSVbY9fBFXyPT1Xnor6T5lul2UzYotGI2c1f4hlt-0yAqiR6XuZ8cpbmShK8iBGENFNpv5lr3xqSiQScNWUBfJN5LzIjXulz1CUE5DCho8Riw0Q","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjloSJZYMtc3S1OI-TKHRLGj_1ps5HlMwRgGrOrorDHvuzToiEuQQ1ZgYlReJnKEwmlsTFRjQrfhASjcJGlp5HVKHiFnGzuXa_Jiyh12PsVC-ILvqwg_cprK5UJKzy5qQ8nGrIWYNpZptxbYTP6NaEpLSLvYxqnM83_SzsaCgYKATcSARQSFQHGX2MipgjfycgTVQ4Aiqf1u86IsQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745038012","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745038014, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('0e854830-84b0-44c3-a3dd-ea469f32c832', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745038327, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745038326","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745038326}"},"state":"LOGGED_IN"}', 1745038327, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('ca796091-4610-403c-b68f-56510edeec5a', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745038331, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745038331","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745038331}"},"state":"LOGGED_IN"}', 1745038331, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('fba7fe13-67ff-4a7e-abf2-0a5a54f5274b', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745039709, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745043307","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiZUdqaHl4ekNCOEk0UU1CVE9mYTQ2QSIsIm5vbmNlIjoicy1IeGRVRHV0SE1lcFlnXzBWSkt2QSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTAzOTcwNywiZXhwIjoxNzQ1MDQzMzA3fQ.RtDtFT53P8pg_jivd2PrUEB8ggtn8XBV48P5s47NmJwBWV6lZaOYdBjPkZHwVLrljghm0v5Qj-t0b-KIiYGcHZdr6WViMulOlfruvCHn5Tgwr_ZvlKdSr1Lg2vcD5SJDTNUBvxlsVGzxuUPVioxK3aCLZ8Uyj3yA1F6txP-gD-RQ9Uiv4OgidKT2ihMDxcaw7lnuM66IhobmTozZgGF6QLAa-S60I4jotZD8COSnu5x1aUPBlVu4y2NseA-g8x1xpkJxM30dM_wDvl_RofZF1LxtiA1IffaRYUy5IdlDWTmcoo8ZWZwWb2RKi98v1fuQyj2y257MgWmdTCaNq4pB3A","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZggIfczqw67HWAXoYwEKhvBQvT0lejmjf74e7A0i5Z3kgwIoCkHdVYePnBYggAKxvRQeSfoskVVHSYg-hynMIUHpZLup9VZUnl86YV_pCupuiAcEMaCcvoWkbqgMvra8vQCd53leWNbaOczIzKrMJvfCa7M-PNfg1dBqL0aCgYKAe0SARQSFQHGX2MitbQPm7fXmdjxFhxaT8ATNg0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745039708","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745039709, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('9a5da714-5d92-4487-bf6d-7f382a72b407', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744902472, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.25.15","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1744906042","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiRmtoWXNuWkRCcHlSNUY1TXpQMGhtZyIsIm5vbmNlIjoiU0N1TXpGZmtQdUFPWGxFaXI1M1JMZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NDkwMjQ0MiwiZXhwIjoxNzQ0OTA2MDQyfQ.nzJ3XOuMPAcKxVRWI4o4AWmlO2kx5RjyE4BDh8tfeS4AQ7HBuTDbhl-chLMCxNlbWBAxdMby0nyEJSzVHesK2PH1mjbfijsxSKH6MsPd1lJdDkcKgKGGkkFNvUBO7wRSoLscapJ36dVqZfDZCxulNvoX--srPAHiiBuYzSFuj5CKjCBmxi_NAin0qGIVoZBVV1yGB582ouX7rmjC8QgtcBwvJBRT1GlqdOBX1UlbnxC13Y6p7OMmIe0eXqvkmmWX_mbApM1ev0y29Efg0JSibW1ROjFxR8g9L-Hn1C2u8jPRYuFlhR8euiTdtJnvLBQMWGGUedFSsODdEXpaU-2P8g","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZglD8De2ixP0ahj-zStFuK7QRjdtNod-ftIVXUT9TsEsI-fFMfr0oCROBCxtYXNPJGR4f8Rze34ZIiGTXS24JhtjbTV7Pq4pwRzPddxT4LMxywfUEcMgqmD7ewpLsvZC8zlpTLGjRz-ORR9gP7iK_p0sYuxCGZ0fTGGgawaCgYKAbMSARQSFQHGX2Mi9NWtQaJC6KEoUBl1sLFUeA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMjUuMTUiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744902449","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1744902472, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('b39665ce-4908-44e2-abf0-91a56f815d64', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745119493, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745122976","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiNlYtOW5EZVFmbVlUOE4yTG9DTDdSQSIsIm5vbmNlIjoibE9mc1phbjQ0VXBkLXA1dkIxMmw1ZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTExOTM3NiwiZXhwIjoxNzQ1MTIyOTc2fQ.Ct1lCBBVWndwq04wTvBci4URTDZiS9pOlBCPbf5LMzYSpvFuxkTkBHI1YolsjGBr_hlKmbTGvoxs9soNuVVNdj5itEplu6X5razMS-7UfSXeBdMtGsXbYh0kzDq6ntWVT_S9s25NejS_Wkh2AtEb0PY643eP-wod51Bbm7IwqpdjldiFMDWiW2bl969ENw_Sfs-WZPnh4pl03cgClGxuQGV9we9RkW4ksEPBGDb28yuydfqBq1SUjg7TIDBq6F1zmyhzeunBiAv0LLPCLji0JU2C57mqovpnHAAUfC6IY6R4qpm3oh7lrw_SAPzENI8Lk2ph1mb5ioxUPrgwNp_R0Q","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZi3bZSoYUsK2jtseO0UfKIsl_CUHLxdAy5ZQM9GdX5zcDSmvBufvMZVdlTnj7XNHBAPe8ngQhSljRnExvWGg8amxeij8fOI6viwNv1CU3EYAoFe6Z-2M63rytOiJKKNyWZPjMNih0DQJxeg49G-AlPI3NzmsKHJzQfllmYaCgYKAYwSARQSFQHGX2Mizzk7tAx4sDzd6-qs3U9EgQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745119377","identity_provider_identity":"ptung230801@gmail.com","authenticators-completed":"{\"599f25e9-d149-4585-a620-ceba48d62b12\":1745119491}"},"state":"LOGGED_IN"}', 1745148937, NULL, 46);
INSERT INTO public.offline_user_session VALUES ('73f3e370-bf38-4441-94df-6e7e811c3b39', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745039947, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745039947","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745039947}"},"state":"LOGGED_IN"}', 1745039952, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('b897c60f-458d-496d-a16e-8b7c321dd6a0', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744904235, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.25.15","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1744907833","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiS0djeUdDa091SUxsS2sxRDFGdUZBdyIsIm5vbmNlIjoiNDNRdTh6eVo4TFpjbFQ5Ml95Sjg4dyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NDkwNDIzNCwiZXhwIjoxNzQ0OTA3ODM0fQ.bePil6pUfUWKov-bMzCnJRzt5bWFHa1tFaYhWbQ4iM9Q_4mRZsaIcuPG3y-Dxb_3LWK6ebfFHmu5uFk-lF1i1P3SUDaT-vYPmHcsgmNkJPS68LG45fWq62QvkfVprAPwj17Xgk46Nd7weupfDZz38QKA12XpUN8BEnPQCpZyAKJTr75nlgqwPukjyFyAmf0lMvJstAZ1u9R_r5GQDkhzzZIUO2wAcc5EXYc2HB8QH69KigeFPuE69RtbQA6eYzGpeqfJN0kvkEAnpGrKkB4hk8iYr3NMnPEPHCoWO-u1bkixNyGNmRmlA5t-1o8Z047FtHDznozOgHqW3vU_0NQGMA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgz0PJCXq8et2RLKgidqi6icDjBBRqJTrhIss9H_ZZQdsm_vfPSHixSP-DpkU4Jb1C-FL-wTXqUXpN8AGsaWe46uIcmQQ93FJMN0usL9Bo8AniA-tsEjrJdsflOzQaq0J78B8fLIb-QorcGxOMkd36Ufj2hb-RD2FPwfd4aCgYKAaYSARQSFQHGX2Mii9Q6DuTr8nOlpEusAKg6aQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMjUuMTUiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744904234","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1744904235, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('c3ae712a-3438-4c2a-9163-b48ae398a255', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744904244, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.25.15","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1744907841","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMDRWeTRLZXo5VjFmTVJLTmtfZUJvZyIsIm5vbmNlIjoibUM5ODFsaC1UUFgzd05hd2dYTGZhZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NDkwNDI0MywiZXhwIjoxNzQ0OTA3ODQzfQ.ajh7v0XrCQQi-URi-touOJ5rn8JKs_aewfPNnO24bX2ZItD_gysgtMOwlbT3MHZ_Ybltgv_Z1VNjcB_NuB6X462iqRSeE4Gb26XmGabzarfOCp-4ArsEd86DG44QYYM1s9vvzNnIxcbKOvHLgR1Uoqs3o4HjeRsWgLTfP-opTAHVW16nrTqrK9kxvaqhY7-G-LW1z1ToZhjSTZZm4fyfKOPNAN0ryJS_nBUhYuNwiXhHoBN5eULxgIpjjtHHhLUc4pt4DytrHxejiNqazQG5JR1HCeXEAYVYPzXTAm4jLAlixhd82wghxWEa9eDraUks37OGVwy6GOZZTQ77iICnaA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhxRHiM-TT6xdEF77Ads0YTdY8CHzonjHZqzccRAEQYZB6tTl_t48_sJ6U497rAoD4Y3KFVvu0UK6t0gPTD4nyceV-ksqMhRnBl0go41Wxn94vikV8h77BvdD6K1r53pG4UjogE32GE6ilZ6RUSJmx2R8AEc3A6k-qLoYYaCgYKAagSARQSFQHGX2MiFvZ-gZ9-Qy59hD3MeO22Ow0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMjUuMTUiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744904243","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1744904244, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('5a2a5c64-42f5-47b4-bc50-52225d2879dd', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745041064, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745043318","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiLUtkcnl0TzU1SWlUWW96RFAxSnNkdyIsIm5vbmNlIjoiUG5hYWZpOVN4b1piUXc2RGlMUDNuUSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTAzOTcxOSwiZXhwIjoxNzQ1MDQzMzE5fQ.HAlgMM6acf0RDX-dj2TU--J3eBnsTBO0IOVBcE9iATINKx78Lypx82yqarwogBtl-0i_70PtBp6KuxF9m2Ku8xTF1LsD0lWGTqA0hrcI9I8p5qPz3ErdVnjM4RlK2JB3l5UKWi4T8jY3PCS4VXPH9Fjfb34YMxHsXeTaWeX6H-orPjeu7sDDJwVPpdIYatphsbrg4udHx4CrrTvFm21b_niP9XqQ0X1DTmMBUM1q7dB48F5dfzQ0Z6rTzxPmKzla8XQWJ2dWWLs7RxrZJx45PKv5gQR_YV9s6egcgz1PfroVw0icjw8s9RB8WFGIyKI8zH1gP-TB8eEG0ZdWFuq-lg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgEr9XQUQp3gIZYKgoOw_FA2hVVXMakXePDuBVeHTBSDwq-gAJwRPjNCeDan-Og4FFx6xJnKPw79TZCVN_KZCgqinIK0DLbDcV8U_3TiTcowH2bvtTa_4H6XTqUb0vb8sFI4U_-jPP0ryoRTkR03KzQilAUp2WrfI3Yah8aCgYKAZYSARQSFQHGX2MiVGkDN_MJVMdnqm4yNSQxNA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745039719","identity_provider_identity":"ptung230801@gmail.com","authenticators-completed":"{\"599f25e9-d149-4585-a620-ceba48d62b12\":1745041062}"},"state":"LOGGED_IN"}', 1745046578, NULL, 10);
INSERT INTO public.offline_user_session VALUES ('933839b8-afe7-44ac-b1f0-b3347b57c910', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1744901207, '1', '{"ipAddress":"123.20.228.245","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjI4LjI0NSIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1744901079","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1744901079,\"599f25e9-d149-4585-a620-ceba48d62b12\":1744901207}"},"state":"LOGGED_IN"}', 1744906621, NULL, 15);
INSERT INTO public.offline_user_session VALUES ('7c0e69db-de0a-4d60-8686-0ddacbfb7a92', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745041469, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745041469","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745041469}"},"state":"LOGGED_IN"}', 1745041469, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('13c3aa2b-b252-4987-a8cd-61aefc6a7557', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745140611, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745140611","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745140611}"},"state":"LOGGED_IN"}', 1745140611, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('bb75afdd-1e49-450f-a2ce-a40bb8ba552a', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745041473, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745041473","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745041473}"},"state":"LOGGED_IN"}', 1745041473, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('efc7dd21-d5d1-4d24-895b-43d40518db65', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745042966, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745042966","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745042966}"},"state":"LOGGED_IN"}', 1745043992, NULL, 2);
INSERT INTO public.offline_user_session VALUES ('5070a082-554c-4db4-ae61-d15f453d3a83', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745044193, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745044193","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745044193}"},"state":"LOGGED_IN"}', 1745044193, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('4dc96619-b743-4cef-a75f-f802b8459408', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745140744, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745140743","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745140743}"},"state":"LOGGED_IN"}', 1745140744, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('01555d93-df23-471f-aff8-ab283a8793fb', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745044359, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745044359","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745044358}"},"state":"LOGGED_IN"}', 1745044359, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('dabb92b8-b9ca-4877-a6d6-6edd35c97e5f', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745140615, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745140615","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745140615}"},"state":"LOGGED_IN"}', 1745141134, NULL, 7);
INSERT INTO public.offline_user_session VALUES ('5638a74a-fd0d-4565-860e-a54538e9c034', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745044364, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745044364","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745044364}"},"state":"LOGGED_IN"}', 1745045239, NULL, 4);
INSERT INTO public.offline_user_session VALUES ('a4da7828-9c60-4bc8-bafb-b4c0143ce2a6', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745141976, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745141976","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745141976}"},"state":"LOGGED_IN"}', 1745141976, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('e9063e83-ed81-47ce-b86f-e8452e1cc64c', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745141980, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745141979","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745141979}"},"state":"LOGGED_IN"}', 1745143275, NULL, 7);
INSERT INTO public.offline_user_session VALUES ('eafc1299-a750-4913-9825-17053ddb9eee', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745046640, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745046640","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745046640}"},"state":"LOGGED_IN"}', 1745065716, NULL, 43);
INSERT INTO public.offline_user_session VALUES ('89d2a229-439b-4dcd-8cc2-46e1b4d8f435', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745143383, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745143382","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745143382}"},"state":"LOGGED_IN"}', 1745143383, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('267fc1da-54da-4647-a0f2-8f756afc8f98', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745400741, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745400741","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745400741}"},"state":"LOGGED_IN"}', 1745400741, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('cd2f9849-2aab-4009-83fc-b6df9171cb87', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745402385, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745402384","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745402384}"},"state":"LOGGED_IN"}', 1745402385, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('3dcf0c36-aa13-4fb8-8873-b97435e72725', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745143387, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745143387","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745143387}"},"state":"LOGGED_IN"}', 1745144719, NULL, 11);
INSERT INTO public.offline_user_session VALUES ('3620226a-516d-45ee-9e56-11dfa1fd9945', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745402389, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745402389","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745402389}"},"state":"LOGGED_IN"}', 1745402389, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('4a6bf8d7-b50a-4490-a9ab-b741365e1fe7', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745405013, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745405013","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745405013}"},"state":"LOGGED_IN"}', 1745405560, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('2c5456ae-80a1-4bf2-845c-bcce389dd14a', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745419102, '1', '{"ipAddress":"123.20.239.85","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjM5Ljg1Iiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745419102","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745419102}"},"state":"LOGGED_IN"}', 1745419102, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('f1c3a42a-cd88-4ffc-b1e1-f4eab5893f28', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745420952, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.36.79","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745424549","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiaTdCaXZtYlpsMXR5dks1c1lja1hpdyIsIm5vbmNlIjoiNjR6UUktNUVBNDNQM1otYVlKOWJUQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTQyMDk1MCwiZXhwIjoxNzQ1NDI0NTUwfQ.Q5a2e95GVuWL_SdsI51MvnC52Jt5s4tKYP2LspSC1MQ2k_uYDLA6yvdN0iONPfqk1CUtJHieYBWV-QWdwvCBCghG8gY91BtlALEHQ99WuGDWuc99lN_sfm4V8qWsozQBiKlMbaHjwJeveqEsUKMaGW0sIgf9y5SFckduBzbYhga5Y4vPMatCwFuIXnWnEmZS6QPHCvTKdMXY88EXvdQncfxKbC_8T8NBJzlH8FZbCCvFV9Cs6I_7s4QshtP6NupGpvH7CSa6KrCEqP56dOwNLq-Wnok7Mx3qdmUkyQiCcB9Bjg_tYAMZy5Qa_jnX_7qA8WotQJ0cplGy9iLZ9GJf5Q","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjRC7LTZm44hIfCdF7WHDIHkq7FBCK4lsi2qP5E2rZNu20uBp31y4ZRbpwA1sieVr7WMQdgY6HXzCMZKNIAKlrbyT1yr0fvUhriwoELdzZp9YAUu4RVAGkn3q1iJJaq5DqZEck8OOcFYdgu3p5mDJ-uWfGsCao6WotUTNAaCgYKAUwSARQSFQHGX2MiqIz3IcdlK125UMRNaK-uVQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMzYuNzkiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745420950","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745420952, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('d7d22990-d62e-4bd7-82f7-6777880f06db', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745423073, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.36.79","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745426664","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiX2NlOWVXOWRBeE5ocjZ1SlFxSHhRQSIsIm5vbmNlIjoiV3hvNm5kUEFtM2VmbXZ2Ykg5ZWR4dyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTQyMzA2NiwiZXhwIjoxNzQ1NDI2NjY2fQ.YfgjRhsuPMGNbDWpKD5NM3U9wbDF15AH5rG-cx8HSv6NPL0I0dtF7HJ6QYQqQZTlk8S8yZl1PmOftIdAbqW1m5xFRPTTS7jwgN2lHSUuHQmKlRe2M-55_OO3-yK3kng-sP-xHpxXuczp2wKXDDFIwANeLQG3fgDV_YiwBiSMo1YuygJDybtvrLtd_fyHJ67ye_K1ObjBHRzXoPBSrk99uFJR5kNB-Ars3jxMTjoyh0pSMff1SQa1WKqSfUWeOTIm_I-Slrq7n3pG1vPLhVoAuNLE4hREQ8LvKml8HUz1T8UtMMS-mAGGa42dbd1p7_JvmoW0hBGvokqwFX8IIS3fEA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgvaM0-6MdUFCkzxttqj2O5WfHrKYF4ZM9QHXa_rhFuKQ1DL3OdMhzMyODfQngixvpyeTKbLPaIxpkcn2Jd6ywozvGLBydPYLIorP3pliO0SIWmbrQbqvAcE1cLjOuONOniFUkCBQBEFH-y7hZD_lElIacbZ0SHpGp4BogaCgYKAQsSARQSFQHGX2MieCqOuuu640kPmPxLTq_OGA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMzYuNzkiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745423066","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745423073, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('e96ae282-fb3d-48c4-9d15-798e2e8cf887', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745423087, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.36.79","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745426683","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoicmxaVGlrYTNRVndiZnFMN3Y0Qk9RdyIsIm5vbmNlIjoiS2MzX1dHblVjcjgtSkxzUTN2SGhNQSIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTQyMzA4NCwiZXhwIjoxNzQ1NDI2Njg0fQ.hOgrQM69wv1UwqXhqb_XYAsy8Xq3MbEjHOBVYetWwFBGkJjlw2r-9B9V_kOlEsl24FQBzhxkF4q3e3tOA_s_5QFS1lLl__d8l73RBkh_meAj9YLLj-ClM1O4JS9k4LVFqwvUeWhsei0SBn1-a63B27DIxqqFppwHLKI9FkHEescBsYTA3Z5ZCtJRpvgFkw_Rs2B6it9LZzXOjZr_xKme4BEjFIJWDvw5S1KPHil8hRsB3fQfIp_77cfOxq1UWe_7CtJi0Eb3muXxrLvEquupJV0g4ENxNCoq_RondZRIJFjPJ7cb30a-InryrSJp1IOYydSoPWyjnmrvx2RoVQPdXA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZjfXuU3lol5zaXW1sOmbEXVCu3ccHtdUq68ZMAH_hJlB3hgydVmtbkh_OG5rwikgr_Kq6Qj_dbSi7drd1aV-bksg6ZJlgQqBZ2RbVsG-xxZ1VwL73H_QmKfszxKGbaoO0GpjscFf78aoKp9frAfiXB0gvrYu5p8KzHYI4waCgYKARgSARQSFQHGX2MiFeBrRvOXhyPqNj4iSngj3A0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMzYuNzkiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745423084","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745423087, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('dd9ccd28-9792-4a82-84e5-c40f85ea2637', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745424462, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.36.79","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745428058","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiaXhsSGpWZGZ4YWJRQThxemptb2dWUSIsIm5vbmNlIjoidUcxaUFRX1JxY2hVOFFWZS1lanp4USIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTQyNDQ2MCwiZXhwIjoxNzQ1NDI4MDYwfQ.KmL2qN0WRzfgXgWPHnZf9LDfnvPnHxsntir9Fb8Y2MWWf6m3L0EiPsr3QJXw32Ge6W-uFq6jINbSATVuDAwzTT8gI0Gos0EKVbR7Pc1xfuknE55lNxXUIk11ne6970XYeVGwtXnig8_VmPJtraFo2dZZDOYvWAk5vO1bsKuwZL1mYEK8ozkuVmcJWIIc4r0jL177qxyIxGhizW-x4ZwGLIf7wGjgYXu68GLTv3FHaGKmQ8uqMeWPsO4kJ90fosmx6ZlPACALhDwvnEsa1lPgb11Y9eCv6D2uZQ5_RduBJ6oGtS1fiAWMaMWSOJnNB-hTtcpV2pbo1K7opladSBjTag","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZgQkNXYP9Th2cnylhkA2cgLmQvT_3wCS3GJnl-8AjI7Sn3hZYZ9MI3AkLkp7XXntFlPsDz_8w_xDun6Hfd7YIh2kMKXtTJDy_GCILQoCbGc7_33l1nxSqCIS-jdc1JOUZpDyPWtVem3v_2RSVirgvkJ1ziDAMMZldDE15YaCgYKAXESARQSFQHGX2MiWjVgIxMPwIbz43YiyKRoaQ0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMzYuNzkiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745424460","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745424462, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('82cecea6-8f5d-4a76-b6ff-e1c432e09279', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745429373, '1', '{"ipAddress":"123.20.239.85","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjMuMjAuMjM5Ljg1Iiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzNS4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1745429373","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745429373}"},"state":"LOGGED_IN"}', 1745429373, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('7d092b33-119f-4205-9272-f59f83d342bd', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745146828, '1', '{"ipAddress":"171.224.241.12","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjI0LjI0MS4xMiIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745146826","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745146826,\"599f25e9-d149-4585-a620-ceba48d62b12\":1745146828}"},"state":"LOGGED_IN"}', 1745151341, NULL, 10);
INSERT INTO public.offline_user_session VALUES ('fa84af14-2b1c-4ffc-bbd3-28ba592fcdd6', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745159881, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.25.15","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745163477","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiX2FBalJhTHVGUWRkUWEzcWlBazNKQSIsIm5vbmNlIjoiNDVlemExNWJtVUwzTjdQRGhhWkdlZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTE1OTg3OSwiZXhwIjoxNzQ1MTYzNDc5fQ.EwQW_3pfceTXZ-uN39Bdb-f_9_uPHD8Bp4HK9u2WfLMPTCqx1j7FpO4dwZicLegjmg4AA3cvcxEnRsN02S6unKlC-1NlQL-cAqZHkCNLwZku1C1rBzAdRBBpn6y0ny2xmHL0o5CXauJh6imBFbnz4s_RTQnxbvUEgjelNI3vOow8YMFHdx-zORIVUh2i8j_NLIujK5TgcJz0GH8E-K5ZtXh7j-R5zEj2gh78FreE7Tkfk8TQ3RRZIPe_vMslOcEcRinYE_fuog4_nIqu3y2JokWx2a4sKFZL7dsLQbplejcJmdKtm9hEb-udhOCmk8eD2yvMGh58dIfkvxvAz6t1IQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZg8ikWEr8N-5bZkVXsNkmYNqKuNfEW0WjPf_SKGfBqRcejsL-A2Y1LvmzZaiR7mtzaTKQNG517CwEyCUYH0ZtnVXrQi582BxAR3fp4g13iFR4emkeYrL3UlRRovpxdsLgrs91G_U74UYyvCa3XqzmVQRXFFAzMBTmrPbnMaCgYKAT4SARQSFQHGX2Mi7czBvCNVVsR-Jv950ky44w0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMjUuMTUiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745159879","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745159881, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('71d7d890-8278-4e53-bbd5-6c4ddd50ba57', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745161551, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.25.15","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745165118","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiSko2QkN2LTJXYjd5Q0tqNlFxZ0IxZyIsIm5vbmNlIjoiMl83WEh4LTRRRnVrOGRhc1djbUh6dyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTE2MTUyMCwiZXhwIjoxNzQ1MTY1MTIwfQ.gRBGk_lD3YTRmWRsF81EP8Sc_OdsXPheHrXS_TjuJlYyTqjUEWMW6xto_XDeqExJAyNB3EFEDBIk86Vvm3Vwo_Muv3OgstjaRK9w7K2lG88I8iuxQA6-fFhMAYijbPRNpn-1D3wpGX3CK1JWQbPgwCc153yg92VKzLJiWkshPlv5Xydj-oMUgGUfTjSWHvBa2MZ2VfGG_PETwhKDMKZ8H28ADhvY27FUe4DBufbfP0I8WPjv5j6vQCjA0cGJOyua1D-bsWnNvP1idJiLpk4oHHEB523lKoA97oDhoBLiyTPrpP73pu1DrDc5nX2-d3aroTgnOQUtd5-beNxowaqZ6w","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZijKEEaV7MM1pBdtzh-2fabW3R2Nf_cygqdjcdhnMf4bMgN_9rNtfxiR9wAOFF1x1bmUE3OBWiRb3Sv5oONOhhcQ2-z3iJakCB74y2gVGxx72cokb-SziAZyuqFFTQOQ6yypdrLabhN1ylNHRmaQdXRA90SE9UDn7fr0E4aCgYKAecSARQSFQHGX2MiB3tFTwRrVKD9wrEdrIrQOw0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMjUuMTUiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745161520","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745161551, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('ed269093-c362-4847-aec7-547b032c4692', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745161562, '1', '{"brokerUserId":"google.115231815514181279511","ipAddress":"118.68.25.15","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1745165158","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6ImMzN2RhNzVjOWZiZTE4YzJjZTkxMjViOWFhMWYzMDBkY2IzMWU4ZDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNzc2ODg2Mjg2MjMtdWhxMDV1YmlwdDE0YzczNDF1YmtnMTA2cW91aW5rM28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTUyMzE4MTU1MTQxODEyNzk1MTEiLCJlbWFpbCI6InB0dW5nMjMwODAxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiSkNRNDFFMzYzWmxYYjQyVFBIS0w4ZyIsIm5vbmNlIjoiUnR2VVVfbklVQWx1NG1mOGo0UWstZyIsIm5hbWUiOiJQSOG6oE0gVMOZTkciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjNqY3BJNThmWGNkSXhtVUZTRVVtTzhxY09sdmFKcGlJaWYyUEd0TVdOZjBOaXZoNDg9czk2LWMiLCJnaXZlbl9uYW1lIjoiUEjhuqBNIiwiZmFtaWx5X25hbWUiOiJUw5lORyIsImlhdCI6MTc0NTE2MTU1OSwiZXhwIjoxNzQ1MTY1MTU5fQ.dI68t5q9jpCemRP23_XkqyA8SSRtVtFdKEkKI8dtuTE9xIf_YnpYa6QN3xrFNBRK9MmnFhavvJs8TFDUL_iEVYz4ZlMgwRtOMM7_7UtcZ9FMxAtJFLjhG_SOPNb8XNizvCcQUH9iRPLI-L_KgHoZYiFZHixoAJ-NFJ3imkprYwghWxlpRF4NgOo3MkDNXjRfd5Cb_Np4C1Y_qPDwoIjHv2-UrpwSJ6pYcCHdAzQmyZCM6Ykzwspq-meFK63f3ZZ8ltWCvlmsHG6scWz-0ELT753G3tydBS4jmVB-7KksKYrZ2S996OqINSvFGpzxUUl25Xf0-QQKbNypFQpqDlgnxg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0AZYkNZhOaNObTRb6q8MMfdQwziQkRXp5JzAWqW_iGtei7WorUGk8F40sZX32RXxAh-h0rWItpPftQX0-Q4zLVs4E27Ex6e89DL_SVnQsXbd9ytNEA4F5tMdhh4msT9eMvJSEIhqh1ntnY4BxyNPiFFlaK22YC4K94SnU53h5c9EaCgYKAb4SARQSFQHGX2MiWIAZSGiKWwTRc7gse4jgwA0178","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTguNjguMjUuMTUiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM1LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745161559","identity_provider_identity":"ptung230801@gmail.com"},"state":"LOGGED_IN"}', 1745161562, NULL, 0);
INSERT INTO public.offline_user_session VALUES ('929c6c03-7fc2-436c-ad20-44ddd6378dee', 'ece32357-5624-4a80-9367-58ae81562601', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 1745208941, '1', '{"ipAddress":"171.232.60.160","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjMyLjYwLjE2MCIsIm9zIjoiTWFjIE9TIFgiLCJvc1ZlcnNpb24iOiIxMC4xNS43IiwiYnJvd3NlciI6IkNocm9tZS8xMzUuMC4wIiwiZGV2aWNlIjoiTWFjIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1745208941","authenticators-completed":"{\"c9df53a5-e217-4195-9ffb-53535f4fb49c\":1745208941}"},"state":"LOGGED_IN"}', 1745208941, NULL, 0);


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.policy_config VALUES ('ce1c5c87-c666-43ad-8075-ca2ae2e880d1', 'fetchRoles', 'true');
INSERT INTO public.policy_config VALUES ('ce1c5c87-c666-43ad-8075-ca2ae2e880d1', 'roles', '[{"id":"0b4eccd2-b305-4026-9705-4b9fa028cb1c","required":true}]');
INSERT INTO public.policy_config VALUES ('a863d98f-759f-4421-a553-5ab9c376960c', 'fetchRoles', 'true');
INSERT INTO public.policy_config VALUES ('0f980173-3ba3-4e30-9cd2-a2eabaff30d1', 'defaultResourceType', '');
INSERT INTO public.policy_config VALUES ('a863d98f-759f-4421-a553-5ab9c376960c', 'roles', '[{"id":"435aeb6e-b775-44dd-9387-ce3dc556d2b2","required":false},{"id":"73d2123e-fd74-4ba8-876a-d0decdef85eb","required":false}]');


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.protocol_mapper VALUES ('b79948d7-6cfd-49f6-b89e-672eb9e6383f', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '84ebcc31-3c0c-442e-88c4-831383ce7b7d', NULL);
INSERT INTO public.protocol_mapper VALUES ('dda27637-2718-4e2d-9354-ed710fbeafcf', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '1badc467-6237-4e4e-8e76-2040f96f32c0', NULL);
INSERT INTO public.protocol_mapper VALUES ('acc20921-044f-4022-b02c-924373575a7d', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'b22c1685-375c-4d89-8235-42a2710575bb');
INSERT INTO public.protocol_mapper VALUES ('27193ec4-58d1-460b-9b95-534a72f92c99', 'organization', 'saml', 'saml-organization-membership-mapper', NULL, 'cefd84e3-17e1-4cbd-8478-55edcec42b37');
INSERT INTO public.protocol_mapper VALUES ('7f6fb180-ae8b-471b-bda1-c683bf94f118', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('958d75b5-7b99-4653-a17b-9cd9e3368e96', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('2523b0b0-723d-4790-8388-3a4948a0eefb', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('7453932c-de2e-4c7b-8dd6-44140bc7f481', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('ecfbc117-19f2-4d02-a209-3af0574f1eee', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('5d82e001-67c8-469a-a794-670efacca05a', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('0b4b6ff8-4647-4aa6-9e75-fdfccec6f60c', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('0795f68f-2d2d-4689-8292-9a829f6bace0', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('733118e2-9dd6-42cc-b83b-232c198edb76', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('826acfd3-93e4-46d6-a143-dfaba0d61260', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('07ed1dd9-2f48-4b9a-b893-7bc69fce6815', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('703c024c-5958-4a69-8afa-6927018c1aa4', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('5ab3ae85-c8d4-4082-b516-ec8fea475b51', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('9ef2780e-462d-49a1-a2f0-4b85c0105d8b', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '459c69bf-a9f1-4e3b-a409-893c5f00d62b');
INSERT INTO public.protocol_mapper VALUES ('1c165a1b-2b46-42e7-b3aa-e0347a912cba', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'e3075fee-3825-4b1e-83d5-b407887919cb');
INSERT INTO public.protocol_mapper VALUES ('f15985a2-c068-4521-9363-9418d566470d', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'e3075fee-3825-4b1e-83d5-b407887919cb');
INSERT INTO public.protocol_mapper VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '8d935235-1c1d-4901-a961-b7d709422674');
INSERT INTO public.protocol_mapper VALUES ('28ef4193-327a-475b-84f0-811f81f9e26a', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '0f950e6a-2aa5-4201-8a7b-3af0879c1e90');
INSERT INTO public.protocol_mapper VALUES ('afe858ea-654c-4122-bfb0-8ccc894f6002', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '0f950e6a-2aa5-4201-8a7b-3af0879c1e90');
INSERT INTO public.protocol_mapper VALUES ('be710668-1459-44c2-b0cd-b7c2ade7eeb2', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '8b514977-3187-4562-bbb2-d3f9218405b6');
INSERT INTO public.protocol_mapper VALUES ('f07f718a-e7f4-4c03-b894-e492c7388084', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '8b514977-3187-4562-bbb2-d3f9218405b6');
INSERT INTO public.protocol_mapper VALUES ('df501bcd-a694-4d5d-b32c-77b4087fdaac', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '8b514977-3187-4562-bbb2-d3f9218405b6');
INSERT INTO public.protocol_mapper VALUES ('a0456fa1-0d12-4b32-916e-5638b51babf3', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '62ffe561-93df-4ea9-aad1-c85fd0285023');
INSERT INTO public.protocol_mapper VALUES ('38821b27-3a21-4c7b-a672-0716ad0b43f1', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'e37b686c-e516-40b0-9155-e8e452a659ce');
INSERT INTO public.protocol_mapper VALUES ('30335f92-87af-494c-a797-108a9869622c', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'e37b686c-e516-40b0-9155-e8e452a659ce');
INSERT INTO public.protocol_mapper VALUES ('0d33f75a-c09d-4153-83b7-35222ba4f6bd', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, 'b17d39ca-4adc-41f6-ba17-42428af3bb9a');
INSERT INTO public.protocol_mapper VALUES ('0951be25-8d07-4479-a7a3-785e156fdb79', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'dfe013ea-56ad-4180-84a4-31db0e05868f');
INSERT INTO public.protocol_mapper VALUES ('de70453b-3b05-46f7-aba1-918ff144fd51', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL, 'dfe013ea-56ad-4180-84a4-31db0e05868f');
INSERT INTO public.protocol_mapper VALUES ('46524ff3-a5c7-4fe3-80ca-4c973a33e7d8', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '28e81e5e-7356-4d30-abf6-0d0a176c850d');
INSERT INTO public.protocol_mapper VALUES ('57ca9862-7a2e-4073-9d11-0a02b31fa521', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '28e81e5e-7356-4d30-abf6-0d0a176c850d');
INSERT INTO public.protocol_mapper VALUES ('ef979de0-c07a-4747-af16-0db1b7774ef7', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '28e81e5e-7356-4d30-abf6-0d0a176c850d');
INSERT INTO public.protocol_mapper VALUES ('02fb0e02-14e2-4244-9336-4fb3d370b164', 'organization', 'openid-connect', 'oidc-organization-membership-mapper', NULL, 'af2ce3a9-d869-4664-8446-e62e161506f8');
INSERT INTO public.protocol_mapper VALUES ('f7ebca59-c843-41ef-a6d4-3a731859c408', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '58c0eec0-b3f3-4b71-b168-8bd4d34afb36', NULL);
INSERT INTO public.protocol_mapper VALUES ('a02479e9-25f0-484e-91ee-601278113801', 'role list', 'saml', 'saml-role-list-mapper', NULL, '504ad71b-16c0-424f-a3be-53dc3fb1adcc');
INSERT INTO public.protocol_mapper VALUES ('7796707f-8852-41ee-9799-1bcf17f1f721', 'organization', 'saml', 'saml-organization-membership-mapper', NULL, '626783bd-c0b7-483f-80fc-725dc3b9bc2f');
INSERT INTO public.protocol_mapper VALUES ('50600c7e-4ffe-425e-9a14-39e28426c117', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('e9de2e0b-2751-4805-a928-a50442d5fc18', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('8c921a37-c274-4676-b6fd-7f6175d08047', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('2fb1dbb0-814b-4b0e-a4c5-35f90a27246e', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('6a1e84f5-62e0-4cea-865c-e5bd92fd0a35', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('bb9ce842-7c38-4248-a09d-ac4a59445292', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('46c211cb-5e5b-4ac7-b421-d27a528e4520', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('faebfe2d-fd53-4947-b29c-8d7530ba75e8', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('e70389c2-7655-4ebb-b8be-45437e5be2f2', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('4ebbdef8-5698-412c-977a-f774cf1653c4', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('e70f6f8d-c7b7-4f5a-a0c1-ccbe5c28664b', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('8da2e36d-eee9-4881-a6c9-f0c5e300c70a', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('83c3259b-f23a-4190-b1c4-8ceb7d12f941', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('8d0d656f-797d-4dfa-9a4d-65d2bf955fe8', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.protocol_mapper VALUES ('a4cfdd0a-4e8f-4a49-a0ba-6da463a2423c', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '348e9652-774c-48ec-b36a-35db8e017f49');
INSERT INTO public.protocol_mapper VALUES ('fcbaa9b7-2126-4807-a9f3-7a76733fefe9', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '348e9652-774c-48ec-b36a-35db8e017f49');
INSERT INTO public.protocol_mapper VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '32db0564-2af7-4320-8587-38ee49ccac5f');
INSERT INTO public.protocol_mapper VALUES ('40e3dbbb-0bfd-41ad-8052-af222b81e78f', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'd3481252-222c-49ad-9023-bdbae7e49ad6');
INSERT INTO public.protocol_mapper VALUES ('89365bc9-301a-47a1-baab-234edd5220fa', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'd3481252-222c-49ad-9023-bdbae7e49ad6');
INSERT INTO public.protocol_mapper VALUES ('20233c77-4368-474b-9297-81a4f396b8e5', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'ad83b366-1434-49b7-9641-986840523046');
INSERT INTO public.protocol_mapper VALUES ('4b0d6462-8a57-48e9-8a29-cdaa5142ace8', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'ad83b366-1434-49b7-9641-986840523046');
INSERT INTO public.protocol_mapper VALUES ('f5f505d0-fd3a-4fac-b504-06f49312ec66', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'ad83b366-1434-49b7-9641-986840523046');
INSERT INTO public.protocol_mapper VALUES ('d9974365-d46d-4cd5-9eac-8c452656a97a', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '01220075-fd5e-4ed7-9aa4-03c1524a184c');
INSERT INTO public.protocol_mapper VALUES ('527c34d4-29c3-4e85-be25-5d8033f72d61', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '7675260a-43b4-4cac-9e87-b9855d128744');
INSERT INTO public.protocol_mapper VALUES ('74183a27-fd61-4196-8630-24be89cfe11a', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '7675260a-43b4-4cac-9e87-b9855d128744');
INSERT INTO public.protocol_mapper VALUES ('a834eba5-40a2-4996-a413-271da5d63f6a', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, 'a38ac7cc-b534-4dc3-8f10-0e42ec4ec91d');
INSERT INTO public.protocol_mapper VALUES ('6b0d4308-de6a-44c3-aec3-4472bfa22cff', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'f54bb7da-6403-42f1-8725-10601970b46f');
INSERT INTO public.protocol_mapper VALUES ('6e862993-d15f-4437-9094-cbc732ccdefe', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL, 'f54bb7da-6403-42f1-8725-10601970b46f');
INSERT INTO public.protocol_mapper VALUES ('29d004ba-357c-4e9e-9807-de069dfd5b30', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'cf8e4818-388d-48e8-867f-bce0dd4ac5d0');
INSERT INTO public.protocol_mapper VALUES ('27f925cc-f32d-4b58-9c13-6407cd022c77', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'cf8e4818-388d-48e8-867f-bce0dd4ac5d0');
INSERT INTO public.protocol_mapper VALUES ('40db31d9-720f-4237-b275-9471a8eaeca4', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'cf8e4818-388d-48e8-867f-bce0dd4ac5d0');
INSERT INTO public.protocol_mapper VALUES ('0a5cd307-5d25-45db-9bdc-9073e0a25cca', 'organization', 'openid-connect', 'oidc-organization-membership-mapper', NULL, 'e12a9cd9-0860-4df4-9056-20a211fd57fa');
INSERT INTO public.protocol_mapper VALUES ('6159edc9-d1b9-4ef1-8b56-ac27365b4b99', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'f98caaa5-4a77-46e2-9332-1c1286af39fd', NULL);
INSERT INTO public.protocol_mapper VALUES ('be64166e-7106-4246-a464-fc6810612543', 'profile picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'cc09bd09-2896-4add-a759-5c0d146c22fb');


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.protocol_mapper_config VALUES ('dda27637-2718-4e2d-9354-ed710fbeafcf', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dda27637-2718-4e2d-9354-ed710fbeafcf', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dda27637-2718-4e2d-9354-ed710fbeafcf', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('dda27637-2718-4e2d-9354-ed710fbeafcf', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dda27637-2718-4e2d-9354-ed710fbeafcf', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dda27637-2718-4e2d-9354-ed710fbeafcf', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('dda27637-2718-4e2d-9354-ed710fbeafcf', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('acc20921-044f-4022-b02c-924373575a7d', 'false', 'single');
INSERT INTO public.protocol_mapper_config VALUES ('acc20921-044f-4022-b02c-924373575a7d', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config VALUES ('acc20921-044f-4022-b02c-924373575a7d', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config VALUES ('0795f68f-2d2d-4689-8292-9a829f6bace0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0795f68f-2d2d-4689-8292-9a829f6bace0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0795f68f-2d2d-4689-8292-9a829f6bace0', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('0795f68f-2d2d-4689-8292-9a829f6bace0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0795f68f-2d2d-4689-8292-9a829f6bace0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0795f68f-2d2d-4689-8292-9a829f6bace0', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0795f68f-2d2d-4689-8292-9a829f6bace0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('07ed1dd9-2f48-4b9a-b893-7bc69fce6815', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('07ed1dd9-2f48-4b9a-b893-7bc69fce6815', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('07ed1dd9-2f48-4b9a-b893-7bc69fce6815', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('07ed1dd9-2f48-4b9a-b893-7bc69fce6815', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('07ed1dd9-2f48-4b9a-b893-7bc69fce6815', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('07ed1dd9-2f48-4b9a-b893-7bc69fce6815', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('07ed1dd9-2f48-4b9a-b893-7bc69fce6815', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('0b4b6ff8-4647-4aa6-9e75-fdfccec6f60c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0b4b6ff8-4647-4aa6-9e75-fdfccec6f60c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0b4b6ff8-4647-4aa6-9e75-fdfccec6f60c', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('0b4b6ff8-4647-4aa6-9e75-fdfccec6f60c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0b4b6ff8-4647-4aa6-9e75-fdfccec6f60c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0b4b6ff8-4647-4aa6-9e75-fdfccec6f60c', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0b4b6ff8-4647-4aa6-9e75-fdfccec6f60c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('2523b0b0-723d-4790-8388-3a4948a0eefb', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2523b0b0-723d-4790-8388-3a4948a0eefb', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2523b0b0-723d-4790-8388-3a4948a0eefb', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('2523b0b0-723d-4790-8388-3a4948a0eefb', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2523b0b0-723d-4790-8388-3a4948a0eefb', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2523b0b0-723d-4790-8388-3a4948a0eefb', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('2523b0b0-723d-4790-8388-3a4948a0eefb', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('5ab3ae85-c8d4-4082-b516-ec8fea475b51', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5ab3ae85-c8d4-4082-b516-ec8fea475b51', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5ab3ae85-c8d4-4082-b516-ec8fea475b51', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('5ab3ae85-c8d4-4082-b516-ec8fea475b51', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5ab3ae85-c8d4-4082-b516-ec8fea475b51', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5ab3ae85-c8d4-4082-b516-ec8fea475b51', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('5ab3ae85-c8d4-4082-b516-ec8fea475b51', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('5d82e001-67c8-469a-a794-670efacca05a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5d82e001-67c8-469a-a794-670efacca05a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5d82e001-67c8-469a-a794-670efacca05a', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('5d82e001-67c8-469a-a794-670efacca05a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5d82e001-67c8-469a-a794-670efacca05a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5d82e001-67c8-469a-a794-670efacca05a', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('5d82e001-67c8-469a-a794-670efacca05a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('703c024c-5958-4a69-8afa-6927018c1aa4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('703c024c-5958-4a69-8afa-6927018c1aa4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('703c024c-5958-4a69-8afa-6927018c1aa4', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('703c024c-5958-4a69-8afa-6927018c1aa4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('703c024c-5958-4a69-8afa-6927018c1aa4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('703c024c-5958-4a69-8afa-6927018c1aa4', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('703c024c-5958-4a69-8afa-6927018c1aa4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('733118e2-9dd6-42cc-b83b-232c198edb76', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('733118e2-9dd6-42cc-b83b-232c198edb76', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('733118e2-9dd6-42cc-b83b-232c198edb76', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('733118e2-9dd6-42cc-b83b-232c198edb76', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('733118e2-9dd6-42cc-b83b-232c198edb76', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('733118e2-9dd6-42cc-b83b-232c198edb76', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('733118e2-9dd6-42cc-b83b-232c198edb76', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('7453932c-de2e-4c7b-8dd6-44140bc7f481', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7453932c-de2e-4c7b-8dd6-44140bc7f481', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7453932c-de2e-4c7b-8dd6-44140bc7f481', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('7453932c-de2e-4c7b-8dd6-44140bc7f481', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7453932c-de2e-4c7b-8dd6-44140bc7f481', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7453932c-de2e-4c7b-8dd6-44140bc7f481', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('7453932c-de2e-4c7b-8dd6-44140bc7f481', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('7f6fb180-ae8b-471b-bda1-c683bf94f118', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7f6fb180-ae8b-471b-bda1-c683bf94f118', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7f6fb180-ae8b-471b-bda1-c683bf94f118', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7f6fb180-ae8b-471b-bda1-c683bf94f118', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('826acfd3-93e4-46d6-a143-dfaba0d61260', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('826acfd3-93e4-46d6-a143-dfaba0d61260', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('826acfd3-93e4-46d6-a143-dfaba0d61260', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('826acfd3-93e4-46d6-a143-dfaba0d61260', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('826acfd3-93e4-46d6-a143-dfaba0d61260', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('826acfd3-93e4-46d6-a143-dfaba0d61260', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('826acfd3-93e4-46d6-a143-dfaba0d61260', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('958d75b5-7b99-4653-a17b-9cd9e3368e96', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('958d75b5-7b99-4653-a17b-9cd9e3368e96', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('958d75b5-7b99-4653-a17b-9cd9e3368e96', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('958d75b5-7b99-4653-a17b-9cd9e3368e96', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('958d75b5-7b99-4653-a17b-9cd9e3368e96', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('958d75b5-7b99-4653-a17b-9cd9e3368e96', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('958d75b5-7b99-4653-a17b-9cd9e3368e96', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('9ef2780e-462d-49a1-a2f0-4b85c0105d8b', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9ef2780e-462d-49a1-a2f0-4b85c0105d8b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9ef2780e-462d-49a1-a2f0-4b85c0105d8b', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('9ef2780e-462d-49a1-a2f0-4b85c0105d8b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9ef2780e-462d-49a1-a2f0-4b85c0105d8b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9ef2780e-462d-49a1-a2f0-4b85c0105d8b', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('9ef2780e-462d-49a1-a2f0-4b85c0105d8b', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ecfbc117-19f2-4d02-a209-3af0574f1eee', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ecfbc117-19f2-4d02-a209-3af0574f1eee', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ecfbc117-19f2-4d02-a209-3af0574f1eee', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('ecfbc117-19f2-4d02-a209-3af0574f1eee', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ecfbc117-19f2-4d02-a209-3af0574f1eee', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ecfbc117-19f2-4d02-a209-3af0574f1eee', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('ecfbc117-19f2-4d02-a209-3af0574f1eee', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('1c165a1b-2b46-42e7-b3aa-e0347a912cba', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1c165a1b-2b46-42e7-b3aa-e0347a912cba', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1c165a1b-2b46-42e7-b3aa-e0347a912cba', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('1c165a1b-2b46-42e7-b3aa-e0347a912cba', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1c165a1b-2b46-42e7-b3aa-e0347a912cba', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1c165a1b-2b46-42e7-b3aa-e0347a912cba', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('1c165a1b-2b46-42e7-b3aa-e0347a912cba', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('f15985a2-c068-4521-9363-9418d566470d', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f15985a2-c068-4521-9363-9418d566470d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f15985a2-c068-4521-9363-9418d566470d', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('f15985a2-c068-4521-9363-9418d566470d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f15985a2-c068-4521-9363-9418d566470d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f15985a2-c068-4521-9363-9418d566470d', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('f15985a2-c068-4521-9363-9418d566470d', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('949960e5-429d-49e1-83e2-c02a86cee6c7', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config VALUES ('28ef4193-327a-475b-84f0-811f81f9e26a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('28ef4193-327a-475b-84f0-811f81f9e26a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('28ef4193-327a-475b-84f0-811f81f9e26a', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('28ef4193-327a-475b-84f0-811f81f9e26a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('28ef4193-327a-475b-84f0-811f81f9e26a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('28ef4193-327a-475b-84f0-811f81f9e26a', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('28ef4193-327a-475b-84f0-811f81f9e26a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('afe858ea-654c-4122-bfb0-8ccc894f6002', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('afe858ea-654c-4122-bfb0-8ccc894f6002', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('afe858ea-654c-4122-bfb0-8ccc894f6002', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('afe858ea-654c-4122-bfb0-8ccc894f6002', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('afe858ea-654c-4122-bfb0-8ccc894f6002', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('afe858ea-654c-4122-bfb0-8ccc894f6002', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('afe858ea-654c-4122-bfb0-8ccc894f6002', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('be710668-1459-44c2-b0cd-b7c2ade7eeb2', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('be710668-1459-44c2-b0cd-b7c2ade7eeb2', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('be710668-1459-44c2-b0cd-b7c2ade7eeb2', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('be710668-1459-44c2-b0cd-b7c2ade7eeb2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('be710668-1459-44c2-b0cd-b7c2ade7eeb2', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('be710668-1459-44c2-b0cd-b7c2ade7eeb2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('df501bcd-a694-4d5d-b32c-77b4087fdaac', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('df501bcd-a694-4d5d-b32c-77b4087fdaac', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f07f718a-e7f4-4c03-b894-e492c7388084', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f07f718a-e7f4-4c03-b894-e492c7388084', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('f07f718a-e7f4-4c03-b894-e492c7388084', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('f07f718a-e7f4-4c03-b894-e492c7388084', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f07f718a-e7f4-4c03-b894-e492c7388084', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('f07f718a-e7f4-4c03-b894-e492c7388084', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a0456fa1-0d12-4b32-916e-5638b51babf3', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a0456fa1-0d12-4b32-916e-5638b51babf3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('30335f92-87af-494c-a797-108a9869622c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('30335f92-87af-494c-a797-108a9869622c', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('30335f92-87af-494c-a797-108a9869622c', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('30335f92-87af-494c-a797-108a9869622c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('30335f92-87af-494c-a797-108a9869622c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('30335f92-87af-494c-a797-108a9869622c', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('30335f92-87af-494c-a797-108a9869622c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('38821b27-3a21-4c7b-a672-0716ad0b43f1', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('38821b27-3a21-4c7b-a672-0716ad0b43f1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('38821b27-3a21-4c7b-a672-0716ad0b43f1', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('38821b27-3a21-4c7b-a672-0716ad0b43f1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('38821b27-3a21-4c7b-a672-0716ad0b43f1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('38821b27-3a21-4c7b-a672-0716ad0b43f1', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('38821b27-3a21-4c7b-a672-0716ad0b43f1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('0d33f75a-c09d-4153-83b7-35222ba4f6bd', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0d33f75a-c09d-4153-83b7-35222ba4f6bd', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0d33f75a-c09d-4153-83b7-35222ba4f6bd', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0951be25-8d07-4479-a7a3-785e156fdb79', 'AUTH_TIME', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('0951be25-8d07-4479-a7a3-785e156fdb79', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0951be25-8d07-4479-a7a3-785e156fdb79', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0951be25-8d07-4479-a7a3-785e156fdb79', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0951be25-8d07-4479-a7a3-785e156fdb79', 'auth_time', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0951be25-8d07-4479-a7a3-785e156fdb79', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('de70453b-3b05-46f7-aba1-918ff144fd51', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('de70453b-3b05-46f7-aba1-918ff144fd51', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('46524ff3-a5c7-4fe3-80ca-4c973a33e7d8', 'client_id', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('46524ff3-a5c7-4fe3-80ca-4c973a33e7d8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('46524ff3-a5c7-4fe3-80ca-4c973a33e7d8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('46524ff3-a5c7-4fe3-80ca-4c973a33e7d8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('46524ff3-a5c7-4fe3-80ca-4c973a33e7d8', 'client_id', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('46524ff3-a5c7-4fe3-80ca-4c973a33e7d8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('57ca9862-7a2e-4073-9d11-0a02b31fa521', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('57ca9862-7a2e-4073-9d11-0a02b31fa521', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('57ca9862-7a2e-4073-9d11-0a02b31fa521', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('57ca9862-7a2e-4073-9d11-0a02b31fa521', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('57ca9862-7a2e-4073-9d11-0a02b31fa521', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('57ca9862-7a2e-4073-9d11-0a02b31fa521', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ef979de0-c07a-4747-af16-0db1b7774ef7', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('ef979de0-c07a-4747-af16-0db1b7774ef7', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ef979de0-c07a-4747-af16-0db1b7774ef7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ef979de0-c07a-4747-af16-0db1b7774ef7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ef979de0-c07a-4747-af16-0db1b7774ef7', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('ef979de0-c07a-4747-af16-0db1b7774ef7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('02fb0e02-14e2-4244-9336-4fb3d370b164', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('02fb0e02-14e2-4244-9336-4fb3d370b164', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('02fb0e02-14e2-4244-9336-4fb3d370b164', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('02fb0e02-14e2-4244-9336-4fb3d370b164', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('02fb0e02-14e2-4244-9336-4fb3d370b164', 'organization', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('02fb0e02-14e2-4244-9336-4fb3d370b164', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a02479e9-25f0-484e-91ee-601278113801', 'false', 'single');
INSERT INTO public.protocol_mapper_config VALUES ('a02479e9-25f0-484e-91ee-601278113801', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config VALUES ('a02479e9-25f0-484e-91ee-601278113801', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config VALUES ('2fb1dbb0-814b-4b0e-a4c5-35f90a27246e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2fb1dbb0-814b-4b0e-a4c5-35f90a27246e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2fb1dbb0-814b-4b0e-a4c5-35f90a27246e', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('2fb1dbb0-814b-4b0e-a4c5-35f90a27246e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2fb1dbb0-814b-4b0e-a4c5-35f90a27246e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2fb1dbb0-814b-4b0e-a4c5-35f90a27246e', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('2fb1dbb0-814b-4b0e-a4c5-35f90a27246e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('46c211cb-5e5b-4ac7-b421-d27a528e4520', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('46c211cb-5e5b-4ac7-b421-d27a528e4520', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('46c211cb-5e5b-4ac7-b421-d27a528e4520', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('46c211cb-5e5b-4ac7-b421-d27a528e4520', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('46c211cb-5e5b-4ac7-b421-d27a528e4520', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('46c211cb-5e5b-4ac7-b421-d27a528e4520', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('46c211cb-5e5b-4ac7-b421-d27a528e4520', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4ebbdef8-5698-412c-977a-f774cf1653c4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4ebbdef8-5698-412c-977a-f774cf1653c4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4ebbdef8-5698-412c-977a-f774cf1653c4', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('4ebbdef8-5698-412c-977a-f774cf1653c4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4ebbdef8-5698-412c-977a-f774cf1653c4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4ebbdef8-5698-412c-977a-f774cf1653c4', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4ebbdef8-5698-412c-977a-f774cf1653c4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('50600c7e-4ffe-425e-9a14-39e28426c117', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('50600c7e-4ffe-425e-9a14-39e28426c117', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('50600c7e-4ffe-425e-9a14-39e28426c117', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('50600c7e-4ffe-425e-9a14-39e28426c117', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6a1e84f5-62e0-4cea-865c-e5bd92fd0a35', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6a1e84f5-62e0-4cea-865c-e5bd92fd0a35', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6a1e84f5-62e0-4cea-865c-e5bd92fd0a35', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('6a1e84f5-62e0-4cea-865c-e5bd92fd0a35', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6a1e84f5-62e0-4cea-865c-e5bd92fd0a35', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6a1e84f5-62e0-4cea-865c-e5bd92fd0a35', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('6a1e84f5-62e0-4cea-865c-e5bd92fd0a35', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('83c3259b-f23a-4190-b1c4-8ceb7d12f941', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('83c3259b-f23a-4190-b1c4-8ceb7d12f941', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('83c3259b-f23a-4190-b1c4-8ceb7d12f941', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('83c3259b-f23a-4190-b1c4-8ceb7d12f941', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('83c3259b-f23a-4190-b1c4-8ceb7d12f941', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('83c3259b-f23a-4190-b1c4-8ceb7d12f941', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('83c3259b-f23a-4190-b1c4-8ceb7d12f941', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('8c921a37-c274-4676-b6fd-7f6175d08047', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8c921a37-c274-4676-b6fd-7f6175d08047', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8c921a37-c274-4676-b6fd-7f6175d08047', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('8c921a37-c274-4676-b6fd-7f6175d08047', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8c921a37-c274-4676-b6fd-7f6175d08047', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8c921a37-c274-4676-b6fd-7f6175d08047', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('8c921a37-c274-4676-b6fd-7f6175d08047', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('8d0d656f-797d-4dfa-9a4d-65d2bf955fe8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8d0d656f-797d-4dfa-9a4d-65d2bf955fe8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8d0d656f-797d-4dfa-9a4d-65d2bf955fe8', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('8d0d656f-797d-4dfa-9a4d-65d2bf955fe8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8d0d656f-797d-4dfa-9a4d-65d2bf955fe8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8d0d656f-797d-4dfa-9a4d-65d2bf955fe8', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('8d0d656f-797d-4dfa-9a4d-65d2bf955fe8', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('8da2e36d-eee9-4881-a6c9-f0c5e300c70a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8da2e36d-eee9-4881-a6c9-f0c5e300c70a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8da2e36d-eee9-4881-a6c9-f0c5e300c70a', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('8da2e36d-eee9-4881-a6c9-f0c5e300c70a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8da2e36d-eee9-4881-a6c9-f0c5e300c70a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8da2e36d-eee9-4881-a6c9-f0c5e300c70a', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('8da2e36d-eee9-4881-a6c9-f0c5e300c70a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('bb9ce842-7c38-4248-a09d-ac4a59445292', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb9ce842-7c38-4248-a09d-ac4a59445292', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb9ce842-7c38-4248-a09d-ac4a59445292', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('bb9ce842-7c38-4248-a09d-ac4a59445292', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb9ce842-7c38-4248-a09d-ac4a59445292', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb9ce842-7c38-4248-a09d-ac4a59445292', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('bb9ce842-7c38-4248-a09d-ac4a59445292', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('e70389c2-7655-4ebb-b8be-45437e5be2f2', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e70389c2-7655-4ebb-b8be-45437e5be2f2', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e70389c2-7655-4ebb-b8be-45437e5be2f2', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('e70389c2-7655-4ebb-b8be-45437e5be2f2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e70389c2-7655-4ebb-b8be-45437e5be2f2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e70389c2-7655-4ebb-b8be-45437e5be2f2', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('e70389c2-7655-4ebb-b8be-45437e5be2f2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('e70f6f8d-c7b7-4f5a-a0c1-ccbe5c28664b', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e70f6f8d-c7b7-4f5a-a0c1-ccbe5c28664b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e70f6f8d-c7b7-4f5a-a0c1-ccbe5c28664b', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('e70f6f8d-c7b7-4f5a-a0c1-ccbe5c28664b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e70f6f8d-c7b7-4f5a-a0c1-ccbe5c28664b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e70f6f8d-c7b7-4f5a-a0c1-ccbe5c28664b', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('e70f6f8d-c7b7-4f5a-a0c1-ccbe5c28664b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('e9de2e0b-2751-4805-a928-a50442d5fc18', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e9de2e0b-2751-4805-a928-a50442d5fc18', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e9de2e0b-2751-4805-a928-a50442d5fc18', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('e9de2e0b-2751-4805-a928-a50442d5fc18', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e9de2e0b-2751-4805-a928-a50442d5fc18', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e9de2e0b-2751-4805-a928-a50442d5fc18', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('e9de2e0b-2751-4805-a928-a50442d5fc18', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('faebfe2d-fd53-4947-b29c-8d7530ba75e8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('faebfe2d-fd53-4947-b29c-8d7530ba75e8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('faebfe2d-fd53-4947-b29c-8d7530ba75e8', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('faebfe2d-fd53-4947-b29c-8d7530ba75e8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('faebfe2d-fd53-4947-b29c-8d7530ba75e8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('faebfe2d-fd53-4947-b29c-8d7530ba75e8', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('faebfe2d-fd53-4947-b29c-8d7530ba75e8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a4cfdd0a-4e8f-4a49-a0ba-6da463a2423c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a4cfdd0a-4e8f-4a49-a0ba-6da463a2423c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a4cfdd0a-4e8f-4a49-a0ba-6da463a2423c', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('a4cfdd0a-4e8f-4a49-a0ba-6da463a2423c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a4cfdd0a-4e8f-4a49-a0ba-6da463a2423c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a4cfdd0a-4e8f-4a49-a0ba-6da463a2423c', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a4cfdd0a-4e8f-4a49-a0ba-6da463a2423c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('fcbaa9b7-2126-4807-a9f3-7a76733fefe9', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fcbaa9b7-2126-4807-a9f3-7a76733fefe9', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fcbaa9b7-2126-4807-a9f3-7a76733fefe9', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('fcbaa9b7-2126-4807-a9f3-7a76733fefe9', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fcbaa9b7-2126-4807-a9f3-7a76733fefe9', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fcbaa9b7-2126-4807-a9f3-7a76733fefe9', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('fcbaa9b7-2126-4807-a9f3-7a76733fefe9', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6c9d1f64-0204-486e-bba7-9fa9acbb6084', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config VALUES ('40e3dbbb-0bfd-41ad-8052-af222b81e78f', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('40e3dbbb-0bfd-41ad-8052-af222b81e78f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('40e3dbbb-0bfd-41ad-8052-af222b81e78f', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('40e3dbbb-0bfd-41ad-8052-af222b81e78f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('40e3dbbb-0bfd-41ad-8052-af222b81e78f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('40e3dbbb-0bfd-41ad-8052-af222b81e78f', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('40e3dbbb-0bfd-41ad-8052-af222b81e78f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('89365bc9-301a-47a1-baab-234edd5220fa', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('89365bc9-301a-47a1-baab-234edd5220fa', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('89365bc9-301a-47a1-baab-234edd5220fa', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('89365bc9-301a-47a1-baab-234edd5220fa', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('89365bc9-301a-47a1-baab-234edd5220fa', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('89365bc9-301a-47a1-baab-234edd5220fa', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('89365bc9-301a-47a1-baab-234edd5220fa', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('20233c77-4368-474b-9297-81a4f396b8e5', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('20233c77-4368-474b-9297-81a4f396b8e5', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('20233c77-4368-474b-9297-81a4f396b8e5', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('20233c77-4368-474b-9297-81a4f396b8e5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('20233c77-4368-474b-9297-81a4f396b8e5', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('20233c77-4368-474b-9297-81a4f396b8e5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4b0d6462-8a57-48e9-8a29-cdaa5142ace8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4b0d6462-8a57-48e9-8a29-cdaa5142ace8', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('4b0d6462-8a57-48e9-8a29-cdaa5142ace8', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('4b0d6462-8a57-48e9-8a29-cdaa5142ace8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4b0d6462-8a57-48e9-8a29-cdaa5142ace8', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4b0d6462-8a57-48e9-8a29-cdaa5142ace8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('f5f505d0-fd3a-4fac-b504-06f49312ec66', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f5f505d0-fd3a-4fac-b504-06f49312ec66', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d9974365-d46d-4cd5-9eac-8c452656a97a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d9974365-d46d-4cd5-9eac-8c452656a97a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('527c34d4-29c3-4e85-be25-5d8033f72d61', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('527c34d4-29c3-4e85-be25-5d8033f72d61', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('527c34d4-29c3-4e85-be25-5d8033f72d61', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('527c34d4-29c3-4e85-be25-5d8033f72d61', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('527c34d4-29c3-4e85-be25-5d8033f72d61', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('527c34d4-29c3-4e85-be25-5d8033f72d61', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('527c34d4-29c3-4e85-be25-5d8033f72d61', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('74183a27-fd61-4196-8630-24be89cfe11a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('74183a27-fd61-4196-8630-24be89cfe11a', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('74183a27-fd61-4196-8630-24be89cfe11a', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('74183a27-fd61-4196-8630-24be89cfe11a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('74183a27-fd61-4196-8630-24be89cfe11a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('74183a27-fd61-4196-8630-24be89cfe11a', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('74183a27-fd61-4196-8630-24be89cfe11a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a834eba5-40a2-4996-a413-271da5d63f6a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a834eba5-40a2-4996-a413-271da5d63f6a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a834eba5-40a2-4996-a413-271da5d63f6a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6b0d4308-de6a-44c3-aec3-4472bfa22cff', 'AUTH_TIME', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('6b0d4308-de6a-44c3-aec3-4472bfa22cff', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6b0d4308-de6a-44c3-aec3-4472bfa22cff', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6b0d4308-de6a-44c3-aec3-4472bfa22cff', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6b0d4308-de6a-44c3-aec3-4472bfa22cff', 'auth_time', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('6b0d4308-de6a-44c3-aec3-4472bfa22cff', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('6e862993-d15f-4437-9094-cbc732ccdefe', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6e862993-d15f-4437-9094-cbc732ccdefe', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27f925cc-f32d-4b58-9c13-6407cd022c77', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('27f925cc-f32d-4b58-9c13-6407cd022c77', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27f925cc-f32d-4b58-9c13-6407cd022c77', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27f925cc-f32d-4b58-9c13-6407cd022c77', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27f925cc-f32d-4b58-9c13-6407cd022c77', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('27f925cc-f32d-4b58-9c13-6407cd022c77', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('29d004ba-357c-4e9e-9807-de069dfd5b30', 'client_id', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('29d004ba-357c-4e9e-9807-de069dfd5b30', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('29d004ba-357c-4e9e-9807-de069dfd5b30', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('29d004ba-357c-4e9e-9807-de069dfd5b30', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('29d004ba-357c-4e9e-9807-de069dfd5b30', 'client_id', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('29d004ba-357c-4e9e-9807-de069dfd5b30', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('40db31d9-720f-4237-b275-9471a8eaeca4', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('40db31d9-720f-4237-b275-9471a8eaeca4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('40db31d9-720f-4237-b275-9471a8eaeca4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('40db31d9-720f-4237-b275-9471a8eaeca4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('40db31d9-720f-4237-b275-9471a8eaeca4', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('40db31d9-720f-4237-b275-9471a8eaeca4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('0a5cd307-5d25-45db-9bdc-9073e0a25cca', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0a5cd307-5d25-45db-9bdc-9073e0a25cca', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('0a5cd307-5d25-45db-9bdc-9073e0a25cca', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0a5cd307-5d25-45db-9bdc-9073e0a25cca', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0a5cd307-5d25-45db-9bdc-9073e0a25cca', 'organization', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0a5cd307-5d25-45db-9bdc-9073e0a25cca', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('6159edc9-d1b9-4ef1-8b56-ac27365b4b99', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6159edc9-d1b9-4ef1-8b56-ac27365b4b99', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6159edc9-d1b9-4ef1-8b56-ac27365b4b99', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('6159edc9-d1b9-4ef1-8b56-ac27365b4b99', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6159edc9-d1b9-4ef1-8b56-ac27365b4b99', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6159edc9-d1b9-4ef1-8b56-ac27365b4b99', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('6159edc9-d1b9-4ef1-8b56-ac27365b4b99', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('be64166e-7106-4246-a464-fc6810612543', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('be64166e-7106-4246-a464-fc6810612543', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('be64166e-7106-4246-a464-fc6810612543', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('be64166e-7106-4246-a464-fc6810612543', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('be64166e-7106-4246-a464-fc6810612543', 'true', 'lightweight.claim');
INSERT INTO public.protocol_mapper_config VALUES ('be64166e-7106-4246-a464-fc6810612543', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('be64166e-7106-4246-a464-fc6810612543', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('be64166e-7106-4246-a464-fc6810612543', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4b0d6462-8a57-48e9-8a29-cdaa5142ace8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4b0d6462-8a57-48e9-8a29-cdaa5142ace8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4b0d6462-8a57-48e9-8a29-cdaa5142ace8', 'true', 'lightweight.claim');


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.realm VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 60, 300, 1800, 'keycloak.v3', 'keycloak.v2', 'keycloak', true, false, 0, 'keycloak.v2', 'echovibe', 0, NULL, false, true, true, false, 'EXTERNAL', 1800, 36000, false, true, '3031e683-70a3-4b1f-af4d-e6677b127cf9', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '0ed8e62f-94ce-4146-bc9c-d291a4b3d549', '360aad8e-458e-42c5-826d-c20278b7de14', '52cbefb3-05f6-415f-9e97-20dbb4a78d16', '812c0516-667b-4f3e-95d1-d0f0f7d4e6ee', 'b33b4e31-0267-472a-be12-59fad29ee939', 2592000, false, 900, true, false, '39e07c10-b846-4eab-96e1-d138458cdefa', 0, true, 0, 0, '3a46a530-8f21-4bae-b8f2-e8230c6fd1a7');
INSERT INTO public.realm VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '31dbe232-8b52-42b7-b84e-a211b8b15e83', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '0aa764fe-6e73-4d5d-93bf-c25e097aea09', '29a30685-2903-42e2-b426-e498378457ff', 'be9df596-47c7-4be2-aae8-d15e77881bdb', '86831432-0aee-4cb3-8553-3f0c02adcc0c', '08509b88-90c3-4b83-9051-7f9d0653fb09', 2592000, false, 900, true, false, 'bec85556-25e3-4a80-9694-3a33ec4af0fa', 0, false, 0, 0, 'd3c05f33-6706-4396-a2b2-2268456979e3');


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xContentTypeOptions', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'nosniff');
INSERT INTO public.realm_attribute VALUES ('_browser_header.referrerPolicy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'no-referrer');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xRobotsTag', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'none');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xFrameOptions', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'SAMEORIGIN');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xXSSProtection', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '1; mode=block');
INSERT INTO public.realm_attribute VALUES ('_browser_header.strictTransportSecurity', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute VALUES ('bruteForceProtected', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'false');
INSERT INTO public.realm_attribute VALUES ('permanentLockout', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'false');
INSERT INTO public.realm_attribute VALUES ('maxTemporaryLockouts', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '0');
INSERT INTO public.realm_attribute VALUES ('bruteForceStrategy', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'MULTIPLE');
INSERT INTO public.realm_attribute VALUES ('maxFailureWaitSeconds', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '900');
INSERT INTO public.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '60');
INSERT INTO public.realm_attribute VALUES ('waitIncrementSeconds', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '60');
INSERT INTO public.realm_attribute VALUES ('quickLoginCheckMilliSeconds', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '1000');
INSERT INTO public.realm_attribute VALUES ('maxDeltaTimeSeconds', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '43200');
INSERT INTO public.realm_attribute VALUES ('failureFactor', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '30');
INSERT INTO public.realm_attribute VALUES ('realmReusableOtpCode', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'false');
INSERT INTO public.realm_attribute VALUES ('firstBrokerLoginFlowId', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '77759c75-384f-492c-8528-188eb9a83ebc');
INSERT INTO public.realm_attribute VALUES ('displayName', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'Keycloak');
INSERT INTO public.realm_attribute VALUES ('displayNameHtml', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO public.realm_attribute VALUES ('defaultSignatureAlgorithm', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'RS256');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'false');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespan', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', '5184000');
INSERT INTO public.realm_attribute VALUES ('bruteForceProtected', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'false');
INSERT INTO public.realm_attribute VALUES ('permanentLockout', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'false');
INSERT INTO public.realm_attribute VALUES ('maxTemporaryLockouts', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0');
INSERT INTO public.realm_attribute VALUES ('bruteForceStrategy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'MULTIPLE');
INSERT INTO public.realm_attribute VALUES ('maxFailureWaitSeconds', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '900');
INSERT INTO public.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '60');
INSERT INTO public.realm_attribute VALUES ('waitIncrementSeconds', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '60');
INSERT INTO public.realm_attribute VALUES ('quickLoginCheckMilliSeconds', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '1000');
INSERT INTO public.realm_attribute VALUES ('maxDeltaTimeSeconds', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '43200');
INSERT INTO public.realm_attribute VALUES ('failureFactor', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '30');
INSERT INTO public.realm_attribute VALUES ('realmReusableOtpCode', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'false');
INSERT INTO public.realm_attribute VALUES ('defaultSignatureAlgorithm', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'RS256');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'false');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespan', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '5184000');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByAdminLifespan', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '43200');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '300');
INSERT INTO public.realm_attribute VALUES ('oauth2DeviceCodeLifespan', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '600');
INSERT INTO public.realm_attribute VALUES ('oauth2DevicePollingInterval', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '5');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpEntityName', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'keycloak');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicySignatureAlgorithms', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'ES256,RS256');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpId', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAttestationConveyancePreference', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAuthenticatorAttachment', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRequireResidentKey', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyUserVerificationRequirement', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyCreateTimeout', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'false');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpEntityNamePasswordless', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'keycloak');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicySignatureAlgorithmsPasswordless', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'ES256,RS256');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpIdPasswordless', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAttestationConveyancePreferencePasswordless', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAuthenticatorAttachmentPasswordless', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRequireResidentKeyPasswordless', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyUserVerificationRequirementPasswordless', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyCreateTimeoutPasswordless', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'false');
INSERT INTO public.realm_attribute VALUES ('cibaBackchannelTokenDeliveryMode', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'poll');
INSERT INTO public.realm_attribute VALUES ('cibaExpiresIn', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '120');
INSERT INTO public.realm_attribute VALUES ('cibaInterval', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '5');
INSERT INTO public.realm_attribute VALUES ('cibaAuthRequestedUserHint', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'login_hint');
INSERT INTO public.realm_attribute VALUES ('parRequestUriLifespan', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '60');
INSERT INTO public.realm_attribute VALUES ('firstBrokerLoginFlowId', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '24414d03-6364-49e6-b667-e0ada658459e');
INSERT INTO public.realm_attribute VALUES ('frontendUrl', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '');
INSERT INTO public.realm_attribute VALUES ('acr.loa.map', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '{}');
INSERT INTO public.realm_attribute VALUES ('displayName', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'Echo Vibe');
INSERT INTO public.realm_attribute VALUES ('adminPermissionsEnabled', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'false');
INSERT INTO public.realm_attribute VALUES ('verifiableCredentialsEnabled', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'false');
INSERT INTO public.realm_attribute VALUES ('clientSessionIdleTimeout', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0');
INSERT INTO public.realm_attribute VALUES ('clientSessionMaxLifespan', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0');
INSERT INTO public.realm_attribute VALUES ('clientOfflineSessionIdleTimeout', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0');
INSERT INTO public.realm_attribute VALUES ('clientOfflineSessionMaxLifespan', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '0');
INSERT INTO public.realm_attribute VALUES ('client-policies.profiles', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '{"profiles":[]}');
INSERT INTO public.realm_attribute VALUES ('client-policies.policies', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '{"policies":[]}');
INSERT INTO public.realm_attribute VALUES ('organizationsEnabled', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'false');
INSERT INTO public.realm_attribute VALUES ('shortVerificationUri', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan.verify-email', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan.idp-verify-account-via-email', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan.reset-credentials', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan.execute-actions', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'nosniff');
INSERT INTO public.realm_attribute VALUES ('_browser_header.referrerPolicy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'no-referrer');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xRobotsTag', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'none');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xFrameOptions', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'SAMEORIGIN');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xXSSProtection', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', '1; mode=block');
INSERT INTO public.realm_attribute VALUES ('_browser_header.strictTransportSecurity', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute VALUES ('displayNameHtml', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'Echo Vibe');


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.realm_events_listeners VALUES ('2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'jboss-logging');
INSERT INTO public.realm_events_listeners VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'jboss-logging');


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.realm_required_credential VALUES ('password', 'password', true, true, '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e');
INSERT INTO public.realm_required_credential VALUES ('password', 'password', true, true, 'dd6a5b23-a699-44e1-8210-886a0a2eafac');


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'jssj zrud spel bgyx', 'password');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'Echo Vibe', 'replyToDisplayName');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'true', 'starttls');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'true', 'auth');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', '465', 'port');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'smtp.gmail.com', 'host');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'vutien.dat.3601@gmail.com', 'replyTo');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'vutien.dat.3601@gmail.com', 'from');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'Echo Vibe', 'fromDisplayName');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', '', 'envelopeFrom');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'true', 'ssl');
INSERT INTO public.realm_smtp_config VALUES ('dd6a5b23-a699-44e1-8210-886a0a2eafac', 'vutien.dat.3601@gmail.com', 'user');


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.redirect_uris VALUES ('d7b0975b-215f-4b16-8118-663a45af5a3c', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', '/admin/master/console/*');
INSERT INTO public.redirect_uris VALUES ('2d6d12e4-4bef-4b0a-b789-2ecb2f22f80d', '/realms/echovibe/account/*');
INSERT INTO public.redirect_uris VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', '/realms/echovibe/account/*');
INSERT INTO public.redirect_uris VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', '/admin/echovibe/console/*');
INSERT INTO public.redirect_uris VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '/*');
INSERT INTO public.redirect_uris VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'https://echovibe.io.vn/*');
INSERT INTO public.redirect_uris VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', 'http://localhost:4300/*');
INSERT INTO public.redirect_uris VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'https://oauth.pstmn.io/v1/browser-callback');
INSERT INTO public.redirect_uris VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'https://admin-local.echovibe.io.vn/*');
INSERT INTO public.redirect_uris VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'https://admin.echovibe.io.vn/*');
INSERT INTO public.redirect_uris VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'http://localhost:4200/*');
INSERT INTO public.redirect_uris VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'http://localhost/*');
INSERT INTO public.redirect_uris VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', 'http://admin.echovibe.io.vn/*');


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.required_action_provider VALUES ('bed0c31b-fe9a-4834-9016-38b807ad1f2a', 'VERIFY_EMAIL', 'Verify Email', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider VALUES ('04cc707d-bce3-45bc-83fb-a2f719d51a2f', 'UPDATE_PROFILE', 'Update Profile', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider VALUES ('43ee5ad4-7243-4617-b3ab-291cc0d43746', 'CONFIGURE_TOTP', 'Configure OTP', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider VALUES ('da2cc76c-d687-476b-bc62-c4fe1c1d4583', 'UPDATE_PASSWORD', 'Update Password', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider VALUES ('3fc11bcc-c46f-4177-8360-0842578e558a', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider VALUES ('2679ebc1-251e-461e-a6f2-35f54496870d', 'delete_account', 'Delete Account', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider VALUES ('29fd34d1-2bce-420c-8f79-884786b20bc8', 'delete_credential', 'Delete Credential', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider VALUES ('7d0e7522-b9a9-406e-b213-225a26ac4347', 'update_user_locale', 'Update User Locale', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider VALUES ('7b296295-bf75-4fa8-a528-f5579ee0b7a8', 'webauthn-register', 'Webauthn Register', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider VALUES ('9e56c094-a56d-4183-af1c-18bb6b5da680', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider VALUES ('96a034a6-4ffb-43f9-8f4a-2a488dc2060d', 'VERIFY_PROFILE', 'Verify Profile', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', true, false, 'VERIFY_PROFILE', 90);
INSERT INTO public.required_action_provider VALUES ('8e31155b-fa9e-4b78-90f1-eb0285ba43d7', 'VERIFY_EMAIL', 'Verify Email', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider VALUES ('5e278a7c-bce7-42c8-9ca4-c72a235c17a1', 'UPDATE_PROFILE', 'Update Profile', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider VALUES ('a2110d74-3577-4779-b628-4c994a25d32b', 'CONFIGURE_TOTP', 'Configure OTP', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider VALUES ('0e115ca4-b57d-49dc-ac45-e5a6d26ce267', 'UPDATE_PASSWORD', 'Update Password', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider VALUES ('e61e1ccf-01ea-4bf3-b371-16cb09c1fcfe', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider VALUES ('3823b768-b69c-4413-a48c-20238a19f451', 'delete_account', 'Delete Account', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider VALUES ('4c92d23e-2fb0-4631-884a-8a4aa50c0333', 'delete_credential', 'Delete Credential', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider VALUES ('826dbda0-8ead-42c1-a9da-d8527d4cd04b', 'update_user_locale', 'Update User Locale', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider VALUES ('b6fc1180-a796-413b-8391-a484f433f7a0', 'webauthn-register', 'Webauthn Register', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider VALUES ('394fdb3e-6fcf-47e2-8f5b-3f80bfbea328', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider VALUES ('2c352bcf-78ba-4093-989d-fc6575b4342a', 'VERIFY_PROFILE', 'Verify Profile', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', true, false, 'VERIFY_PROFILE', 90);


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.resource_policy VALUES ('a737b8b5-139b-42aa-b7d5-791dc7fb65b9', '0f980173-3ba3-4e30-9cd2-a2eabaff30d1');
INSERT INTO public.resource_policy VALUES ('1d91d452-2a0f-45e2-90c4-c27dafcac905', '6d07f7f7-a448-4384-9afa-9d610faeeeb8');
INSERT INTO public.resource_policy VALUES ('0a8dfbc4-428f-4c19-b38c-3a2c3e7fa51e', 'a2b8dbe4-2cf1-426d-8585-d8f91de7ec54');
INSERT INTO public.resource_policy VALUES ('d23f7d4c-2f3f-4282-8e3b-64edb5920c8e', '06ff0c72-da49-4c3d-a412-6a676b14b7af');
INSERT INTO public.resource_policy VALUES ('7cc0d108-cbd1-4610-b0bb-70b0e4bf2532', '0e5b46dd-6d47-401d-ac5d-b140f60a39b4');


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.resource_scope VALUES ('a737b8b5-139b-42aa-b7d5-791dc7fb65b9', 'f02a1c2d-4d35-4b7d-b20f-064bf76daa3f');
INSERT INTO public.resource_scope VALUES ('1d91d452-2a0f-45e2-90c4-c27dafcac905', '2069897a-496c-4260-916c-1dcd83b5068c');
INSERT INTO public.resource_scope VALUES ('0a8dfbc4-428f-4c19-b38c-3a2c3e7fa51e', '2069897a-496c-4260-916c-1dcd83b5068c');
INSERT INTO public.resource_scope VALUES ('d23f7d4c-2f3f-4282-8e3b-64edb5920c8e', '2069897a-496c-4260-916c-1dcd83b5068c');
INSERT INTO public.resource_scope VALUES ('7cc0d108-cbd1-4610-b0bb-70b0e4bf2532', 'f02a1c2d-4d35-4b7d-b20f-064bf76daa3f');


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.resource_server VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', true, 0, 1);


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.resource_server_policy VALUES ('0f980173-3ba3-4e30-9cd2-a2eabaff30d1', 'ArtistCommand - Manage Artist APIs Permission', '', 'scope', 0, 0, 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);
INSERT INTO public.resource_server_policy VALUES ('6d07f7f7-a448-4384-9afa-9d610faeeeb8', 'ArtistQuery - Query Artist APIs Permission', '', 'scope', 0, 0, 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);
INSERT INTO public.resource_server_policy VALUES ('a2b8dbe4-2cf1-426d-8585-d8f91de7ec54', 'ArtistCommand - OpenAPI Documentation Permission', '', 'resource', 0, 0, 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);
INSERT INTO public.resource_server_policy VALUES ('06ff0c72-da49-4c3d-a412-6a676b14b7af', 'TrackCommand - OpenAPI Documentation Permission', '', 'resource', 0, 0, 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);
INSERT INTO public.resource_server_policy VALUES ('a863d98f-759f-4421-a553-5ab9c376960c', 'Artist Manager Policy', '', 'role', 1, 0, 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);
INSERT INTO public.resource_server_policy VALUES ('ce1c5c87-c666-43ad-8075-ca2ae2e880d1', 'Artist Policy', '', 'role', 1, 0, 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);
INSERT INTO public.resource_server_policy VALUES ('0e5b46dd-6d47-401d-ac5d-b140f60a39b4', 'ArtistCommand - Manage Track APIs Permission', '', 'resource', 0, 0, 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', NULL);


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.resource_server_resource VALUES ('a737b8b5-139b-42aa-b7d5-791dc7fb65b9', 'ArtistCommand - Manage Artist APIs', 'echovibe:artistcommand:artist', '', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', false, 'ArtistCommand - Manage Artist APIs');
INSERT INTO public.resource_server_resource VALUES ('1d91d452-2a0f-45e2-90c4-c27dafcac905', 'ArtistQuery - Query Artist APIs', 'echovibe:artistquery:artist', '', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', false, 'ArtistQuery - Query Artist APIs');
INSERT INTO public.resource_server_resource VALUES ('0a8dfbc4-428f-4c19-b38c-3a2c3e7fa51e', 'ArtistCommand - OpenAPI Documenation', 'echovibe:documenation:openapi', '', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', false, 'ArtistCommand - OpenAPI Documenation');
INSERT INTO public.resource_server_resource VALUES ('d23f7d4c-2f3f-4282-8e3b-64edb5920c8e', 'TrackCommand - OpenAPI Documenation', 'echovibe:documenation:openapi', '', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', false, 'TrackCommand - OpenAPI Documenation');
INSERT INTO public.resource_server_resource VALUES ('7cc0d108-cbd1-4610-b0bb-70b0e4bf2532', 'TrackCommand - Manage Track APIs', 'echovibe:trackcomand:track', '', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', false, 'TrackCommand - Manage Track APIs');


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.resource_server_scope VALUES ('f02a1c2d-4d35-4b7d-b20f-064bf76daa3f', 'POST', '', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'POST');
INSERT INTO public.resource_server_scope VALUES ('2069897a-496c-4260-916c-1dcd83b5068c', 'GET', '', 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 'GET');


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.resource_uris VALUES ('d23f7d4c-2f3f-4282-8e3b-64edb5920c8e', '/command/v1/tracks/openapi');
INSERT INTO public.resource_uris VALUES ('7cc0d108-cbd1-4610-b0bb-70b0e4bf2532', '/command/v1/tracks/bulk-create');
INSERT INTO public.resource_uris VALUES ('7cc0d108-cbd1-4610-b0bb-70b0e4bf2532', '/command/v1/tracks/bulk-update');
INSERT INTO public.resource_uris VALUES ('7cc0d108-cbd1-4610-b0bb-70b0e4bf2532', '/command/v1/tracks/bulk-release');
INSERT INTO public.resource_uris VALUES ('7cc0d108-cbd1-4610-b0bb-70b0e4bf2532', '/command/v1/tracks/bulk-delete');
INSERT INTO public.resource_uris VALUES ('7cc0d108-cbd1-4610-b0bb-70b0e4bf2532', '/command/v1/tracks/bulk-map-audio');
INSERT INTO public.resource_uris VALUES ('0a8dfbc4-428f-4c19-b38c-3a2c3e7fa51e', '/command/v1/artists/openapi');
INSERT INTO public.resource_uris VALUES ('1d91d452-2a0f-45e2-90c4-c27dafcac905', '/query/v1/artists');
INSERT INTO public.resource_uris VALUES ('1d91d452-2a0f-45e2-90c4-c27dafcac905', '/query/v1/artists/byRefCode');
INSERT INTO public.resource_uris VALUES ('1d91d452-2a0f-45e2-90c4-c27dafcac905', '/query/v1/artists?{params}');
INSERT INTO public.resource_uris VALUES ('1d91d452-2a0f-45e2-90c4-c27dafcac905', '/query/v1/artists/byId');
INSERT INTO public.resource_uris VALUES ('a737b8b5-139b-42aa-b7d5-791dc7fb65b9', '/command/v1/artists/bulk-create');
INSERT INTO public.resource_uris VALUES ('a737b8b5-139b-42aa-b7d5-791dc7fb65b9', '/command/v1/artists/bulk-delete');
INSERT INTO public.resource_uris VALUES ('a737b8b5-139b-42aa-b7d5-791dc7fb65b9', '/command/v1/artists/bulk-set-verification');
INSERT INTO public.resource_uris VALUES ('a737b8b5-139b-42aa-b7d5-791dc7fb65b9', '/command/v1/artists/bulk-update');
INSERT INTO public.resource_uris VALUES ('a737b8b5-139b-42aa-b7d5-791dc7fb65b9', '/command/v1/artists/bulk-release');


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.scope_mapping VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', 'c8ba8356-8216-46bf-a431-47b0b9de0d34');
INSERT INTO public.scope_mapping VALUES ('84ebcc31-3c0c-442e-88c4-831383ce7b7d', '98fd5993-790b-45d6-9b0f-9594e32a5647');
INSERT INTO public.scope_mapping VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', '4f8af0cb-3953-4212-bbce-820870e010b4');
INSERT INTO public.scope_mapping VALUES ('58c0eec0-b3f3-4b71-b168-8bd4d34afb36', 'dbfdc817-d71a-4673-b890-bbf0d37f0da7');


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.scope_policy VALUES ('f02a1c2d-4d35-4b7d-b20f-064bf76daa3f', '0f980173-3ba3-4e30-9cd2-a2eabaff30d1');
INSERT INTO public.scope_policy VALUES ('2069897a-496c-4260-916c-1dcd83b5068c', '6d07f7f7-a448-4384-9afa-9d610faeeeb8');


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.user_attribute VALUES ('picture', 'https://lh3.googleusercontent.com/a/ACg8ocKr8LQ5YHKZx4ULgyvfLAzMR6vjCU7khlsO1PugLvRHXVSP1ydYXw=s96-c', '4c50b1e9-e68d-4dcc-af55-90239c585a43', '48de2130-ba36-4615-9767-ed816f422a39', NULL, NULL, NULL);
INSERT INTO public.user_attribute VALUES ('picture', 'https://lh3.googleusercontent.com/a/ACg8ocJ3jcpI58fXcdIxmUFSEUmO8qcOlvaJpiIif2PGtMWNf0Nivh48=s96-c', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'dc388086-06e3-41e0-bff8-5cfe42a661d5', NULL, NULL, NULL);
INSERT INTO public.user_attribute VALUES ('picture', 'https://lh3.googleusercontent.com/a/ACg8ocKr8LQ5YHKZx4ULgyvfLAzMR6vjCU7khlsO1PugLvRHXVSP1ydYXw', 'ece32357-5624-4a80-9367-58ae81562601', '0d1f1367-0b47-4af4-ab79-ae941d802b5f', NULL, NULL, NULL);
INSERT INTO public.user_attribute VALUES ('picture', 'https://lh3.googleusercontent.com/a/ACg8ocIsuRLMu_k6YJ4YAJ91Gl8BuPeqjbIjeucCsl9ss4tYL-hc4eVB=s96-c', 'b6165172-130a-4480-bbf5-3651691834ca', '220ff251-542e-4ae9-9d60-d8888f7012e1', NULL, NULL, NULL);
INSERT INTO public.user_attribute VALUES ('picture', 'https://lh3.googleusercontent.com/a/ACg8ocKwB59HWh2TYocIXHMJRxcsiOduNcaEmR1E8BgXs5kGzCfNJihh=s96-c', '82e87c6a-1ad1-4fa3-98d3-f8cc366b030b', '19567fe6-9fb2-448f-91d2-8430be19001e', NULL, NULL, NULL);


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.user_consent VALUES ('0057ee6a-4dbc-433a-94cf-0b0c6b0983ca', '169fdb62-3bb6-4c8f-a485-014473d18c75', 'ece32357-5624-4a80-9367-58ae81562601', 1744024333870, 1744024333933, NULL, NULL);
INSERT INTO public.user_consent VALUES ('02902ebe-0eaf-4bae-b604-87c74a59f25a', '169fdb62-3bb6-4c8f-a485-014473d18c75', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc', 1744378255878, 1744378255997, NULL, NULL);
INSERT INTO public.user_consent VALUES ('3d10a8f9-ea6b-4ea6-8869-dc12a7fbf293', '169fdb62-3bb6-4c8f-a485-014473d18c75', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 1744902449708, 1744902449727, NULL, NULL);


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.user_consent_client_scope VALUES ('0057ee6a-4dbc-433a-94cf-0b0c6b0983ca', '169fdb62-3bb6-4c8f-a485-014473d18c75');
INSERT INTO public.user_consent_client_scope VALUES ('0057ee6a-4dbc-433a-94cf-0b0c6b0983ca', '348e9652-774c-48ec-b36a-35db8e017f49');
INSERT INTO public.user_consent_client_scope VALUES ('0057ee6a-4dbc-433a-94cf-0b0c6b0983ca', 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.user_consent_client_scope VALUES ('0057ee6a-4dbc-433a-94cf-0b0c6b0983ca', 'ad83b366-1434-49b7-9641-986840523046');
INSERT INTO public.user_consent_client_scope VALUES ('0057ee6a-4dbc-433a-94cf-0b0c6b0983ca', '0a21b0dd-6ab7-4d39-bec1-0162a769c732');
INSERT INTO public.user_consent_client_scope VALUES ('02902ebe-0eaf-4bae-b604-87c74a59f25a', '169fdb62-3bb6-4c8f-a485-014473d18c75');
INSERT INTO public.user_consent_client_scope VALUES ('02902ebe-0eaf-4bae-b604-87c74a59f25a', '348e9652-774c-48ec-b36a-35db8e017f49');
INSERT INTO public.user_consent_client_scope VALUES ('02902ebe-0eaf-4bae-b604-87c74a59f25a', 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.user_consent_client_scope VALUES ('02902ebe-0eaf-4bae-b604-87c74a59f25a', 'ad83b366-1434-49b7-9641-986840523046');
INSERT INTO public.user_consent_client_scope VALUES ('02902ebe-0eaf-4bae-b604-87c74a59f25a', '0a21b0dd-6ab7-4d39-bec1-0162a769c732');
INSERT INTO public.user_consent_client_scope VALUES ('3d10a8f9-ea6b-4ea6-8869-dc12a7fbf293', '169fdb62-3bb6-4c8f-a485-014473d18c75');
INSERT INTO public.user_consent_client_scope VALUES ('3d10a8f9-ea6b-4ea6-8869-dc12a7fbf293', '348e9652-774c-48ec-b36a-35db8e017f49');
INSERT INTO public.user_consent_client_scope VALUES ('3d10a8f9-ea6b-4ea6-8869-dc12a7fbf293', 'cc09bd09-2896-4add-a759-5c0d146c22fb');
INSERT INTO public.user_consent_client_scope VALUES ('3d10a8f9-ea6b-4ea6-8869-dc12a7fbf293', 'ad83b366-1434-49b7-9641-986840523046');
INSERT INTO public.user_consent_client_scope VALUES ('3d10a8f9-ea6b-4ea6-8869-dc12a7fbf293', '0a21b0dd-6ab7-4d39-bec1-0162a769c732');


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.user_entity VALUES ('ece32357-5624-4a80-9367-58ae81562601', 'vutien.dat.3601+admin@gmail.com', 'vutien.dat.3601+admin@gmail.com', true, true, NULL, 'Administrator', 'Echo Vibe', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'admin', 1742549704579, NULL, 0);
INSERT INTO public.user_entity VALUES ('564ed521-e001-49ac-bcad-e114a7ca45e1', NULL, '5b237fb4-5609-4a03-ad48-7107a721a24d', false, true, NULL, NULL, NULL, 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'service-account-echovibe', 1739865201678, 'fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', 0);
INSERT INTO public.user_entity VALUES ('4a047c9a-f502-4788-a0ce-2f8f3f632960', 'vutien.dat.3601@gmail.com', 'vutien.dat.3601@gmail.com', true, true, NULL, 'Echo', 'Vibe', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'echovibe', 1739865035026, NULL, 0);
INSERT INTO public.user_entity VALUES ('790e017c-4459-4921-b732-49b14a7779be', 'vutien.dat.3601+test@gmail.com', 'vutien.dat.3601+test@gmail.com', true, true, NULL, 'Test', 'User', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'test', 1739865554308, NULL, 0);
INSERT INTO public.user_entity VALUES ('2aad1ba3-aa92-44b7-9d86-e8d51b3ee6e1', 'vutien.dat.3601+testartistmanager@gmail.com', 'vutien.dat.3601+testartistmanager@gmail.com', true, true, NULL, 'Test', 'Artist Manager', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'testartistmanager', 1739892130644, NULL, 0);
INSERT INTO public.user_entity VALUES ('0b217f9c-59b3-4b71-a0cb-082bd43b2c35', 'ptung230801@gmail.com', 'ptung230801@gmail.com', true, true, NULL, 'PHẠM', 'TÙNG', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'ptung230801@gmail.com', 1742565175141, NULL, 0);
INSERT INTO public.user_entity VALUES ('4c50b1e9-e68d-4dcc-af55-90239c585a43', 'vutien.dat.3601@gmail.com', 'vutien.dat.3601@gmail.com', true, true, NULL, 'Dat', 'Vu', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'vutien.dat.3601@gmail.com', 1742389291717, NULL, 0);
INSERT INTO public.user_entity VALUES ('5f4682fd-a16b-472e-8ea9-fb7cf89c89fc', 'vutien.dat.3601+echovibe@gmail.com', 'vutien.dat.3601+echovibe@gmail.com', true, true, NULL, 'echovibe', 'echovibe', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'echovibe', 1742441912842, NULL, 0);
INSERT INTO public.user_entity VALUES ('9f4df771-be8c-4f1f-95b8-b7da84aa9fbd', NULL, 'b3566b15-5809-48e0-996a-104be3fe2899', false, true, NULL, 'Vu', 'Do', '2026c8b7-3df3-4568-a2e8-89f7d2fffe5e', 'vudo', 1743582782130, NULL, 0);
INSERT INTO public.user_entity VALUES ('b6165172-130a-4480-bbf5-3651691834ca', 'pttung230801@gmail.com', 'pttung230801@gmail.com', true, true, NULL, 'Tùng', 'Phạm', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'pttung230801@gmail.com', 1742613604161, NULL, 0);
INSERT INTO public.user_entity VALUES ('82e87c6a-1ad1-4fa3-98d3-f8cc366b030b', 'truonglam.113.147@gmail.com', 'truonglam.113.147@gmail.com', true, true, NULL, 'Lam', 'Vo', 'dd6a5b23-a699-44e1-8210-886a0a2eafac', 'truonglam.113.147@gmail.com', 1745902784136, NULL, 0);


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--



--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.user_required_action VALUES ('b6165172-130a-4480-bbf5-3651691834ca', 'VERIFY_EMAIL');


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.user_role_mapping VALUES ('d3c05f33-6706-4396-a2b2-2268456979e3', '4a047c9a-f502-4788-a0ce-2f8f3f632960');
INSERT INTO public.user_role_mapping VALUES ('241fe769-3c75-4f9f-9d11-09c03d1abd8b', '4a047c9a-f502-4788-a0ce-2f8f3f632960');
INSERT INTO public.user_role_mapping VALUES ('90f9c3d5-9103-48b9-8ed7-df08696d71c8', '4a047c9a-f502-4788-a0ce-2f8f3f632960');
INSERT INTO public.user_role_mapping VALUES ('c1a662d0-51bf-43ff-96d4-1e48918c0f05', '4a047c9a-f502-4788-a0ce-2f8f3f632960');
INSERT INTO public.user_role_mapping VALUES ('48e6c230-8c04-4682-a594-50f40015b60a', '4a047c9a-f502-4788-a0ce-2f8f3f632960');
INSERT INTO public.user_role_mapping VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '564ed521-e001-49ac-bcad-e114a7ca45e1');
INSERT INTO public.user_role_mapping VALUES ('adc8ecf8-ecad-4583-afd3-1322cbeae86a', '564ed521-e001-49ac-bcad-e114a7ca45e1');
INSERT INTO public.user_role_mapping VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '790e017c-4459-4921-b732-49b14a7779be');
INSERT INTO public.user_role_mapping VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '2aad1ba3-aa92-44b7-9d86-e8d51b3ee6e1');
INSERT INTO public.user_role_mapping VALUES ('73d2123e-fd74-4ba8-876a-d0decdef85eb', '2aad1ba3-aa92-44b7-9d86-e8d51b3ee6e1');
INSERT INTO public.user_role_mapping VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '4c50b1e9-e68d-4dcc-af55-90239c585a43');
INSERT INTO public.user_role_mapping VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('435aeb6e-b775-44dd-9387-ce3dc556d2b2', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('b18947c5-2899-4c3f-a03b-46d34c64751c', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('27e1ca03-473f-4f79-83be-3a1bcfe4a513', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('a17ed491-2603-481b-9175-f383c241d9f3', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('dbfdc817-d71a-4673-b890-bbf0d37f0da7', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('22004d3b-0773-4e07-9789-1c628128c373', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('4f8af0cb-3953-4212-bbce-820870e010b4', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('fd687c2f-9a61-41e7-bd78-2aed4561aa35', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('40e3ec88-cc76-4c76-bda3-51e2519185c3', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('ac383a78-e1ce-4800-bb18-58986bbb3f18', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('6fdc94fa-bf18-4810-9855-8b2896f428a5', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('d2b1bdb5-fca3-40b3-ac55-760dc7b2bab9', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('aa56f4f6-5aa9-4965-9924-46f3af55502d', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('83b9f2cc-737e-4aea-b7ae-2c5bad0e17ff', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('42bd1074-987d-409c-a494-0cc504d084f0', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('a776a0a2-94d5-4d5d-b811-cc40d9bb0762', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('add044bb-d3df-4a90-803c-a66488ce182f', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('44b45f91-4b23-49d3-bf05-c52a2b56c629', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('1399ad75-8c8e-4c2b-bede-9639abe5492c', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('a81d15fa-7dde-41d7-a442-23cc82355df0', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('f4d97501-58a6-46d8-b1f0-691504623c37', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('72be0591-a36c-4f66-a915-a749035d7152', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('4355c3bc-9487-4f78-8ede-f5cb257ca4c4', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('3f471337-62da-4a46-b8a7-17424a790618', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('d41e0d07-46ed-4427-ab0e-4ac93bc34317', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('62901d69-6a2b-48ac-9946-f7e937f77f63', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('b7b009bd-5932-4cec-b0f1-308f913c1f5c', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('b42c9c10-448f-440a-af35-8c67583f3e22', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('1bd2b1f1-790c-439f-a19a-9ac069878ffb', '5f4682fd-a16b-472e-8ea9-fb7cf89c89fc');
INSERT INTO public.user_role_mapping VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', 'ece32357-5624-4a80-9367-58ae81562601');
INSERT INTO public.user_role_mapping VALUES ('435aeb6e-b775-44dd-9387-ce3dc556d2b2', 'ece32357-5624-4a80-9367-58ae81562601');
INSERT INTO public.user_role_mapping VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35');
INSERT INTO public.user_role_mapping VALUES ('435aeb6e-b775-44dd-9387-ce3dc556d2b2', '0b217f9c-59b3-4b71-a0cb-082bd43b2c35');
INSERT INTO public.user_role_mapping VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', 'b6165172-130a-4480-bbf5-3651691834ca');
INSERT INTO public.user_role_mapping VALUES ('d3c05f33-6706-4396-a2b2-2268456979e3', '9f4df771-be8c-4f1f-95b8-b7da84aa9fbd');
INSERT INTO public.user_role_mapping VALUES ('3a46a530-8f21-4bae-b8f2-e8230c6fd1a7', '82e87c6a-1ad1-4fa3-98d3-f8cc366b030b');


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: echovibe_keycloak
--

INSERT INTO public.web_origins VALUES ('1badc467-6237-4e4e-8e76-2040f96f32c0', '+');
INSERT INTO public.web_origins VALUES ('f98caaa5-4a77-46e2-9332-1c1286af39fd', '+');
INSERT INTO public.web_origins VALUES ('fc52cbd7-fdcb-4cd9-83c4-f0a1dc452944', '/*');
INSERT INTO public.web_origins VALUES ('169fdb62-3bb6-4c8f-a485-014473d18c75', '*');
INSERT INTO public.web_origins VALUES ('a40eb3a2-ac4e-4496-bed0-32414c7c64c0', '*');


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: echovibe_keycloak
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: echovibe_keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6
-- Dumped by pg_dump version 16.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

