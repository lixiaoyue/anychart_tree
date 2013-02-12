--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.app_file_id_seq OWNER TO olga;

--
-- Name: app_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_file_id_seq OWNED BY app_file.id;


--
-- Name: app_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_file_id_seq', 51, true);


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
    NO MAXVALUE
    NO MINVALUE
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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.app_node_id_seq OWNER TO olga;

--
-- Name: app_node_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_node_id_seq OWNED BY app_node.id;


--
-- Name: app_node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_node_id_seq', 65, true);


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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.app_product_id_seq OWNER TO olga;

--
-- Name: app_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_product_id_seq OWNED BY app_product.id;


--
-- Name: app_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_product_id_seq', 5, true);


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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.app_release_id_seq OWNER TO olga;

--
-- Name: app_release_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_release_id_seq OWNED BY app_release.id;


--
-- Name: app_release_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_release_id_seq', 4, true);


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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.app_releasehistory_id_seq OWNER TO olga;

--
-- Name: app_releasehistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_releasehistory_id_seq OWNED BY app_releasehistory.id;


--
-- Name: app_releasehistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_releasehistory_id_seq', 3, true);


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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.app_source_id_seq OWNER TO olga;

--
-- Name: app_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_source_id_seq OWNED BY app_source.id;


--
-- Name: app_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_source_id_seq', 7, true);


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
    NO MAXVALUE
    NO MINVALUE
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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.app_statuscoloruser_id_seq OWNER TO olga;

--
-- Name: app_statuscoloruser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_statuscoloruser_id_seq OWNED BY app_statuscoloruser.id;


--
-- Name: app_statuscoloruser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_statuscoloruser_id_seq', 18, true);


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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.app_statushistory_id_seq OWNER TO olga;

--
-- Name: app_statushistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_statushistory_id_seq OWNED BY app_statushistory.id;


--
-- Name: app_statushistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_statushistory_id_seq', 94, true);


--
-- Name: app_term; Type: TABLE; Schema: public; Owner: olga; Tablespace: 
--

CREATE TABLE app_term (
    id integer NOT NULL,
    product_id integer NOT NULL,
    name character varying(300) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.app_term OWNER TO olga;

--
-- Name: app_term_id_seq; Type: SEQUENCE; Schema: public; Owner: olga
--

CREATE SEQUENCE app_term_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.app_term_id_seq OWNER TO olga;

--
-- Name: app_term_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE app_term_id_seq OWNED BY app_term.id;


--
-- Name: app_term_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('app_term_id_seq', 13, true);


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
    NO MAXVALUE
    NO MINVALUE
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
    NO MAXVALUE
    NO MINVALUE
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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO olga;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('auth_permission_id_seq', 54, true);


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
    NO MAXVALUE
    NO MINVALUE
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
    NO MAXVALUE
    NO MINVALUE
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
    NO MAXVALUE
    NO MINVALUE
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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO olga;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 69, true);


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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO olga;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: olga
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: olga
--

SELECT pg_catalog.setval('django_content_type_id_seq', 18, true);


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
    NO MAXVALUE
    NO MINVALUE
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
    NO MAXVALUE
    NO MINVALUE
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

ALTER TABLE ONLY app_term ALTER COLUMN id SET DEFAULT nextval('app_term_id_seq'::regclass);


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
1	Цветочки!	files/buket.226.jpg	2012-12-20 07:35:49.864644+04
2	Кустик.jpg	files/flowers-wallpaper-1920x1200-084.jpg	2012-12-20 07:37:15.565913+04
17	тукзар.jpg	files/tmp/cq6vwhhymLQ.jpg	2012-12-28 08:05:49.885065+04
18	тукзар.jpg	files/tmp/cq6vwhhymLQ_1.jpg	2012-12-28 08:06:29.754462+04
\.


