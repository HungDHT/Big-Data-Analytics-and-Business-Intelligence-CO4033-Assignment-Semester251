CREATE OR REPLACE TABLE `oulad-analytics-project.oulad_raw_data.agg_scores` AS
SELECT
  res.id_student,
  asm.code_module,
  asm.code_presentation,
  -- Calculate weighted average score
  SUM(res.score * asm.weight) / NULLIF(SUM(asm.weight), 0) AS weighted_score,
  -- Count how many assessments they passed (assuming 40 is pass)
  COUNTIF(res.score >= 40) AS assessments_passed
FROM `oulad-analytics-project.oulad_raw_data.studentAssessment` res
JOIN `oulad-analytics-project.oulad_raw_data.assessments` asm
  ON res.id_assessment = asm.id_assessment
GROUP BY 1, 2, 3;