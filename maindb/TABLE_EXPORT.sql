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
-- ame: lukup_category_id_seq; Type: SEQUENCE; Schema: public;

--o-- Data for Name: lukup_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lukup_category (id, id_parent_category, name, type, media_url, upload_date, update_date) FROM stdin;
1	\N	Electronics	\N	\N	2024-06-03 09:44:03.666835-04	\N
2	\N	Fashion	\N	\N	2024-06-03 09:44:03.666835-04	\N
3	\N	Home & Kitchen	\N	\N	2024-06-03 09:44:03.666835-04	\N
4	\N	Beauty & Personal Care	\N	\N	2024-06-03 09:44:03.666835-04	\N
5	\N	Books	\N	\N	2024-06-03 09:44:03.666835-04	\N
6	\N	Sports & Outdoors	\N	\N	2024-06-03 09:44:03.666835-04	\N
7	\N	Toys & Games	\N	\N	2024-06-03 09:44:03.666835-04	\N
8	\N	Automotive	\N	\N	2024-06-03 09:44:03.666835-04	\N
9	\N	Health & Wellness	\N	\N	2024-06-03 09:44:03.666835-04	\N
10	\N	Groceries	\N	\N	2024-06-03 09:44:03.666835-04	\N
11	\N	Baby Products	\N	\N	2024-06-03 09:44:03.666835-04	\N
12	\N	Office Supplies	\N	\N	2024-06-03 09:44:03.666835-04	\N
13	\N	Pet Supplies	\N	\N	2024-06-03 09:44:03.666835-04	\N
14	\N	Garden & Outdoor	\N	\N	2024-06-03 09:44:03.666835-04	\N
16	\N	Musical Instruments	\N	\N	2024-06-03 09:44:03.666835-04	\N
18	\N	Industrial & Scientific	\N	\N	2024-06-03 09:44:03.666835-04	\N
19	1	Mobile Phones	\N	\N	2024-06-03 09:58:32.052185-04	\N
20	1	Laptops	\N	\N	2024-06-03 09:58:32.052185-04	\N
21	1	Tablets	\N	\N	2024-06-03 09:58:32.052185-04	\N
22	1	Cameras	\N	\N	2024-06-03 09:58:32.052185-04	\N
23	1	Audio & Headphones	\N	\N	2024-06-03 09:58:32.052185-04	\N
24	1	Wearable Technology	\N	\N	2024-06-03 09:58:32.052185-04	\N
25	1	Smart Home Devices	\N	\N	2024-06-03 09:58:32.052185-04	\N
27	3	Furniture	\N	\N	2024-06-03 09:59:40.296351-04	\N
28	3	Home Decor	\N	\N	2024-06-03 09:59:40.296351-04	\N
29	3	Kitchen & Dining	\N	\N	2024-06-03 09:59:40.296351-04	\N
30	3	Appliances	\N	\N	2024-06-03 09:59:40.296351-04	\N
31	2	Men's Clothing	\N	\N	2024-06-03 10:09:41.835969-04	\N
32	2	Women's Clothing	\N	\N	2024-06-03 10:09:41.835969-04	\N
33	2	Footwear	\N	\N	2024-06-03 10:09:41.835969-04	\N
34	2	Accessories	\N	\N	2024-06-03 10:09:41.835969-04	\N
35	27	Living Room Furniture  	\N	\N	2024-06-03 10:12:49.026039-04	\N
36	27	Bedroom Furniture	\N	\N	2024-06-03 10:12:49.026039-04	\N
37	27	Office Furniture	\N	\N	2024-06-03 10:12:49.026039-04	\N
38	28	Wall Art  	\N	\N	2024-06-03 10:17:25.347975-04	\N
39	28	Clocks	\N	\N	2024-06-03 10:17:25.347975-04	\N
40	28	Rugs	\N	\N	2024-06-03 10:17:25.347975-04	\N
41	29	Cookware	\N	\N	2024-06-03 10:17:37.306756-04	\N
42	29	Tableware	\N	\N	2024-06-03 10:17:37.306756-04	\N
43	29	Kitchen Storage	\N	\N	2024-06-03 10:17:37.306756-04	\N
44	30	Refrigerators	\N	\N	2024-06-03 10:17:47.962759-04	\N
45	30	Ovens	\N	\N	2024-06-03 10:17:47.962759-04	\N
46	30	Dishwashers	\N	\N	2024-06-03 10:17:47.962759-04	\N
47	31	Shirts	\N	\N	2024-06-03 10:23:22.506846-04	\N
48	31	T-Shirts	\N	\N	2024-06-03 10:23:22.506846-04	\N
51	31	Suits	\N	\N	2024-06-03 10:23:22.506846-04	\N
52	32	Dresses	\N	\N	2024-06-03 10:23:33.835419-04	\N
53	32	Tops	\N	\N	2024-06-03 10:23:33.835419-04	\N
54	32	Skirts	\N	\N	2024-06-03 10:23:33.835419-04	\N
55	32	Jeans	\N	\N	2024-06-03 10:23:33.835419-04	\N
56	32	Jackets	\N	\N	2024-06-03 10:23:33.835419-04	\N
57	33	Men's Footwear	\N	\N	2024-06-03 10:23:53.065369-04	\N
58	33	Women's Footwear	\N	\N	2024-06-03 10:23:53.065369-04	\N
59	34	Bags	\N	\N	2024-06-03 10:24:06.369135-04	\N
60	34	Watches	\N	\N	2024-06-03 10:24:06.369135-04	\N
61	34	Jewelry	\N	\N	2024-06-03 10:24:06.369135-04	\N
62	4	Skincare	\N	\N	2024-06-03 10:30:55.173867-04	\N
63	4	Haircare	\N	\N	2024-06-03 10:30:55.173867-04	\N
64	4	Makeup	\N	\N	2024-06-03 10:30:55.173867-04	\N
65	4	Fragrances	\N	\N	2024-06-03 10:30:55.173867-04	\N
66	4	Personal Care Appliances	\N	\N	2024-06-03 10:30:55.173867-04	\N
67	5	Romance	\N	\N	2024-06-03 10:42:39.431036-04	\N
68	5	Mystery, Thriller & Suspense	\N	\N	2024-06-03 10:42:39.431036-04	\N
69	5	Science Fiction & Fantasy	\N	\N	2024-06-03 10:42:39.431036-04	\N
70	5	Horror	\N	\N	2024-06-03 10:42:39.431036-04	\N
71	5	Literary Fiction	\N	\N	2024-06-03 10:42:39.431036-04	\N
72	5	Biographies & Memoirs	\N	\N	2024-06-03 10:42:39.431036-04	\N
73	5	Self-Help	\N	\N	2024-06-03 10:42:39.431036-04	\N
74	5	History	\N	\N	2024-06-03 10:42:39.431036-04	\N
75	5	Science & Math	\N	\N	2024-06-03 10:42:39.431036-04	\N
76	5	Health, Fitness & Dieting	\N	\N	2024-06-03 10:42:39.431036-04	\N
77	5	Children's Books	\N	\N	2024-06-03 10:42:39.431036-04	\N
78	5	Cookbooks, Food & Wine	\N	\N	2024-06-03 10:42:39.431036-04	\N
79	5	Arts, Music & Photography	\N	\N	2024-06-03 10:42:39.431036-04	\N
80	5	Business & Investing	\N	\N	2024-06-03 10:42:39.431036-04	\N
81	5	Computers & Technology	\N	\N	2024-06-03 10:42:39.431036-04	\N
87	68	Mystery	\N	\N	2024-06-03 10:53:23.486778-04	\N
88	68	Thriller	\N	\N	2024-06-03 10:53:23.486778-04	\N
89	68	Suspense	\N	\N	2024-06-03 10:53:23.486778-04	\N
90	68	Crime Fiction	\N	\N	2024-06-03 10:53:23.486778-04	\N
91	68	Detective Fiction	\N	\N	2024-06-03 10:53:23.486778-04	\N
92	72	Biographies	\N	\N	2024-06-03 10:53:47.7093-04	\N
93	72	Memoirs	\N	\N	2024-06-03 10:53:47.7093-04	\N
94	72	Autobiographies	\N	\N	2024-06-03 10:53:47.7093-04	\N
95	72	Historical Biographies	\N	\N	2024-06-03 10:53:47.7093-04	\N
96	72	Celebrity Biographies	\N	\N	2024-06-03 10:53:47.7093-04	\N
97	75	Science	\N	\N	2024-06-03 10:53:57.806924-04	\N
98	75	Math	\N	\N	2024-06-03 10:53:57.806924-04	\N
99	75	Physics	\N	\N	2024-06-03 10:53:57.806924-04	\N
100	75	Biology	\N	\N	2024-06-03 10:53:57.806924-04	\N
101	75	Chemistry	\N	\N	2024-06-03 10:53:57.806924-04	\N
102	76	Health	\N	\N	2024-06-03 10:54:10.538312-04	\N
104	76	Dieting	\N	\N	2024-06-03 10:54:10.538312-04	\N
106	76	Wellness	\N	\N	2024-06-03 10:54:10.538312-04	\N
107	80	Business	\N	\N	2024-06-03 10:54:22.719158-04	\N
108	80	Investing	\N	\N	2024-06-03 10:54:22.719158-04	\N
109	80	Entrepreneurship	\N	\N	2024-06-03 10:54:22.719158-04	\N
110	80	Management	\N	\N	2024-06-03 10:54:22.719158-04	\N
111	80	Marketing	\N	\N	2024-06-03 10:54:22.719158-04	\N
112	81	Computers	\N	\N	2024-06-03 10:54:34.96446-04	\N
113	81	Technology	\N	\N	2024-06-03 10:54:34.96446-04	\N
114	81	Programming	\N	\N	2024-06-03 10:54:34.96446-04	\N
115	81	Web Development	\N	\N	2024-06-03 10:54:34.96446-04	\N
116	81	Databases	\N	\N	2024-06-03 10:54:34.96446-04	\N
117	6	Fitness Equipment	\N	\N	2024-06-03 11:06:08.782542-04	\N
118	6	Outdoor Recreation	\N	\N	2024-06-03 11:06:08.782542-04	\N
119	6	Team Sports	\N	\N	2024-06-03 11:06:08.782542-04	\N
120	6	Water Sports	\N	\N	2024-06-03 11:06:08.782542-04	\N
121	6	Winter Sports	\N	\N	2024-06-03 11:06:08.782542-04	\N
122	6	Hunting & Shooting	\N	\N	2024-06-03 11:06:08.782542-04	\N
123	6	Tennis	\N	\N	2024-06-03 11:06:08.782542-04	\N
124	6	Golf	\N	\N	2024-06-03 11:06:08.782542-04	\N
125	6	Yoga	\N	\N	2024-06-03 11:06:08.782542-04	\N
126	117	Cardio Training	\N	\N	2024-06-03 11:08:02.858864-04	\N
127	117	Strength Training	\N	\N	2024-06-03 11:08:02.858864-04	\N
128	126	Treadmills	\N	\N	2024-06-03 11:09:51.411544-04	\N
129	126	Bikes	\N	\N	2024-06-03 11:09:51.411544-04	\N
130	126	Ellipticals	\N	\N	2024-06-03 11:09:51.411544-04	\N
131	126	Rowing Machines	\N	\N	2024-06-03 11:09:51.411544-04	\N
136	127	Dumbbells	\N	\N	2024-06-03 11:16:00.692627-04	\N
137	127	Kettlebells	\N	\N	2024-06-03 11:16:00.692627-04	\N
138	127	Weight Benches	\N	\N	2024-06-03 11:16:00.692627-04	\N
139	127	Home Gyms	\N	\N	2024-06-03 11:16:00.692627-04	\N
140	118	Camping & Hiking	\N	\N	2024-06-03 11:16:21.733145-04	\N
141	118	Cycling	\N	\N	2024-06-03 11:16:21.733145-04	\N
142	118	Fishing	\N	\N	2024-06-03 11:16:21.733145-04	\N
143	140	Tents	\N	\N	2024-06-03 11:37:25.923589-04	\N
144	140	Sleeping Bags	\N	\N	2024-06-03 11:37:25.923589-04	\N
145	140	Backpacks	\N	\N	2024-06-03 11:37:25.923589-04	\N
146	140	Hiking Boots	\N	\N	2024-06-03 11:37:25.923589-04	\N
147	141	Bicycles	\N	\N	2024-06-03 11:39:55.519717-04	\N
148	141	Helmets	\N	\N	2024-06-03 11:39:55.519717-04	\N
149	141	Bike Accessories	\N	\N	2024-06-03 11:39:55.519717-04	\N
150	141	Cycling Apparel	\N	\N	2024-06-03 11:39:55.519717-04	\N
151	142	Fishing Rods	\N	\N	2024-06-03 11:40:06.987379-04	\N
152	142	Fishing Reels	\N	\N	2024-06-03 11:40:06.987379-04	\N
153	142	Tackle Boxes	\N	\N	2024-06-03 11:40:06.987379-04	\N
154	142	Fishing Apparel	\N	\N	2024-06-03 11:40:06.987379-04	\N
155	119	Soccer	\N	\N	2024-06-03 11:43:04.026598-04	\N
156	119	Basketball	\N	\N	2024-06-03 11:43:04.026598-04	\N
157	119	Baseball & Softbal	\N	\N	2024-06-03 11:43:04.026598-04	\N
158	155	Soccer Balls	\N	\N	2024-06-03 11:49:10.708703-04	\N
159	155	Soccer Cleats	\N	\N	2024-06-03 11:49:10.708703-04	\N
160	155	Goals & Nets	\N	\N	2024-06-03 11:49:10.708703-04	\N
161	155	Shin Guards	\N	\N	2024-06-03 11:49:10.708703-04	\N
162	156	basketballs	\N	\N	2024-06-03 11:50:00.672358-04	\N
163	156	hoops	\N	\N	2024-06-03 11:50:00.672358-04	\N
164	156	shoes	\N	\N	2024-06-03 11:50:00.672358-04	\N
165	156	apparel	\N	\N	2024-06-03 11:50:00.672358-04	\N
166	157	bats	\N	\N	2024-06-03 11:50:13.100206-04	\N
167	157	Gloves & Mitts	\N	\N	2024-06-03 11:50:13.100206-04	\N
168	157	Balls	\N	\N	2024-06-03 11:50:13.100206-04	\N
169	157	Protective Gear	\N	\N	2024-06-03 11:50:13.100206-04	\N
170	7	Action Figures & Playsets	\N	\N	2024-06-03 12:43:25.563342-04	\N
171	7	Building Toys	\N	\N	2024-06-03 12:43:25.563342-04	\N
172	7	Dolls & Accessories	\N	\N	2024-06-03 12:43:25.563342-04	\N
173	7	Educational Toys	\N	\N	2024-06-03 12:43:25.563342-04	\N
174	7	Outdoor Play	\N	\N	2024-06-03 12:43:25.563342-04	\N
175	7	Games & Puzzles	\N	\N	2024-06-03 12:43:25.563342-04	\N
176	7	Stuffed Animals & Plush Toys	\N	\N	2024-06-03 12:43:25.563342-04	\N
177	7	Arts & Crafts	\N	\N	2024-06-03 12:43:25.563342-04	\N
178	7	Vehicles & Remote Control	\N	\N	2024-06-03 12:43:25.563342-04	\N
179	170	Superheroes	\N	\N	2024-06-03 12:45:12.123582-04	\N
180	170	TV & Movie Characters	\N	\N	2024-06-03 12:45:12.123582-04	\N
181	170	Playsets	\N	\N	2024-06-03 12:45:12.123582-04	\N
182	8	Passenger Vehicles	\N	\N	2024-06-03 13:01:22.342479-04	\N
183	8	Trucks	\N	\N	2024-06-03 13:01:22.342479-04	\N
184	8	Buses	\N	\N	2024-06-03 13:01:22.342479-04	\N
185	8	Vans	\N	\N	2024-06-03 13:01:22.342479-04	\N
186	8	Two-Wheelers	\N	\N	2024-06-03 13:01:22.342479-04	\N
187	8	Electric Vehicles	\N	\N	2024-06-03 13:01:22.342479-04	\N
188	8	Parts and Components	\N	\N	2024-06-03 13:01:22.342479-04	\N
189	182	Sedans	\N	\N	2024-06-03 13:02:12.924192-04	\N
190	182	Hatchbacks	\N	\N	2024-06-03 13:02:12.924192-04	\N
191	182	SUVs	\N	\N	2024-06-03 13:02:12.924192-04	\N
192	182	Coupes	\N	\N	2024-06-03 13:02:12.924192-04	\N
193	182	Convertibles	\N	\N	2024-06-03 13:02:12.924192-04	\N
194	182	Station Wagons	\N	\N	2024-06-03 13:02:12.924192-04	\N
195	182	Crossovers	\N	\N	2024-06-03 13:02:12.924192-04	\N
196	183	Light Trucks	\N	\N	2024-06-03 13:05:29.359937-04	\N
197	183	Medium Trucks	\N	\N	2024-06-03 13:05:29.359937-04	\N
198	183	Heavy Trucks	\N	\N	2024-06-03 13:05:29.359937-04	\N
199	184	City Buses	\N	\N	2024-06-03 13:05:38.354117-04	\N
200	184	Coaches	\N	\N	2024-06-03 13:05:38.354117-04	\N
201	184	School Buses	\N	\N	2024-06-03 13:05:38.354117-04	\N
202	185	Cargo Vans	\N	\N	2024-06-03 13:05:55.951685-04	\N
203	185	Passenger Vans	\N	\N	2024-06-03 13:05:55.951685-04	\N
204	8	Pickups	\N	\N	2024-06-03 13:06:32.286876-04	\N
205	8	 Motorsports	\N	\N	2024-06-03 13:08:01.738527-04	\N
206	188	Engine Components	\N	\N	2024-06-04 01:50:27.421982-04	\N
207	188	Electrical & Electronic Systems	\N	\N	2024-06-04 01:50:27.421982-04	\N
208	188	Chassis and Suspension	\N	\N	2024-06-04 01:50:27.421982-04	\N
209	188	Transmission Systems	\N	\N	2024-06-04 01:50:27.421982-04	\N
210	188	Braking Systems	\N	\N	2024-06-04 01:50:27.421982-04	\N
211	185	Exhaust Systems	\N	\N	2024-06-04 01:50:27.421982-04	\N
212	206	Cylinders	\N	\N	2024-06-04 02:00:07.679672-04	\N
213	206	Pistons	\N	\N	2024-06-04 02:00:07.679672-04	\N
214	206	Crankshafts	\N	\N	2024-06-04 02:00:07.679672-04	\N
215	206	Camshafts	\N	\N	2024-06-04 02:00:07.679672-04	\N
216	206	Turbochargers	\N	\N	2024-06-04 02:00:07.679672-04	\N
217	207	Batteries	\N	\N	2024-06-04 02:00:21.027636-04	\N
218	207	Alternators	\N	\N	2024-06-04 02:00:21.027636-04	\N
219	207	Starters	\N	\N	2024-06-04 02:00:21.027636-04	\N
220	207	Electronic Control Units (ECUs)	\N	\N	2024-06-04 02:00:21.027636-04	\N
221	207	Infotainment Systems	\N	\N	2024-06-04 02:00:21.027636-04	\N
222	208	Shock Absorbers	\N	\N	2024-06-04 02:00:33.181201-04	\N
223	208	Struts	\N	\N	2024-06-04 02:00:33.181201-04	\N
224	208	Springs	\N	\N	2024-06-04 02:00:33.181201-04	\N
225	208	Control Arms	\N	\N	2024-06-04 02:00:33.181201-04	\N
226	209	Gearboxes	\N	\N	2024-06-04 02:00:44.016728-04	\N
227	209	Clutches	\N	\N	2024-06-04 02:00:44.016728-04	\N
228	209	Differentials	\N	\N	2024-06-04 02:00:44.016728-04	\N
229	209	Driveshafts	\N	\N	2024-06-04 02:00:44.016728-04	\N
231	210	Brake Pads	\N	\N	2024-06-04 02:00:53.163972-04	\N
232	210	Brake Discs	\N	\N	2024-06-04 02:00:53.163972-04	\N
233	210	Anti-lock Braking Systems (ABS)	\N	\N	2024-06-04 02:00:53.163972-04	\N
234	9	Physical Health	\N	\N	2024-06-04 02:07:10.204494-04	\N
235	9	Mental Health	\N	\N	2024-06-04 02:07:10.204494-04	\N
236	9	Emotional Wellness	\N	\N	2024-06-04 02:07:10.204494-04	\N
237	9	Holistic Health	\N	\N	2024-06-04 02:07:10.204494-04	\N
238	9	Reproductive Health	\N	\N	2024-06-04 02:07:10.204494-04	\N
239	9	Environmental Health	\N	\N	2024-06-04 02:07:10.204494-04	\N
240	9	Senior Health	\N	\N	2024-06-04 02:07:10.204494-04	\N
241	9	Pediatric Health	\N	\N	2024-06-04 02:07:10.204494-04	\N
242	234	Fitness	\N	\N	2024-06-04 02:09:58.442824-04	\N
243	234	Nutrition	\N	\N	2024-06-04 02:09:58.442824-04	\N
244	234	Weight Management	\N	\N	2024-06-04 02:09:58.442824-04	\N
245	234	Preventive Health	\N	\N	2024-06-04 02:09:58.442824-04	\N
246	234	Chronic Disease Management	\N	\N	2024-06-04 02:09:58.442824-04	\N
250	242	Exercise Programs	\N	\N	2024-06-04 02:20:17.765303-04	\N
251	242	Personal Training	\N	\N	2024-06-04 02:20:17.765303-04	\N
252	242	Group Fitness Classes	\N	\N	2024-06-04 02:20:17.765303-04	\N
253	242	Home Workouts	\N	\N	2024-06-04 02:20:17.765303-04	\N
254	243	Diet Plans	\N	\N	2024-06-04 02:20:54.533138-04	\N
255	243	Supplements	\N	\N	2024-06-04 02:20:54.533138-04	\N
256	243	Healthy Recipes	\N	\N	2024-06-04 02:20:54.533138-04	\N
257	243	Nutrition Counseling	\N	\N	2024-06-04 02:20:54.533138-04	\N
258	244	Weight Loss Programs	\N	\N	2024-06-04 02:22:07.248944-04	\N
259	244	Weight Gain Strategies	\N	\N	2024-06-04 02:22:07.248944-04	\N
260	244	Bariatric Surgery	\N	\N	2024-06-04 02:22:07.248944-04	\N
261	245	Vaccinations	\N	\N	2024-06-04 02:22:32.157204-04	\N
262	245	Regular Check-ups	\N	\N	2024-06-04 02:22:32.157204-04	\N
263	245	Screenings and Tests	\N	\N	2024-06-04 02:22:32.157204-04	\N
264	246	Diabetes Management	\N	\N	2024-06-04 02:22:57.863256-04	\N
265	246	Hypertension Management	\N	\N	2024-06-04 02:22:57.863256-04	\N
266	246	Heart Disease Care	\N	\N	2024-06-04 02:22:57.863256-04	\N
267	235	Therapy and Counseling	\N	\N	2024-06-04 02:26:03.041093-04	\N
268	235	Mental Health Disorders	\N	\N	2024-06-04 02:26:03.041093-04	\N
269	235	Substance Abuse	\N	\N	2024-06-04 02:26:03.041093-04	\N
270	235	Stress Management	\N	\N	2024-06-04 02:26:03.041093-04	\N
271	267	Individual Therapy	\N	\N	2024-06-04 02:31:49.632112-04	\N
272	267	Group Therapy	\N	\N	2024-06-04 02:31:49.632112-04	\N
273	267	Family Counseling	\N	\N	2024-06-04 02:31:49.632112-04	\N
274	268	Depression	\N	\N	2024-06-04 02:32:01.3855-04	\N
275	268	Anxiety	\N	\N	2024-06-04 02:32:01.3855-04	\N
276	268	Bipolar Disorder	\N	\N	2024-06-04 02:32:01.3855-04	\N
277	269	Addiction Treatment	\N	\N	2024-06-04 02:32:13.728141-04	\N
278	269	Rehabilitation Programs	\N	\N	2024-06-04 02:32:13.728141-04	\N
279	269	Support Groups	\N	\N	2024-06-04 02:32:13.728141-04	\N
280	270	Meditation	\N	\N	2024-06-04 02:32:24.174375-04	\N
281	270	Mindfulness	\N	\N	2024-06-04 02:32:24.174375-04	\N
282	270	Relaxation Techniques	\N	\N	2024-06-04 02:32:24.174375-04	\N
283	236	Self-Care	\N	\N	2024-06-04 02:35:05.473594-04	\N
284	236	Relationship Health	\N	\N	2024-06-04 02:35:05.473594-04	\N
285	236	Life Coaching	\N	\N	2024-06-04 02:35:05.473594-04	\N
286	283	Journaling	\N	\N	2024-06-04 02:36:56.72972-04	\N
287	283	Hobbies and Interests	\N	\N	2024-06-04 02:36:56.72972-04	\N
288	283	Personal Development	\N	\N	2024-06-04 02:36:56.72972-04	\N
289	284	Couples Counseling	\N	\N	2024-06-04 02:39:01.215294-04	\N
290	284	Communication Skills	\N	\N	2024-06-04 02:39:01.215294-04	\N
291	284	Conflict Resolution	\N	\N	2024-06-04 02:39:01.215294-04	\N
292	285	Goal Setting	\N	\N	2024-06-04 02:39:14.028257-04	\N
293	285	Motivation Techniques	\N	\N	2024-06-04 02:39:14.028257-04	\N
294	285	Career Counseling	\N	\N	2024-06-04 02:39:14.028257-04	\N
295	237	Alternative Medicine	\N	\N	2024-06-04 02:42:40.087465-04	\N
296	237	Complementary Therapies	\N	\N	2024-06-04 02:42:40.087465-04	\N
297	237	Natural Remedies	\N	\N	2024-06-04 02:42:40.087465-04	\N
298	295	Acupuncture	\N	\N	2024-06-04 02:47:06.148512-04	\N
299	295	Chiropractic Care	\N	\N	2024-06-04 02:47:06.148512-04	\N
300	295	Herbal Medicine	\N	\N	2024-06-04 02:47:06.148512-04	\N
301	296	Massage Therapy	\N	\N	2024-06-04 02:47:15.55054-04	\N
302	296	Aromatherapy	\N	\N	2024-06-04 02:47:15.55054-04	\N
303	296	Reiki	\N	\N	2024-06-04 02:47:15.55054-04	\N
304	297	Homeopathy	\N	\N	2024-06-04 02:47:26.358487-04	\N
305	297	Naturopathy	\N	\N	2024-06-04 02:47:26.358487-04	\N
306	297	Natural herbs	\N	\N	2024-06-04 02:47:26.358487-04	\N
310	238	Women’s Health	\N	\N	2024-06-04 02:55:07.122784-04	\N
311	238	Men’s Health	\N	\N	2024-06-04 02:55:07.122784-04	\N
312	238	Sexual Health	\N	\N	2024-06-04 02:55:07.122784-04	\N
313	239	Workplace Wellness Programs	\N	\N	2024-06-04 02:55:17.77011-04	\N
314	239	Occupational Therapy	\N	\N	2024-06-04 02:55:17.77011-04	\N
315	240	Community Health	\N	\N	2024-06-04 02:55:29.256968-04	\N
316	240	Global Health	\N	\N	2024-06-04 02:55:29.256968-04	\N
317	241	Healthy Living Environments	\N	\N	2024-06-04 02:55:39.310147-04	\N
318	241	Sustainable Living	\N	\N	2024-06-04 02:55:39.310147-04	\N
319	10	Fresh Produce	\N	\N	2024-06-04 03:15:15.843876-04	\N
320	10	Dairy & Eggs	\N	\N	2024-06-04 03:15:15.843876-04	\N
321	10	Meat & Seafood	\N	\N	2024-06-04 03:15:15.843876-04	\N
322	10	Bakery	\N	\N	2024-06-04 03:15:15.843876-04	\N
323	10	Beverages	\N	\N	2024-06-04 03:15:15.843876-04	\N
324	10	Pantry Staples	\N	\N	2024-06-04 03:15:15.843876-04	\N
325	10	Snacks & Confectionery	\N	\N	2024-06-04 03:15:15.843876-04	\N
326	10	Frozen Foods	\N	\N	2024-06-04 03:15:15.843876-04	\N
327	10	Condiments & Sauces	\N	\N	2024-06-04 03:15:15.843876-04	\N
328	10	Health Foods	\N	\N	2024-06-04 03:15:15.843876-04	\N
329	319	Fruits	\N	\N	2024-06-04 03:17:33.667267-04	\N
330	319	Vegetables	\N	\N	2024-06-04 03:17:33.667267-04	\N
331	329	Citrus (Oranges, Lemons, Limes)	\N	\N	2024-06-04 03:19:19.048489-04	\N
332	329	Berries (Strawberries, Blueberries, Raspberries)	\N	\N	2024-06-04 03:19:19.048489-04	\N
333	329	Tropical (Bananas, Pineapples, Mangoes)	\N	\N	2024-06-04 03:19:19.048489-04	\N
334	329	Stone Fruits (Peaches, Plums, Cherries)	\N	\N	2024-06-04 03:19:19.048489-04	\N
335	329	Melons (Watermelon, Cantaloupe, Honeydew)	\N	\N	2024-06-04 03:19:19.048489-04	\N
336	329	Apples & Pears	\N	\N	2024-06-04 03:19:19.048489-04	\N
337	329	Grapes	\N	\N	2024-06-04 03:19:19.048489-04	\N
338	329	Avocados	\N	\N	2024-06-04 03:19:19.048489-04	\N
339	330	Leafy Greens (Spinach, Kale, Lettuce)	\N	\N	2024-06-04 03:21:11.028527-04	\N
340	330	Root Vegetables (Carrots, Potatoes, Beets)	\N	\N	2024-06-04 03:21:11.028527-04	\N
341	330	Cruciferous (Broccoli, Cauliflower, Cabbage)	\N	\N	2024-06-04 03:21:11.028527-04	\N
342	330	Alliums (Onions, Garlic, Leeks)	\N	\N	2024-06-04 03:21:11.028527-04	\N
343	330	Peppers (Bell Peppers, Hot Peppers)	\N	\N	2024-06-04 03:21:11.028527-04	\N
344	330	Squash & Zucchini	\N	\N	2024-06-04 03:21:11.028527-04	\N
345	330	Mushrooms	\N	\N	2024-06-04 03:21:11.028527-04	\N
346	330	Tomatoes	\N	\N	2024-06-04 03:21:11.028527-04	\N
351	320	Milk & Cream	\N	\N	2024-06-04 03:26:18.727074-04	\N
352	320	Yogurt	\N	\N	2024-06-04 03:26:18.727074-04	\N
353	320	Butter & Margarine	\N	\N	2024-06-04 03:26:18.727074-04	\N
354	320	Eggs	\N	\N	2024-06-04 03:26:18.727074-04	\N
355	321	Beef	\N	\N	2024-06-04 03:26:44.708485-04	\N
356	321	Pork	\N	\N	2024-06-04 03:26:44.708485-04	\N
357	321	Poultry	\N	\N	2024-06-04 03:26:44.708485-04	\N
358	321	Deli Meats	\N	\N	2024-06-04 03:26:44.708485-04	\N
359	321	Seafood	\N	\N	2024-06-04 03:26:44.708485-04	\N
364	322	Bread	\N	\N	2024-06-04 03:29:52.996185-04	\N
365	322	Pastries	\N	\N	2024-06-04 03:29:52.996185-04	\N
366	322	Cakes & Pies	\N	\N	2024-06-04 03:29:52.996185-04	\N
367	322	Cookies & Biscuits	\N	\N	2024-06-04 03:29:52.996185-04	\N
368	364	White Bread	\N	\N	2024-06-04 03:31:56.508942-04	\N
369	364	Whole Wheat Bread	\N	\N	2024-06-04 03:31:56.508942-04	\N
370	364	Sourdough	\N	\N	2024-06-04 03:31:56.508942-04	\N
371	364	Baguettes	\N	\N	2024-06-04 03:31:56.508942-04	\N
372	365	Croissants	\N	\N	2024-06-04 03:36:04.574463-04	\N
373	365	Muffins	\N	\N	2024-06-04 03:36:04.574463-04	\N
374	365	Donuts	\N	\N	2024-06-04 03:36:04.574463-04	\N
375	366	Birthday Cakes	\N	\N	2024-06-04 03:36:33.558801-04	\N
376	366	Cheesecakes	\N	\N	2024-06-04 03:36:33.558801-04	\N
377	366	Fruit Pies	\N	\N	2024-06-04 03:36:33.558801-04	\N
378	367	Chocolate Chip Cookies	\N	\N	2024-06-04 03:36:44.258614-04	\N
379	367	Shortbread	\N	\N	2024-06-04 03:36:44.258614-04	\N
380	367	Crackers	\N	\N	2024-06-04 03:36:44.258614-04	\N
381	323	Water	\N	\N	2024-06-04 03:40:26.172788-04	\N
382	323	Juices	\N	\N	2024-06-04 03:40:26.172788-04	\N
383	323	Soft Drinks	\N	\N	2024-06-04 03:40:26.172788-04	\N
384	323	Alcoholic Beverages	\N	\N	2024-06-04 03:40:26.172788-04	\N
385	323	Tea & Coffee	\N	\N	2024-06-04 03:40:26.172788-04	\N
386	384	Beer	\N	\N	2024-06-04 04:05:38.965542-04	\N
387	384	Wine	\N	\N	2024-06-04 04:05:38.965542-04	\N
388	384	(Whiskey, Vodka, Rum)	\N	\N	2024-06-04 04:05:38.965542-04	\N
389	324	Grains & Rice	\N	\N	2024-06-04 04:10:17.718674-04	\N
390	324	Pasta & Noodles	\N	\N	2024-06-04 04:10:17.718674-04	\N
391	324	Canned Goods	\N	\N	2024-06-04 04:10:17.718674-04	\N
392	324	Baking Supplies	\N	\N	2024-06-04 04:10:17.718674-04	\N
393	324	Spices & Seasonings	\N	\N	2024-06-04 04:10:17.718674-04	\N
394	324	Oils & Vinegars	\N	\N	2024-06-04 04:10:17.718674-04	\N
\.
--
-- Name: lukup_category unique_category_name; Type: CONSTRAINT; Schema: public; Owner: postgres


--
-- Name: idx_categories_name_lukup; Type: INDEX; Schema: public; Owner: postgres
--

--
-- Name: lukup_category lukup_category_id_parent_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

--
-- Name: TABLE lukup_category; Type: ACL; Schema: public; Owner: postgres


--
-- PostgreSQL database dump complete
--

