CREATE OR REPLACE TABLE `oulad-analytics-project.oulad_raw_data.master_training_data` AS
SELECT
  info.*,
  -- Registration info (days since course start)
  reg.date_registration,
  IFNULL(reg.date_unregistration, 0) AS date_unregistration,
  -- VLE metrics (fill nulls with 0 for students with no activity)
  IFNULL(vle.total_clicks, 0) AS total_clicks,
  IFNULL(vle.active_days, 0) AS active_days,
  IFNULL(vle.forum_clicks, 0) AS forum_clicks,
  IFNULL(vle.quiz_clicks, 0) AS quiz_clicks,
  -- Assessment metrics
  IFNULL(scores.weighted_score, 0) AS weighted_score,
  IFNULL(scores.assessments_passed, 0) AS assessments_passed
FROM `oulad-analytics-project.oulad_raw_data.clean_student_info` info
LEFT JOIN `oulad-analytics-project.oulad_raw_data.studentRegistration` reg
  ON info.id_student = reg.id_student
  AND info.code_module = reg.code_module
  AND info.code_presentation = reg.code_presentation
LEFT JOIN `oulad-analytics-project.oulad_raw_data.agg_vle` vle
  ON info.id_student = vle.id_student
  AND info.code_module = vle.code_module
  AND info.code_presentation = vle.code_presentation
LEFT JOIN `oulad-analytics-project.oulad_raw_data.agg_scores` scores
  ON info.id_student = scores.id_student
  AND info.code_module = scores.code_module
  AND info.code_presentation = scores.code_presentation;