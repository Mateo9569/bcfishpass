-- join crossings table to access and habitat upstream reports, 
-- convert array types to text for easier dumps

drop view if exists bcfishpass.crossings_vw;
create or replace view bcfishpass.crossings_vw as
select
 c.aggregated_crossings_id,
 c.stream_crossing_id,
 c.dam_id,
 c.user_barrier_anthropogenic_id,
 c.modelled_crossing_id,
 c.crossing_source,
 c.crossing_feature_type,
 c.pscis_status,
 c.crossing_type_code,
 c.crossing_subtype_code,
 array_to_string(c.modelled_crossing_type_source, ';') as modelled_crossing_type_source,
 c.barrier_status,
 c.pscis_road_name,
 c.pscis_stream_name,
 c.pscis_assessment_comment,
 c.pscis_assessment_date,
 c.pscis_final_score,
 c.transport_line_structured_name_1,
 c.transport_line_type_description,
 c.transport_line_surface_description,
 c.ften_forest_file_id,
 c.ften_file_type_description,
 c.ften_client_number,
 c.ften_client_name,
 c.ften_life_cycle_status_code,
 c.rail_track_name,
 c.rail_owner_name,
 c.rail_operator_english_name,
 c.ogc_proponent,
 c.dam_name,
 c.dam_height,
 c.dam_owner,
 c.dam_use,
 c.dam_operating_status,
 c.utm_zone,
 c.utm_easting,
 c.utm_northing,
 c.dbm_mof_50k_grid,
 c.linear_feature_id,
 c.blue_line_key,
 c.watershed_key,
 c.downstream_route_measure,
 c.wscode_ltree as wscode,
 c.localcode_ltree as localcode,
 c.watershed_group_code,
 c.gnis_stream_name,
 c.stream_order,
 c.stream_magnitude,
 s.upstream_area_ha,
 s.stream_order_parent,
 s.stream_order_max,
 s.map_upstream,
 s.channel_width,
 s.mad_m3s,
 array_to_string(c.observedspp_dnstr, ';') as observedspp_dnstr,
 array_to_string(c.observedspp_upstr, ';') as observedspp_upstr,
 array_to_string(c.crossings_dnstr, ';') as crossings_dnstr,
 array_to_string(c.barriers_anthropogenic_dnstr, ';') as barriers_anthropogenic_dnstr,
 array_to_string(c.barriers_anthropogenic_upstr, ';') as barriers_anthropogenic_upstr,
 coalesce(array_length(c.barriers_anthropogenic_dnstr, 1), 0) as barriers_anthropogenic_dnstr_count,
 coalesce(array_length(c.barriers_anthropogenic_upstr, 1), 0) as barriers_anthropogenic_upstr_count,
 a.gradient,
 a.total_network_km,
 a.total_stream_km,
 a.total_lakereservoir_ha,
 a.total_wetland_ha,
 a.total_slopeclass03_waterbodies_km,
 a.total_slopeclass03_km,
 a.total_slopeclass05_km,
 a.total_slopeclass08_km,
 a.total_slopeclass15_km,
 a.total_slopeclass22_km,
 a.total_slopeclass30_km,
 a.total_belowupstrbarriers_network_km,
 a.total_belowupstrbarriers_stream_km,
 a.total_belowupstrbarriers_lakereservoir_ha,
 a.total_belowupstrbarriers_wetland_ha,
 a.total_belowupstrbarriers_slopeclass03_waterbodies_km,
 a.total_belowupstrbarriers_slopeclass03_km,
 a.total_belowupstrbarriers_slopeclass05_km,
 a.total_belowupstrbarriers_slopeclass08_km,
 a.total_belowupstrbarriers_slopeclass15_km,
 a.total_belowupstrbarriers_slopeclass22_km,
 a.total_belowupstrbarriers_slopeclass30_km,
 array_to_string(a.barriers_ch_cm_co_pk_sk_dnstr, ';') as barriers_ch_cm_co_pk_sk_dnstr,
 a.ch_cm_co_pk_sk_network_km,
 a.ch_cm_co_pk_sk_stream_km,
 a.ch_cm_co_pk_sk_lakereservoir_ha,
 a.ch_cm_co_pk_sk_wetland_ha,
 a.ch_cm_co_pk_sk_slopeclass03_waterbodies_km,
 a.ch_cm_co_pk_sk_slopeclass03_km,
 a.ch_cm_co_pk_sk_slopeclass05_km,
 a.ch_cm_co_pk_sk_slopeclass08_km,
 a.ch_cm_co_pk_sk_slopeclass15_km,
 a.ch_cm_co_pk_sk_slopeclass22_km,
 a.ch_cm_co_pk_sk_slopeclass30_km,
 a.ch_cm_co_pk_sk_belowupstrbarriers_network_km,
 a.ch_cm_co_pk_sk_belowupstrbarriers_stream_km,
 a.ch_cm_co_pk_sk_belowupstrbarriers_lakereservoir_ha,
 a.ch_cm_co_pk_sk_belowupstrbarriers_wetland_ha,
 a.ch_cm_co_pk_sk_belowupstrbarriers_slopeclass03_waterbodies_km,
 a.ch_cm_co_pk_sk_belowupstrbarriers_slopeclass03_km,
 a.ch_cm_co_pk_sk_belowupstrbarriers_slopeclass05_km,
 a.ch_cm_co_pk_sk_belowupstrbarriers_slopeclass08_km,
 a.ch_cm_co_pk_sk_belowupstrbarriers_slopeclass15_km,
 a.ch_cm_co_pk_sk_belowupstrbarriers_slopeclass22_km,
 a.ch_cm_co_pk_sk_belowupstrbarriers_slopeclass30_km,
 array_to_string(a.barriers_st_dnstr, ';') as barriers_st_dnstr,
 a.st_network_km,
 a.st_stream_km,
 a.st_lakereservoir_ha,
 a.st_wetland_ha,
 a.st_slopeclass03_waterbodies_km,
 a.st_slopeclass03_km,
 a.st_slopeclass05_km,
 a.st_slopeclass08_km,
 a.st_slopeclass15_km,
 a.st_slopeclass22_km,
 a.st_slopeclass30_km,
 a.st_belowupstrbarriers_network_km,
 a.st_belowupstrbarriers_stream_km,
 a.st_belowupstrbarriers_lakereservoir_ha,
 a.st_belowupstrbarriers_wetland_ha,
 a.st_belowupstrbarriers_slopeclass03_waterbodies_km,
 a.st_belowupstrbarriers_slopeclass03_km,
 a.st_belowupstrbarriers_slopeclass05_km,
 a.st_belowupstrbarriers_slopeclass08_km,
 a.st_belowupstrbarriers_slopeclass15_km,
 a.st_belowupstrbarriers_slopeclass22_km,
 a.st_belowupstrbarriers_slopeclass30_km,
 h.bt_spawning_km,
 h.bt_rearing_km,
 h.bt_spawning_belowupstrbarriers_km,
 h.bt_rearing_belowupstrbarriers_km,
 h.ch_spawning_km,
 h.ch_rearing_km,
 h.ch_spawning_belowupstrbarriers_km,
 h.ch_rearing_belowupstrbarriers_km,
 h.cm_spawning_km,
 h.cm_spawning_belowupstrbarriers_km,
 h.co_spawning_km,
 h.co_rearing_km,
 h.co_rearing_ha,
 h.co_spawning_belowupstrbarriers_km,
 h.co_rearing_belowupstrbarriers_km,
 h.co_rearing_belowupstrbarriers_ha,
 h.pk_spawning_km,
 h.pk_spawning_belowupstrbarriers_km,
 h.sk_spawning_km,
 h.sk_rearing_km,
 h.sk_rearing_ha,
 h.sk_spawning_belowupstrbarriers_km,
 h.sk_rearing_belowupstrbarriers_km,
 h.sk_rearing_belowupstrbarriers_ha,
 h.st_spawning_km,
 h.st_rearing_km,
 h.st_spawning_belowupstrbarriers_km,
 h.st_rearing_belowupstrbarriers_km,
 h.wct_spawning_km,
 h.wct_rearing_km,
 h.wct_spawning_belowupstrbarriers_km,
 h.wct_rearing_belowupstrbarriers_km,
 c.geom
 from bcfishpass.crossings c
 left outer join bcfishpass.crossings_upstream_access a on c.aggregated_crossings_id = a.aggregated_crossings_id
 left outer join bcfishpass.crossings_upstream_habitat h on c.aggregated_crossings_id = h.aggregated_crossings_id
 left outer join bcfishpass.streams s on c.linear_feature_id = s.linear_feature_id;