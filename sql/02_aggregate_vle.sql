CREATE OR REPLACE TABLE `oulad-analytics-project.oulad_raw_data.agg_vle` AS
SELECT
  a.id_student,
  a.code_module,
  a.code_presentation,
  SUM(a.sum_click) AS total_clicks,
  COUNT(DISTINCT a.date) AS active_days,
  -- Pivot data to see clicks per material type
  SUM(CASE WHEN b.activity_type = 'forumng' THEN a.sum_click ELSE 0 END) AS forum_clicks,
  SUM(CASE WHEN b.activity_type = 'quiz' THEN a.sum_click ELSE 0 END) AS quiz_clicks
FROM `oulad-analytics-project.oulad_raw_data.studentVle` a
LEFT JOIN `oulad-analytics-project.oulad_raw_data.vle` b
  ON a.id_site = b.id_site
GROUP BY 1, 2, 3;
