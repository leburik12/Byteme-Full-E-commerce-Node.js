--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)

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
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, id_district, id_role, user_uuid, first_name, last_name, phone, gender, email, password_hash, is_active, id_type, is_id_verified, user_name) FROM stdin;
5	\N	3	baaef859-ac4a-4318-a6bb-a128bd401c74	abe	abe	913116879	m	abe@gmail.com	$2b$10$rcD.k94zeeojAvzyuTjhn.0ASpashSYkz3ZRvHrcrBSihIJELV34y	t	\N	f	abe
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

--
-- Name: user user_user_name_key; Type: CONSTRAINT; Schema: public; Owner: postg

--
-- Name: idx_user_first_name; Type: INDEX; Schema: public; Owner: postgres
--

--
-- Name: idx_user_phone; Type: INDEX; Schema: public; Owner: postgres
--


--
-- Name: user user_id_district_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

--ALTER TABLE ONLY public."user"
--ADD CONSTRAINT user_id_district_fkey FOREIGN KEY (id_district) REFERENCES public.districts(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: user user_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Own ADD CONSTRAINT user_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: TABLE "user"; Type: ACL; Schema: public; Owner: postgres
--

--GRANT ALL ON TABLE public."user" TO emanuel1

--
-- PostgreSQL database dump complete
--

