--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: app_file; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_file (
    id integer NOT NULL,
    name character varying(200),
    file character varying(100) NOT NULL,
    date timestamp with time zone NOT NULL
);


ALTER TABLE public.app_file OWNER TO olga;

--
-- Name: app_file_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_file_id_seq OWNER TO olga;

--
-- Name: app_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_file_id_seq OWNED BY app_file.id;


--
-- Name: app_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_file_id_seq', 1, false);


--
-- Name: app_node; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_node (
    id integer NOT NULL,
    title character varying(300) NOT NULL,
    name_id character varying(300) NOT NULL,
    product_id integer NOT NULL,
    parent_id integer,
    type character varying(2) NOT NULL,
    curator_id integer,
    developer_id integer,
    tester_id integer,
    cur_status_id integer,
    cur_release_id integer,
    source_id integer,
    source_description character varying(300),
    creation_date timestamp with time zone NOT NULL,
    last_modified_date timestamp with time zone NOT NULL,
    content text,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    CONSTRAINT app_node_level_check CHECK ((level >= 0)),
    CONSTRAINT app_node_lft_check CHECK ((lft >= 0)),
    CONSTRAINT app_node_rght_check CHECK ((rght >= 0)),
    CONSTRAINT app_node_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE public.app_node OWNER TO olga;

--
-- Name: app_node_files; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_node_files (
    id integer NOT NULL,
    node_id integer NOT NULL,
    file_id integer NOT NULL
);


ALTER TABLE public.app_node_files OWNER TO olga;

--
-- Name: app_node_files_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_node_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_node_files_id_seq OWNER TO olga;

--
-- Name: app_node_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_node_files_id_seq OWNED BY app_node_files.id;


--
-- Name: app_node_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_node_files_id_seq', 1, false);


--
-- Name: app_node_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_node_id_seq OWNER TO olga;

--
-- Name: app_node_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_node_id_seq OWNED BY app_node.id;


--
-- Name: app_node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_node_id_seq', 1, false);


--
-- Name: app_product; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_product (
    id integer NOT NULL,
    title character varying(300) NOT NULL,
    short_name character varying(300) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.app_product OWNER TO olga;

--
-- Name: app_product_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_product_id_seq OWNER TO olga;

--
-- Name: app_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_product_id_seq OWNED BY app_product.id;


--
-- Name: app_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_product_id_seq', 3, true);


--
-- Name: app_release; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_release (
    id integer NOT NULL,
    name character varying(300) NOT NULL,
    number character varying(50) NOT NULL,
    status boolean NOT NULL,
    description text NOT NULL,
    date timestamp with time zone,
    product_id integer NOT NULL
);


ALTER TABLE public.app_release OWNER TO olga;

--
-- Name: app_release_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_release_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_release_id_seq OWNER TO olga;

--
-- Name: app_release_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_release_id_seq OWNED BY app_release.id;


--
-- Name: app_release_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_release_id_seq', 1, false);


--
-- Name: app_releasehistory; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_releasehistory (
    id integer NOT NULL,
    id_node_id integer NOT NULL,
    id_release_id integer NOT NULL,
    description text NOT NULL,
    date timestamp with time zone NOT NULL
);


ALTER TABLE public.app_releasehistory OWNER TO olga;

--
-- Name: app_releasehistory_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_releasehistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_releasehistory_id_seq OWNER TO olga;

--
-- Name: app_releasehistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_releasehistory_id_seq OWNED BY app_releasehistory.id;


--
-- Name: app_releasehistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_releasehistory_id_seq', 1, false);


--
-- Name: app_source; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_source (
    id integer NOT NULL,
    source character varying(300) NOT NULL
);


ALTER TABLE public.app_source OWNER TO olga;

--
-- Name: app_source_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_source_id_seq OWNER TO olga;

--
-- Name: app_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_source_id_seq OWNED BY app_source.id;


--
-- Name: app_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_source_id_seq', 3, true);


--
-- Name: app_status; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_status (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    color character varying(7) NOT NULL
);


ALTER TABLE public.app_status OWNER TO olga;

--
-- Name: app_status_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_status_id_seq OWNER TO olga;

--
-- Name: app_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_status_id_seq OWNED BY app_status.id;


--
-- Name: app_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_status_id_seq', 6, true);


--
-- Name: app_statuscoloruser; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_statuscoloruser (
    id integer NOT NULL,
    user_id integer NOT NULL,
    status_id integer NOT NULL,
    color character varying(7) NOT NULL
);


ALTER TABLE public.app_statuscoloruser OWNER TO olga;

--
-- Name: app_statuscoloruser_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_statuscoloruser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_statuscoloruser_id_seq OWNER TO olga;

--
-- Name: app_statuscoloruser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_statuscoloruser_id_seq OWNED BY app_statuscoloruser.id;


--
-- Name: app_statuscoloruser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_statuscoloruser_id_seq', 1, false);


--
-- Name: app_statushistory; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_statushistory (
    id integer NOT NULL,
    id_node_id integer NOT NULL,
    id_status_id integer NOT NULL,
    description text NOT NULL,
    date timestamp with time zone NOT NULL
);


ALTER TABLE public.app_statushistory OWNER TO olga;

--
-- Name: app_statushistory_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_statushistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_statushistory_id_seq OWNER TO olga;

--
-- Name: app_statushistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_statushistory_id_seq OWNED BY app_statushistory.id;


--
-- Name: app_statushistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_statushistory_id_seq', 1, false);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO olga;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO olga;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('auth_group_id_seq', 3, true);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO olga;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO olga;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 81, true);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO olga;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO olga;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('auth_permission_id_seq', 51, true);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    password character varying(128) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superuser boolean NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO olga;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO olga;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO olga;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 21, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO olga;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('auth_user_id_seq', 13, true);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO olga;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO olga;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    content_type_id integer,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO olga;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO olga;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 46, true);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO olga;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO olga;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('django_content_type_id_seq', 17, true);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO olga;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO olga;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO olga;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Name: registration_registrationprofile; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE registration_registrationprofile (
    id integer NOT NULL,
    user_id integer NOT NULL,
    activation_key character varying(40) NOT NULL
);


ALTER TABLE public.registration_registrationprofile OWNER TO olga;

--
-- Name: registration_registrationprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE registration_registrationprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.registration_registrationprofile_id_seq OWNER TO olga;

--
-- Name: registration_registrationprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE registration_registrationprofile_id_seq OWNED BY registration_registrationprofile.id;


--
-- Name: registration_registrationprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('registration_registrationprofile_id_seq', 1, false);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_file ALTER COLUMN id SET DEFAULT nextval('app_file_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node ALTER COLUMN id SET DEFAULT nextval('app_node_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node_files ALTER COLUMN id SET DEFAULT nextval('app_node_files_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_product ALTER COLUMN id SET DEFAULT nextval('app_product_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_release ALTER COLUMN id SET DEFAULT nextval('app_release_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_releasehistory ALTER COLUMN id SET DEFAULT nextval('app_releasehistory_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_source ALTER COLUMN id SET DEFAULT nextval('app_source_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_status ALTER COLUMN id SET DEFAULT nextval('app_status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_statuscoloruser ALTER COLUMN id SET DEFAULT nextval('app_statuscoloruser_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_statushistory ALTER COLUMN id SET DEFAULT nextval('app_statushistory_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: olga
--

ALTER TABLE ONLY registration_registrationprofile ALTER COLUMN id SET DEFAULT nextval('registration_registrationprofile_id_seq'::regclass);


--
-- Data for Name: app_file; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_file (id, name, file, date) FROM stdin;
\.


--
-- Data for Name: app_node; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_node (id, title, name_id, product_id, parent_id, type, curator_id, developer_id, tester_id, cur_status_id, cur_release_id, source_id, source_description, creation_date, last_modified_date, content, lft, rght, tree_id, level) FROM stdin;
\.


--
-- Data for Name: app_node_files; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_node_files (id, node_id, file_id) FROM stdin;
\.


--
-- Data for Name: app_product; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_product (id, title, short_name, description) FROM stdin;
1	AnyStock	AS	
2	AnyGantt	AG	
3	AnyChart	AC	
\.


--
-- Data for Name: app_release; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_release (id, name, number, status, description, date, product_id) FROM stdin;
\.


--
-- Data for Name: app_releasehistory; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_releasehistory (id, id_node_id, id_release_id, description, date) FROM stdin;
\.


--
-- Data for Name: app_source; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_source (id, source) FROM stdin;
1	отчет об ошибке
2	аналитика
3	клиентский запрос
\.


--
-- Data for Name: app_status; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_status (id, title, color) FROM stdin;
1	cоздано	#cccccc
2	на согласовании	#CD3700
3	в процессе реализации	#0000CD
4	в процессе проверки	#006400
5	реализовано	#8B4513
6	удалено	#EE7621
\.


--
-- Data for Name: app_statuscoloruser; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_statuscoloruser (id, user_id, status_id, color) FROM stdin;
\.


--
-- Data for Name: app_statushistory; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_statushistory (id, id_node_id, id_status_id, description, date) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY auth_group (id, name) FROM stdin;
1	curators
3	developers
2	testers
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	25
2	1	26
3	1	27
4	1	28
5	1	29
6	1	30
7	1	31
8	1	32
9	1	33
10	1	34
11	1	35
12	1	36
13	1	37
14	1	38
15	1	39
16	1	40
17	1	41
18	1	42
19	1	43
20	1	44
21	1	45
22	1	46
23	1	47
24	1	48
25	1	49
26	1	50
27	1	51
28	3	25
29	3	26
30	3	27
31	3	28
32	3	29
33	3	30
34	3	31
35	3	32
36	3	33
37	3	34
38	3	35
39	3	36
40	3	37
41	3	38
42	3	39
43	3	40
44	3	41
45	3	42
46	3	43
47	3	44
48	3	45
49	3	46
50	3	47
51	3	48
52	3	49
53	3	50
54	3	51
55	2	25
56	2	26
57	2	27
58	2	28
59	2	29
60	2	30
61	2	31
62	2	32
63	2	33
64	2	34
65	2	35
66	2	36
67	2	37
68	2	38
69	2	39
70	2	40
71	2	41
72	2	42
73	2	43
74	2	44
75	2	45
76	2	46
77	2	47
78	2	48
79	2	49
80	2	50
81	2	51
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add site	7	add_site
20	Can change site	7	change_site
21	Can delete site	7	delete_site
22	Can add registration profile	8	add_registrationprofile
23	Can change registration profile	8	change_registrationprofile
24	Can delete registration profile	8	delete_registrationprofile
25	Can add продукт	9	add_product
26	Can change продукт	9	change_product
27	Can delete продукт	9	delete_product
28	Can add релиз	10	add_release
29	Can change релиз	10	change_release
30	Can delete релиз	10	delete_release
31	Can add статус	11	add_status
32	Can change статус	11	change_status
33	Can delete статус	11	delete_status
34	Can add цвет статуса	12	add_statuscoloruser
35	Can change цвет статуса	12	change_statuscoloruser
36	Can delete цвет статуса	12	delete_statuscoloruser
37	Can add источник	13	add_source
38	Can change источник	13	change_source
39	Can delete источник	13	delete_source
40	Can add файл	14	add_file
41	Can change файл	14	change_file
42	Can delete файл	14	delete_file
43	Can add узел дерева	15	add_node
44	Can change узел дерева	15	change_node
45	Can delete узел дерева	15	delete_node
46	Can add историю смены статусов	16	add_statushistory
47	Can change историю смены статусов	16	change_statushistory
48	Can delete историю смены статусов	16	delete_statushistory
49	Can add историю смены релиза	17	add_releasehistory
50	Can change историю смены релиза	17	change_releasehistory
51	Can delete историю смены релиза	17	delete_releasehistory
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined) FROM stdin;
4	alexandra.batyreva	Александра	Батырева	alexandra.batireva@anychart.com	pbkdf2_sha256$10000$Z6nIeu3S4RYN$9dxu60kRHaJwagKHxs2ZuqtiQisQ/vnjF5sd8NGt/SI=	f	t	f	2012-12-11 13:15:04+09	2012-12-11 13:15:04+09
3	alexander.kudryavtsev	Александр	Кудрявцев	alexander.kudryavtsev@anychart.com	pbkdf2_sha256$10000$erXtrXTF4PtM$2aTPDu4ikp4rdEMlesO/Osp90AFg0NiCts/65vmzWYE=	f	t	f	2012-12-11 13:14:57+09	2012-12-11 13:14:57+09
2	alex.batsuev	Александр	Бацуев	alex.batsuev@anychart.com	pbkdf2_sha256$10000$ftZUefOZabqF$jKjJxDBtipFdxalaH+HqouNfrQDi4ss0eYF18KFV/yI=	f	t	f	2012-12-11 13:14:48+09	2012-12-11 13:14:48+09
5	andrey.shakhmin	Андрей	Шахмин	andrey.shakhmin@anychart.com	pbkdf2_sha256$10000$Jb63Wu9NyAOJ$JR2Pnz69XuuugN0ObbvY8loWdBf+ew5YyLF51AhfZc8=	f	t	f	2012-12-11 13:15:10+09	2012-12-11 13:15:10+09
6	anton.baranchuk	Антон	Баранчук	anton.baranchuk@anychart.com	pbkdf2_sha256$10000$lEeJgQ6GbxAf$O1YOAGr9mEIdgk13VyHxmN2GFQhTrsOpu20roW98RRo=	f	t	f	2012-12-11 13:15:17+09	2012-12-11 13:15:17+09
7	anton.kagakin	Антон	Кагакин	anton.kagakin@anychart.com	pbkdf2_sha256$10000$T1VjP45kAmUo$xXpzDwExRq9QKaNGUTjo0FAQpVk3OXG6hJwcxzS99Lc=	f	t	f	2012-12-11 13:15:24+09	2012-12-11 13:15:24+09
8	anton.saukh	Антон	Саух	anton.saukh@anychart.com	pbkdf2_sha256$10000$IJj4GiMF6qIO$hMlA5zheCEanClsexjunwIPfbBg/jbe4RlMIAaaPAow=	f	t	f	2012-12-11 13:15:31+09	2012-12-11 13:15:31+09
1	olga	Ольга	Рыкова	vorobyeva.rykova@gmail.com	pbkdf2_sha256$10000$qFjLZ3ymg3ex$5+SvMj8jO4tPE9a9Jl1Jy+wr8Cw2/yPYMzRFQd9u3cM=	t	t	t	2012-12-11 13:07:15+09	2012-12-11 13:05:53+09
9	olga.rykova	Ольга	Рыкова	olga.rykova@anychart.com	pbkdf2_sha256$10000$MDegXoaPloWb$oc9C7pLCACpEOINe1IcNjyJSSkoEWguY2ah1ImXvhEw=	f	t	f	2012-12-11 13:16:07+09	2012-12-11 13:16:07+09
10	roman.lubushkin	Роман	Любушкин	roman.lubushkin@anychart.com	pbkdf2_sha256$10000$Dzg6RCpYVr26$LjTBYzVbFepoh8Z5qQz0i0xCsmO1UWxQ7yNhjCwrjbc=	f	t	f	2012-12-11 13:16:23+09	2012-12-11 13:16:23+09
11	sergey.medvedev	Сергей	Медведев	sergey.medvedev@anychart.com	pbkdf2_sha256$10000$4ePSrP0LHH50$muFw4RUelsP563PwmrutM+BmWkIZM+C1LQtDIiqYEfU=	f	t	f	2012-12-11 13:16:27+09	2012-12-11 13:16:27+09
12	timothy.loginov	Тимофей	Логинов	timothy.loginov@anychart.com	pbkdf2_sha256$10000$KOXv5ZWJ5jCv$4cFLZ4+T/p7srPlPDMu+mnLWAO6u1/7tq9AfRdBG9yM=	f	t	f	2012-12-11 13:16:34+09	2012-12-11 13:16:34+09
13	vitaly.radionov	Виталий	Радионов	vitaly.radionov@anychart.com	pbkdf2_sha256$10000$6NCR7sswLkMQ$INjTEttU73+ywZj8ZaPa7Nib1F+sfgto8z0oo+GtH3g=	f	t	f	2012-12-11 13:16:40+09	2012-12-11 13:16:40+09
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
4	4	1
5	4	2
6	3	3
7	2	3
8	5	1
9	6	1
10	7	3
11	8	3
12	1	1
13	1	2
14	1	3
15	9	1
16	9	2
17	10	3
18	11	3
19	12	1
20	13	1
21	13	2
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY django_admin_log (id, action_time, user_id, content_type_id, object_id, object_repr, action_flag, change_message) FROM stdin;
1	2012-12-11 13:11:10.021369+09	1	13	1	отчет об ошибке	1	
2	2012-12-11 13:11:13.283032+09	1	13	2	аналитика	1	
3	2012-12-11 13:11:16.812713+09	1	13	3	клиентский запрос	1	
4	2012-12-11 13:11:45.838072+09	1	9	1	AnyStock	1	
5	2012-12-11 13:11:57.276941+09	1	9	2	AnyGantt	1	
6	2012-12-11 13:12:04.840942+09	1	9	3	AnyChart	1	
7	2012-12-11 13:12:27.833855+09	1	11	1	cоздано	1	
8	2012-12-11 13:12:35.536469+09	1	11	2	на согласовании	1	
9	2012-12-11 13:12:45.425359+09	1	11	3	в процессе реализации	1	
10	2012-12-11 13:12:52.265142+09	1	11	4	в процессе проверки	1	
11	2012-12-11 13:12:59.347463+09	1	11	5	реализовано	1	
12	2012-12-11 13:13:06.487157+09	1	11	6	удалено	1	
13	2012-12-11 13:13:40.841742+09	1	3	1	curators	1	
14	2012-12-11 13:13:46.917063+09	1	3	2	testers	1	
15	2012-12-11 13:13:50.783695+09	1	3	3	developers	1	
16	2012-12-11 13:14:01.559934+09	1	3	1	curators	2	Изменен permissions.
17	2012-12-11 13:14:08.156647+09	1	3	3	developers	2	Изменен permissions.
18	2012-12-11 13:14:15.046806+09	1	3	2	testers	2	Изменен permissions.
19	2012-12-11 13:14:49.025305+09	1	4	2	alex.batsuev	1	
20	2012-12-11 13:14:57.505002+09	1	4	3	alexander.kudryavtsev	1	
21	2012-12-11 13:15:04.126617+09	1	4	4	alexandra.batyreva	1	
22	2012-12-11 13:15:10.98545+09	1	4	5	andrey.shakhmin	1	
23	2012-12-11 13:15:17.504234+09	1	4	6	anton.baranchuk	1	
24	2012-12-11 13:15:24.972039+09	1	4	7	anton.kagakin	1	
25	2012-12-11 13:15:31.21112+09	1	4	8	anton.saukh	1	
26	2012-12-11 13:16:07.518865+09	1	4	9	olga.rykova	1	
27	2012-12-11 13:16:23.155336+09	1	4	10	roman.lubushkin	1	
28	2012-12-11 13:16:27.80849+09	1	4	11	sergey.medvedev	1	
29	2012-12-11 13:16:34.172418+09	1	4	12	timothy.loginov	1	
30	2012-12-11 13:16:41.039799+09	1	4	13	vitaly.radionov	1	
31	2012-12-11 13:17:40.228858+09	1	4	3	alexander.kudryavtsev	2	Изменен password,first_name,last_name,email,is_staff и groups.
32	2012-12-11 13:18:11.177286+09	1	4	4	alexandra.batyreva	2	Изменен password,first_name,last_name,email и groups.
33	2012-12-11 13:18:22.582626+09	1	4	4	alexandra.batyreva	2	Изменен password.
34	2012-12-11 13:18:27.605297+09	1	4	3	alexander.kudryavtsev	2	Изменен password и is_staff.
35	2012-12-11 13:18:52.077702+09	1	4	2	alex.batsuev	2	Изменен password,first_name,last_name,email и groups.
36	2012-12-11 13:19:09.703447+09	1	4	5	andrey.shakhmin	2	Изменен password,first_name,last_name,email и groups.
37	2012-12-11 13:19:32.792454+09	1	4	6	anton.baranchuk	2	Изменен password,first_name,last_name,email и groups.
38	2012-12-11 13:19:51.282802+09	1	4	7	anton.kagakin	2	Изменен password,first_name,last_name,email и groups.
39	2012-12-11 13:20:05.160081+09	1	4	8	anton.saukh	2	Изменен password,first_name,last_name,email и groups.
40	2012-12-11 13:20:16.878688+09	1	4	1	olga	2	Изменен password,first_name и last_name.
41	2012-12-11 13:20:24.425405+09	1	4	1	olga	2	Изменен password и groups.
42	2012-12-11 13:20:41.576995+09	1	4	9	olga.rykova	2	Изменен password,first_name,last_name,email и groups.
43	2012-12-11 13:20:56.480556+09	1	4	10	roman.lubushkin	2	Изменен password,first_name,last_name,email и groups.
44	2012-12-11 13:21:11.250457+09	1	4	11	sergey.medvedev	2	Изменен password,first_name,last_name,email и groups.
45	2012-12-11 13:21:25.907196+09	1	4	12	timothy.loginov	2	Изменен password,first_name,last_name,email и groups.
46	2012-12-11 13:21:42.930136+09	1	4	13	vitaly.radionov	2	Изменен password,first_name,last_name,email и groups.
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	log entry	admin	logentry
2	permission	auth	permission
3	group	auth	group
4	user	auth	user
5	content type	contenttypes	contenttype
6	session	sessions	session
7	site	sites	site
8	registration profile	registration	registrationprofile
9	продукт	app	product
10	релиз	app	release
11	статус	app	status
12	цвет статуса	app	statuscoloruser
13	источник	app	source
14	файл	app	file
15	узел дерева	app	node
16	историю смены статусов	app	statushistory
17	историю смены релиза	app	releasehistory
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
b8af87bfc870294092e3638bb1b18a6d	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-12-25 13:07:15.962754+09
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Data for Name: registration_registrationprofile; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY registration_registrationprofile (id, user_id, activation_key) FROM stdin;
\.


--
-- Name: app_file_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_file
    ADD CONSTRAINT app_file_pkey PRIMARY KEY (id);


--
-- Name: app_node_files_node_id_file_id_key; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_node_files
    ADD CONSTRAINT app_node_files_node_id_file_id_key UNIQUE (node_id, file_id);


--
-- Name: app_node_files_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_node_files
    ADD CONSTRAINT app_node_files_pkey PRIMARY KEY (id);


--
-- Name: app_node_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_node
    ADD CONSTRAINT app_node_pkey PRIMARY KEY (id);


--
-- Name: app_product_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_product
    ADD CONSTRAINT app_product_pkey PRIMARY KEY (id);


--
-- Name: app_release_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_release
    ADD CONSTRAINT app_release_pkey PRIMARY KEY (id);


--
-- Name: app_releasehistory_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_releasehistory
    ADD CONSTRAINT app_releasehistory_pkey PRIMARY KEY (id);


--
-- Name: app_source_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_source
    ADD CONSTRAINT app_source_pkey PRIMARY KEY (id);


--
-- Name: app_status_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_status
    ADD CONSTRAINT app_status_pkey PRIMARY KEY (id);


--
-- Name: app_statuscoloruser_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_statuscoloruser
    ADD CONSTRAINT app_statuscoloruser_pkey PRIMARY KEY (id);


--
-- Name: app_statushistory_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_statushistory
    ADD CONSTRAINT app_statushistory_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_model_key; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_key UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: registration_registrationprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY registration_registrationprofile
    ADD CONSTRAINT registration_registrationprofile_pkey PRIMARY KEY (id);


--
-- Name: registration_registrationprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY registration_registrationprofile
    ADD CONSTRAINT registration_registrationprofile_user_id_key UNIQUE (user_id);


--
-- Name: app_node_cur_release_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_cur_release_id ON app_node USING btree (cur_release_id);


--
-- Name: app_node_cur_status_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_cur_status_id ON app_node USING btree (cur_status_id);


--
-- Name: app_node_curator_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_curator_id ON app_node USING btree (curator_id);


--
-- Name: app_node_developer_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_developer_id ON app_node USING btree (developer_id);


--
-- Name: app_node_files_file_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_files_file_id ON app_node_files USING btree (file_id);


--
-- Name: app_node_files_node_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_files_node_id ON app_node_files USING btree (node_id);


--
-- Name: app_node_level; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_level ON app_node USING btree (level);


--
-- Name: app_node_lft; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_lft ON app_node USING btree (lft);


--
-- Name: app_node_parent_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_parent_id ON app_node USING btree (parent_id);


--
-- Name: app_node_product_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_product_id ON app_node USING btree (product_id);


--
-- Name: app_node_rght; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_rght ON app_node USING btree (rght);


--
-- Name: app_node_source_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_source_id ON app_node USING btree (source_id);


--
-- Name: app_node_tester_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_tester_id ON app_node USING btree (tester_id);


--
-- Name: app_node_tree_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_tree_id ON app_node USING btree (tree_id);


--
-- Name: app_node_type; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_type ON app_node USING btree (type);


--
-- Name: app_node_type_like; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_node_type_like ON app_node USING btree (type varchar_pattern_ops);


--
-- Name: app_release_product_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_release_product_id ON app_release USING btree (product_id);


--
-- Name: app_releasehistory_id_node_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_releasehistory_id_node_id ON app_releasehistory USING btree (id_node_id);


--
-- Name: app_statuscoloruser_status_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_statuscoloruser_status_id ON app_statuscoloruser USING btree (status_id);


--
-- Name: app_statuscoloruser_user_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_statuscoloruser_user_id ON app_statuscoloruser USING btree (user_id);


--
-- Name: app_statushistory_id_node_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_statushistory_id_node_id ON app_statushistory USING btree (id_node_id);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX django_admin_log_content_type_id ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX django_admin_log_user_id ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX django_session_expire_date ON django_session USING btree (expire_date);


--
-- Name: app_node_cur_release_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node
    ADD CONSTRAINT app_node_cur_release_id_fkey FOREIGN KEY (cur_release_id) REFERENCES app_release(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_node_cur_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node
    ADD CONSTRAINT app_node_cur_status_id_fkey FOREIGN KEY (cur_status_id) REFERENCES app_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_node_curator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node
    ADD CONSTRAINT app_node_curator_id_fkey FOREIGN KEY (curator_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_node_developer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node
    ADD CONSTRAINT app_node_developer_id_fkey FOREIGN KEY (developer_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_node_files_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node_files
    ADD CONSTRAINT app_node_files_file_id_fkey FOREIGN KEY (file_id) REFERENCES app_file(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_node_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node
    ADD CONSTRAINT app_node_product_id_fkey FOREIGN KEY (product_id) REFERENCES app_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_node_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node
    ADD CONSTRAINT app_node_source_id_fkey FOREIGN KEY (source_id) REFERENCES app_source(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_node_tester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node
    ADD CONSTRAINT app_node_tester_id_fkey FOREIGN KEY (tester_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_release_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_release
    ADD CONSTRAINT app_release_product_id_fkey FOREIGN KEY (product_id) REFERENCES app_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_releasehistory_id_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_releasehistory
    ADD CONSTRAINT app_releasehistory_id_node_id_fkey FOREIGN KEY (id_node_id) REFERENCES app_node(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_releasehistory_id_release_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_releasehistory
    ADD CONSTRAINT app_releasehistory_id_release_id_fkey FOREIGN KEY (id_release_id) REFERENCES app_release(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_statuscoloruser_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_statuscoloruser
    ADD CONSTRAINT app_statuscoloruser_status_id_fkey FOREIGN KEY (status_id) REFERENCES app_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_statuscoloruser_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_statuscoloruser
    ADD CONSTRAINT app_statuscoloruser_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_statushistory_id_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_statushistory
    ADD CONSTRAINT app_statushistory_id_node_id_fkey FOREIGN KEY (id_node_id) REFERENCES app_node(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_statushistory_id_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_statushistory
    ADD CONSTRAINT app_statushistory_id_status_id_fkey FOREIGN KEY (id_status_id) REFERENCES app_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_288599e6; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT content_type_id_refs_id_288599e6 FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_728de91f; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_728de91f FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_3cea63fe; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_3cea63fe FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: node_id_refs_id_ecd033eb; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node_files
    ADD CONSTRAINT node_id_refs_id_ecd033eb FOREIGN KEY (node_id) REFERENCES app_node(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: parent_id_refs_id_eff33d7d; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_node
    ADD CONSTRAINT parent_id_refs_id_eff33d7d FOREIGN KEY (parent_id) REFERENCES app_node(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: registration_registrationprofile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY registration_registrationprofile
    ADD CONSTRAINT registration_registrationprofile_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_831107f1; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_831107f1 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_c8665aa; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT user_id_refs_id_c8665aa FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_f2045483; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_f2045483 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

