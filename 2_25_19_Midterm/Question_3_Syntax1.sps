* Encoding: UTF-8.
*Restructuring the Data

SORT CASES BY Supervisor.
CASESTOVARS
/ID = Supervisor
/GROUPBY = VARIABLE.
EXECUTE.

*Recoding Variable Names

RECODE ITEM1.1 to ITEM2.5 (MISSING = 999).
MISSING VALUES ITEM1.1 to ITEM2.5 (999).
EXECUTE.

*Estimate rWG

COMPUTE obs_IS = var(IS.1,IS.2,IS.3,IS.4,IS.5,IS.6,IS.7,IS.8,IS.9,IS.10).
EXECUTE.

COMPUTE IS_un = 1-(obs_IS/2).
EXECUTE.


COMPUTE obs_C = var(C.1,C.2,C.3,C.4,C.5,C.6,C.7,C.8,C.9,C.10).
EXECUTE.

COMPUTE C_un = 1-(obs_C/2).
EXECUTE.

*Estimate ADM
*Burke and Dunlap (2002) suggested a critical value of .80 or less for establishing agreement
when using a 5-point scale.

COMPUTE MEAN_IS = mean(IS.1,IS.2,IS.3,IS.4,IS.5,IS.6,IS.7,IS.8,IS.9,IS.10).
COMPUTE AD_IS = mean(abs(IS.1-MEAN_IS),abs(IS.2-MEAN_IS),abs(IS.3-MEAN_IS),abs(IS.4-MEAN_IS),abs(IS.5-MEAN_IS),abs(IS.6-MEAN_IS),abs(IS.7-MEAN_IS),abs(IS.8-MEAN_IS),abs(IS.9-MEAN_IS),abs(IS.10-MEAN_IS)).
EXECUTE.

COMPUTE MEAN_C = mean(C.1,C.2,C.3,C.4,C.5,C.6,C.7,C.8,C.9,C.10).
COMPUTE AD_C = mean(abs(C.1-MEAN_C),abs(C.2-MEAN_C),abs(C.3-MEAN_C),abs(C.4-MEAN_C),abs(C.5-MEAN_C),abs(C.6-MEAN_C),abs(C.7-MEAN_C),abs(C.8-MEAN_C),abs(C.9-MEAN_C),abs(C.10-MEAN_C)).
EXECUTE.

*Estimate ICC(1) and ICC(K)

RELIABILITY
/VARIABLES = N.1,N.2,N.3,N.4,N.5,N.6,N.7,N.9,N.9,N.10
/SCALE(ALPHA) = ALL/MODEL = ALPHA
/ICC = MODEL(ONEWAY) CIN = 95 TESTVAL = 0.
EXECUTE.

RELIABILITY
/VARIABLES = E.1,E.2,E.3,E.4,E.5,E.6,E.7,E.9,E.9,E.10
/SCALE(ALPHA) = ALL/MODEL = ALPHA
/ICC = MODEL(ONEWAY) CIN = 95 TESTVAL = 0.
EXECUTE.

RELIABILITY
/VARIABLES = O.1,O.2,O.3,O.4,O.5,O.6,O.7,O.9,O.9,O.10
/SCALE(ALPHA) = ALL/MODEL = ALPHA
/ICC = MODEL(ONEWAY) CIN = 95 TESTVAL = 0.
EXECUTE.

RELIABILITY
/VARIABLES = A.1,A.2,A.3,A.4,A.5,A.6,A.7,A.9,A.9,A.10
/SCALE(ALPHA) = ALL/MODEL = ALPHA
/ICC = MODEL(ONEWAY) CIN = 95 TESTVAL = 0.
EXECUTE.

RELIABILITY
/VARIABLES = C.1,C.2,C.3,C.4,C.5,C.6,C.7,C.9,C.9,C.10
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