--
-- Data for Name: app_node; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_node (id, title, name_id, product_id, parent_id, type, curator_id, developer_id, tester_id, cur_status_id, cur_release_id, source_id, source_description, creation_date, last_modified_date, content, lft, rght, tree_id, level) FROM stdin;
4	Управление запусками тестирования  	AATS-2	4	\N	NE	13	\N	\N	\N	\N	\N	None	2012-12-14 07:33:14.499438+04	2012-12-20 07:31:47.801602+04		1	26	3	0
22	 my ass	AS-1	1	\N	BR	12	\N	\N	1	\N	\N		2012-12-26 11:21:52.25909+04	2012-12-26 13:24:46.433162+04	<p>\n\t&nbsp;!filname!, !imgname:a!,&nbsp;!imgName!, !ImgName:small!, &nbsp;</p>\n<p>\n\t[T:]termin[:T]</p>\n<p>\n\t<img src="/media/files/AS-1/Untitled.png" style="width:200px; float: left; margin: 0 5px"></p>\n<p style="text-align:center">\n\t<img src="/media/files/AS-1/screen.png" /></p>\n<p style="text-align:center">\n\t&nbsp;</p>\n<p>\n\t&nbsp;</p>\n	1	2	15	0
54	Источники требований	ACRT-26	5	26	BR	13	\N	\N	1	\N	\N		2013-01-14 05:47:30.814636+04	2013-01-14 07:12:13.044056+04	<p>\n\tСистема должна иметь возможность редактирования и расширения&nbsp;<a class="tip" href="/ACRT/dictionary/#Источник_требования" id="12" target="_blank">источников требований<span class="hidden">&nbsp;</span></a>.</p>\n<p>\n\t<strong>Значения по умолчанию</strong>:</p>\n<ul>\n\t<li>\n\t\tКлиентский запрос</li>\n\t<li>\n\t\tОтчет об ошибке</li>\n\t<li>\n\t\tАналитика</li>\n</ul>\n<p>\n\t&nbsp;</p>\n	2	7	1	1
28	GUI  	ACRT-6	5	\N	NE	13	\N	\N	\N	\N	\N	None	2012-12-27 10:40:04.054909+04	2013-01-14 13:15:41.010031+04		1	8	14	0
36	Расположение	ACRT-14	5	34	OR	13	1	4	6	\N	2		2012-12-27 11:48:28.444708+04	2013-01-15 11:45:54.137931+04	<p>\n\tФорма авторизации должна располлагаться по центру страницы, как по вертикали так и по горизонтали.</p>\n<p>\n\tФорма авторизации должна располгааться на отдельной странице, где кроме нее ничего быть не должно.</p>\n<p>\n\tНапример так</p>\n<p>\n\t<img src="/media/files/ACRT-14/fullScreen.png" style="width:200px; float: left; margin: 0 5px"></p>\n	8	9	16	3
46	Пользователи	ACRT-18	5	26	BR	13	\N	\N	1	\N	\N		2013-01-10 11:02:51.708729+04	2013-01-14 07:13:22.28594+04	<p>\n\tРедактируемый справочник пользователей в системе.</p>\n<p>\n\t<strong>Цель справочника</strong>: Добавление/удаление пользователей в группы, определяющие роли в данной системе.</p>\n<p>\n\tПраво на внесение изменений есть только у пользователей из группы <strong>Администраторы</strong>, все остальные могут только просмотривать данный справочник.&nbsp;</p>\n	8	19	1	1
47	Группы пользователей	ACRT-19	5	46	BR	13	\N	\N	1	\N	\N		2013-01-10 11:11:07.66301+04	2013-01-14 12:52:40.040682+04	<p>\n\tСистема должна уметь отображать статичный список ролевых групп, определенных в <a href="http://192.168.1.56:8100/ACRT/#BR-17" target="_blank">Ролевой политике</a>, с подробной информацией о каждой группе, а имено: наименование <a class="tip" href="/ACRT/dictionary/#ролевая_группа" target="_blank">ролевой группы<span class="hidden">объединение пользователей системы по исполнительской роли. Например, все разработчики компании (роль Разработчик) принадлежат к одной группе Разработчики.</span></a>.</p>\n<p>\n\tДоступ к просмотру предоставлен всем пользователям.</p>\n<p>\n\t&nbsp;</p>\n	9	10	1	2
32	Система уведомлений	ACRT-10	5	\N	NE	13	\N	\N	1	\N	\N	\N	2012-12-27 10:57:58.488428+04	2012-12-27 10:57:58.50862+04	\N	1	4	4	0
40	Торпеда	AC-4	3	\N	BR	4	\N	\N	1	\N	\N		2012-12-28 09:40:55.812267+04	2013-01-10 09:11:30.971387+04	<p>\n\t<a class="tip" href="/AC/dictionary/#тыри" target="_blank">тыри<span class="hidden">олырвало234234</span></a></p>\n	1	4	2	0
8	GUI	AATS-6	4	5	NE	13	\N	\N	1	\N	\N	\N	2012-12-14 08:29:57.31632+04	2012-12-14 08:29:57.324236+04	\N	4	5	9	1
41	узел	AC-5	3	1	BR	4	\N	\N	1	\N	\N	\N	2012-12-28 10:10:47.110753+04	2012-12-28 10:10:47.305494+04	\N	6	11	13	1
24	Работа с Требованиями	ACRT-2	5	\N	NE	13	\N	\N	1	\N	\N	\N	2012-12-27 10:37:55.923395+04	2012-12-27 10:37:55.93689+04	\N	1	4	6	0
11	Функциональная часть	AATS-9	4	5	NE	13	\N	\N	1	\N	\N	\N	2012-12-14 08:30:40.635071+04	2012-12-14 08:30:40.647857+04	\N	2	3	9	1
5	Работа с отчетами 	AATS-3	4	\N	NE	13	\N	\N	\N	\N	\N	None	2012-12-14 07:35:10.002154+04	2012-12-21 10:05:34.525969+04		1	6	9	0
7	GUI	AATS-5	4	3	NE	13	\N	\N	1	\N	\N	\N	2012-12-14 08:29:49.790935+04	2012-12-14 08:29:49.804378+04	\N	4	5	5	1
27	Работа со Статистикой	ACRT-5	5	\N	NE	13	\N	\N	1	\N	\N	\N	2012-12-27 10:39:16.336407+04	2012-12-27 10:39:16.376916+04	\N	1	2	12	0
25	Работа с Релизами 	ACRT-3	5	\N	NE	13	\N	\N	\N	\N	\N	None	2012-12-27 10:38:27.457469+04	2012-12-27 10:39:24.675448+04		1	2	8	0
29	Работа с Корзиной 	ACRT-7	5	\N	NE	13	\N	\N	\N	\N	\N	None	2012-12-27 10:41:34.840403+04	2013-01-10 12:59:09.330275+04		1	2	10	0
13	Наполнение Header	AATS-11	4	12	BR	13	1	\N	1	1	2		2012-12-20 09:02:19.213198+04	2013-01-14 05:13:13.258089+04	<p>\n\tHeader&nbsp;</p>\n	18	19	3	3
14	Иерархия тестовых групп	AATS-12	4	12	BR	13	\N	\N	1	\N	\N	\N	2012-12-20 09:09:32.51437+04	2013-01-14 05:13:13.263074+04	\N	20	21	3	3
6	GUI	AATS-4	4	4	NE	13	\N	\N	1	\N	\N	\N	2012-12-14 08:29:36.602853+04	2012-12-14 08:29:37.091707+04	\N	4	25	3	1
51	Добавление пользователей	ACRT-23	5	46	BR	13	\N	\N	1	\N	\N		2013-01-11 06:07:40.819459+04	2013-01-14 05:13:13.272681+04	<p>\n\tСистема должна иметь возможность добавления новых пользователей через интерфейс справочника пользователей.</p>\n<p>\n\t<strong>Важно</strong>:</p>\n<p>\n\tПраво на добавление пользователей в систему имеют <u>только</u> участники группы администраторов системы (см. <a href="http://192.168.1.56:8100/ACRT/#BR-15" target="_blank">Ролевая политика</a>).</p>\n<p>\n\tДля добавления пользователя в систему указывается <u>только</u> его корпоративный email (см. <a href="http://192.168.1.56:8100/ACRT/#BR-22">Требования к Логинам и Именам</a>).</p>\n<p>\n\t&nbsp;</p>\n<p>\n\t<strong>Поведение системы при получении корпоротивной почты пользователя</strong>:</p>\n<ul>\n\t<li>\n\t\tЕсли пользователя с текущими данными не зарегистрировано, то необходимо создать новую учетную запись, со следующими данными:\n\t\t<ol>\n\t\t\t<li>\n\t\t\t\temail пользователя - полученный системой email.</li>\n\t\t\t<li>\n\t\t\t\tимя пользователя - &nbsp;получаем из email простыми преорбазованиями (например, vitaly.radionov@anychart.com &rArr; Vitaly Radionov)</li>\n\t\t\t<li>\n\t\t\t\tпароль пользователя - генерируется последовательность из 6 буквенно-цифренных символов (буквы латинские), позже пользователь сам поменяет пароль на необходимый.</li>\n\t\t</ol>\n\t\t<br />\n\t\tДалее, пользователю отправляется письмо, содержащие вышесказанные данные.<br />\n\t\tГруппы, которым принадлежит пользователь указываются вручную администраторами позже.<br />\n\t\t&nbsp;</li>\n\t<li>\n\t\tЕсли пользователь с указанным email существует, то системой выдается сообщение &quot;Пользователь с указанным email уже зарегистрирован в системе&quot;.</li>\n</ul>\n	11	12	1	2
26	Справочники  	ACRT-4	5	\N	NE	13	\N	\N	\N	\N	\N	None	2012-12-27 10:38:52.366511+04	2013-01-15 12:25:32.826405+04	<p>\n\tДанный раздел содержит требования, касающиеся &nbsp;<a class="tip" href="/ACRT/dictionary/#Справочник" id="13" target="_blank">Справочник<span class="hidden">&nbsp;</span></a>ов</p>\n	1	20	1	0
60	Изменение пароля учетной записи	ACRT-32	5	53	BR	13	\N	\N	1	\N	\N		2013-01-14 13:31:04.840472+04	2013-01-14 13:32:47.1043+04	<p>\n\tСистема должна иметь предоставлять пользователю возможность изменения пароля к своей учетной записи, а также изменение пароля к любой пользовательской учетной записи любому участнику группы администраторов.</p>\n	17	18	16	2
64	Пользовательская настройка уведомлений	ACRT-36	5	32	BR	13	\N	\N	1	\N	\N		2013-01-15 13:03:27.705236+04	2013-01-15 13:06:42.750834+04	<p>\n\tСистема должна предоставлять пользователю возможность выбора событий для уведомлений</p>\n	2	3	4	1
2	Buisness requierment 1	AC-2	3	1	BR	13	2	1	1	\N	\N	<p>\tsupoertt</p>	2012-12-13 11:28:25+04	2012-12-28 09:43:32.368228+04	<p>\r\n\tdasda</p>\r\n	2	5	13	1
58	Функционал элемента дерева	ACRT-30	5	57	BR	13	\N	\N	1	\N	\N		2013-01-14 07:19:37.925519+04	2013-01-15 13:54:19.31679+04	<p>\n\tСистема должна обеспечивать элемент дерева требований следующей функциональностью: Expand/Collapse, отображение состояния элемента, просмотр требования, добавить дочерний элемент в дерево, получение ссылки на текущий элемент, возможность переместить данный элемент в любую часть дерева.</p>\n<p>\n\t<strong>Внешний вид</strong>:</p>\n<p>\n\t<span style="color:#008000;"><strong>[expand_state] [progress_state] </strong></span><span style="color:#2f4f4f;"><strong><em>Element&#39;s Name</em></strong></span><span style="color:#008000;"><strong> </strong></span><span style="color:#0000cd;"><strong>[view] [add child]</strong></span><span style="color:#008000;"><strong> </strong></span><span style="color:#800080;"><strong>[link] [move]</strong></span></p>\n<p>\n\tквадратными скобками обозначены иконки</p>\n<ol>\n\t<li>\n\t\t<strong>[expand_state]</strong> - информирует о состояние дочерних элементов, отображены ли они или скрыты.\n\t\t<ul>\n\t\t\t<li>\n\t\t\t\tесли элемент не содеожит дочерних элементов, то иконки быть не должно.</li>\n\t\t\t<li>\n\t\t\t\tесли элемент сожержит дочерние элементы и они скрыты, то текущая иконка должна быть <img src="/media/files/ACRT-30/collapsed.png" /></li>\n\t\t\t<li>\n\t\t\t\tесли элемент&nbsp;сожержит дочерние элементы и они отображены, то текущая должна быть <img src="/media/files/ACRT-30/expanded.png" /></li>\n\t\t</ul>\n\t</li>\n\t<li>\n\t\t<strong>[progress_state]</strong> - отображает состояние прогресса работы над текущими требованиями.\n\t\t<ul>\n\t\t\t<li>\n\t\t\t\tесли работы по требованию (и дочерним) не начиналась, то иконки быть не должно</li>\n\t\t\t<li>\n\t\t\t\tесли работы по требованию (и дочерним) началась, но есть не завершенные дочерние, то текущая иконка должна быть <img src="/media/files/ACRT-30/work.png" /></li>\n\t\t\t<li>\n\t\t\t\tесли работы по требованию (и дочерним) завершились полностью, то текущая иконка должна быть <img src="/media/files/ACRT-30/done.png" /></li>\n\t\t</ul>\n\t</li>\n\t<li>\n\t\t<strong>Element&#39;s name</strong> - заголовок текущего требования (или наименование группирующей папки), представляет собой ссылку, при клике на которую происходит Expand/Collapse дочерних элементов, если такие имеются.</li>\n\t<li>\n\t\t<strong>[view]</strong> - ссылка, при клике на который текущее требование открывается в режиме просмотра, вид иконки: <img src="/media/files/ACRT-30/view.png" /></li>\n\t<li>\n\t\t<strong>[add child]</strong> - ссылка, при клике на которую появляется форма добавления папки/бизнес-требования/Ф-нФ требования, вид иконки: <img src="/media/files/ACRT-30/add.png" /></li>\n\t<li>\n\t\t<strong>[link]</strong> - ссылка на текущий элемент дерева (target=_blank), вид иконки: <img src="/media/files/ACRT-30/link.png" /></li>\n\t<li>\n\t\t<strong>[move]</strong> - вызывает метод по перемещению данного элемента на другую позицию в дереве (со всеми его дочерними элементами), вид иконки: <img src="/media/files/ACRT-30/move.png" /></li>\n</ol>\n<p>\n\t[link] и [move] должны поддердивать drug&amp;drop таким образом:</p>\n<ul>\n\t<li>\n\t\t[link]: при перетаскивании данной иконки в текстовое поле редактирование описания требования, в поле вставляется гиперссылка вида: <a href="ГИПЕРССЫЛКА НА ЭЛЕМЕНТ" target="_blank"> ЗАГОЛОВОК ЭЛЕМЕНТА </a></li>\n\t<li>\n\t\t[move]: каждый элемент дерева &quot;обернут&quot; в div по всей ширине дерева (и корневой элемент, но не словарь и не корзина). при перетаскивании иконки вверх или вниз по дереву жирным border &quot;подсвечивается&quot; div с элементом над которым сейчас находится иконка move переносимого элемента. как только произошел mouseUp, то переносимый жлемент становится дочерним элементом текущего. Нажатие клавиши Esc или клик вне области дерева прерывают операцию перемещения элемента дерева.</li>\n</ul>\n	3	4	14	2
1	Test1	AC-1	3	\N	NE	13	\N	\N	1	\N	\N	\N	2012-12-13 11:28:10.715261+04	2012-12-13 11:28:10.74765+04	\N	1	14	13	0
42	ртр	AC-6	3	41	OR	4	\N	\N	6	\N	\N	\N	2012-12-28 10:16:04.671065+04	2013-01-09 05:07:40.776806+04	\N	9	10	13	2
12	Основная web-морда	AATS-10	4	6	BR	13	1	\N	1	1	2		2012-12-20 06:14:34.294798+04	2012-12-21 11:30:29.034006+04	<p>\n\tМорда представляет собой 3-column-design&nbsp;</p>\n<p>\n\t<strong><span style="color: red; ">TO-DO Картинка здесь</span></strong></p>\n<ul>\n\t<li>\n\t\t<strong>header</strong> содержит кросслинки на другие разделы системы и отображает некоторые данные текущего пользователя</li>\n\t<li>\n\t\t<strong>left column</strong>&nbsp; содержит иерархию тестов и тестовых групп.</li>\n\t<li>\n\t\t<strong>center column</strong>&nbsp;содержит пункты выбора ветки компонента, а также сред исполнения тестов&nbsp;</li>\n\t<li>\n\t\t<strong>right column</strong>&nbsp;сожержит информацию о последних запусках и очередях (если они имеют место быть)</li>\n</ul>\n<p>\n\tНазначние данной панели:<br />\n\tФормирование сессии запуска. То есть, сформировать целевую группу тестов для запуска в определенном окружении.</p>\n<p>\n\t&nbsp;</p>\n<p>\n\t&nbsp;</p>\n	5	24	3	2
30	Учетные записи и Роли 	ACRT-8	5	\N	NE	13	\N	\N	\N	\N	\N	None	2012-12-27 10:42:31.761462+04	2013-01-14 13:07:43.330227+04	<p>\n\tВ данном разделе находятся всевозможные требования, касающиеся Ролевой политики внутри продукта, а также управления учетными записями пользователей.</p>\n	1	26	16	0
55	Добавление нового источника	ACRT-27	5	54	BR	13	\N	\N	1	\N	\N		2013-01-14 05:54:31.036732+04	2013-01-15 11:51:28.053772+04	<p>\n\tСистема должна предоставлять возможность добавления новых источников требований в виде однострочной строки, не превышающей 50 символов с длину.</p>\n	3	4	1	2
59	Добавление терминов в описание требования	ACRT-31	5	24	BR	13	\N	\N	1	\N	\N		2013-01-14 08:56:27.793538+04	2013-01-14 09:00:00.257442+04	<p>\n\tСистема должна иметь возможность добавления терминов в описание требований посредством интерфейса работы со словарем.</p>\n<p>\n\t&nbsp;</p>\n<p>\n\tЧерез интерфейс можно как вставить уже существующий в словаре термин, так и добавить новый.</p>\n<p>\n\tНеобходима возможность изменения вставляемого текста наименования термина (склонение термина).</p>\n	2	3	6	1
39	Узел тестовый	AC-3	3	1	BR	4	\N	\N	1	\N	\N		2012-12-28 09:40:20.800931+04	2013-01-09 12:01:21.876442+04		12	13	13	1
43	екпипип	AC-7	3	41	OR	4	\N	\N	6	\N	\N		2012-12-28 10:17:07.247687+04	2013-01-09 05:09:40.088573+04		7	8	13	2
37	Ролевая политика	ACRT-15	5	30	BR	13	\N	\N	1	\N	\N		2012-12-27 11:53:24.625485+04	2013-01-14 08:54:45.529871+04	<p>\n\tВ данном продукте существуют следующие роли:</p>\n<ul>\n\t<li>\n\t\t<a class="tip" href="/ACRT/dictionary/#Администратор" id="5" target="_blank">Администратор<span class="hidden">&nbsp;</span></a><br />\n\t\t<span class="hidden">Это роль в системе, которая обладает максимальными правами.</span><span class="hidden">Это роль в системе, которая обладает максимальными правами.</span><span class="hidden">Это роль в системе, которая обладает максимальными правами.</span><span class="hidden">Это роль в системе, которая обладает максимальными правами.</span></li>\n\t<li>\n\t\t<a class="tip" href="/ACRT/dictionary/#Куратор" id="4" target="_blank">Куратор<span class="hidden">&nbsp;</span></a><span class="hidden">Это роль, которая показывает, кто является ответственным лицом за выполнение данного требования. Куратор отслеживает и согласует любые изменения по требованиям, которые он создал сам. </span><br />\n\t\t<span class="hidden">Это роль, которая показывает, кто является ответственным лицом за выполнение данного требования. Куратор отслеживает и согласует любые изменения по требованиям, которые он создал сам. </span><span class="hidden">Это роль, которая показывает, кто является ответственным лицом за выполнение данного требования. Куратор отслеживает и согласует любые изменения по требованиям, которые он создал сам. </span><span class="hidden">Это роль, которая показывает, кто является ответственным лицом за выполнение данного требования. Куратор отслеживает и согласует любые изменения по требованиям, которые он создал сам. </span></li>\n\t<li>\n\t\t<a class="tip" href="/ACRT/dictionary/#Разработчик" id="6" target="_blank">Разработчик<span class="hidden">&nbsp;</span></a><span class="hidden">Роль, ответственная за написание кода </span><br />\n\t\t<span class="hidden">Роль, ответственная за написание кода </span><span class="hidden">Роль, ответственная за написание кода </span></li>\n\t<li>\n\t\t<a class="tip" href="/ACRT/dictionary/#Тестировщик" id="7" target="_blank">Тестировщик<span class="hidden">&nbsp;</span></a><span class="hidden">Роль, ответственная за корректность работы продукта. Специалист по качеству продукта.</span><br />\n\t\t<span class="hidden">Роль, ответственная за корректность работы продукта. Специалист по качеству продукта.</span><span class="hidden">Роль, ответственная за корректность работы продукта. Специалист по качеству продукта.</span></li>\n\t<li>\n\t\t<a class="tip" href="/ACRT/dictionary/#Наблюдатель" id="1" target="_blank">Наблюдатель<span class="hidden">&nbsp;</span></a><span class="hidden">Не авторизованный пользователь</span></li>\n</ul>\n<p>\n\t&nbsp;</p>\n<p>\n\t&nbsp;</p>\n<p>\n\t&nbsp;</p>\n	20	25	16	1
31	Авторизация пользователей	ACRT-9	5	30	BR	13	1	4	1	\N	2		2012-12-27 10:51:17.987237+04	2013-01-15 11:01:46.255456+04	<p>\n\t<strong>Система должна поддерживать авторизацию пользователей.</strong></p>\n<p>\n\tКаждый пользователь должен иметь персональные настройки системы.</p>\n<p>\n\tПри этом авторизация лишь раскрывает дополнительные возможности, то есть, не авторизованный пользователь может работать в системе с самыми минимальными правами (read only).</p>\n	2	13	16	1
53	Администрирование учетных записей	ACRT-25	5	30	BR	13	\N	\N	1	\N	\N		2013-01-11 07:50:54.369115+04	2013-01-14 13:30:22.052665+04	<p>\n\tУдаление, добавление и частичное редактирование учетных записей происходит через интерфейс <a href="http://192.168.1.56:8100/ACRT/#BR-18" target="_blank">Справочники:Пользователи</a>.</p>\n<p>\n\tПод частичным редактированием понимается: изменение email (основного логина, в случаях крайней необходимости) пользователя, а также его участие в различных группах.</p>\n	14	19	16	1
44	Редактирование и просмотр требований	ACRT-16	5	37	BR	13	\N	\N	1	\N	\N		2013-01-10 05:48:27.447975+04	2013-01-14 09:31:06.456082+04	<p>\n\t&nbsp;</p>\n<table border="1" cellpadding="0" cellspacing="0" style="width: 550px; " width="497">\n\t<colgroup>\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t</colgroup>\n\t<tbody>\n\t\t<tr height="14">\n\t\t\t<td height="42" rowspan="2" style="height: 56px; width: 96px; text-align: center; ">\n\t\t\t\t<strong>Роли</strong></td>\n\t\t\t<td colspan="8" height="14" style="height: 18px; text-align: center; ">\n\t\t\t\t<strong>Редактирование требований, назначенных на текущего пользователя</strong></td>\n\t\t\t<td colspan="1" rowspan="1" style="width: 71px; text-align: center; ">\n\t\t\t\t&nbsp;</td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tназва</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tние</p>\n\t\t\t</td>\n\t\t\t<td>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tразра</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tботчик</p>\n\t\t\t</td>\n\t\t\t<td>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tтести</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tровщик</p>\n\t\t\t</td>\n\t\t\t<td>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tстат</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tус</p>\n\t\t\t</td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\tрелиз</td>\n\t\t\t<td>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tисточ</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tник</p>\n\t\t\t</td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t&nbsp;-/+ файла</td>\n\t\t\t<td>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tописа</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tние</p>\n\t\t\t</td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<strong>просмотр</strong></td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<a class="tip" href="/ACRT/dictionary/#Администратор" id="5" target="_blank">Администратор<span class="hidden">&nbsp;</span></a></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<a class="tip" href="/ACRT/dictionary/#Куратор" id="4" target="_blank">Куратор<span class="hidden">&nbsp;</span></a>*</td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<a class="tip" href="/ACRT/dictionary/#Разработчик" id="6" target="_blank">Разработчик<span class="hidden">&nbsp;</span></a></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<a class="tip" href="/ACRT/dictionary/#Тестировщик" id="7" target="_blank">Тестировщик<span class="hidden">&nbsp;</span></a></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<a class="tip" href="/ACRT/dictionary/#Наблюдатель" id="1" target="_blank">Наблюдатель<span class="hidden">&nbsp;</span></a></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t</tr>\n\t</tbody>\n</table>\n<table border="1" cellpadding="0" cellspacing="0" style="width: 550px; " width="497">\n\t<colgroup>\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t\t<col />\n\t</colgroup>\n\t<tbody>\n\t\t<tr height="14">\n\t\t\t<td height="42" rowspan="2" style="height: 56px; width: 96px; text-align: center; ">\n\t\t\t\t<strong>Роли</strong></td>\n\t\t\t<td colspan="8" style="text-align: center; ">\n\t\t\t\t<strong>Редактирование любых других требований</strong></td>\n\t\t\t<td colspan="1" rowspan="1" style="width: 71px; text-align: center; ">\n\t\t\t\t&nbsp;</td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tназва</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tние</p>\n\t\t\t</td>\n\t\t\t<td>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tразра</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tботчик</p>\n\t\t\t</td>\n\t\t\t<td>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tтести</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tровщик</p>\n\t\t\t</td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\tстатус</td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\tрелиз</td>\n\t\t\t<td>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tисточ</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tник</p>\n\t\t\t</td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t&nbsp;+/- файла</td>\n\t\t\t<td>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tописа</p>\n\t\t\t\t<p style="text-align: center; ">\n\t\t\t\t\tние</p>\n\t\t\t</td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<strong>просмотр</strong></td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<a class="tip" href="/ACRT/dictionary/#Администратор" id="5" target="_blank">Администратор<span class="hidden">&nbsp;</span></a></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<a class="tip" href="/ACRT/dictionary/#Куратор" id="4" target="_blank">Куратор<span class="hidden">&nbsp;</span></a>*</td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<a class="tip" href="/ACRT/dictionary/#Разработчик" id="6" target="_blank">Разработчик<span class="hidden">&nbsp;</span></a></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<a class="tip" href="/ACRT/dictionary/#Тестировщик" id="7" target="_blank">Тестировщик<span class="hidden">&nbsp;</span></a></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t</tr>\n\t\t<tr height="14">\n\t\t\t<td height="14" style="height: 18px; ">\n\t\t\t\t<a class="tip" href="/ACRT/dictionary/#Наблюдатель" id="1" target="_blank">Наблюдатель<span class="hidden">&nbsp;</span></a></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-ban-circle">&nbsp;</i></td>\n\t\t\t<td style="text-align: center; ">\n\t\t\t\t<i class="icon-plus">&nbsp;</i></td>\n\t\t</tr>\n\t</tbody>\n</table>\n<p>\n\t* В случае куратора имеются в виду требования, которые он создал сам и любые другие требования, созданные другими кураторами.</p>\n	23	24	16	2
23	Работа с Продуктами   	ACRT-1	5	\N	NE	13	\N	\N	\N	\N	\N	None	2012-12-27 10:37:44.052115+04	2013-01-15 13:59:35.794408+04		1	2	7	0
48	Список пользователей	ACRT-20	5	46	BR	13	1	4	2	4	2		2013-01-10 11:25:11.386419+04	2013-01-16 05:22:55.684056+04	<p>\n\tСистема должна иметь возможность выводить список имеющихся пользователей, с предоставлением основной информации о каждом пользователе.</p>\n<p>\n\t<strong>Доступ</strong>:</p>\n<ul>\n\t<li>\n\t\tпросматривать список пользователей может&nbsp;любой пользователь</li>\n\t<li>\n\t\tвносить изменения могут только представители группы администраторов.</li>\n</ul>\n<p>\n\t<strong>Отображаемая информация:</strong></p>\n<ul>\n\t<li>\n\t\tФИО пользователя</li>\n\t<li>\n\t\tКорпоративный e-mail пользователя</li>\n\t<li>\n\t\tГруппы, в которые входит пользователь</li>\n\t<li>\n\t\tПродукты, в которых участвует пользователь</li>\n</ul>\n<p>\n\t&nbsp;</p>\n	13	14	1	2
34	Форма авторизации	ACRT-12	5	31	BR	13	\N	\N	1	\N	\N		2012-12-27 11:33:49.848156+04	2013-01-10 06:04:27.743199+04	<p>\n\tСиситема должна поддерживать &quot;глобальную авторизацию&quot;, которая должна проходить где-то уровнем выше на сервере.</p>\n<p>\n\tЕсли авторизация была проведена успешно, то каикм-то путем утилита узнает об этом.</p>\n<p>\n\tНо если пользователь, по каким-лио причинам, не прошел ту авторизацию <strike>или пока у нас её нет</strike>, то пользователь должен иметь возможность осуществить вход в систему.</p>\n	7	12	16	2
9	Функциональная часть 	AATS-7	4	4	NE	13	\N	\N	\N	\N	\N	None	2012-12-14 08:30:21.517737+04	2012-12-14 08:35:49.712742+04	<p>\n\tВсе, что не относится к визуальной части.</p>\n<p>\n\tКонцепции работы данного модуля.&nbsp;</p>\n	2	3	3	1
57	Дерево требований	ACRT-29	5	28	BR	13	\N	\N	1	\N	\N	\N	2013-01-14 07:18:44.949951+04	2013-01-14 07:18:44.959541+04	\N	2	5	14	1
10	Функциональная часть  	AATS-8	4	3	NE	13	\N	\N	\N	\N	\N	None	2012-12-14 08:30:33.880342+04	2012-12-14 08:36:30.630754+04	<p>\n\t<span style="color: rgb(92, 91, 91); font-family: Georgia, serif; font-size: 16px; ">Все, что не относится к визуальной части.</span></p>\n<p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(92, 91, 91); font-family: Georgia, serif; font-size: 16px; ">\n\tКонцепции работы данного модуля.&nbsp;</p>\n	2	3	5	1
3	Редактирование тестов 	AATS-1	4	\N	NE	13	\N	\N	\N	\N	\N	None	2012-12-14 07:30:43.559562+04	2012-12-20 07:31:55.920845+04	<p>\n\t&nbsp;</p>\n<p>\n\tВ данном разделе описывается работа с модулем манипулирования тестами.</p>\n<p>\n\tДобавление / Удаление / Редактирование тестами и их группами.</p>\n	1	6	5	0
49	Работа со Словарем	ACRT-21	5	\N	NE	13	\N	\N	1	\N	\N	\N	2013-01-10 12:57:15.682348+04	2013-01-10 12:57:15.711072+04	\N	1	2	11	0
50	Логины и Имена пользователей	ACRT-22	5	31	BR	13	\N	\N	1	\N	\N		2013-01-11 05:45:08.794195+04	2013-01-14 07:09:59.746442+04	<p>\n\tСогласно<strong> <span style="color:#ff0000;">[ссылка на правила авторизации во внутренних утилитах]</span></strong>&nbsp; авторизация сотрудников компании будет происходить по их коропоративным email&#39;ам. Учитывая правила корпоративной почты<strong> <span style="color:#ff0000;">[ссылка на правила корпоративной почты]</span></strong>.</p>\n<p>\n\tТаким образом <strong>login</strong>&nbsp;для входа в систему корпоративная почта пользователя.</p>\n<p>\n\tИмя пользователя, согласно вышеуказанным правилам, содержится в логине ( имя.фамилия@anychart.com ). Оно и должно использоваться в системе. Пользователь не может его поменять.</p>\n<p>\n\t&nbsp;</p>\n	3	4	16	2
62	Режим просмотра требования	ACRT-34	5	28	BR	13	\N	\N	1	\N	\N		2013-01-15 11:16:06.037201+04	2013-01-16 05:05:13.776749+04	<p>\n\tсписок аттачей вынести в отдельную вкладку или в спойлер (закрытый по-умолчанию)</p>\n<p>\n\t&nbsp;</p>\n<p>\n\tспециальные стили для особых блоков (например, формулировка)</p>\n<p>\n\t&nbsp;</p>\n<p>\n\tу ссылок и терминов должны быть разные стили.</p>\n	6	7	14	1
35	Внешний вид	ACRT-13	5	34	OR	13	1	4	1	\N	2		2012-12-27 11:34:19.8741+04	2013-01-15 11:45:30.423405+04	<p>\n\tФорма авторизации должна выглядеть просто и со вкусом.</p>\n<p>\n\tОна должна содержать:</p>\n<ol>\n\t<li>\n\t\tодно текстовое поле Login</li>\n\t<li>\n\t\tодно поле типа password под пароль</li>\n\t<li>\n\t\tкнопку входа</li>\n\t<li>\n\t\tcheckbox для запоминания в Cookie текущего браузера</li>\n\t<li>\n\t\tкнопку сброса пароля (см требование <a href="http://192.168.1.56:8100/ACRT/#BR-33" target="_blank">Восстановление пароля</a>)</li>\n</ol>\n<p>\n\tПридерживаться следующего вида:</p>\n<p>\n\t&nbsp;</p>\n<p style="text-align:center">\n\t<img src="/media/files/ACRT-13/smallScreen.png" style="width: 353px; height: 290px; " /></p>\n<p>\n\t&nbsp;</p>\n<p>\n\tИсходники можно взять тут <a href="/media/files/ACRT-13/css3.zip" target="_blank">css3.zip</a></p>\n	10	11	16	3
56	Удаление источников	ACRT-28	5	54	BR	13	\N	\N	1	\N	\N		2013-01-14 06:02:03.211322+04	2013-01-15 12:21:14.24863+04	<h3 style="color:blue;">\n\tСистема должна предоставлять возможность удаления источников требования.</h3>\n<p>\n\tПри попытке удалить источник требования должна осуществляться проверка: не использован ли данный источник в каком-либо требовании.</p>\n<p>\n\t&nbsp;</p>\n	5	6	1	2
45	Пользователи и группы	ACRT-17	5	37	BR	13	\N	\N	1	\N	\N		2013-01-10 07:33:52.873169+04	2013-01-14 09:12:39.241238+04	<p>\n\tСистема должна предоставлять возможность пльзователю состоять в нескольких <a class="tip" href="/ACRT/dictionary/#ролевая_группа" id="11" target="_blank">ролевых группах</a>&nbsp;единовременно (например, разработчик и администратор).</p>\n<p>\n\tРедактирование&nbsp;<a class="tip" href="/ACRT/dictionary/#ролевая_группа" id="11" target="_blank">ролевых групп</a>&nbsp;происходит в специальном справочнике (см.&nbsp;<a href="http://192.168.1.56:8100/ACRT/#BR-18" target="_blank">Справочник Пользователи</a>)</p>\n<p>\n\t&nbsp;</p>\n<p>\n\tСистема должна иметь статичный список ролевых групп пользователей, согласно ролевой политике:</p>\n<ul>\n\t<li>\n\t\t<a class="tip" href="/ACRT/dictionary/#Администратор" id="5" target="_blank">Администратор<span class="hidden">&nbsp;</span></a>ы</li>\n\t<li>\n\t\t<a class="tip" href="/ACRT/dictionary/#Куратор" id="4" target="_blank">Куратор<span class="hidden">&nbsp;</span></a><span class="hidden">Это роль, которая показывает, кто является ответственным лицом за выполнение данного требования. Куратор отслеживает и согласует любые изменения по требованиям, которые он создал сам. </span>ы</li>\n\t<li>\n\t\t<a class="tip" href="/ACRT/dictionary/#Разработчик" id="6" target="_blank">Разработчик<span class="hidden">&nbsp;</span></a><span class="hidden">Роль, ответственная за написание кода </span>и</li>\n\t<li>\n\t\t<a class="tip" href="/ACRT/dictionary/#Тестировщик" id="7" target="_blank">Тестировщик<span class="hidden">&nbsp;</span></a><span class="hidden">Роль, ответственная за корректность работы продукта. Специалист по качеству продукта.</span>и</li>\n</ul>\n<p>\n\tГруппы&nbsp;<strong>Разработчики</strong>&nbsp;и&nbsp;<strong>Тестировщики</strong>, &nbsp;соответствуют полям на форме добавления/редактирования требования.</p>\n<p>\n\tГруппы нельзя добавлять/удалять/редактировать.</p>\n	21	22	16	2
61	Восстановление паролей	ACRT-33	5	53	BR	13	\N	\N	1	\N	\N		2013-01-15 11:03:03.528451+04	2013-01-15 11:42:13.96435+04	<h4 style="color: blue; ">\n\tСистема должна пердоставлять возможность сброса пароля от учетной записи её владельцу.</h4>\n<p>\n\tВ случае, если пользователь утерял пароль он должен иметь возможность сбросить свой пароль, перейдя по ссылке &quot;Пароль безнадёжно забыт&quot;.</p>\n<p>\n\tМеханизм обработки запроса на сброс пароля следующий:</p>\n<ol>\n\t<li>\n\t\tИз поля &quot;Логин&quot; формы авторизации берется текущее значение</li>\n\t<li>\n\t\tОсуществляется проверка, является ли полученное значение логином хоть к какой-либо учетке</li>\n\t<li>\n\t\tПользователю с найденым логином (email) высылается письмо, содержащее текст, примерного содержания: &quot;Вами был подан запрос на сброс пароля в утилите AnyChart Requirement Tree. Если это действительно сделали Вы, то перейдите по следующей ссылке:&quot;, где ссылка - это временно сгенерированый ключ со сроком действия 1 час:\n\t\t<ul>\n\t\t\t<li>\n\t\t\t\tесли пользователь перешел по ссылке, то ключ удаляется</li>\n\t\t\t<li>\n\t\t\t\tв системе восстановления пароля сбрасываются все ключи, срок жизни которых более часа.</li>\n\t\t</ul>\n\t</li>\n\t<li>\n\t\tПри переходе по ключу, пользователю назначается случайный пароль, который генерируется скриптом из требования <a href="http://192.168.1.56:8100/ACRT/#BR-23" target="_blank">Добавление пользователей</a>.</li>\n\t<li>\n\t\tПользователю высылается письмо с его новым паролем.</li>\n</ol>\n<p>\n\tВ иных случаях поле пароля не сбрасывается.</p>\n	15	16	16	2
65	Новое	AC-8	3	40	OR	1	\N	\N	1	\N	\N		2013-01-16 07:49:09.282165+04	2013-01-16 07:50:31.267446+04	<p>\n\t<a href="http://www.nature.com/news/quantum-gas-goes-below-absolute-zero-1.12146">Много</a>&nbsp;<a href="http://physicsworld.com/blog/2013/01/have_physicists_ventured_below.html">шума</a>&nbsp;слышно в последнее время в научной блогосфере о&nbsp;<a href="http://www.sciencemag.org/content/339/6115/52">недавнем эксперименте</a>, в котором физики создали газ из квантовых частиц с отрицательной температурой &ndash;&nbsp;ниже абсолютного нуля. Это довольно странно, т.к. предполагается, что абсолютный ноль &ndash; это такая температура, при которой движение атомов прекращается, когда подвижные атомы в обычном состоянии, полностью останавливаются. По всей видимости, это холодно так, как только может быть холодно. Возможно ли, чтобы что-то было холоднее, чем это?<br />\n\t<br />\n\tВот краткий ответ. Можно создать отрицательные температуры. Фактически это было сделано&nbsp;<a href="http://prola.aps.org/abstract/PR/v81/i2/p279_1">впервые</a>&nbsp;в 1951 году. Но это не то, как это звучит &ndash; эти температуры не холоднее абсолютного нуля. Например, вы не можете охлаждать, что-либо до тех пор, пока температура не упадёт ниже абсолютного нуля. На самом деле, как я постараюсь объяснить, объекты с отрицательной температурой&nbsp;<a href="http://www.npr.org/2013/01/04/168624854/negative-temperatures-that-are-hotter-than-the-sun">ведут себя</a>, как будто&nbsp;<a href="http://www.sciencenews.org/view/generic/id/347370/description/Hottest_temperature_ever_measured_is_a_negative_one">они теплее</a>, чем объекты с любой положительной температурой. (с) Habrahabr</p>\n	2	3	2	1
52	Удаление пользователей	ACRT-24	5	46	BR	13	\N	\N	1	\N	\N		2013-01-11 06:35:01.743373+04	2013-01-14 12:57:37.841486+04	<p>\n\tСистема должна иметь возможность удаления пользователей через интерфейс справочника.<br />\n\t&nbsp;</p>\n<p>\n\t<strong>Важно</strong>:</p>\n<p>\n\tУдалять пользователей из системы могут <u>только</u> участники группы администраторов системы&nbsp;(см.&nbsp;<a href="http://192.168.1.56:8100/ACRT/#BR-15" target="_blank">Ролевая политика</a>).</p>\n<p>\n\t<strong>Поведение системы при запросе на удаление</strong>:</p>\n<ol>\n\t<li>\n\t\tЕсли удаляемый пользователь не связан ни с одним требованием, то он удаляется.<br />\n\t\tТакая ситуация возможна при ошибочно добавленных пользователях, или если пользователи не активныв данной системе.<br />\n\t\t&nbsp;</li>\n\t<li>\n\t\tЕсли удаляемый пользователь связан хотя бы с одним требованием, то его нельзя удалить. В таком случае надо выводить список зависимых от него требований, что бы Администратор мог переназначить все зависимые от данного пользователя требования на других лиц. После того, как все конфликты будут устранены пользователя будет удален в соответствии с пунктом 1.</li>\n</ol>\n	15	16	1	2
63	Участие в продуктах	ACRT-35	5	46	BR	13	\N	\N	1	\N	\N		2013-01-15 12:26:09.27598+04	2013-01-15 12:45:01.777628+04	<p>\n\tСистема должна иметь возможность распределения пользователей по продуктам учитывая, что один пользователь может участвовать в нескольких продуктах.</p>\n<p>\n\tНадо иметь в виду, что Роль пользователя от прудкта к продукту не меняется.<br />\n\tПросто это необходимо, что бы избежать неразберихи.</p>\n<p>\n\tОпределение какие пользователи участвуют в конкретном продукте происходит в свойствах этого продукта.<br />\n\tСмотри соответствующее требование.</p>\n	17	18	1	2
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
4	Automatic testing system	AATS	Или просто Ася. Наша новая мега крутая утилита для тестирования. 
5	Requirement tree	ACRT	Требования для утилиты по работе с требованиями. 
\.


