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
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE activity_logs (
    id integer NOT NULL,
    name character varying(255),
    student_id integer,
    project_id integer,
    teacher_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activity_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activity_logs_id_seq OWNED BY activity_logs.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: categories_projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories_projects (
    id integer NOT NULL,
    category_id integer,
    project_id integer
);


--
-- Name: categories_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_projects_id_seq OWNED BY categories_projects.id;


--
-- Name: chats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chats (
    id integer NOT NULL,
    message text,
    student_id integer,
    teacher_id integer,
    project_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: chats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE chats_id_seq OWNED BY chats.id;


--
-- Name: chats_students; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chats_students (
    id integer NOT NULL,
    chat_id integer,
    student_id integer
);


--
-- Name: chats_students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chats_students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chats_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE chats_students_id_seq OWNED BY chats_students.id;


--
-- Name: chats_teachers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chats_teachers (
    id integer NOT NULL,
    chat_id integer,
    teacher_id integer
);


--
-- Name: chats_teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chats_teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chats_teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE chats_teachers_id_seq OWNED BY chats_teachers.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(255),
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    project_type character varying(255),
    subject_id integer,
    approval_status character varying(255)
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
-- Name: projects_students; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects_students (
    id integer NOT NULL,
    project_id integer,
    student_id integer
);


--
-- Name: projects_students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_students_id_seq OWNED BY projects_students.id;


--
-- Name: projects_teachers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects_teachers (
    id integer NOT NULL,
    project_id integer,
    teacher_id integer
);


--
-- Name: projects_teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_teachers_id_seq OWNED BY projects_teachers.id;


--
-- Name: projects_technologies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects_technologies (
    id integer NOT NULL,
    technology_id integer,
    project_id integer
);


--
-- Name: projects_technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_technologies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_technologies_id_seq OWNED BY projects_technologies.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: students; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE students (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    phone_number character varying(255),
    email character varying(255),
    matricula_number character varying(255),
    pesel character varying(255),
    password_hash character varying(255),
    password_salt character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE students_id_seq OWNED BY students.id;


--
-- Name: students_subjects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE students_subjects (
    id integer NOT NULL,
    student_id integer,
    subject_id integer
);


--
-- Name: students_subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE students_subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE students_subjects_id_seq OWNED BY students_subjects.id;


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE subjects (
    id integer NOT NULL,
    name character varying(255),
    subject_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE subjects_id_seq OWNED BY subjects.id;


--
-- Name: subjects_teachers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE subjects_teachers (
    id integer NOT NULL,
    teacher_id integer,
    subject_id integer
);


--
-- Name: subjects_teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE subjects_teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subjects_teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE subjects_teachers_id_seq OWNED BY subjects_teachers.id;


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE teachers (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    phone_number character varying(255),
    email character varying(255),
    password_hash character varying(255),
    password_salt character varying(255),
    academic_title character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teachers_id_seq OWNED BY teachers.id;


--
-- Name: technologies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE technologies (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE technologies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE technologies_id_seq OWNED BY technologies.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activity_logs ALTER COLUMN id SET DEFAULT nextval('activity_logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories_projects ALTER COLUMN id SET DEFAULT nextval('categories_projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY chats ALTER COLUMN id SET DEFAULT nextval('chats_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY chats_students ALTER COLUMN id SET DEFAULT nextval('chats_students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY chats_teachers ALTER COLUMN id SET DEFAULT nextval('chats_teachers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects_students ALTER COLUMN id SET DEFAULT nextval('projects_students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects_teachers ALTER COLUMN id SET DEFAULT nextval('projects_teachers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects_technologies ALTER COLUMN id SET DEFAULT nextval('projects_technologies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY students_subjects ALTER COLUMN id SET DEFAULT nextval('students_subjects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY subjects ALTER COLUMN id SET DEFAULT nextval('subjects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY subjects_teachers ALTER COLUMN id SET DEFAULT nextval('subjects_teachers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teachers ALTER COLUMN id SET DEFAULT nextval('teachers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY technologies ALTER COLUMN id SET DEFAULT nextval('technologies_id_seq'::regclass);


--
-- Name: activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories_projects
    ADD CONSTRAINT categories_projects_pkey PRIMARY KEY (id);


--
-- Name: chats_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);


--
-- Name: chats_students_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chats_students
    ADD CONSTRAINT chats_students_pkey PRIMARY KEY (id);


--
-- Name: chats_teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chats_teachers
    ADD CONSTRAINT chats_teachers_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: projects_students_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects_students
    ADD CONSTRAINT projects_students_pkey PRIMARY KEY (id);


--
-- Name: projects_teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects_teachers
    ADD CONSTRAINT projects_teachers_pkey PRIMARY KEY (id);


--
-- Name: projects_technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects_technologies
    ADD CONSTRAINT projects_technologies_pkey PRIMARY KEY (id);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: students_subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY students_subjects
    ADD CONSTRAINT students_subjects_pkey PRIMARY KEY (id);


--
-- Name: subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: subjects_teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY subjects_teachers
    ADD CONSTRAINT subjects_teachers_pkey PRIMARY KEY (id);


--
-- Name: teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY technologies
    ADD CONSTRAINT technologies_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140225184101');

INSERT INTO schema_migrations (version) VALUES ('20140311183152');

INSERT INTO schema_migrations (version) VALUES ('20140312081939');

INSERT INTO schema_migrations (version) VALUES ('20140312082708');

INSERT INTO schema_migrations (version) VALUES ('20140312084047');

INSERT INTO schema_migrations (version) VALUES ('20140312110616');

INSERT INTO schema_migrations (version) VALUES ('20140314113830');

INSERT INTO schema_migrations (version) VALUES ('20140314115212');

INSERT INTO schema_migrations (version) VALUES ('20140314115804');

INSERT INTO schema_migrations (version) VALUES ('20140314120112');

INSERT INTO schema_migrations (version) VALUES ('20140317184305');

INSERT INTO schema_migrations (version) VALUES ('20140317184531');

INSERT INTO schema_migrations (version) VALUES ('20140319102055');

INSERT INTO schema_migrations (version) VALUES ('20140319102409');

INSERT INTO schema_migrations (version) VALUES ('20140319135752');

INSERT INTO schema_migrations (version) VALUES ('20140319140227');

INSERT INTO schema_migrations (version) VALUES ('20140329142645');

INSERT INTO schema_migrations (version) VALUES ('20140402092223');

INSERT INTO schema_migrations (version) VALUES ('20140402093712');

INSERT INTO schema_migrations (version) VALUES ('20140402093758');

