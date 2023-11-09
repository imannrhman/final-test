--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg120+1)

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
-- Name: demo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.demo (
    id integer NOT NULL,
    name character varying(200) DEFAULT ''::character varying NOT NULL,
    hint text DEFAULT ''::text NOT NULL
);


--
-- Name: demo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.demo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: demo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.demo_id_seq OWNED BY public.demo.id;


--
-- Name: dim_date; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dim_date (
    date_key integer NOT NULL,
    date date NOT NULL,
    day_of_week integer NOT NULL,
    week integer NOT NULL,
    month integer NOT NULL,
    quarter integer NOT NULL,
    year integer NOT NULL
);


--
-- Name: dim_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dim_posts (
    post_id integer,
    post_text character varying(500),
    post_date date,
    user_id integer
);


--
-- Name: dim_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dim_users (
    user_id integer NOT NULL,
    user_name character varying(100),
    country character varying(50)
);


--
-- Name: fact_post_performance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fact_post_performance (
    post_id integer,
    like_count integer,
    comment_count integer,
    date_key integer
);


--
-- Name: raw_likes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.raw_likes (
    like_id integer,
    user_id integer,
    post_id integer,
    like_date date
);


--
-- Name: raw_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.raw_posts (
    post_id integer,
    post_text character varying(500),
    post_date date,
    user_id integer
);


--
-- Name: raw_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.raw_users (
    user_id integer,
    user_name character varying(100),
    country character varying(50)
);


--
-- Name: demo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.demo ALTER COLUMN id SET DEFAULT nextval('public.demo_id_seq'::regclass);


--
-- Name: demo demo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.demo
    ADD CONSTRAINT demo_pkey PRIMARY KEY (id);


--
-- Name: dim_date dim_date_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dim_date
    ADD CONSTRAINT dim_date_pkey PRIMARY KEY (date_key);


--
-- Name: dim_users dim_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dim_users
    ADD CONSTRAINT dim_users_pkey PRIMARY KEY (user_id);


--
-- Name: dim_posts dim_posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dim_posts
    ADD CONSTRAINT dim_posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.dim_users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fact_post_performance fact_post_performance_date_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fact_post_performance
    ADD CONSTRAINT fact_post_performance_date_key_fkey FOREIGN KEY (date_key) REFERENCES public.dim_date(date_key);


--
-- PostgreSQL database dump complete
--