--
-- Data for Name: app_release; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_release (id, name, number, status, description, date, product_id) FROM stdin;
1	Рефакторинг и переработка	2.0	f	Переработка нового продукта\n	2013-02-28 19:00:00+04	4
3	Новый	2345-7	f	ergeq	2013-02-03 19:00:00+04	4
4	Человеческий	1.0	f	первая реализация	2013-02-14 19:00:00+04	5
\.


--
-- Data for Name: app_releasehistory; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_releasehistory (id, id_node_id, id_release_id, description, date) FROM stdin;
1	12	1		2012-12-20 06:20:36.573817+04
2	13	1		2012-12-20 09:07:59.803751+04
3	48	4		2013-01-16 05:22:55.671575+04
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
7	1	1	#5c5c5c
8	1	2	#0063cd
9	1	3	#0c38a6
10	1	4	#002264
11	1	5	#2b5f01
12	1	6	#4a2626
13	4	1	#596052
14	4	2	#CD3700
15	4	3	#0000CD
16	4	4	#006400
17	4	5	#8B4513
18	4	6	#EE7621
1	13	1	#5c2428
2	13	2	#fff20f
3	13	3	#14d0f0
4	13	4	#0054a3
5	13	5	#1ca11b
6	13	6	#ee2121
\.


--
-- Data for Name: app_statushistory; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_statushistory (id, id_node_id, id_status_id, description, date) FROM stdin;
1	1	1	Just created	2012-12-13 11:28:10.744682+04
2	2	1	Just created	2012-12-13 11:28:25.014364+04
3	3	1	Just created	2012-12-14 07:30:43.569832+04
4	4	1	Just created	2012-12-14 07:33:14.51877+04
5	5	1	Just created	2012-12-14 07:35:10.021921+04
6	6	1	Just created	2012-12-14 08:29:36.608183+04
7	7	1	Just created	2012-12-14 08:29:49.796665+04
8	8	1	Just created	2012-12-14 08:29:57.321577+04
9	9	1	Just created	2012-12-14 08:30:21.527603+04
10	10	1	Just created	2012-12-14 08:30:33.890124+04
11	11	1	Just created	2012-12-14 08:30:40.645172+04
12	12	1	Just created	2012-12-20 06:14:34.303969+04
13	13	1	Just created	2012-12-20 09:02:19.21962+04
14	14	1	Just created	2012-12-20 09:09:32.523319+04
28	13	6		2012-12-21 10:58:26.108818+04
29	14	6		2012-12-21 10:58:26.120066+04
31	12	6		2012-12-21 10:58:26.140021+04
32	12	1	Восстановлено из корзины	2012-12-21 11:03:37.893108+04
33	14	1	Восстановлено из корзины	2012-12-21 11:03:48.359974+04
34	13	1	Восстановлено из корзины	2012-12-21 11:03:48.390735+04
39	22	1	Just created	2012-12-26 11:21:52.268453+04
40	23	1	Just created	2012-12-27 10:37:44.063305+04
41	24	1	Just created	2012-12-27 10:37:55.934185+04
42	25	1	Just created	2012-12-27 10:38:27.482211+04
43	26	1	Just created	2012-12-27 10:38:52.377647+04
44	27	1	Just created	2012-12-27 10:39:16.346775+04
45	28	1	Just created	2012-12-27 10:40:04.063568+04
46	29	1	Just created	2012-12-27 10:41:34.850825+04
47	30	1	Just created	2012-12-27 10:42:31.791754+04
48	31	1	Just created	2012-12-27 10:51:17.993373+04
49	32	1	Just created	2012-12-27 10:57:58.499452+04
52	34	1	Just created	2012-12-27 11:33:49.856633+04
53	35	1	Just created	2012-12-27 11:34:19.879606+04
54	36	1	Just created	2012-12-27 11:48:28.456131+04
55	37	1	Just created	2012-12-27 11:53:24.635712+04
62	39	1	Just created	2012-12-28 09:40:20.809383+04
63	40	1	Just created	2012-12-28 09:40:55.824651+04
64	41	1	Just created	2012-12-28 10:10:47.30267+04
65	42	1	Just created	2012-12-28 10:16:04.677676+04
66	43	1	Just created	2012-12-28 10:17:07.25822+04
67	42	6	за ненадобностью	2013-01-09 05:07:40.773345+04
68	43	6	за ненадобностью	2013-01-09 05:09:40.085119+04
69	39	6	за ненадобностью	2013-01-09 05:09:54.494953+04
70	39	1	Восстановлено из корзины	2013-01-09 07:19:50.178434+04
71	44	1	Just created	2013-01-10 05:48:27.454247+04
72	45	1	Just created	2013-01-10 07:33:52.884851+04
73	46	1	Just created	2013-01-10 11:02:51.715202+04
74	47	1	Just created	2013-01-10 11:11:08.157713+04
75	48	1	Just created	2013-01-10 11:25:11.395761+04
76	49	1	Just created	2013-01-10 12:57:15.694126+04
77	50	1	Just created	2013-01-11 05:45:08.805978+04
78	51	1	Just created	2013-01-11 06:07:40.830341+04
79	52	1	Just created	2013-01-11 06:35:01.752695+04
80	53	1	Just created	2013-01-11 07:50:54.379973+04
81	54	1	Just created	2013-01-14 05:47:30.826146+04
82	55	1	Just created	2013-01-14 05:54:31.04321+04
83	56	1	Just created	2013-01-14 06:02:03.221481+04
84	57	1	Just created	2013-01-14 07:18:44.956408+04
85	58	1	Just created	2013-01-14 07:19:37.931486+04
86	59	1	Just created	2013-01-14 08:56:27.800201+04
87	60	1	Just created	2013-01-14 13:31:04.847283+04
88	61	1	Just created	2013-01-15 11:03:03.540114+04
89	62	1	Just created	2013-01-15 11:16:06.046703+04
90	36	6	не актуально	2013-01-15 11:45:54.134386+04
91	63	1	Just created	2013-01-15 12:26:09.285115+04
92	64	1	Just created	2013-01-15 13:03:28.171275+04
93	48	2	согласовать с разработчиком	2013-01-16 05:22:55.660252+04
94	65	1	Just created	2013-01-16 07:49:09.288736+04
\.


