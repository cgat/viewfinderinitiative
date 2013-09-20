--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: historic_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE historic_images (
    id integer NOT NULL,
    image character varying(255),
    date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    width integer,
    height integer
);


--
-- Name: historic_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE historic_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: historic_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE historic_images_id_seq OWNED BY historic_images.id;


--
-- Name: pointsable_points; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pointsable_points (
    id integer NOT NULL,
    x integer,
    y integer,
    label character varying(255),
    pointsable_type character varying(255),
    pointsable_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pointsable_points_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pointsable_points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pointsable_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pointsable_points_id_seq OWNED BY pointsable_points.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: repeat_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE repeat_images (
    id integer NOT NULL,
    image character varying(255),
    date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    width integer,
    height integer
);


--
-- Name: repeat_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE repeat_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: repeat_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE repeat_images_id_seq OWNED BY repeat_images.id;


--
-- Name: repeat_pairs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE repeat_pairs (
    id integer NOT NULL,
    historic_image_id integer,
    repeat_image_id integer,
    station_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: repeat_pairs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE repeat_pairs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: repeat_pairs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE repeat_pairs_id_seq OWNED BY repeat_pairs.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: stations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stations (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    project_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: stations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stations_id_seq OWNED BY stations.id;


--
-- Name: user_repeat_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_repeat_images (
    id integer NOT NULL,
    image character varying(255),
    date date,
    user_id integer,
    repeat_pair_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    width integer,
    height integer,
    notes text
);


--
-- Name: user_repeat_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_repeat_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_repeat_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_repeat_images_id_seq OWNED BY user_repeat_images.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY historic_images ALTER COLUMN id SET DEFAULT nextval('historic_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pointsable_points ALTER COLUMN id SET DEFAULT nextval('pointsable_points_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY repeat_images ALTER COLUMN id SET DEFAULT nextval('repeat_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY repeat_pairs ALTER COLUMN id SET DEFAULT nextval('repeat_pairs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stations ALTER COLUMN id SET DEFAULT nextval('stations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_repeat_images ALTER COLUMN id SET DEFAULT nextval('user_repeat_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: historic_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY historic_images
    ADD CONSTRAINT historic_images_pkey PRIMARY KEY (id);


--
-- Name: pointsable_points_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pointsable_points
    ADD CONSTRAINT pointsable_points_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: repeat_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY repeat_images
    ADD CONSTRAINT repeat_images_pkey PRIMARY KEY (id);


--
-- Name: repeat_pairs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY repeat_pairs
    ADD CONSTRAINT repeat_pairs_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: stations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (id);


--
-- Name: user_repeat_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_repeat_images
    ADD CONSTRAINT user_repeat_images_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_stations_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stations_on_project_id ON stations USING btree (project_id);


--
-- Name: index_user_repeat_images_on_historic_image_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_repeat_images_on_historic_image_id ON user_repeat_images USING btree (repeat_pair_id);


--
-- Name: index_user_repeat_images_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_repeat_images_on_user_id ON user_repeat_images USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130715050815');

INSERT INTO schema_migrations (version) VALUES ('20130715050818');

INSERT INTO schema_migrations (version) VALUES ('20130715050824');

INSERT INTO schema_migrations (version) VALUES ('20130715085606');

INSERT INTO schema_migrations (version) VALUES ('20130722023759');

INSERT INTO schema_migrations (version) VALUES ('20130722023828');

INSERT INTO schema_migrations (version) VALUES ('20130722024910');

INSERT INTO schema_migrations (version) VALUES ('20130722025031');

INSERT INTO schema_migrations (version) VALUES ('20130722043446');

INSERT INTO schema_migrations (version) VALUES ('20130726021946');

INSERT INTO schema_migrations (version) VALUES ('20130726022038');

INSERT INTO schema_migrations (version) VALUES ('20130726022705');

INSERT INTO schema_migrations (version) VALUES ('20130902042954');

INSERT INTO schema_migrations (version) VALUES ('20130911044514');