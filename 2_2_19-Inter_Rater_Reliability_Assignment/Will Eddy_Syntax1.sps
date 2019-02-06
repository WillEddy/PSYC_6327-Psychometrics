* Encoding: UTF-8.
*Restructuring the Data

SORT CASES BY Celebrity.
CASESTOVARS
/ID = Celebrity
/GROUPBY = VARIABLE.
EXECUTE.

*Recoding Variable Names

RECODE ITEM1.1 to ITEM2.5 (MISSING = 999).
MISSING VALUES ITEM1.1 to ITEM2.5 (999).
EXECUTE.

*Estimate rWG

COMPUTE obs_N = var(N.1,N.2,N.3,N.4,N.5,N.6,N.7,N.9,N.9,N.10).
EXECUTE.

COMPUTE N_un = 1-(obs_N/2).
COMPUTE N_ss = 1-(obs_N/1.34).
EXECUTE.


COMPUTE obs_E = var(E.1,E.2,E.3,E.4,E.5,E.6,E.7,E.9,E.9,E.10).
EXECUTE.

COMPUTE E_un = 1-(obs_E/2).
COMPUTE E_ss = 1-(obs_E/1.34).
EXECUTE.

COMPUTE obs_O = var(O.1,O.2,O.3,O.4,O.5,O.6,O.7,O.9,O.9,O.10).
EXECUTE.

COMPUTE O_un = 1-(obs_O/2).
COMPUTE O_ss = 1-(obs_O/1.34).
EXECUTE.

COMPUTE obs_A = var(A.1,A.2,A.3,A.4,A.5,A.6,A.7,A.9,A.9,A.10).
EXECUTE.

COMPUTE A_un = 1-(obs_A/2).
COMPUTE A_ss = 1-(obs_A/1.34).
EXECUTE.

COMPUTE obs_C = var(C.1,C.2,C.3,C.4,C.5,C.6,C.7,C.9,C.9,C.10).
EXECUTE.

COMPUTE C_un = 1-(obs_C/2).
COMPUTE C_ss = 1-(obs_C/1.34).
EXECUTE.

*Estimate ADM
*Burke and Dunlap (2002) suggested a critical value of .80 or less for establishing agreement
when using a 5-point scale.

COMPUTE MEAN_N = mean(N.1,N.2,N.3,N.4,N.5,N.6,N.7,N.9,N.9,N.10).
COMPUTE AD_N = mean(abs(N.1-MEAN_N),abs(N.2-MEAN_N),abs(N.3-MEAN_N),abs(N.4-MEAN_N),abs(N.5-MEAN_N),
                                abs(N.6-MEAN_N),abs(N.7-MEAN_N),abs(N.8-MEAN_N),abs(N.9-MEAN_N),abs(N.10-MEAN_N)).
EXECUTE.

COMPUTE MEAN_E = mean(E.1,E.2,E.3,E.4,E.5,E.6,E.7,E.9,E.9,E.10).
COMPUTE AD_E = mean(abs(E.1-MEAN_E),abs(E.2-MEAN_E),abs(E.3-MEAN_E),abs(E.4-MEAN_E),abs(E.5-MEAN_E),
                                abs(E.6-MEAN_E),abs(E.7-MEAN_E),abs(E.8-MEAN_E),abs(E.9-MEAN_E),abs(E.10-MEAN_E)).
EXECUTE.

COMPUTE MEAN_O = mean(O.1,O.2,O.3,O.4,O.5,O.6,O.7,O.9,O.9,O.10).
COMPUTE AD_O = mean(abs(O.1-MEAN_O),abs(O.2-MEAN_O),abs(O.3-MEAN_O),abs(O.4-MEAN_O),abs(O.5-MEAN_O),
                                abs(O.6-MEAN_O),abs(O.7-MEAN_O),abs(O.8-MEAN_O),abs(O.9-MEAN_O),abs(O.10-MEAN_O)).
EXECUTE.

COMPUTE MEAN_A = mean(A.1,A.2,A.3,A.4,A.5,A.6,A.7,A.9,A.9,A.10).
COMPUTE AD_A = mean(abs(A.1-MEAN_A),abs(A.2-MEAN_A),abs(A.3-MEAN_A),abs(A.4-MEAN_A),abs(A.5-MEAN_A),
                                abs(A.6-MEAN_A),abs(A.7-MEAN_A),abs(A.8-MEAN_A),abs(A.9-MEAN_A),abs(A.10-MEAN_A)).
EXECUTE.

COMPUTE MEAN_C = mean(C.1,C.2,C.3,C.4,C.5,C.6,C.7,C.9,C.9,C.10).
COMPUTE AD_C = mean(abs(C.1-MEAN_C),abs(C.2-MEAN_C),abs(C.3-MEAN_C),abs(C.4-MEAN_C),abs(C.5-MEAN_C),
                                abs(C.6-MEAN_C),abs(C.7-MEAN_C),abs(C.8-MEAN_C),abs(C.9-MEAN_C),abs(C.10-MEAN_C)).
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