--
-- Data for Name: app_term; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY app_term (id, product_id, name, description) FROM stdin;
1	5	Наблюдатель	Не авторизованный пользователь
4	5	Куратор	Это роль, которая показывает, кто является ответственным лицом за выполнение данного требования. Куратор отслеживает и согласует любые изменения по требованиям, которые он создал сам. 
7	5	Тестировщик	Роль, ответственная за корректность работы продукта. Специалист по качеству продукта.
8	3	новый раз	не пиастрас
9	3	новыйц два	ылвоарыловралыовра
10	3	тыри	олырвало234234
12	5	Источник требования	Описание источника информации, которая породила данное требование. Например, источником требования может выступать запрос клиента на реализацию той или иной возможности, или же источником требования может служить исследовательская (аналитическая) работа над конкурентами. 
6	5	Разработчик	Роль, ответственная за написание кода 
13	5	Справочник	Это сущность, содержащая информацию общую для всех проектов внутри данной утилиты 
5	5	Администратор	Это роль в системе, которая обладает максимальными правами. 
11	5	Ролевая группа	Объединение пользователей системы по исполнительской роли. Например, все разработчики компании (роль Разработчик) принадлежат к одной группе Разработчики.
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
52	Can add термин	18	add_term
53	Can change термин	18	change_term
54	Can delete термин	18	delete_term
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined) FROM stdin;
3	alexander.kudryavtsev	Александр	Кудрявцев	alexander.kudryavtsev@anychart.com	pbkdf2_sha256$10000$erXtrXTF4PtM$2aTPDu4ikp4rdEMlesO/Osp90AFg0NiCts/65vmzWYE=	f	t	f	2012-12-11 08:14:57+04	2012-12-11 08:14:57+04
2	alex.batsuev	Александр	Бацуев	alex.batsuev@anychart.com	pbkdf2_sha256$10000$ftZUefOZabqF$jKjJxDBtipFdxalaH+HqouNfrQDi4ss0eYF18KFV/yI=	f	t	f	2012-12-11 08:14:48+04	2012-12-11 08:14:48+04
5	andrey.shakhmin	Андрей	Шахмин	andrey.shakhmin@anychart.com	pbkdf2_sha256$10000$Jb63Wu9NyAOJ$JR2Pnz69XuuugN0ObbvY8loWdBf+ew5YyLF51AhfZc8=	f	t	f	2012-12-11 08:15:10+04	2012-12-11 08:15:10+04
6	anton.baranchuk	Антон	Баранчук	anton.baranchuk@anychart.com	pbkdf2_sha256$10000$lEeJgQ6GbxAf$O1YOAGr9mEIdgk13VyHxmN2GFQhTrsOpu20roW98RRo=	f	t	f	2012-12-11 08:15:17+04	2012-12-11 08:15:17+04
7	anton.kagakin	Антон	Кагакин	anton.kagakin@anychart.com	pbkdf2_sha256$10000$T1VjP45kAmUo$xXpzDwExRq9QKaNGUTjo0FAQpVk3OXG6hJwcxzS99Lc=	f	t	f	2012-12-11 08:15:24+04	2012-12-11 08:15:24+04
8	anton.saukh	Антон	Саух	anton.saukh@anychart.com	pbkdf2_sha256$10000$IJj4GiMF6qIO$hMlA5zheCEanClsexjunwIPfbBg/jbe4RlMIAaaPAow=	f	t	f	2012-12-11 08:15:31+04	2012-12-11 08:15:31+04
10	roman.lubushkin	Роман	Любушкин	roman.lubushkin@anychart.com	pbkdf2_sha256$10000$Dzg6RCpYVr26$LjTBYzVbFepoh8Z5qQz0i0xCsmO1UWxQ7yNhjCwrjbc=	f	t	f	2012-12-11 08:16:23+04	2012-12-11 08:16:23+04
11	sergey.medvedev	Сергей	Медведев	sergey.medvedev@anychart.com	pbkdf2_sha256$10000$4ePSrP0LHH50$muFw4RUelsP563PwmrutM+BmWkIZM+C1LQtDIiqYEfU=	f	t	f	2012-12-11 08:16:27+04	2012-12-11 08:16:27+04
12	timothy.loginov	Тимофей	Логинов	timothy.loginov@anychart.com	pbkdf2_sha256$10000$KOXv5ZWJ5jCv$4cFLZ4+T/p7srPlPDMu+mnLWAO6u1/7tq9AfRdBG9yM=	f	t	f	2012-12-26 11:20:42.739273+04	2012-12-11 08:16:34+04
4	alexandra.batyreva	Александра	Батырева	alexandra.batireva@anychart.com	pbkdf2_sha256$10000$Z6nIeu3S4RYN$9dxu60kRHaJwagKHxs2ZuqtiQisQ/vnjF5sd8NGt/SI=	f	t	f	2013-01-09 07:26:52.228216+04	2012-12-11 08:15:04+04
13	vitaly.radionov	Виталий	Радионов	vitaly.radionov@anychart.com	pbkdf2_sha256$10000$6NCR7sswLkMQ$INjTEttU73+ywZj8ZaPa7Nib1F+sfgto8z0oo+GtH3g=	f	t	f	2013-01-10 12:18:51.600971+04	2012-12-11 08:16:40+04
1	olga	Ольга	Рыкова	vorobyeva.rykova@gmail.com	pbkdf2_sha256$10000$qFjLZ3ymg3ex$5+SvMj8jO4tPE9a9Jl1Jy+wr8Cw2/yPYMzRFQd9u3cM=	t	t	t	2013-01-15 06:45:43.292052+04	2012-12-11 08:05:53+04
9	olga.rykova	Ольга	Рыкова	olga.rykova@anychart.com	pbkdf2_sha256$10000$MDegXoaPloWb$oc9C7pLCACpEOINe1IcNjyJSSkoEWguY2ah1ImXvhEw=	f	t	f	2013-02-12 07:33:06.734649+04	2012-12-11 08:16:07+04
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
1	2012-12-11 08:11:10.021369+04	1	13	1	отчет об ошибке	1	
2	2012-12-11 08:11:13.283032+04	1	13	2	аналитика	1	
3	2012-12-11 08:11:16.812713+04	1	13	3	клиентский запрос	1	
4	2012-12-11 08:11:45.838072+04	1	9	1	AnyStock	1	
5	2012-12-11 08:11:57.276941+04	1	9	2	AnyGantt	1	
6	2012-12-11 08:12:04.840942+04	1	9	3	AnyChart	1	
7	2012-12-11 08:12:27.833855+04	1	11	1	cоздано	1	
8	2012-12-11 08:12:35.536469+04	1	11	2	на согласовании	1	
9	2012-12-11 08:12:45.425359+04	1	11	3	в процессе реализации	1	
10	2012-12-11 08:12:52.265142+04	1	11	4	в процессе проверки	1	
11	2012-12-11 08:12:59.347463+04	1	11	5	реализовано	1	
12	2012-12-11 08:13:06.487157+04	1	11	6	удалено	1	
13	2012-12-11 08:13:40.841742+04	1	3	1	curators	1	
14	2012-12-11 08:13:46.917063+04	1	3	2	testers	1	
15	2012-12-11 08:13:50.783695+04	1	3	3	developers	1	
16	2012-12-11 08:14:01.559934+04	1	3	1	curators	2	Изменен permissions.
17	2012-12-11 08:14:08.156647+04	1	3	3	developers	2	Изменен permissions.
18	2012-12-11 08:14:15.046806+04	1	3	2	testers	2	Изменен permissions.
19	2012-12-11 08:14:49.025305+04	1	4	2	alex.batsuev	1	
20	2012-12-11 08:14:57.505002+04	1	4	3	alexander.kudryavtsev	1	
21	2012-12-11 08:15:04.126617+04	1	4	4	alexandra.batyreva	1	
22	2012-12-11 08:15:10.98545+04	1	4	5	andrey.shakhmin	1	
23	2012-12-11 08:15:17.504234+04	1	4	6	anton.baranchuk	1	
24	2012-12-11 08:15:24.972039+04	1	4	7	anton.kagakin	1	
25	2012-12-11 08:15:31.21112+04	1	4	8	anton.saukh	1	
26	2012-12-11 08:16:07.518865+04	1	4	9	olga.rykova	1	
27	2012-12-11 08:16:23.155336+04	1	4	10	roman.lubushkin	1	
28	2012-12-11 08:16:27.80849+04	1	4	11	sergey.medvedev	1	
29	2012-12-11 08:16:34.172418+04	1	4	12	timothy.loginov	1	
30	2012-12-11 08:16:41.039799+04	1	4	13	vitaly.radionov	1	
31	2012-12-11 08:17:40.228858+04	1	4	3	alexander.kudryavtsev	2	Изменен password,first_name,last_name,email,is_staff и groups.
32	2012-12-11 08:18:11.177286+04	1	4	4	alexandra.batyreva	2	Изменен password,first_name,last_name,email и groups.
33	2012-12-11 08:18:22.582626+04	1	4	4	alexandra.batyreva	2	Изменен password.
34	2012-12-11 08:18:27.605297+04	1	4	3	alexander.kudryavtsev	2	Изменен password и is_staff.
35	2012-12-11 08:18:52.077702+04	1	4	2	alex.batsuev	2	Изменен password,first_name,last_name,email и groups.
36	2012-12-11 08:19:09.703447+04	1	4	5	andrey.shakhmin	2	Изменен password,first_name,last_name,email и groups.
37	2012-12-11 08:19:32.792454+04	1	4	6	anton.baranchuk	2	Изменен password,first_name,last_name,email и groups.
38	2012-12-11 08:19:51.282802+04	1	4	7	anton.kagakin	2	Изменен password,first_name,last_name,email и groups.
39	2012-12-11 08:20:05.160081+04	1	4	8	anton.saukh	2	Изменен password,first_name,last_name,email и groups.
40	2012-12-11 08:20:16.878688+04	1	4	1	olga	2	Изменен password,first_name и last_name.
41	2012-12-11 08:20:24.425405+04	1	4	1	olga	2	Изменен password и groups.
42	2012-12-11 08:20:41.576995+04	1	4	9	olga.rykova	2	Изменен password,first_name,last_name,email и groups.
43	2012-12-11 08:20:56.480556+04	1	4	10	roman.lubushkin	2	Изменен password,first_name,last_name,email и groups.
44	2012-12-11 08:21:11.250457+04	1	4	11	sergey.medvedev	2	Изменен password,first_name,last_name,email и groups.
45	2012-12-11 08:21:25.907196+04	1	4	12	timothy.loginov	2	Изменен password,first_name,last_name,email и groups.
46	2012-12-11 08:21:42.930136+04	1	4	13	vitaly.radionov	2	Изменен password,first_name,last_name,email и groups.
47	2012-12-13 13:14:49.408403+04	1	9	4	Anychart automatic testing system	1	
48	2012-12-14 08:15:28.706301+04	1	9	4	Automatic testing system	2	Изменен title.
49	2012-12-20 07:35:49.866022+04	1	14	1	Цветочки!	1	
50	2012-12-21 11:26:58.709554+04	1	15	15	Требование тестовое	3	
51	2012-12-21 11:26:58.711666+04	1	15	18	Тестовое	3	
52	2012-12-21 11:26:58.712855+04	1	15	21	Тестовое	3	
53	2012-12-21 11:26:58.725654+04	1	15	17	Новое требование	3	
54	2012-12-21 11:26:58.726713+04	1	15	20	Новое, тестовое	3	
55	2012-12-21 11:26:58.727774+04	1	15	16	Новое тестовое	3	
56	2012-12-21 11:26:58.72881+04	1	15	19	Nht,jdfyb	3	
57	2012-12-26 11:50:32.610279+04	1	9	5	Requirement tree	1	
58	2012-12-27 12:42:02.667033+04	1	18	2	Наблюдатель 5  - Бла-бла	3	
59	2012-12-28 08:52:34.940973+04	1	18	3	Разработчик - Тот, который чего-то	3	
60	2012-12-28 09:43:32.372824+04	1	15	2	AC-2	2	Изменен source,source_description и content.
61	2013-01-14 05:13:13.247982+04	1	15	45	ACRT-17	2	Изменен type.
62	2013-01-14 05:13:13.255366+04	1	15	44	ACRT-16	2	Изменен type.
63	2013-01-14 05:13:13.260557+04	1	15	13	AATS-11	2	Изменен type.
64	2013-01-14 05:13:13.26535+04	1	15	14	AATS-12	2	Изменен type.
65	2013-01-14 05:13:13.270155+04	1	15	47	ACRT-19	2	Изменен type.
66	2013-01-14 05:13:13.275337+04	1	15	51	ACRT-23	2	Изменен type.
67	2013-01-14 05:13:13.287352+04	1	15	48	ACRT-20	2	Изменен type.
68	2013-01-14 05:13:13.292388+04	1	15	52	ACRT-24	2	Изменен type.
69	2013-01-14 05:14:25.946951+04	1	15	33	ACRT-11	3	
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
18	термин	app	term
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: olga
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
b8af87bfc870294092e3638bb1b18a6d	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-12-25 08:07:15.962754+04
253cf5b94fa488d7fb6e943636b66296	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-12-25 12:30:47.207959+04
b8643481183311c036e8a5904799d336	ZDljODlmODE1ZDVmYmUzOTg0MGMxMzU1MjRiYTg1YzBjY2M0ZjJmOTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLCXUu\n	2012-12-26 13:09:29.144601+04
8885381310d51d0d13493d8ab938bb19	OTcxNzliMjIzN2YzNmVmYjM3Yzk4N2M0N2MwNjhlMDRkNmIyNzgyZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLDXUu\n	2012-12-27 11:27:34.570837+04
204b98fb8a3c030d9dbe2181170b28fb	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2013-01-04 10:07:22.245059+04
9a9f9bb9a38017e1cd71f0e3cd6537ee	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2013-01-09 08:13:51.981529+04
bda21680c31e0f36203d8847ea0ad6c8	YjQ1N2M4MDkwYjdiOWM2NWQ0M2FkMjI1NGUwN2EwM2QzYjczN2IyZjqAAn1xAShVCnRlc3Rjb29r\naWVxAlUGd29ya2VkcQNVDV9hdXRoX3VzZXJfaWRxBEsMVRJfYXV0aF91c2VyX2JhY2tlbmRxBVUp\nZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRxBnUu\n	2013-01-09 11:21:01.096924+04
4ddb428915b8d05cb67c84b03cf39792	OTcxNzliMjIzN2YzNmVmYjM3Yzk4N2M0N2MwNjhlMDRkNmIyNzgyZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLDXUu\n	2013-01-10 12:06:06.093448+04
5e52e75df5b88e1299c9f631711da6f9	OTcxNzliMjIzN2YzNmVmYjM3Yzk4N2M0N2MwNjhlMDRkNmIyNzgyZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLDXUu\n	2013-01-10 12:11:16.368668+04
795799a57930f1c98a69d80904e0400c	YWNlNzk0ZWRkYzdhZTQ4NGNkNWJlZTFmNzEzMWNjYTM2ODZlYWM1MjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2013-01-11 07:37:34.847575+04
24dd804bec8543bdf67558fac67a7dd8	YWNlNzk0ZWRkYzdhZTQ4NGNkNWJlZTFmNzEzMWNjYTM2ODZlYWM1MjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2013-01-23 07:26:52.23176+04
69265f2f980b0b5d2d166cc597552c6b	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2013-01-23 08:23:29.125177+04
a3246cf8a39d640c7121cf1969eb0abf	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2013-01-24 07:13:44.851885+04
af6367529a7b34ba04d3171095b60e12	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2013-01-24 08:52:43.822641+04
6631e62a7a327e731fd4eb5bbec6e232	OTcxNzliMjIzN2YzNmVmYjM3Yzk4N2M0N2MwNjhlMDRkNmIyNzgyZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLDXUu\n	2013-01-24 12:18:51.6128+04
3ce55eb200b4206227ca0b79d9a3bd47	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2013-01-28 06:34:46.885166+04
6376a2bde6585a778f272de745df818d	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2013-01-28 06:59:46.427134+04
92d03948775fe57e0c858dfe7d46c605	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2013-01-28 13:08:49.787167+04
83a1476829139d06e53aac66318c9a2d	ZGIxYzM2OWRlNGU1Y2I0ODA2NWE5MjNlNzcxZjFlNjE1MDk5MTM4NzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2013-01-29 06:45:43.303332+04
a19f5180950c9ebed1e044de66460a81	ZDljODlmODE1ZDVmYmUzOTg0MGMxMzU1MjRiYTg1YzBjY2M0ZjJmOTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLCXUu\n	2013-02-26 07:33:06.769274+04
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
-- Name: app_term_pkey; Type: CONSTRAINT; Schema: public; Owner: olga; Tablespace: 
--

ALTER TABLE ONLY app_term
    ADD CONSTRAINT app_term_pkey PRIMARY KEY (id);


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
-- Name: app_term_product_id; Type: INDEX; Schema: public; Owner: olga; Tablespace: 
--

CREATE INDEX app_term_product_id ON app_term USING btree (product_id);


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
-- Name: app_term_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: olga
--

ALTER TABLE ONLY app_term
    ADD CONSTRAINT app_term_product_id_fkey FOREIGN KEY (product_id) REFERENCES app_product(id) DEFERRABLE INITIALLY DEFERRED;


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

