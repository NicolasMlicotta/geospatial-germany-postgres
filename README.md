# Geospatial Data Analysis of Germany Using PostgreSQL/PostGIS

This repository contains a set of SQL queries that demonstrate how to perform geospatial analysis on Germany’s administrative boundaries, transportation networks, and hydrology layers using PostgreSQL with the PostGIS extension. The emphasis here is on exploring spatial functions—such as computing areas, lengths, containment, and proximity—directly within a PostGIS-enabled database.

---

## 🌐 Data Sources

All spatial layers referenced by the SQL queries originate from DIVA-GIS (https://diva-gis.org/data.html). Specifically:

1. **Administrative Boundaries**  
   - **Country polygons** (level 0)  
   - **State/region polygons** (level 1)  
   - **Sub-region polygons** (level 2)  
   - **District polygons** (level 3)

2. **Transportation Networks**  
   - **Roads (carreteras)** shapefiles  
   - **Railways (vías de trenes)** shapefiles

3. **Hydrology**  
   - **Rivers and streams** (‘water_lines’) shapefiles

Additionally, a city-level population dataset (cities with population > 1,000) was sourced from OpenDataSoft (https://public.opendatasoft.com/). This CSV provides each city’s name, population, and geographic coordinates, which are used to calculate population aggregates by state and district.

Examples:
![image](https://github.com/user-attachments/assets/a4149f50-b818-4713-9b85-09a65bc38e98)

![image](https://github.com/user-attachments/assets/5c49ea43-5e93-43e8-ae5a-a2ef2accaf0e)

![image](https://github.com/user-attachments/assets/bc2ef6b0-17c3-4772-be93-920ea61c88cd)



