--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg100+1)

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
-- Name: pacilflix; Type: SCHEMA; Schema: -; Owner: michelle.angelica21
--

CREATE SCHEMA pacilflix;


ALTER SCHEMA pacilflix OWNER TO "michelle.angelica21";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: contributors; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.contributors (
    id uuid NOT NULL,
    nama character varying(50) NOT NULL,
    jenis_kelamin integer NOT NULL,
    kewarganegaraan character varying(50) NOT NULL,
    CONSTRAINT contributors_jenis_kelamin_check CHECK ((jenis_kelamin = ANY (ARRAY[0, 1])))
);


ALTER TABLE pacilflix.contributors OWNER TO "michelle.angelica21";

--
-- Name: daftar_favorit; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.daftar_favorit (
    "timestamp" timestamp without time zone NOT NULL,
    username character varying(50) NOT NULL,
    judul character varying(50) NOT NULL
);


ALTER TABLE pacilflix.daftar_favorit OWNER TO "michelle.angelica21";

--
-- Name: dukungan_perangkat; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.dukungan_perangkat (
    nama_paket character varying(50) NOT NULL,
    dukungan_perangkat character varying(50) NOT NULL
);


ALTER TABLE pacilflix.dukungan_perangkat OWNER TO "michelle.angelica21";

--
-- Name: episode; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.episode (
    id_series uuid NOT NULL,
    sub_judul character varying(100) NOT NULL,
    sinopsis character varying(255) NOT NULL,
    durasi integer DEFAULT 0 NOT NULL,
    url_video character varying(255) NOT NULL,
    release_date date NOT NULL
);


ALTER TABLE pacilflix.episode OWNER TO "michelle.angelica21";

--
-- Name: film; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.film (
    id_tayangan uuid NOT NULL,
    url_video_film character varying(255) NOT NULL,
    release_date_film date NOT NULL,
    durasi_film integer DEFAULT 0 NOT NULL
);


ALTER TABLE pacilflix.film OWNER TO "michelle.angelica21";

--
-- Name: genre_tayangan; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.genre_tayangan (
    id_tayangan uuid NOT NULL,
    genre character varying(50) NOT NULL
);


ALTER TABLE pacilflix.genre_tayangan OWNER TO "michelle.angelica21";

--
-- Name: memainkan_tayangan; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.memainkan_tayangan (
    id_tayangan uuid NOT NULL,
    id_pemain uuid NOT NULL
);


ALTER TABLE pacilflix.memainkan_tayangan OWNER TO "michelle.angelica21";

--
-- Name: menulis_skenario_tayangan; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.menulis_skenario_tayangan (
    id_tayangan uuid NOT NULL,
    id_penulis_skenario uuid NOT NULL
);


ALTER TABLE pacilflix.menulis_skenario_tayangan OWNER TO "michelle.angelica21";

--
-- Name: paket; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.paket (
    nama character varying(50) NOT NULL,
    harga integer NOT NULL,
    resolusi_layar character varying(50) NOT NULL,
    CONSTRAINT paket_harga_check CHECK ((harga >= 0))
);


ALTER TABLE pacilflix.paket OWNER TO "michelle.angelica21";

--
-- Name: pemain; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.pemain (
    id uuid NOT NULL
);


ALTER TABLE pacilflix.pemain OWNER TO "michelle.angelica21";

--
-- Name: pengguna; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.pengguna (
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    id_tayangan uuid,
    negara_asal character varying(50) DEFAULT 'Unknown'::character varying NOT NULL
);


ALTER TABLE pacilflix.pengguna OWNER TO "michelle.angelica21";

--
-- Name: penulis_skenario; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.penulis_skenario (
    id uuid NOT NULL
);


ALTER TABLE pacilflix.penulis_skenario OWNER TO "michelle.angelica21";

--
-- Name: persetujuan; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.persetujuan (
    nama character varying(100) NOT NULL,
    id_tayangan uuid NOT NULL,
    tanggal_persetujuan date NOT NULL,
    durasi integer NOT NULL,
    biaya integer NOT NULL,
    tanggal_mulai_penayangan date NOT NULL,
    CONSTRAINT persetujuan_biaya_check CHECK ((biaya >= 0)),
    CONSTRAINT persetujuan_durasi_check CHECK ((durasi >= 0))
);


ALTER TABLE pacilflix.persetujuan OWNER TO "michelle.angelica21";

--
-- Name: perusahaan_produksi; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.perusahaan_produksi (
    nama character varying(100) NOT NULL
);


ALTER TABLE pacilflix.perusahaan_produksi OWNER TO "michelle.angelica21";

--
-- Name: riwayat_nonton; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.riwayat_nonton (
    id_tayangan uuid,
    username character varying(50) NOT NULL,
    start_date_time timestamp without time zone NOT NULL,
    end_date_time timestamp without time zone NOT NULL
);


ALTER TABLE pacilflix.riwayat_nonton OWNER TO "michelle.angelica21";

--
-- Name: series; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.series (
    id_tayangan uuid NOT NULL
);


ALTER TABLE pacilflix.series OWNER TO "michelle.angelica21";

--
-- Name: sutradara; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.sutradara (
    id uuid NOT NULL
);


ALTER TABLE pacilflix.sutradara OWNER TO "michelle.angelica21";

--
-- Name: tayangan; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.tayangan (
    id uuid NOT NULL,
    judul character varying(100) NOT NULL,
    sinopsis character varying(255) NOT NULL,
    asal_negara character varying(50) NOT NULL,
    sinopsis_trailer character varying(255) NOT NULL,
    url_video_trailer character varying(255) NOT NULL,
    release_date_trailer date NOT NULL,
    id_sutradara uuid
);


ALTER TABLE pacilflix.tayangan OWNER TO "michelle.angelica21";

--
-- Name: tayangan_memiliki_daftar_favorit; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.tayangan_memiliki_daftar_favorit (
    id_tayangan uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    username character varying(50) NOT NULL
);


ALTER TABLE pacilflix.tayangan_memiliki_daftar_favorit OWNER TO "michelle.angelica21";

