*Restructuring the Data

SORT CASES BY Target.
CASESTOVARS
/ID = Target
/GROUPBY = VARIABLE.
EXECUTE.

*Recoding Variable Names

RECODE ITEM1.1 to ITEM2.5 (MISSING = 999).
MISSING VALUES ITEM1.1 to ITEM2.5 (999).
EXECUTE.

*Estimate rWG

COMPUTE obs_var1 = var(item1.1,item1.2,item1.3,item1.4,item1.5).
EXECUTE.

COMPUTE rwg1_un = 1-(obs_var1/2).
COMPUTE rwg1_ss = 1-(obs_var1/1.34).
EXECUTE.

*Estimate ADM
*Burke and Dunlap (2002) suggested a critical value of .80 or less for establishing agreement
when using a 5-point scale.

COMPUTE MEAN1 = mean(item1.1,item1.2,item1.3,item1.4,item1.5).
COMPUTE AD1 = mean(abs(item1.1-mean1),abs(item1.2-mean1),abs(item1.3-mean1),
abs(item1.4-mean1), abs(item1.5-mean1)).
EXECUTE.

*Estimate ICC(1) and ICC(K)

RELIABILITY
/VARIABLES = Item1.1 Item1.2 Item1.3 Item1.4 Item1.5
/SCALE(ALPHA) = ALL/MODEL = ALPHA
/ICC = MODEL(ONEWAY) CIN = 95 TESTVAL = 0.
EXECUTE.

*Estimate rWG(J)

COMPUTE obs_var2 = var(item2.1,item2.2,item2.3,item2.4,item2.5).
COMPUTE avg_var = mean(obs_var1,obs_var2).
EXECUTE.

COMPUTE rwgj_un = (2*(1-avg_var/2))/((2*(1-avg_var/2)) + avg_var/2).
COMPUTE rwgj_ss = (2*(1-avg_var/1.34))/((2*(1-avg_var/1.34)) + avg_var/1.34).
EXECUTE.

*Estimate ADM(J)

COMPUTE MEAN2 = mean(item2.1,item2.2,item2.3,item2.4,item2.5).
COMPUTE AD2 = mean(abs(item2.1-mean2),abs(item2.2-mean2),abs(item2.3-mean2),
abs(item2.4-mean2), abs(item2.5-mean2)).
COMPUTE ADJ = mean(AD1,AD2).
EXECUTE.