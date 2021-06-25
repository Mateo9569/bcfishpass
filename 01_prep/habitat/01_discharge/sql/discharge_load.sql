-- Either my syntax is bad or using st_transform() to reproject the vector geometry directly in the overlay query does not work
-- Avoid the issue for now by just creating a temp table of watershed centroids in 4326
CREATE TEMPORARY TABLE temp_wsd_pts AS
SELECT
  watershed_feature_id,
  st_transform(st_pointonsurface(geom), 4326) as geom
FROM whse_basemapping.fwa_watersheds_poly
WHERE watershed_group_code = :'wsg';

INSERT INTO bcfishpass.discharge_load
(watershed_feature_id, discharge_mm)
SELECT 
  p.watershed_feature_id,
  ST_Value(rast, p.geom) as discharge_mm
FROM temp_wsd_pts p
INNER JOIN bcfishpass.discharge_raster
ON ST_intersects(p.geom, st_convexhull(rast));