--
-- Name: tayangan_terunduh; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.tayangan_terunduh (
    id_tayangan uuid NOT NULL,
    username character varying(50) NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE pacilflix.tayangan_terunduh OWNER TO "michelle.angelica21";

--
-- Name: transaction; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.transaction (
    username character varying(50) NOT NULL,
    start_date_time date NOT NULL,
    end_date_time date,
    nama_paket character varying(50),
    metode_pembayaran character varying(50) NOT NULL,
    timestamp_pembayaran timestamp without time zone NOT NULL
);


ALTER TABLE pacilflix.transaction OWNER TO "michelle.angelica21";

--
-- Name: ulasan; Type: TABLE; Schema: pacilflix; Owner: michelle.angelica21
--

CREATE TABLE pacilflix.ulasan (
    id_tayangan uuid,
    username character varying(50) NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    rating integer DEFAULT 0 NOT NULL,
    deskripsi character varying(255)
);


ALTER TABLE pacilflix.ulasan OWNER TO "michelle.angelica21";

--
-- Data for Name: contributors; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.contributors (id, nama, jenis_kelamin, kewarganegaraan) FROM stdin;
a3d69458-7724-4a2f-a886-2e6187e3aa5a	John Doe	0	USA
7c755736-74ea-4038-be66-c5c8dae1b3b9	Jane Smith	1	Canada
f438c3fb-8b68-4202-9eb3-07d68bea3c98	Alice Johnson	1	UK
1aa6af86-6aba-499b-999a-92385c8b3c81	Michael Brown	0	USA
5f59bb23-89d0-4d67-bfd8-ea42645eb34d	Mary Davis	1	Australia
69cb41b4-c1cd-44c7-930f-502b708d9a43	Chris Garcia	0	Mexico
f697b629-07b1-4c80-9109-34f62c1acd42	Jessica Wilson	1	New Zealand
b163acc8-a635-4ba6-af4e-532dc2d4b7cb	David Martinez	0	Spain
c3086ae9-d312-437b-b3e2-f9e8372ff5df	Angela Anderson	1	South Africa
9ae4eb31-48d4-4f5c-83ba-d5f21e3c4f60	Daniel Taylor	0	USA
f5f858b3-4748-452a-b91c-3ad8e1a9e33a	Laura Thomas	1	UK
e6dfbe45-5335-4cc6-866d-2cc25275b85f	James Lee	0	Canada
f96b2bff-05e0-49c1-8b8e-821de6b995dd	Sarah Harris	1	Australia
a64fb9e1-1cb8-4a1f-91b0-16bb3bc72dcd	Kevin Robinson	0	Ireland
67236e2b-3cdf-470d-b466-83d41ce8e5e4	Rachel Walker	1	New Zealand
d61e3087-86b4-4024-ae7b-466099556552	Brian Clark	0	USA
9c2e22d7-376f-447f-9ddb-a572ea8e5850	Nina Lewis	1	UK
85185a98-4291-4465-b58f-eaedd87be085	George Allen	0	USA
b16f2b2c-c83b-473d-ba90-c0f1b36b1e7b	Simone Young	1	Canada
953b70b5-ecc1-4ddd-b882-d9050e454c5a	Ethan King	0	USA
aa7ace57-cc9b-4e25-8d21-c64e8d4b3def	Lisa Wright	1	UK
0b6da608-e475-4db0-9764-5462c002fd90	Mark Lopez	0	Brazil
5c4e9b9f-2749-4463-9249-f171cb483462	Emily Hill	1	USA
d3b14dcb-5e7e-409c-8c48-8491eb69c6dc	Arthur Scott	0	Scotland
70ff176d-567d-428e-aac6-aed6c361ce9d	Barbara Torres	1	Portugal
fdbc2031-4e6e-4aab-a5d1-d6becff3175b	Steven Nguyen	0	Vietnam
5b33dc07-a290-4c5b-8f99-151345499c21	Linda Hernandez	1	Mexico
57075989-6ef5-4cd7-ad7f-c877cea44a31	Joseph Moore	0	Ireland
e2ebe193-4e09-4010-ad08-afe7cc586c29	Patricia Jackson	1	USA
33b49f63-532d-4949-a4fd-44bf6136abfa	Joshua Martin	0	UK
f421e9b9-cfe8-4757-b49b-5602a4edb30c	Amy Lee	1	Korea
d95d1a5b-eb9e-44e7-84e4-8811d0de5d0d	Jacob Gonzalez	0	Chile
1f7e308e-f02b-43dc-8da7-8d62a0715df1	Diana Carter	1	New Zealand
bcf8e9e2-c232-41a7-ab7e-86eca4d48994	Nathan Perry	0	Australia
3b1f68a1-bd29-48ba-86a0-51dec21afdbe	Olivia Edwards	1	USA
ec481144-0fa0-4bb0-b28b-f7a12cff1d6d	Kyle Miller	0	Canada
bd116d87-ea4a-44c1-be8d-83b383037c19	Madison Thompson	1	Ireland
5b6bcf57-16a7-4eba-916a-138526980d3f	Alex White	0	UK
7d1f76a0-edca-455f-b36f-8c1bdd4d1a2a	Samantha Baker	1	Australia
19f164fd-c879-43a0-847c-641ecbbdbdfe	Michael Green	0	USA
c383caa0-a63c-4b1f-b1ea-dbe5b79a8ec4	Michelle Hall	1	Canada
87f01601-aa28-4b35-b88c-c422c9674b9f	Benjamin Harris	0	USA
fa39e7bd-f702-40f1-88b2-e93cc41dfbc2	Mia Nelson	1	Sweden
d71cbee4-d4d6-455b-a547-83d4ee8ae85e	Charlie Roberts	0	UK
7fcf9320-ecc6-44d9-9be7-916ed99da623	Chloe Clark	1	France
a838ec05-d6a4-4268-8b9d-6e93dfe112a6	Ryan Lewis	0	USA
d8b709d1-23e9-4d9d-89ca-eef9f1c61530	Lauren Walker	1	Australia
51a2010c-d2f5-4607-83fa-eb7a2535d3f1	Jack Wilson	0	New Zealand
1d18d26a-2aa5-48d9-9aa0-1cb91bf1cb2e	Sophia Young	1	Canada
76757057-05f2-4ba6-84b6-5059549f1503	Aiden King	0	USA
461bfd74-4a35-4f82-85f6-a39e24b2288e	Hailey Scott	1	Scotland
74fe9e0e-0254-4fa1-bb70-3df4344df948	Elijah Campbell	0	Ireland
b9e66bb0-cfcf-4647-bc79-5ef2f757d482	Grace Parker	1	South Africa
94ed05b4-e92c-4733-8445-78b8c650161e	Isaac Evans	0	Wales
8c08f82d-3ad9-4286-b156-1cb716d73886	Aubrey Brown	1	USA
cf8e34d0-e72d-4146-b863-b1b3a1767574	Luke Davis	0	Australia
f082f96a-53cb-4593-89b8-22f867ca0148	Lily Anderson	1	Norway
8eb39079-6022-4634-b71b-3505c469fd1e	Gabriel Martin	0	France
bbe842a4-1a2e-406b-a2ee-b86a93a519cc	Zoey Robinson	1	USA
8241c894-56df-4321-884e-2a3abcf0aa95	Oliver Johnson	0	Canada
207ee903-af54-4f38-8006-a344b96d06f5	Ava Thompson	1	UK
26f81171-2b61-4551-a379-e06522ff21d1	William White	0	Australia
67b0d938-8e01-4730-8a64-6a89b089cb29	Mason Harris	0	USA
71fdce5b-1b77-404c-91a1-2a5df9c5c182	Eva Morales	1	Bolivia
d8759eae-5404-4f4b-97ee-784cba063251	Tom Sanders	0	USA
\.


--
-- Data for Name: daftar_favorit; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.daftar_favorit ("timestamp", username, judul) FROM stdin;
2024-04-30 10:00:00	user1	Adventure Hits
2024-04-30 10:15:00	user2	Chill Weekends
2024-04-30 10:30:00	user3	Romantic Evenings
2024-04-30 10:45:00	user4	Mystery Thrillers
2024-04-30 11:00:00	user5	Crime and Punishment
2024-04-30 11:15:00	user6	Futuristic Journeys
2024-04-30 11:30:00	user7	Sci-Fi Sagas
2024-04-30 11:45:00	user8	High Stakes
2024-05-01 10:00:00	user1	Deep Dives
2024-05-01 10:15:00	user2	Historical Dramas
2024-05-01 10:30:00	user3	Survival Stories
2024-05-01 10:45:00	user4	Art Heists
2024-05-01 11:00:00	user5	Escape Adventures
2024-05-01 11:15:00	user6	Ancient Mysteries
2024-05-01 11:30:00	user7	Royal Affairs
2024-05-01 11:45:00	user8	Chilling Tales
\.


--
-- Data for Name: dukungan_perangkat; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.dukungan_perangkat (nama_paket, dukungan_perangkat) FROM stdin;
Paket Dasar	Android
Paket Dasar	iOS
Paket Lanjutan	Android
Paket Lanjutan	iOS
Paket Lanjutan	Windows
Paket Premium	Android
Paket Premium	iOS
Paket Premium	Windows
\.


--
-- Data for Name: episode; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.episode (id_series, sub_judul, sinopsis, durasi, url_video, release_date) FROM stdin;
9948198b-2f02-4073-9e74-b8d3277911ec	The Mysterious Beginnings	Uncover the secrets of the mountains.	45	http://example.com/video1	2024-06-05
9948198b-2f02-4073-9e74-b8d3277911ec	The Ascent	Climbing the steep cliffs.	50	http://example.com/video2	2024-06-12
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	Artificial Dawn	Exploring the rise of AI.	40	http://example.com/video3	2024-06-19
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	The Heist Begins	Planning the ultimate theft.	55	http://example.com/video4	2024-06-26
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	Escape Plan	Executing the plan step by step.	60	http://example.com/video5	2024-07-03
fbbf3e81-865c-44d3-a725-c0965a495450	Silent Shadows	The haunting begins in the icy landscape.	50	http://example.com/video6	2024-07-10
fbbf3e81-865c-44d3-a725-c0965a495450	The Lost	Lost in the never-ending frost.	45	http://example.com/video7	2024-07-17
d0bafd93-0a89-408d-9dd2-1c37b8695578	Breakout	The first signs of freedom.	48	http://example.com/video8	2024-07-24
d0bafd93-0a89-408d-9dd2-1c37b8695578	The Chase	The pursuit after the escape.	52	http://example.com/video9	2024-07-31
d0bafd93-0a89-408d-9dd2-1c37b8695578	New Horizons	Facing the challenges outside the walls.	55	http://example.com/video10	2024-08-07
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	New World	Adapting to a world controlled by machines.	47	http://example.com/video11	2024-08-14
9948198b-2f02-4073-9e74-b8d3277911ec	The Summit	Reaching the peak and finding the truth.	53	http://example.com/video12	2024-08-21
\.


--
-- Data for Name: film; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.film (id_tayangan, url_video_film, release_date_film, durasi_film) FROM stdin;
1d954a21-e52a-4013-9c4e-efff66b193ca	http://example.com/film1d954a21-e52a-4013-9c4e-efff66b193ca	2024-10-01	123
529073a1-963b-4560-abf9-42b93fd0b6e4	http://example.com/film529073a1-963b-4560-abf9-42b93fd0b6e4	2024-11-15	141
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	http://example.com/filmc6bf4ead-bb8e-49ba-8fcd-adb622df2441	2024-12-20	129
65674e91-9346-4fb6-aa10-c945075b748c	http://example.com/film65674e91-9346-4fb6-aa10-c945075b748c	2025-01-25	143
a4d78922-0eb3-4734-91ef-3641265ca7a9	http://example.com/filma4d78922-0eb3-4734-91ef-3641265ca7a9	2025-02-10	122
1c116500-760f-455e-8fca-ae8b91bc1283	http://example.com/film1c116500-760f-455e-8fca-ae8b91bc1283	2025-04-18	98
20e91152-8e49-4799-aaea-7c3edda5c469	http://example.com/film20e91152-8e49-4799-aaea-7c3edda5c469	2025-06-01	117
288d29bc-1569-4bf6-9353-81e4b39c3f13	http://example.com/film288d29bc-1569-4bf6-9353-81e4b39c3f13	2025-07-15	86
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	http://example.com/film505e0cf7-d5aa-4dca-84e2-1cc72a152d38	2025-08-05	33
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	http://example.com/film2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	2025-11-20	81
\.


--
-- Data for Name: genre_tayangan; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.genre_tayangan (id_tayangan, genre) FROM stdin;
1d954a21-e52a-4013-9c4e-efff66b193ca	Adventure
529073a1-963b-4560-abf9-42b93fd0b6e4	Mystery
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	Drama
65674e91-9346-4fb6-aa10-c945075b748c	Romance
a4d78922-0eb3-4734-91ef-3641265ca7a9	Sci-Fi
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	Thriller
1c116500-760f-455e-8fca-ae8b91bc1283	Documentary
9948198b-2f02-4073-9e74-b8d3277911ec	Action
20e91152-8e49-4799-aaea-7c3edda5c469	Historical
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	Horror
\.


--
-- Data for Name: memainkan_tayangan; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.memainkan_tayangan (id_tayangan, id_pemain) FROM stdin;
1d954a21-e52a-4013-9c4e-efff66b193ca	c383caa0-a63c-4b1f-b1ea-dbe5b79a8ec4
529073a1-963b-4560-abf9-42b93fd0b6e4	76757057-05f2-4ba6-84b6-5059549f1503
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	1aa6af86-6aba-499b-999a-92385c8b3c81
65674e91-9346-4fb6-aa10-c945075b748c	8241c894-56df-4321-884e-2a3abcf0aa95
a4d78922-0eb3-4734-91ef-3641265ca7a9	207ee903-af54-4f38-8006-a344b96d06f5
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	7d1f76a0-edca-455f-b36f-8c1bdd4d1a2a
1c116500-760f-455e-8fca-ae8b91bc1283	207ee903-af54-4f38-8006-a344b96d06f5
9948198b-2f02-4073-9e74-b8d3277911ec	76757057-05f2-4ba6-84b6-5059549f1503
20e91152-8e49-4799-aaea-7c3edda5c469	f5f858b3-4748-452a-b91c-3ad8e1a9e33a
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	d95d1a5b-eb9e-44e7-84e4-8811d0de5d0d
288d29bc-1569-4bf6-9353-81e4b39c3f13	c383caa0-a63c-4b1f-b1ea-dbe5b79a8ec4
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	8241c894-56df-4321-884e-2a3abcf0aa95
fbbf3e81-865c-44d3-a725-c0965a495450	74fe9e0e-0254-4fa1-bb70-3df4344df948
d0bafd93-0a89-408d-9dd2-1c37b8695578	5c4e9b9f-2749-4463-9249-f171cb483462
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	1d18d26a-2aa5-48d9-9aa0-1cb91bf1cb2e
1d954a21-e52a-4013-9c4e-efff66b193ca	e2ebe193-4e09-4010-ad08-afe7cc586c29
529073a1-963b-4560-abf9-42b93fd0b6e4	5c4e9b9f-2749-4463-9249-f171cb483462
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	70ff176d-567d-428e-aac6-aed6c361ce9d
65674e91-9346-4fb6-aa10-c945075b748c	9c2e22d7-376f-447f-9ddb-a572ea8e5850
a4d78922-0eb3-4734-91ef-3641265ca7a9	85185a98-4291-4465-b58f-eaedd87be085
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	207ee903-af54-4f38-8006-a344b96d06f5
1c116500-760f-455e-8fca-ae8b91bc1283	f421e9b9-cfe8-4757-b49b-5602a4edb30c
9948198b-2f02-4073-9e74-b8d3277911ec	a3d69458-7724-4a2f-a886-2e6187e3aa5a
20e91152-8e49-4799-aaea-7c3edda5c469	67236e2b-3cdf-470d-b466-83d41ce8e5e4
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	85185a98-4291-4465-b58f-eaedd87be085
288d29bc-1569-4bf6-9353-81e4b39c3f13	1d18d26a-2aa5-48d9-9aa0-1cb91bf1cb2e
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	5b6bcf57-16a7-4eba-916a-138526980d3f
fbbf3e81-865c-44d3-a725-c0965a495450	f421e9b9-cfe8-4757-b49b-5602a4edb30c
d0bafd93-0a89-408d-9dd2-1c37b8695578	33b49f63-532d-4949-a4fd-44bf6136abfa
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	5b33dc07-a290-4c5b-8f99-151345499c21
1d954a21-e52a-4013-9c4e-efff66b193ca	9c2e22d7-376f-447f-9ddb-a572ea8e5850
529073a1-963b-4560-abf9-42b93fd0b6e4	7d1f76a0-edca-455f-b36f-8c1bdd4d1a2a
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	85185a98-4291-4465-b58f-eaedd87be085
65674e91-9346-4fb6-aa10-c945075b748c	5b33dc07-a290-4c5b-8f99-151345499c21
a4d78922-0eb3-4734-91ef-3641265ca7a9	a3d69458-7724-4a2f-a886-2e6187e3aa5a
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	f697b629-07b1-4c80-9109-34f62c1acd42
1c116500-760f-455e-8fca-ae8b91bc1283	bbe842a4-1a2e-406b-a2ee-b86a93a519cc
9948198b-2f02-4073-9e74-b8d3277911ec	cf8e34d0-e72d-4146-b863-b1b3a1767574
20e91152-8e49-4799-aaea-7c3edda5c469	d8759eae-5404-4f4b-97ee-784cba063251
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	cf8e34d0-e72d-4146-b863-b1b3a1767574
288d29bc-1569-4bf6-9353-81e4b39c3f13	67236e2b-3cdf-470d-b466-83d41ce8e5e4
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	f082f96a-53cb-4593-89b8-22f867ca0148
fbbf3e81-865c-44d3-a725-c0965a495450	fdbc2031-4e6e-4aab-a5d1-d6becff3175b
d0bafd93-0a89-408d-9dd2-1c37b8695578	9c2e22d7-376f-447f-9ddb-a572ea8e5850
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	c383caa0-a63c-4b1f-b1ea-dbe5b79a8ec4
1d954a21-e52a-4013-9c4e-efff66b193ca	85185a98-4291-4465-b58f-eaedd87be085
529073a1-963b-4560-abf9-42b93fd0b6e4	8241c894-56df-4321-884e-2a3abcf0aa95
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	74fe9e0e-0254-4fa1-bb70-3df4344df948
65674e91-9346-4fb6-aa10-c945075b748c	51a2010c-d2f5-4607-83fa-eb7a2535d3f1
a4d78922-0eb3-4734-91ef-3641265ca7a9	8241c894-56df-4321-884e-2a3abcf0aa95
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	461bfd74-4a35-4f82-85f6-a39e24b2288e
1c116500-760f-455e-8fca-ae8b91bc1283	f5f858b3-4748-452a-b91c-3ad8e1a9e33a
9948198b-2f02-4073-9e74-b8d3277911ec	70ff176d-567d-428e-aac6-aed6c361ce9d
20e91152-8e49-4799-aaea-7c3edda5c469	57075989-6ef5-4cd7-ad7f-c877cea44a31
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	7d1f76a0-edca-455f-b36f-8c1bdd4d1a2a
288d29bc-1569-4bf6-9353-81e4b39c3f13	51a2010c-d2f5-4607-83fa-eb7a2535d3f1
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	b9e66bb0-cfcf-4647-bc79-5ef2f757d482
fbbf3e81-865c-44d3-a725-c0965a495450	33b49f63-532d-4949-a4fd-44bf6136abfa
d0bafd93-0a89-408d-9dd2-1c37b8695578	ec481144-0fa0-4bb0-b28b-f7a12cff1d6d
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	8241c894-56df-4321-884e-2a3abcf0aa95
1d954a21-e52a-4013-9c4e-efff66b193ca	1aa6af86-6aba-499b-999a-92385c8b3c81
529073a1-963b-4560-abf9-42b93fd0b6e4	1aa6af86-6aba-499b-999a-92385c8b3c81
65674e91-9346-4fb6-aa10-c945075b748c	1aa6af86-6aba-499b-999a-92385c8b3c81
a4d78922-0eb3-4734-91ef-3641265ca7a9	1aa6af86-6aba-499b-999a-92385c8b3c81
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	1aa6af86-6aba-499b-999a-92385c8b3c81
1c116500-760f-455e-8fca-ae8b91bc1283	1aa6af86-6aba-499b-999a-92385c8b3c81
9948198b-2f02-4073-9e74-b8d3277911ec	1aa6af86-6aba-499b-999a-92385c8b3c81
20e91152-8e49-4799-aaea-7c3edda5c469	1aa6af86-6aba-499b-999a-92385c8b3c81
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	1aa6af86-6aba-499b-999a-92385c8b3c81
288d29bc-1569-4bf6-9353-81e4b39c3f13	1aa6af86-6aba-499b-999a-92385c8b3c81
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	1aa6af86-6aba-499b-999a-92385c8b3c81
fbbf3e81-865c-44d3-a725-c0965a495450	1aa6af86-6aba-499b-999a-92385c8b3c81
d0bafd93-0a89-408d-9dd2-1c37b8695578	1aa6af86-6aba-499b-999a-92385c8b3c81
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	1aa6af86-6aba-499b-999a-92385c8b3c81
\.


--
-- Data for Name: menulis_skenario_tayangan; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.menulis_skenario_tayangan (id_tayangan, id_penulis_skenario) FROM stdin;
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	7fcf9320-ecc6-44d9-9be7-916ed99da623
65674e91-9346-4fb6-aa10-c945075b748c	33b49f63-532d-4949-a4fd-44bf6136abfa
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	33b49f63-532d-4949-a4fd-44bf6136abfa
fbbf3e81-865c-44d3-a725-c0965a495450	33b49f63-532d-4949-a4fd-44bf6136abfa
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	33b49f63-532d-4949-a4fd-44bf6136abfa
288d29bc-1569-4bf6-9353-81e4b39c3f13	7fcf9320-ecc6-44d9-9be7-916ed99da623
288d29bc-1569-4bf6-9353-81e4b39c3f13	33b49f63-532d-4949-a4fd-44bf6136abfa
20e91152-8e49-4799-aaea-7c3edda5c469	7fcf9320-ecc6-44d9-9be7-916ed99da623
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	33b49f63-532d-4949-a4fd-44bf6136abfa
a4d78922-0eb3-4734-91ef-3641265ca7a9	7fcf9320-ecc6-44d9-9be7-916ed99da623
a4d78922-0eb3-4734-91ef-3641265ca7a9	33b49f63-532d-4949-a4fd-44bf6136abfa
1c116500-760f-455e-8fca-ae8b91bc1283	33b49f63-532d-4949-a4fd-44bf6136abfa
1d954a21-e52a-4013-9c4e-efff66b193ca	33b49f63-532d-4949-a4fd-44bf6136abfa
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	7fcf9320-ecc6-44d9-9be7-916ed99da623
20e91152-8e49-4799-aaea-7c3edda5c469	33b49f63-532d-4949-a4fd-44bf6136abfa
fbbf3e81-865c-44d3-a725-c0965a495450	7fcf9320-ecc6-44d9-9be7-916ed99da623
d0bafd93-0a89-408d-9dd2-1c37b8695578	33b49f63-532d-4949-a4fd-44bf6136abfa
9948198b-2f02-4073-9e74-b8d3277911ec	7fcf9320-ecc6-44d9-9be7-916ed99da623
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	33b49f63-532d-4949-a4fd-44bf6136abfa
65674e91-9346-4fb6-aa10-c945075b748c	7fcf9320-ecc6-44d9-9be7-916ed99da623
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	7fcf9320-ecc6-44d9-9be7-916ed99da623
9948198b-2f02-4073-9e74-b8d3277911ec	33b49f63-532d-4949-a4fd-44bf6136abfa
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	33b49f63-532d-4949-a4fd-44bf6136abfa
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	7fcf9320-ecc6-44d9-9be7-916ed99da623
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	7fcf9320-ecc6-44d9-9be7-916ed99da623
1d954a21-e52a-4013-9c4e-efff66b193ca	7fcf9320-ecc6-44d9-9be7-916ed99da623
529073a1-963b-4560-abf9-42b93fd0b6e4	33b49f63-532d-4949-a4fd-44bf6136abfa
1c116500-760f-455e-8fca-ae8b91bc1283	7fcf9320-ecc6-44d9-9be7-916ed99da623
529073a1-963b-4560-abf9-42b93fd0b6e4	7fcf9320-ecc6-44d9-9be7-916ed99da623
d0bafd93-0a89-408d-9dd2-1c37b8695578	7fcf9320-ecc6-44d9-9be7-916ed99da623
fbbf3e81-865c-44d3-a725-c0965a495450	fa39e7bd-f702-40f1-88b2-e93cc41dfbc2
9948198b-2f02-4073-9e74-b8d3277911ec	bd116d87-ea4a-44c1-be8d-83b383037c19
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	207ee903-af54-4f38-8006-a344b96d06f5
1c116500-760f-455e-8fca-ae8b91bc1283	1d18d26a-2aa5-48d9-9aa0-1cb91bf1cb2e
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	c3086ae9-d312-437b-b3e2-f9e8372ff5df
\.


--
-- Data for Name: paket; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.paket (nama, harga, resolusi_layar) FROM stdin;
Paket Dasar	99000	720p
Paket Lanjutan	139000	1080p
Paket Premium	189000	4K
\.


--
-- Data for Name: pemain; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.pemain (id) FROM stdin;
76757057-05f2-4ba6-84b6-5059549f1503
b163acc8-a635-4ba6-af4e-532dc2d4b7cb
aa7ace57-cc9b-4e25-8d21-c64e8d4b3def
d95d1a5b-eb9e-44e7-84e4-8811d0de5d0d
c383caa0-a63c-4b1f-b1ea-dbe5b79a8ec4
461bfd74-4a35-4f82-85f6-a39e24b2288e
7d1f76a0-edca-455f-b36f-8c1bdd4d1a2a
f697b629-07b1-4c80-9109-34f62c1acd42
33b49f63-532d-4949-a4fd-44bf6136abfa
a3d69458-7724-4a2f-a886-2e6187e3aa5a
67236e2b-3cdf-470d-b466-83d41ce8e5e4
5b6bcf57-16a7-4eba-916a-138526980d3f
bcf8e9e2-c232-41a7-ab7e-86eca4d48994
5c4e9b9f-2749-4463-9249-f171cb483462
74fe9e0e-0254-4fa1-bb70-3df4344df948
57075989-6ef5-4cd7-ad7f-c877cea44a31
f5f858b3-4748-452a-b91c-3ad8e1a9e33a
9ae4eb31-48d4-4f5c-83ba-d5f21e3c4f60
207ee903-af54-4f38-8006-a344b96d06f5
8c08f82d-3ad9-4286-b156-1cb716d73886
bbe842a4-1a2e-406b-a2ee-b86a93a519cc
f421e9b9-cfe8-4757-b49b-5602a4edb30c
51a2010c-d2f5-4607-83fa-eb7a2535d3f1
b9e66bb0-cfcf-4647-bc79-5ef2f757d482
d3b14dcb-5e7e-409c-8c48-8491eb69c6dc
a64fb9e1-1cb8-4a1f-91b0-16bb3bc72dcd
e2ebe193-4e09-4010-ad08-afe7cc586c29
f082f96a-53cb-4593-89b8-22f867ca0148
70ff176d-567d-428e-aac6-aed6c361ce9d
f438c3fb-8b68-4202-9eb3-07d68bea3c98
cf8e34d0-e72d-4146-b863-b1b3a1767574
d8759eae-5404-4f4b-97ee-784cba063251
8241c894-56df-4321-884e-2a3abcf0aa95
fdbc2031-4e6e-4aab-a5d1-d6becff3175b
ec481144-0fa0-4bb0-b28b-f7a12cff1d6d
5b33dc07-a290-4c5b-8f99-151345499c21
85185a98-4291-4465-b58f-eaedd87be085
1aa6af86-6aba-499b-999a-92385c8b3c81
1d18d26a-2aa5-48d9-9aa0-1cb91bf1cb2e
9c2e22d7-376f-447f-9ddb-a572ea8e5850
\.


--
-- Data for Name: pengguna; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.pengguna (username, password, id_tayangan, negara_asal) FROM stdin;
user1	a6ad7ecdaf3f37c9c636845eadae0907	1c116500-760f-455e-8fca-ae8b91bc1283	USA
user2	cf594f6a90b43390dc76e9f1c9e98fae	1c116500-760f-455e-8fca-ae8b91bc1283	UK
user3	e58deb545bcd8f677d3851ac94559794	65674e91-9346-4fb6-aa10-c945075b748c	Canada
user4	c1b5843510d89fc518ad711af5f9275c	529073a1-963b-4560-abf9-42b93fd0b6e4	France
user5	da2d60d5fec5d9f3706941036b7cc3bf	4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	Italy
user6	6bfc939fd832444bd5892ff8ceee56ed	9d1c6529-55f2-4bbc-a11b-2076ca872a0e	Japan
user7	e5348e915fe0f24d14644d24738013a6	1d954a21-e52a-4013-9c4e-efff66b193ca	Australia
user8	cc72e7e8c89e9e7656c4688838e04665	9948198b-2f02-4073-9e74-b8d3277911ec	Nepal
\.


--
-- Data for Name: penulis_skenario; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.penulis_skenario (id) FROM stdin;
207ee903-af54-4f38-8006-a344b96d06f5
f5f858b3-4748-452a-b91c-3ad8e1a9e33a
87f01601-aa28-4b35-b88c-c422c9674b9f
aa7ace57-cc9b-4e25-8d21-c64e8d4b3def
7fcf9320-ecc6-44d9-9be7-916ed99da623
9c2e22d7-376f-447f-9ddb-a572ea8e5850
71fdce5b-1b77-404c-91a1-2a5df9c5c182
76757057-05f2-4ba6-84b6-5059549f1503
5c4e9b9f-2749-4463-9249-f171cb483462
1d18d26a-2aa5-48d9-9aa0-1cb91bf1cb2e
1aa6af86-6aba-499b-999a-92385c8b3c81
7d1f76a0-edca-455f-b36f-8c1bdd4d1a2a
b163acc8-a635-4ba6-af4e-532dc2d4b7cb
b9e66bb0-cfcf-4647-bc79-5ef2f757d482
19f164fd-c879-43a0-847c-641ecbbdbdfe
a838ec05-d6a4-4268-8b9d-6e93dfe112a6
e2ebe193-4e09-4010-ad08-afe7cc586c29
bcf8e9e2-c232-41a7-ab7e-86eca4d48994
f96b2bff-05e0-49c1-8b8e-821de6b995dd
f421e9b9-cfe8-4757-b49b-5602a4edb30c
74fe9e0e-0254-4fa1-bb70-3df4344df948
c3086ae9-d312-437b-b3e2-f9e8372ff5df
d71cbee4-d4d6-455b-a547-83d4ee8ae85e
d8b709d1-23e9-4d9d-89ca-eef9f1c61530
d61e3087-86b4-4024-ae7b-466099556552
8c08f82d-3ad9-4286-b156-1cb716d73886
33b49f63-532d-4949-a4fd-44bf6136abfa
8eb39079-6022-4634-b71b-3505c469fd1e
bd116d87-ea4a-44c1-be8d-83b383037c19
fa39e7bd-f702-40f1-88b2-e93cc41dfbc2
\.


--
-- Data for Name: persetujuan; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.persetujuan (nama, id_tayangan, tanggal_persetujuan, durasi, biaya, tanggal_mulai_penayangan) FROM stdin;
Skyline Films	4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	2025-05-02	37	35226	2025-05-07
Phoenix Entertainment Group	529073a1-963b-4560-abf9-42b93fd0b6e4	2024-08-05	42	58729	2024-08-24
Golden Age Pictures	1c116500-760f-455e-8fca-ae8b91bc1283	2026-01-11	123	40249	2026-02-04
Sapphire Films	1c116500-760f-455e-8fca-ae8b91bc1283	2025-08-03	56	98125	2025-08-10
Sapphire Films	20e91152-8e49-4799-aaea-7c3edda5c469	2025-12-16	48	96936	2025-12-24
Global Media Productions	fbbf3e81-865c-44d3-a725-c0965a495450	2026-01-07	135	86359	2026-01-12
Vista Productions	1d954a21-e52a-4013-9c4e-efff66b193ca	2025-11-19	107	87365	2025-11-30
Sapphire Films	20e91152-8e49-4799-aaea-7c3edda5c469	2024-09-06	177	27042	2024-09-25
Terra Firma Studios	1d954a21-e52a-4013-9c4e-efff66b193ca	2024-05-28	36	98010	2024-06-11
Quantum Media	4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	2026-01-23	66	50055	2026-01-26
Starlight Studios	2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	2024-11-19	76	71940	2024-12-07
Golden Age Pictures	9d1c6529-55f2-4bbc-a11b-2076ca872a0e	2024-05-12	178	69674	2024-05-15
Quantum Media	fbbf3e81-865c-44d3-a725-c0965a495450	2025-02-18	113	36155	2025-03-07
Eclipse Entertainment	505e0cf7-d5aa-4dca-84e2-1cc72a152d38	2026-03-13	140	83279	2026-03-16
Silver Screen Partners	505e0cf7-d5aa-4dca-84e2-1cc72a152d38	2025-01-25	50	65254	2025-01-30
Eclipse Entertainment	505e0cf7-d5aa-4dca-84e2-1cc72a152d38	2025-03-21	146	64576	2025-03-23
Starlight Studios	fbbf3e81-865c-44d3-a725-c0965a495450	2025-03-04	85	95787	2025-03-10
Sapphire Films	2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	2025-02-27	96	45220	2025-03-25
Eclipse Entertainment	2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	2024-12-02	180	18298	2024-12-15
Silver Screen Partners	288d29bc-1569-4bf6-9353-81e4b39c3f13	2026-01-07	132	69288	2026-01-12
\.


--
-- Data for Name: perusahaan_produksi; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.perusahaan_produksi (nama) FROM stdin;
Global Media Productions
Skyline Films
Eclipse Entertainment
Starlight Studios
Dreamscape Cinema
Horizon Motion Pictures
Redwood Filmworks
Silver Screen Partners
Vista Productions
Sapphire Films
Phoenix Entertainment Group
Quantum Media
Neptune Film Co.
Terra Firma Studios
Golden Age Pictures
\.


--
-- Data for Name: riwayat_nonton; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.riwayat_nonton (id_tayangan, username, start_date_time, end_date_time) FROM stdin;
1d954a21-e52a-4013-9c4e-efff66b193ca	user1	2024-01-01 20:00:00	2024-01-01 22:00:00
529073a1-963b-4560-abf9-42b93fd0b6e4	user2	2024-01-02 20:00:00	2024-01-02 21:30:00
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	user3	2024-01-03 19:00:00	2024-01-03 20:45:00
65674e91-9346-4fb6-aa10-c945075b748c	user4	2024-01-04 18:00:00	2024-01-04 19:50:00
a4d78922-0eb3-4734-91ef-3641265ca7a9	user5	2024-01-05 20:30:00	2024-01-05 22:20:00
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	user6	2024-01-06 21:00:00	2024-01-06 23:00:00
1c116500-760f-455e-8fca-ae8b91bc1283	user7	2024-01-07 20:00:00	2024-01-07 21:30:00
9948198b-2f02-4073-9e74-b8d3277911ec	user8	2024-01-08 19:00:00	2024-01-08 20:00:00
20e91152-8e49-4799-aaea-7c3edda5c469	user1	2024-01-09 20:00:00	2024-01-09 22:00:00
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	user2	2024-01-10 20:30:00	2024-01-10 22:30:00
288d29bc-1569-4bf6-9353-81e4b39c3f13	user3	2024-01-11 21:00:00	2024-01-11 23:00:00
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	user4	2024-01-12 20:00:00	2024-01-12 21:30:00
fbbf3e81-865c-44d3-a725-c0965a495450	user5	2024-01-13 19:00:00	2024-01-13 20:45:00
d0bafd93-0a89-408d-9dd2-1c37b8695578	user6	2024-01-14 18:00:00	2024-01-14 19:50:00
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	user7	2024-01-15 20:30:00	2024-01-15 22:20:00
1d954a21-e52a-4013-9c4e-efff66b193ca	user8	2024-01-16 21:00:00	2024-01-16 23:00:00
529073a1-963b-4560-abf9-42b93fd0b6e4	user1	2024-01-17 20:00:00	2024-01-17 21:30:00
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	user2	2024-01-18 19:00:00	2024-01-18 20:00:00
65674e91-9346-4fb6-aa10-c945075b748c	user3	2024-01-19 20:00:00	2024-01-19 22:00:00
a4d78922-0eb3-4734-91ef-3641265ca7a9	user4	2024-01-20 20:30:00	2024-01-20 22:30:00
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	user5	2024-01-21 21:00:00	2024-01-21 23:00:00
1c116500-760f-455e-8fca-ae8b91bc1283	user6	2024-01-22 20:00:00	2024-01-22 21:30:00
9948198b-2f02-4073-9e74-b8d3277911ec	user7	2024-01-23 19:00:00	2024-01-23 20:45:00
20e91152-8e49-4799-aaea-7c3edda5c469	user8	2024-01-24 18:00:00	2024-01-24 19:50:00
\.


--
-- Data for Name: series; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.series (id_tayangan) FROM stdin;
9948198b-2f02-4073-9e74-b8d3277911ec
9d1c6529-55f2-4bbc-a11b-2076ca872a0e
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1
fbbf3e81-865c-44d3-a725-c0965a495450
d0bafd93-0a89-408d-9dd2-1c37b8695578
\.


--
-- Data for Name: sutradara; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.sutradara (id) FROM stdin;
9c2e22d7-376f-447f-9ddb-a572ea8e5850
70ff176d-567d-428e-aac6-aed6c361ce9d
e2ebe193-4e09-4010-ad08-afe7cc586c29
19f164fd-c879-43a0-847c-641ecbbdbdfe
1f7e308e-f02b-43dc-8da7-8d62a0715df1
461bfd74-4a35-4f82-85f6-a39e24b2288e
207ee903-af54-4f38-8006-a344b96d06f5
26f81171-2b61-4551-a379-e06522ff21d1
94ed05b4-e92c-4733-8445-78b8c650161e
5b33dc07-a290-4c5b-8f99-151345499c21
\.


--
-- Data for Name: tayangan; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.tayangan (id, judul, sinopsis, asal_negara, sinopsis_trailer, url_video_trailer, release_date_trailer, id_sutradara) FROM stdin;
1d954a21-e52a-4013-9c4e-efff66b193ca	Epic Adventure	A thrilling quest in uncharted territories.	USA	Watch our heroes embark on a monumental journey.	http://example.com/trailer1	2023-10-01	9c2e22d7-376f-447f-9ddb-a572ea8e5850
529073a1-963b-4560-abf9-42b93fd0b6e4	Mystery at the Manor	Solve the ancient secrets of an old family estate.	UK	Discover the hidden truths in this captivating mystery.	http://example.com/trailer2	2023-11-15	70ff176d-567d-428e-aac6-aed6c361ce9d
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	The Last Stand	A story of survival and resilience.	Canada	The fight for the last safe haven on Earth begins.	http://example.com/trailer3	2023-12-20	e2ebe193-4e09-4010-ad08-afe7cc586c29
65674e91-9346-4fb6-aa10-c945075b748c	Love in Paris	A romantic saga set against the backdrop of the city of lights.	France	Fall in love again with our charming leads.	http://example.com/trailer4	2024-01-25	19f164fd-c879-43a0-847c-641ecbbdbdfe
a4d78922-0eb3-4734-91ef-3641265ca7a9	Space Odyssey	Journey through the stars and beyond.	USA	The universe is vast, and its secrets are waiting.	http://example.com/trailer5	2024-02-10	1f7e308e-f02b-43dc-8da7-8d62a0715df1
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	The Grand Heist	A clever thief, a bigger score, the ultimate risk.	Italy	See the mastermind at work in the sneak peek.	http://example.com/trailer6	2024-03-22	461bfd74-4a35-4f82-85f6-a39e24b2288e
1c116500-760f-455e-8fca-ae8b91bc1283	Underwater Worlds	Explore the depths of the ocean and the creatures within.	Australia	Dive deep into the unknown.	http://example.com/trailer7	2024-04-18	207ee903-af54-4f38-8006-a344b96d06f5
9948198b-2f02-4073-9e74-b8d3277911ec	Mountain Trek	A perilous journey up the world’s deadliest peaks.	Nepal	Climb alongside our team in the trailer.	http://example.com/trailer8	2024-05-05	26f81171-2b61-4551-a379-e06522ff21d1
20e91152-8e49-4799-aaea-7c3edda5c469	Desert Winds	Uncover the mysteries hidden in the desert sands.	Egypt	The desert is harsh, but its stories are captivating.	http://example.com/trailer9	2024-06-01	94ed05b4-e92c-4733-8445-78b8c650161e
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	Cyber Future	What does the future hold when technology can think?	Japan	Explore a world governed by AI in this exclusive trailer.	http://example.com/trailer10	2024-06-20	5b33dc07-a290-4c5b-8f99-151345499c21
288d29bc-1569-4bf6-9353-81e4b39c3f13	Reign of the King	The true story of a monarch who shaped history.	England	Witness the rise of a king in this historical epic.	http://example.com/trailer11	2024-07-15	9c2e22d7-376f-447f-9ddb-a572ea8e5850
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	Art of the Heist	Every painting tells a story, some are worth stealing.	France	Delve into the art world’s dark side.	http://example.com/trailer12	2024-08-05	70ff176d-567d-428e-aac6-aed6c361ce9d
fbbf3e81-865c-44d3-a725-c0965a495450	Frozen Silence	The cold isn't the only thing to fear in this chilling horror.	Russia	Feel the terror in the icy trailer.	http://example.com/trailer13	2024-09-01	e2ebe193-4e09-4010-ad08-afe7cc586c29
d0bafd93-0a89-408d-9dd2-1c37b8695578	The Great Escape	A daring escape from the most secure prison.	USA	See the plan unfold in this gripping preview.	http://example.com/trailer14	2024-10-07	19f164fd-c879-43a0-847c-641ecbbdbdfe
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	Lost Civilization	Discover ancient civilizations and their untold stories.	Peru	Journey through forgotten ruins in this documentary.	http://example.com/trailer15	2024-11-20	1f7e308e-f02b-43dc-8da7-8d62a0715df1
\.


--
-- Data for Name: tayangan_memiliki_daftar_favorit; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.tayangan_memiliki_daftar_favorit (id_tayangan, "timestamp", username) FROM stdin;
1d954a21-e52a-4013-9c4e-efff66b193ca	2024-04-30 10:00:00	user1
529073a1-963b-4560-abf9-42b93fd0b6e4	2024-04-30 10:15:00	user2
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	2024-04-30 10:30:00	user3
65674e91-9346-4fb6-aa10-c945075b748c	2024-04-30 10:45:00	user4
a4d78922-0eb3-4734-91ef-3641265ca7a9	2024-04-30 11:00:00	user5
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	2024-04-30 11:15:00	user6
1c116500-760f-455e-8fca-ae8b91bc1283	2024-04-30 11:30:00	user7
9948198b-2f02-4073-9e74-b8d3277911ec	2024-04-30 11:45:00	user8
20e91152-8e49-4799-aaea-7c3edda5c469	2024-05-01 10:00:00	user1
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	2024-05-01 10:15:00	user2
288d29bc-1569-4bf6-9353-81e4b39c3f13	2024-05-01 10:30:00	user3
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	2024-05-01 10:45:00	user4
fbbf3e81-865c-44d3-a725-c0965a495450	2024-05-01 11:00:00	user5
d0bafd93-0a89-408d-9dd2-1c37b8695578	2024-05-01 11:15:00	user6
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	2024-05-01 11:30:00	user7
1d954a21-e52a-4013-9c4e-efff66b193ca	2024-05-01 11:45:00	user8
\.


--
-- Data for Name: tayangan_terunduh; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.tayangan_terunduh (id_tayangan, username, "timestamp") FROM stdin;
1d954a21-e52a-4013-9c4e-efff66b193ca	user1	2024-04-25 08:00:00
529073a1-963b-4560-abf9-42b93fd0b6e4	user2	2024-04-25 09:00:00
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	user3	2024-04-25 10:00:00
65674e91-9346-4fb6-aa10-c945075b748c	user4	2024-04-25 11:00:00
a4d78922-0eb3-4734-91ef-3641265ca7a9	user5	2024-04-25 12:00:00
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	user6	2024-04-25 13:00:00
1c116500-760f-455e-8fca-ae8b91bc1283	user7	2024-04-25 14:00:00
9948198b-2f02-4073-9e74-b8d3277911ec	user8	2024-04-25 15:00:00
20e91152-8e49-4799-aaea-7c3edda5c469	user1	2024-04-25 16:00:00
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	user2	2024-04-25 17:00:00
288d29bc-1569-4bf6-9353-81e4b39c3f13	user3	2024-04-25 18:00:00
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	user4	2024-04-25 19:00:00
fbbf3e81-865c-44d3-a725-c0965a495450	user5	2024-04-25 20:00:00
d0bafd93-0a89-408d-9dd2-1c37b8695578	user6	2024-04-25 21:00:00
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	user7	2024-04-25 22:00:00
1d954a21-e52a-4013-9c4e-efff66b193ca	user8	2024-04-26 08:00:00
529073a1-963b-4560-abf9-42b93fd0b6e4	user1	2024-04-26 09:00:00
c6bf4ead-bb8e-49ba-8fcd-adb622df2441	user2	2024-04-26 10:00:00
65674e91-9346-4fb6-aa10-c945075b748c	user3	2024-04-26 11:00:00
a4d78922-0eb3-4734-91ef-3641265ca7a9	user4	2024-04-26 12:00:00
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	user5	2024-04-26 13:00:00
1c116500-760f-455e-8fca-ae8b91bc1283	user6	2024-04-26 14:00:00
9948198b-2f02-4073-9e74-b8d3277911ec	user7	2024-04-26 15:00:00
20e91152-8e49-4799-aaea-7c3edda5c469	user8	2024-04-26 16:00:00
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	user1	2024-04-26 17:00:00
288d29bc-1569-4bf6-9353-81e4b39c3f13	user2	2024-04-26 18:00:00
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	user3	2024-04-26 19:00:00
fbbf3e81-865c-44d3-a725-c0965a495450	user4	2024-04-26 20:00:00
d0bafd93-0a89-408d-9dd2-1c37b8695578	user5	2024-04-26 21:00:00
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	user6	2024-04-26 22:00:00
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.transaction (username, start_date_time, end_date_time, nama_paket, metode_pembayaran, timestamp_pembayaran) FROM stdin;
user1	2024-04-27	2024-04-28	Paket Lanjutan	Credit Card	2024-04-27 01:00:00
user1	2024-04-28	2024-04-29	Paket Lanjutan	Credit Card	2024-04-28 01:00:00
user1	2024-04-29	2024-04-30	Paket Lanjutan	Bank Transfer	2024-04-29 01:00:00
user2	2024-04-27	2024-04-28	Paket Dasar	PayPal	2024-04-27 01:00:00
user2	2024-04-28	2024-04-29	Paket Dasar	Bank Transfer	2024-04-28 01:00:00
user2	2024-04-29	2024-04-30	Paket Dasar	Bank Transfer	2024-04-29 01:00:00
user3	2024-04-27	2024-04-28	Paket Dasar	Debit Card	2024-04-27 01:00:00
user3	2024-04-28	2024-04-29	Paket Lanjutan	PayPal	2024-04-28 01:00:00
user3	2024-04-29	2024-04-30	Paket Premium	Credit Card	2024-04-29 01:00:00
user4	2024-04-27	2024-04-28	Paket Lanjutan	PayPal	2024-04-27 01:00:00
user4	2024-04-28	2024-04-29	Paket Lanjutan	Bank Transfer	2024-04-28 01:00:00
user4	2024-04-29	2024-04-30	Paket Dasar	Debit Card	2024-04-29 01:00:00
user5	2024-04-27	2024-04-28	Paket Lanjutan	PayPal	2024-04-27 01:00:00
user5	2024-04-28	2024-04-29	Paket Dasar	PayPal	2024-04-28 01:00:00
user5	2024-04-29	2024-04-30	Paket Lanjutan	PayPal	2024-04-29 01:00:00
user6	2024-04-27	2024-04-28	Paket Lanjutan	Bank Transfer	2024-04-27 01:00:00
user6	2024-04-28	2024-04-29	Paket Lanjutan	Bank Transfer	2024-04-28 01:00:00
user6	2024-04-29	2024-04-30	Paket Dasar	Debit Card	2024-04-29 01:00:00
user7	2024-04-27	2024-04-28	Paket Dasar	PayPal	2024-04-27 01:00:00
user7	2024-04-28	2024-04-29	Paket Premium	Debit Card	2024-04-28 01:00:00
user7	2024-04-29	2024-04-30	Paket Dasar	Bank Transfer	2024-04-29 01:00:00
user8	2024-04-27	2024-04-28	Paket Lanjutan	Credit Card	2024-04-27 01:00:00
user8	2024-04-28	2024-04-29	Paket Lanjutan	Bank Transfer	2024-04-28 01:00:00
user8	2024-04-29	2024-04-30	Paket Lanjutan	Bank Transfer	2024-04-29 01:00:00
\.


--
-- Data for Name: ulasan; Type: TABLE DATA; Schema: pacilflix; Owner: michelle.angelica21
--

COPY pacilflix.ulasan (id_tayangan, username, "timestamp", rating, deskripsi) FROM stdin;
1c116500-760f-455e-8fca-ae8b91bc1283	user1	2024-04-30 15:00:00	4	Intriguing dive into unknown depths.
65674e91-9346-4fb6-aa10-c945075b748c	user3	2024-04-30 16:00:00	5	Beautiful and romantic story.
529073a1-963b-4560-abf9-42b93fd0b6e4	user4	2024-04-30 17:00:00	3	Engaging mystery but predictable at times.
4cd1c7b7-a7b1-4bbb-a937-4d15a65335a1	user5	2024-04-30 18:00:00	5	Thrilling heist with lots of twists.
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	user6	2024-04-30 19:00:00	4	Futuristic and thought-provoking.
1d954a21-e52a-4013-9c4e-efff66b193ca	user7	2024-04-30 20:00:00	5	A spectacular adventure that keeps you on the edge.
9948198b-2f02-4073-9e74-b8d3277911ec	user8	2024-04-30 21:00:00	2	A bit slow but the scenery is stunning.
fbbf3e81-865c-44d3-a725-c0965a495450	user1	2024-05-01 15:00:00	3	Chilling narrative, needed more depth.
d0bafd93-0a89-408d-9dd2-1c37b8695578	user2	2024-05-01 16:00:00	4	Edge of your seat escape drama.
2c63f30a-c09f-4ef7-8d78-f9c7a6e382bc	user3	2024-05-01 17:00:00	5	Fascinating look at lost civilizations.
20e91152-8e49-4799-aaea-7c3edda5c469	user4	2024-05-01 18:00:00	4	Desert Winds blew me away!
505e0cf7-d5aa-4dca-84e2-1cc72a152d38	user5	2024-05-01 19:00:00	3	Artistic but lacks a compelling narrative.
288d29bc-1569-4bf6-9353-81e4b39c3f13	user6	2024-05-01 20:00:00	5	Royal drama done right.
9d1c6529-55f2-4bbc-a11b-2076ca872a0e	user7	2024-05-01 21:00:00	3	Decent AI storyline, but not very original.
65674e91-9346-4fb6-aa10-c945075b748c	user8	2024-05-02 15:00:00	2	Expected more from the romantic scenes.
529073a1-963b-4560-abf9-42b93fd0b6e4	user1	2024-05-02 16:00:00	4	Great acting, pulled the mystery together well.
\.


--
-- Name: contributors contributors_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.contributors
    ADD CONSTRAINT contributors_pkey PRIMARY KEY (id);


--
-- Name: daftar_favorit daftar_favorit_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.daftar_favorit
    ADD CONSTRAINT daftar_favorit_pkey PRIMARY KEY ("timestamp", username);


--
-- Name: dukungan_perangkat dukungan_perangkat_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.dukungan_perangkat
    ADD CONSTRAINT dukungan_perangkat_pkey PRIMARY KEY (nama_paket, dukungan_perangkat);


--
-- Name: episode episode_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.episode
    ADD CONSTRAINT episode_pkey PRIMARY KEY (id_series, sub_judul);


--
-- Name: film film_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (id_tayangan);


--
-- Name: genre_tayangan genre_tayangan_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.genre_tayangan
    ADD CONSTRAINT genre_tayangan_pkey PRIMARY KEY (id_tayangan, genre);


--
-- Name: memainkan_tayangan memainkan_tayangan_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.memainkan_tayangan
    ADD CONSTRAINT memainkan_tayangan_pkey PRIMARY KEY (id_tayangan, id_pemain);


--
-- Name: menulis_skenario_tayangan menulis_skenario_tayangan_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.menulis_skenario_tayangan
    ADD CONSTRAINT menulis_skenario_tayangan_pkey PRIMARY KEY (id_tayangan, id_penulis_skenario);


--
-- Name: paket paket_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.paket
    ADD CONSTRAINT paket_pkey PRIMARY KEY (nama);


--
-- Name: pemain pemain_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.pemain
    ADD CONSTRAINT pemain_pkey PRIMARY KEY (id);


--
-- Name: pengguna pengguna_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.pengguna
    ADD CONSTRAINT pengguna_pkey PRIMARY KEY (username);


--
-- Name: penulis_skenario penulis_skenario_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.penulis_skenario
    ADD CONSTRAINT penulis_skenario_pkey PRIMARY KEY (id);


--
-- Name: persetujuan persetujuan_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.persetujuan
    ADD CONSTRAINT persetujuan_pkey PRIMARY KEY (nama, id_tayangan, tanggal_persetujuan);


--
-- Name: perusahaan_produksi perusahaan_produksi_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.perusahaan_produksi
    ADD CONSTRAINT perusahaan_produksi_pkey PRIMARY KEY (nama);


--
-- Name: riwayat_nonton riwayat_nonton_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.riwayat_nonton
    ADD CONSTRAINT riwayat_nonton_pkey PRIMARY KEY (username, start_date_time);


--
-- Name: series series_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.series
    ADD CONSTRAINT series_pkey PRIMARY KEY (id_tayangan);


--
-- Name: sutradara sutradara_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.sutradara
    ADD CONSTRAINT sutradara_pkey PRIMARY KEY (id);


--
-- Name: tayangan_memiliki_daftar_favorit tayangan_memiliki_daftar_favorit_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.tayangan_memiliki_daftar_favorit
    ADD CONSTRAINT tayangan_memiliki_daftar_favorit_pkey PRIMARY KEY (id_tayangan, "timestamp", username);


--
-- Name: tayangan tayangan_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.tayangan
    ADD CONSTRAINT tayangan_pkey PRIMARY KEY (id);


--
-- Name: tayangan_terunduh tayangan_terunduh_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.tayangan_terunduh
    ADD CONSTRAINT tayangan_terunduh_pkey PRIMARY KEY (id_tayangan, username, "timestamp");


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (username, start_date_time);


--
-- Name: ulasan ulasan_pkey; Type: CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.ulasan
    ADD CONSTRAINT ulasan_pkey PRIMARY KEY (username, "timestamp");


--
-- Name: daftar_favorit daftar_favorit_username_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.daftar_favorit
    ADD CONSTRAINT daftar_favorit_username_fkey FOREIGN KEY (username) REFERENCES pacilflix.pengguna(username);


--
-- Name: dukungan_perangkat dukungan_perangkat_nama_paket_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.dukungan_perangkat
    ADD CONSTRAINT dukungan_perangkat_nama_paket_fkey FOREIGN KEY (nama_paket) REFERENCES pacilflix.paket(nama);


--
-- Name: episode episode_id_series_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.episode
    ADD CONSTRAINT episode_id_series_fkey FOREIGN KEY (id_series) REFERENCES pacilflix.series(id_tayangan);


--
-- Name: film film_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.film
    ADD CONSTRAINT film_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: genre_tayangan genre_tayangan_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.genre_tayangan
    ADD CONSTRAINT genre_tayangan_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: memainkan_tayangan memainkan_tayangan_id_pemain_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.memainkan_tayangan
    ADD CONSTRAINT memainkan_tayangan_id_pemain_fkey FOREIGN KEY (id_pemain) REFERENCES pacilflix.pemain(id);


--
-- Name: memainkan_tayangan memainkan_tayangan_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.memainkan_tayangan
    ADD CONSTRAINT memainkan_tayangan_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: menulis_skenario_tayangan menulis_skenario_tayangan_id_penulis_skenario_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.menulis_skenario_tayangan
    ADD CONSTRAINT menulis_skenario_tayangan_id_penulis_skenario_fkey FOREIGN KEY (id_penulis_skenario) REFERENCES pacilflix.penulis_skenario(id);


--
-- Name: menulis_skenario_tayangan menulis_skenario_tayangan_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.menulis_skenario_tayangan
    ADD CONSTRAINT menulis_skenario_tayangan_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: pemain pemain_id_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.pemain
    ADD CONSTRAINT pemain_id_fkey FOREIGN KEY (id) REFERENCES pacilflix.contributors(id);


--
-- Name: pengguna pengguna_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.pengguna
    ADD CONSTRAINT pengguna_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: penulis_skenario penulis_skenario_id_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.penulis_skenario
    ADD CONSTRAINT penulis_skenario_id_fkey FOREIGN KEY (id) REFERENCES pacilflix.contributors(id);


--
-- Name: persetujuan persetujuan_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.persetujuan
    ADD CONSTRAINT persetujuan_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: persetujuan persetujuan_nama_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.persetujuan
    ADD CONSTRAINT persetujuan_nama_fkey FOREIGN KEY (nama) REFERENCES pacilflix.perusahaan_produksi(nama);


--
-- Name: riwayat_nonton riwayat_nonton_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.riwayat_nonton
    ADD CONSTRAINT riwayat_nonton_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: riwayat_nonton riwayat_nonton_username_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.riwayat_nonton
    ADD CONSTRAINT riwayat_nonton_username_fkey FOREIGN KEY (username) REFERENCES pacilflix.pengguna(username);


--
-- Name: series series_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.series
    ADD CONSTRAINT series_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: sutradara sutradara_id_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.sutradara
    ADD CONSTRAINT sutradara_id_fkey FOREIGN KEY (id) REFERENCES pacilflix.contributors(id);


--
-- Name: tayangan tayangan_id_sutradara_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.tayangan
    ADD CONSTRAINT tayangan_id_sutradara_fkey FOREIGN KEY (id_sutradara) REFERENCES pacilflix.sutradara(id);


--
-- Name: tayangan_memiliki_daftar_favorit tayangan_memiliki_daftar_favorit_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.tayangan_memiliki_daftar_favorit
    ADD CONSTRAINT tayangan_memiliki_daftar_favorit_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: tayangan_memiliki_daftar_favorit tayangan_memiliki_daftar_favorit_timestamp_username_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.tayangan_memiliki_daftar_favorit
    ADD CONSTRAINT tayangan_memiliki_daftar_favorit_timestamp_username_fkey FOREIGN KEY ("timestamp", username) REFERENCES pacilflix.daftar_favorit("timestamp", username);


--
-- Name: tayangan_terunduh tayangan_terunduh_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.tayangan_terunduh
    ADD CONSTRAINT tayangan_terunduh_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: tayangan_terunduh tayangan_terunduh_username_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.tayangan_terunduh
    ADD CONSTRAINT tayangan_terunduh_username_fkey FOREIGN KEY (username) REFERENCES pacilflix.pengguna(username);


--
-- Name: transaction transaction_nama_paket_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.transaction
    ADD CONSTRAINT transaction_nama_paket_fkey FOREIGN KEY (nama_paket) REFERENCES pacilflix.paket(nama);


--
-- Name: transaction transaction_username_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.transaction
    ADD CONSTRAINT transaction_username_fkey FOREIGN KEY (username) REFERENCES pacilflix.pengguna(username);


--
-- Name: ulasan ulasan_id_tayangan_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.ulasan
    ADD CONSTRAINT ulasan_id_tayangan_fkey FOREIGN KEY (id_tayangan) REFERENCES pacilflix.tayangan(id);


--
-- Name: ulasan ulasan_username_fkey; Type: FK CONSTRAINT; Schema: pacilflix; Owner: michelle.angelica21
--

ALTER TABLE ONLY pacilflix.ulasan
    ADD CONSTRAINT ulasan_username_fkey FOREIGN KEY (username) REFERENCES pacilflix.pengguna(username);


--
-- PostgreSQL database dump complete
--

