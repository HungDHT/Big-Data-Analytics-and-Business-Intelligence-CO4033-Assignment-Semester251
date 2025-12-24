SELECT
  base.*,
  pred.success_probability,
  pred.predicted_risk_group,
  CASE
    WHEN pred.predicted_risk_group = 'High Risk' THEN '🔴 Intervention Needed'
    WHEN pred.predicted_risk_group = 'Medium Risk' THEN '🟡 Monitor'
    WHEN pred.predicted_risk_group = 'Low Risk' THEN '🟢 On Track'
    ELSE '⚪ Data Missing'
  END AS dashboard_status
FROM `oulad-analytics-project.oulad_raw_data.master_training_data` base
LEFT JOIN `oulad-analytics-project.oulad_raw_data.predicted_student_risk` pred
  ON base.id_student = pred.id_student
  AND base.code_module = pred.code_module
  AND base.code_presentation = pred.code_presentation