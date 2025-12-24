CREATE OR REPLACE TABLE `oulad-analytics-project.oulad_raw_data.clean_student_info` AS
SELECT
  id_student,
  code_module,
  code_presentation,
  gender,
  region,
  highest_education,
  -- Handle missing IMD bands (replace '?' with 'Missing')
  IF(imd_band = '?', 'Missing', imd_band) AS imd_band,
  age_band,
  num_of_prev_attempts,
  studied_credits,
  disability,
  -- Create a Binary Target for prediction (1 = Pass/Distinction, 0 = Fail/Withdrawn)
  CASE
    WHEN final_result IN ('Pass', 'Distinction') THEN 1
    ELSE 0
  END AS is_successful,
  final_result
FROM `oulad-analytics-project.oulad_raw_data.studentInfo`;
