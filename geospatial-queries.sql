-- 1) What is the total area (km²) and population of Germany?
CREATE OR REPLACE VIEW pregunta_1 AS
SELECT 
  c."NAME_0" AS country,
  (SELECT SUM(population) FROM cities) AS population,
  ST_Area(ST_Transform(c.geom, 25832)) / 1000000 AS area_km2
FROM country c
WHERE c."NAME_0" = 'Germany';

-- 2a) Which states are the most populated?
CREATE OR REPLACE VIEW pregunta_2_a AS
SELECT 
  s."NAME_1" AS state,
  SUM(ci.population) AS population
FROM cities ci
JOIN districts d ON d."ID_3" = ci.id_3
JOIN states s ON s."ID_1" = d."ID_1"
GROUP BY s."NAME_1"
ORDER BY population DESC;

-- 2b) Which districts are the most populated?
CREATE OR REPLACE VIEW pregunta_2_b AS
SELECT 
  d."NAME_3" AS district,
  SUM(ci.population) AS population
FROM cities ci
JOIN districts d ON d."ID_3" = ci.id_3
GROUP BY d."NAME_3"
ORDER BY population DESC;

-- 3) How many kilometers of railway lines and roads does Germany have? And per km²?
CREATE OR REPLACE VIEW pregunta_3 AS
SELECT 
  c."NAME_0" AS country,
  ST_Area(ST_Transform(c.geom, 25832)) / 1000000 AS area_km2,
  (SELECT SUM(ST_Length(ST_Transform(geom, 25832))) / 1000 FROM rails) AS total_rails_km,
  (SELECT SUM(ST_Length(ST_Transform(geom, 25832))) / 1000 FROM roads) AS total_roads_km,
  (
    (SELECT SUM(ST_Length(ST_Transform(geom, 25832))) / 1000 FROM rails) /
    (ST_Area(ST_Transform(c.geom, 25832)) / 1000000)
  ) AS rails_km_per_km2,
  (
    (SELECT SUM(ST_Length(ST_Transform(geom, 25832))) / 1000 FROM roads) /
    (ST_Area(ST_Transform(c.geom, 25832)) / 1000000)
  ) AS roads_km_per_km2
FROM country c
WHERE c."NAME_0" = 'Germany';

-- 4) Which states have the greatest length of railway lines?
CREATE OR REPLACE VIEW pregunta_4 AS
SELECT 
  s."NAME_1" AS state,
  SUM(ST_Length(ST_Transform(r.geom, 25832))) / 1000 AS km
FROM rails r
JOIN states s ON ST_Contains(s.geom, r.geom)
GROUP BY s."NAME_1"
ORDER BY km DESC;

-- 5) Which states have the greatest length of roads?
CREATE OR REPLACE VIEW pregunta_5 AS
SELECT 
  s."NAME_1" AS state,
  SUM(ST_Length(ST_Transform(r.geom, 25832))) / 1000 AS km
FROM roads r
JOIN states s ON ST_Contains(s.geom, r.geom)
GROUP BY s."NAME_1"
ORDER BY km DESC;

-- 6) Which districts have the greatest length of railway lines?
CREATE OR REPLACE VIEW pregunta_6 AS 
SELECT 
  d."NAME_3" AS district,
  SUM(ST_Length(ST_Transform(r.geom, 25832))) / 1000 AS km
FROM rails r
LEFT JOIN districts d ON ST_Intersects(d.geom, r.geom)
GROUP BY d."NAME_3"
ORDER BY km DESC;

-- 7) Which districts have the greatest length of roads?
CREATE OR REPLACE VIEW pregunta_7 AS
SELECT 
  d."NAME_3" AS district,
  SUM(ST_Length(ST_Transform(r.geom, 25832))) / 1000 AS km
FROM roads r
JOIN districts d ON ST_Intersects(d.geom, r.geom)
GROUP BY d."NAME_3"
ORDER BY km DESC;

-- 8) How many kilometers of rivers and streams does Germany have?
CREATE OR REPLACE VIEW pregunta_8 AS
SELECT
  c."NAME_0" AS country,
  SUM(ST_Length(ST_Transform(w.geom, 25832))) / 1000 AS km_water_lines
FROM water_lines w
JOIN country c ON ST_Contains(c.geom, w.geom)
WHERE c."NAME_0" = 'Germany'
GROUP BY c."NAME_0";

-- 9) Which districts have the greatest length of rivers and streams?
CREATE OR REPLACE VIEW pregunta_9 AS
SELECT 
  d."NAME_3" AS district,
  SUM(ST_Length(ST_Transform(w.geom, 25832))) / 1000 AS km_water_lines
FROM water_lines w
LEFT JOIN districts d ON ST_Intersects(d.geom, w.geom)
GROUP BY d."NAME_3"
ORDER BY km_water_lines DESC;

-- 10) Which states have the greatest length of rivers and streams?
CREATE OR REPLACE VIEW pregunta_10 AS
SELECT 
  s."NAME_1" AS state,
  SUM(ST_Length(ST_Transform(w.geom, 25832))) / 1000 AS km_water_lines
FROM water_lines w
JOIN states s ON ST_Contains(s.geom, w.geom)
GROUP BY s."NAME_1"
ORDER BY km_water_lines DESC;
