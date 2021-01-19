--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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
-- Name: weather; Type: TABLE; Schema: public; Owner: jadlp
--

CREATE TABLE public.weather (
    id integer NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    low integer NOT NULL,
    high integer NOT NULL,
    rainfall numeric DEFAULT 0,
    CONSTRAINT temperatures_rainfall_check CHECK ((rainfall >= (0)::numeric))
);


ALTER TABLE public.weather OWNER TO jadlp;

--
-- Name: temperatures_id_seq; Type: SEQUENCE; Schema: public; Owner: jadlp
--

CREATE SEQUENCE public.temperatures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temperatures_id_seq OWNER TO jadlp;

--
-- Name: temperatures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jadlp
--

ALTER SEQUENCE public.temperatures_id_seq OWNED BY public.weather.id;


--
-- Name: weather id; Type: DEFAULT; Schema: public; Owner: jadlp
--

ALTER TABLE ONLY public.weather ALTER COLUMN id SET DEFAULT nextval('public.temperatures_id_seq'::regclass);


--
-- Data for Name: weather; Type: TABLE DATA; Schema: public; Owner: jadlp
--

INSERT INTO public.weather VALUES (7, '2016-03-07', 29, 32, 0.000);
INSERT INTO public.weather VALUES (8, '2016-03-08', 23, 31, 0.000);
INSERT INTO public.weather VALUES (9, '2016-03-09', 17, 28, 0.000);
INSERT INTO public.weather VALUES (1, '2016-03-01', 34, 43, 0.117);
INSERT INTO public.weather VALUES (2, '2016-03-02', 32, 44, 0.117);
INSERT INTO public.weather VALUES (3, '2016-03-03', 31, 47, 0.156);
INSERT INTO public.weather VALUES (4, '2016-03-04', 33, 42, 0.078);
INSERT INTO public.weather VALUES (5, '2016-03-05', 39, 46, 0.273);
INSERT INTO public.weather VALUES (6, '2016-03-06', 32, 43, 0.078);


--
-- Name: temperatures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jadlp
--

SELECT pg_catalog.setval('public.temperatures_id_seq', 9, true);


--
-- Name: weather temperatures_pkey; Type: CONSTRAINT; Schema: public; Owner: jadlp
--

ALTER TABLE ONLY public.weather
    ADD CONSTRAINT temperatures_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

