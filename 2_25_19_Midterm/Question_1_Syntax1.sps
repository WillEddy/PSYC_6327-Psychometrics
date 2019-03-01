* Encoding: UTF-8.
*Did the measure of agreeableness demonstrate and acceptable level of internal consistency at: Time 1? Time 2?
*What item-level improvements could be made to the measure? (Do not engender these changes in the data for further analyses.)

DATASET ACTIVATE DataSet4.
RELIABILITY
  /VARIABLES=WS1_1 WS2_1 WS3_1 WS4_1 WS5_1 WS6_1 WS7_1 WS8_1
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

RELIABILITY
  /VARIABLES=WS1_2 WS2_2 WS3_2 WS4_2 WS5_2 WS6_2 WS7_2 WS8_2
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

*What is the test-retest reliability of the measure?

COMPUTE WS_T1=MEAN(WS1_1,WS2_1,WS3_1,WS4_1,WS5_1,WS6_1,WS7_1,WS8_1).
COMPUTE WS_T2=MEAN(WS1_2,WS2_2,WS3_2,WS4_2,WS5_2,WS6_2,WS7_2,WS8_2).
EXECUTE.

CORRELATIONS
  /VARIABLES=WS_T1 WS_T2
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*What is the 95% confidence interval for any observed score X obtained at Time 1?

DESCRIPTIVES VARIABLES=WS_T1
  /STATISTICS=STDDEV.

*What is the 95% confidence interval for any observed score X obtained at Time 2?

DESCRIPTIVES VARIABLES=WS_T2
  /STATISTICS=STDDEV.
