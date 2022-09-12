--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE test_db;




--
-- Drop roles
--

DROP ROLE "test-admin-user";
DROP ROLE "test-simple-user";


--
-- Roles
--

CREATE ROLE "test-admin-user";
ALTER ROLE "test-admin-user" WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md531f65fc5e3efab3b3b7b91bed56a15a7';
CREATE ROLE "test-simple-user";
ALTER ROLE "test-simple-user" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md551155973ccb48148b39e5ce518feff31';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.12 (Debian 12.12-1.pgdg110+1)
-- Dumped by pg_dump version 12.12 (Debian 12.12-1.pgdg110+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: test-admin-user
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO "test-admin-user";

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: test-admin-user
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: test-admin-user
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: test-admin-user
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.12 (Debian 12.12-1.pgdg110+1)
-- Dumped by pg_dump version 12.12 (Debian 12.12-1.pgdg110+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: test-admin-user
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO "test-admin-user";

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: test-admin-user
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- Database "test_db" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.12 (Debian 12.12-1.pgdg110+1)
-- Dumped by pg_dump version 12.12 (Debian 12.12-1.pgdg110+1)

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
-- Name: test_db; Type: DATABASE; Schema: -; Owner: test-admin-user
--

CREATE DATABASE test_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE test_db OWNER TO "test-admin-user";

\connect test_db

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
-- Name: clients; Type: TABLE; Schema: public; Owner: test-admin-user
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    "фамилия" character varying,
    "страна проживания" character varying,
    "заказ" integer
);


ALTER TABLE public.clients OWNER TO "test-admin-user";

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: test-admin-user
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_id_seq OWNER TO "test-admin-user";

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test-admin-user
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: test-admin-user
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    "наименование" character varying,
    "цена" integer
);


ALTER TABLE public.orders OWNER TO "test-admin-user";

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: test-admin-user
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO "test-admin-user";

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test-admin-user
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: test-admin-user
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: test-admin-user
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: test-admin-user
--

COPY public.clients (id, "фамилия", "страна проживания", "заказ") FROM stdin;
4	Ронни Джеймс Дио	Russia	\N
5	Ritchie Blackmore	Russia	\N
1	Иванов Иван Иванович	USA	3
2	Петров Петр Петрович	Canada	4
3	Иоганн Себастьян Бах	Japan	5
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: test-admin-user
--

COPY public.orders (id, "наименование", "цена") FROM stdin;
1	Шоколад	10
2	Принтер	3000
3	Книга	500
4	Монитор	7000
5	Гитара	4000
\.


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test-admin-user
--

SELECT pg_catalog.setval('public.clients_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test-admin-user
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: test-admin-user
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: test-admin-user
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: clients_страна проживания_idx; Type: INDEX; Schema: public; Owner: test-admin-user
--

CREATE INDEX "clients_страна проживания_idx" ON public.clients USING btree ("страна проживания");


--
-- Name: clients fk_заказ; Type: FK CONSTRAINT; Schema: public; Owner: test-admin-user
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT "fk_заказ" FOREIGN KEY ("заказ") REFERENCES public.orders(id);


--
-- Name: DATABASE test_db; Type: ACL; Schema: -; Owner: test-admin-user
--

GRANT CONNECT ON DATABASE test_db TO "test-simple-user";


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: test-admin-user
--

GRANT USAGE ON SCHEMA public TO "test-simple-user";


--
-- Name: TABLE clients; Type: ACL; Schema: public; Owner: test-admin-user
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.clients TO "test-simple-user";


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: test-admin-user
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.orders TO "test-simple-user";


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

