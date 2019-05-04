* G1.sps for Generalizability Theory analyses    

set printback = off.
matrix.

* There are two main ways of entering data into this program.

* Method 1: You can specify the data to be analyzed on a 
  GET statement, as in the example below.  On the GET statement,
  the data matrix must be named SCORES (as in the example);
  "FILE = *" will use the currently active SPSS data set;
  "FILE = C:\filename" will use the specified SPSS data file on your
  computer.  The * beside the GET command below converts the
  command into a comment.  To use the GET command, remove 
  the * that appears before GET; specify the data for analysis
  on FILE =; and specify the variables for analysis on VARIABLES =.

*GET scores / file = *  /variables = all / missing = omit.

* Method 2: A data matrix can be entered directly, within the
  MATRIX--END MATRIX program, using a COMPUTE 
  statement, as in the trial-run data below. The data matrix must
  be named "scores"; the data must appear inside curly brackets;
  place a comma between the data values for each case;
  and place a semicolon at the end of the data values for each case.

*  A third method for entering data is to use a READ statement,
   which is a MATRIX--END MATRIX command.  READ can be used
   to read a raw data file on your computer.  See the online
   documentation for MATRIX--END MATRIX.


****************  START OF TRIAL-RUN DATA  ************************************

* The following data are from Brennan, 2001, p 72, Table 3.1, for a
  p x i x o design, with 10 persons, 4 items, and 2 occasions.  The 
  data are entered using a COMPUTE statement.  To analyze your own data,
  the trial-run data matrix must be removed/deleted.  Or you can leave
  the trial-run data in place and convert the trial-run data matrix to
  an SPSS comment statement by simply placing a * before COMPUTE.

COMPUTE scores = {
   2,   6,   7,   5,   2,   5,   5,   5;
   4,   5,   6,   7,   6,   7,   5,   7;
   5,   5,   4,   6,   5,   4,   5,   5;
   5,   9,   8,   6,   5,   7,   7,   6;
   4,   3,   5,   6,   4,   5,   6,   4;
   4,   4,   4,   7,   6,   4,   7,   8;
   2,   6,   6,   5,   2,   7,   7,   5;
   3,   4,   4,   5,   6,   6,   6,   4;
   0,   5,   4,   5,   5,   5,   5,   3;
   6,   8,   7,   6,   6,   8,   8,   6    }.

****************  END OF TRIAL-RUN DATA  ************************************


* Enter the number of levels/conditions of Facet 1 (e.g., # of items).
compute nfacet1 = 4.

* Enter the number of levels/conditions of Facet 2 (e.g., # of occasions);
  You can ignore this step for single-facet designs.
compute nfacet2 = 2.

* For two-facet designs, Facet 1 is the facet with the fastest-changing
  conditions in the columns of your data matrix.  For example, if the
  first 10 columns/variables contained the data for 10 different items
  measured on occasion 1, and if the next 10 columns/variables contained
  the data for the same 10 items measured on occasion 2, then items 
  would be the fastest-changing facet.  As you slide from one column to
  the next across the data matrix, it is the item levels that change 
  most quickly.  You would therefore enter a value of "10" for
  NFACET1 and a value of "2" for NFACET2 on the above statements.

* Enter the design of your data on the "COMPUTE TYPE =" statement below:
     enter "1" for a single-facet fully-crossed design, as in P * F1
     enter "2" for a single-facet nested nested design, as in F1 : P
     enter "3" for a two-facet fully-crossed design, as in P * F1 * F2
     enter "4" for a two-facet nested design, as in P * (F1 : F2)
     enter "5" for a two-facet nested design, as in (F1 : P) * F2
     enter "6" for a two-facet nested design, as in F1 : (P * F2)
     enter "7" for a two-facet nested design, as in (F1 * F2) : P
     enter "8" for a two-facet nested design, as in F1 : F2 : P.
compute type = 3.

* Enter D-study values for Facet 1; enter the values inside curly
  brackets, and place a comma between the values.
compute dfacet1 = {5,10,15,20}.

* Enter D-study values for Facet 2; enter the values inside curly
  brackets, and place a comma between the values.  You can ignore this
  step for single-facet designs.
compute dfacet2 = {1,2,3,4,5}.


* At the very bottom of this file, after the END MATRIX statement, is
  a GRAPH command that can be used to plot the results for the D-study
  values that you specified above.  Specify the data that you would like to
  plot by entering the appropriate number on the COMPUTE GRAPHDAT statement:
  enter "1" for relative error variances;
  enter "2" for absolute error variances;
  enter "3" for G-coefficients;
  enter "4" for phi coefficients.
compute graphdat = 3.


* End of user specifications. Now just run this whole file.
***************************************************************************

print /title = 'GENERALIZABILITY THEORY ANALYSES:' / space = 3.

do if  (type = 1).
print /title = 
  "Design Type 1: single-facet fully-crossed design, as in P * F1" .
else if (type = 2).
print /title = 
  "Design Type 2: single-facet nested nested design, as in F1 : P".
else if (type = 3).
print /title = 
  "Design Type 3: two-facet fully-crossed design, as in P * F1 * F2".
else if (type = 4).
print /title = 
  "Design Type 4: two-facet nested design, as in P * (F1 : F2)".
else if (type = 5).
print /title = 
  "Design Type 5: two-facet nested design, as in (F1 : P) * F2".
else if (type = 6).
print /title = 
  "Design Type 6: two-facet nested design, as in F1 : (P * F2)".
else if (type = 7).
print /title = 
  "Design Type 7: two-facet nested design, as in (F1 * F2) : P".
else if (type = 8).
print /title = 
  "Design Type 8: two-facet nested design, as in F1 : F2 : P".
end if.

compute p = nrow(scores).
compute i = nfacet1.
compute h = nfacet2.

print p /title = "Number of persons/objects ('P'):".
print i /title = "Number of levels for Facet 1 ('F1'):".
do if ( type > 2).
print h /title = "Number of levels for Facet 2 ('F2'):".
end if.


* single-facet fully-crossed design, as in P * F1.
do if type = 1.

* degrees of freedom.
compute dfp = p-1.
compute dfi = i-1.
compute dfpi = dfp*dfi.

* raw data computations.
compute hABCD = scores.
compute pmean = rsum(hABCD)/i.
compute p2mean = cssq(pmean).
compute imean = csum(hABCD)/p.
compute i2mean = rssq(imean).
compute pi2tot = mssq(hABCD).
compute gmean = rsum(imean)/i.

compute Tpers = i * p2mean.
compute Titem = p * i2mean.
compute Tpi   = pi2tot.
compute Tu    = p * i * (gmean * gmean).
 
* sum of squares.
compute pss  = Tpers - Tu.
compute iss  = Titem - Tu.
compute piss = Tpi - Tpers - Titem + Tu.

* mean squares.
compute pms = pss/dfp.
compute ims = iss/dfi.
compute pims = piss/dfpi.

* variance components: Brennan, 2001, p 79, 83, 85, 442.
compute vcs = t(inv({ i,0,1; 0,p,1; 0,0,1}) *  { pms; ims; pims }).

* setting negative variances to zero.
loop #luper = 1 to ncol(vcs).
do if (vcs(1,#luper) < 0).
compute vcs(1,#luper) = 0.
print /title=
  'One or more negative variance estimates have been set to zero'.
end if.
end loop.

compute pvar  = vcs(1,1).
compute ivar  = vcs(1,2).
compute pivar = vcs(1,3).
compute totvar = msum(vcs).

* relative and absolute error variances.
compute relv = pivar/i.
compute absv = (ivar/i) + relv.

* matrices for D-studies.
compute persons  = { 1, 0, 1 }.
compute vfacet1  = { 0, i, i }.

print {dfp,pss,pms,pvar,(pvar/totvar);
  dfi,iss,ims,ivar,(ivar/totvar);
  dfpi,piss,pims,pivar,(pivar/totvar)}
 /format "f12.3"
 /title = "ANOVA Table:"
 /clabels = "df","SS","MS","Variance" "Proport."
 /rlabels = "P","F1","P*F1".

end if.


* single-facet nested nested design, as in F1 : P.
do if type = 2.

* degrees of freedom.
compute dfp = p-1.
compute dfip = p*(i-1).

* raw data computations.
compute hABCD = scores.
compute pmean = (rsum(hABCD))/i.
compute p2mean = mssq(pmean).
compute pi2mean = mssq(hABCD).
compute mean = msum(pmean)/p.

* sum of squares.
compute pss = i*p2mean-p*i*mean*mean.
compute ipss = (pi2mean)-(i*p2mean).

* mean squares.
compute pms = pss/dfp.
compute ipms = ipss/dfip.

* variance components: Brennan, 2001, p 79, 83, 85, 442.
compute vcs = t(inv({ i,1; 0,1 }) *  { pms; ipms }).
* setting negative variances to zero.
loop #luper = 1 to ncol(vcs).
do if (vcs(1,#luper) < 0).
compute vcs(1,#luper) = 0.
print /title=
  'One or more negative variance estimates have been set to zero'.
end if.
end loop.
compute pvar   = vcs(1,1).
compute ipvar  = vcs(1,2).
compute totvar = msum(vcs).

* relative and absolute error variances.
compute relv = ipvar/i.
compute absv = relv.

* matrices for D-studies.
compute persons  = { 1, 1 }.
compute vfacet1  = { 0, i }.

print {dfp,pss,pms,pvar,(pvar/totvar);
  dfip,ipss,ipms,ipvar,(ipvar/totvar)}
 /format "f12.3"
 /title = "ANOVA Table:"
 /clabels = "df","SS","MS","Variance", "Proport."
 /rlabels = "P","F1:P".

end if.


* two-facet fully-crossed design, as in P * F1 * F2.
do if type = 3.

* degrees of freedom.
compute dfp = (nrow(scores) - 1).
compute dfo = (h - 1).
compute dfi = ((ncol(scores)/(h)) - 1).
compute dfpo = (dfp*dfo).
compute dfpi = (dfp*dfi).
compute dfio = (dfi*dfo).
compute dfpoi = (dfp*dfo*dfi).

* pointers/counters.
compute cntfirst = 1.
compute cntlast = i.

* raw data computations.
compute pimean = make(p,i,0).
compute pmean = make(p,1,0).
compute omean = make(h,1,-9999).
compute pomean = make(p,h,-9999).
compute iomean = make(h,i,-9999).
loop #cols = 1 to h.
compute hABCD = scores(:, cntfirst:cntlast).
compute iomean(#cols,:) = csum(hABCD)/p.
compute pomean(:,#cols) = rsum(hABCD)/i.
compute pimean = pimean+hABCD.
compute cntfirst = cntfirst + i.
compute cntlast = cntlast + i.
end loop.

compute pmean = rsum(pomean)/h.
compute omean = csum(pomean)/p.
compute pimean = pimean/h.
compute imean = csum(pimean)/p.
compute mean = csum(pmean)/p.

compute Tpers = (i*h)*(mssq(pmean)).
compute Titem = (p*h)*(rssq(imean)).
compute Tocca = (p*i)*(mssq(omean)).
compute Tu = (p)*(i)*(h)*((mean)*(mean)).
compute Tpi = (h)*(mssq(pimean)).
compute Tpo = cssq(pomean).
compute Tpo = rsum(Tpo)*i.
compute Tio = (p)*(mssq(iomean)).
compute Tpoi = (mssq(scores)).

* sum of squares.
compute pss = (Tpers-Tu).
compute iss = (Titem-Tu).
compute oss = (Tocca-Tu).
compute piss = (Tpi-Tpers-Titem+Tu).
compute poss = (Tpo-Tpers-Tocca+Tu).
compute ioss = (Tio-Titem-Tocca+Tu).
compute poiss = (Tpoi-Tpi-Tpo-Tio+Tpers+Titem+Tocca-Tu).

* mean squares.
compute poims = poiss/dfpoi. 
compute ioms = ioss/dfio.
compute poms = poss/dfpo.
compute pims = piss/dfpi.
compute oms = oss/dfo.
compute ims = iss/dfi.
compute pms = pss/dfp.

* variance components: Brennan, 2001, p 79, 83, 85, 442.
compute bigP = ({ i*h,0,0,h,i,0,1; 0,p*h,0,h,0,p,1; 0,0,p*i,0,i,p,1;
   0,0,0,h,0,0,1;  0,0,0,0,i,0,1;   0,0,0,0,0,p,1;   0,0,0,0,0,0,1  }).
compute vcs = t(inv(bigP) * { pms; ims; oms; pims; poms; ioms; poims }).
* setting negative variances to zero.
loop #luper = 1 to ncol(vcs).
do if (vcs(1,#luper) < 0).
compute vcs(1,#luper) = 0.
print /title=
  'One or more negative variance estimates have been set to zero'.
end if.
end loop.
compute pvar  = vcs(1,1).
compute ivar  = vcs(1,2).
compute ovar  = vcs(1,3).
compute pivar = vcs(1,4).
compute povar = vcs(1,5).
compute iovar = vcs(1,6).
compute poivar = vcs(1,7).
compute totvar = msum(vcs).

* relative and absolute error variances.
compute relv = (pivar/i)+(povar/h)+(poivar/(i*h)).
compute absv = (ivar/i)+(ovar/h)+(iovar/(i*h))+relv.

* matrices for D-studies.
compute persons  = { 1, 0, 0, 1, 1, 0, 1 }.
compute vfacet1  = { 0, i, 0, i, 0, i, i }.
compute vfacet2  = { 0, 0, h, 0, h, h, h }.

print {dfp,pss,pms,pvar,(pvar/totvar);
  dfi,iss,ims,ivar,(ivar/totvar);
  dfo,oss,oms,ovar,(ovar/totvar);
  dfpi,piss,pims,pivar,(pivar/totvar);
  dfpo,poss,poms,povar,(povar/totvar);
  dfio,ioss,ioms,iovar,(iovar/totvar);
  dfpoi,poiss,poims,poivar,(poivar/totvar)}
 /format "f12.3"
 /title = "ANOVA Table:"
 /clabels = "df","SS","MS","Variance", "Proport."
 /rlabels = "P","F1","F2","P*F1","P*F2","F1*F2","P*F1*F2".

end if.


* two-facet nested design, as in P * (F1 : F2).
do if type = 4.

* degrees of freedom.
compute dfp = (nrow(scores) - 1).
compute dfh = (h-1).
compute dfih = (h)*(i-1).
compute dfph = dfp*dfh.
compute dfpih = h*dfp*(i-1).
compute dftot = dfp+dfh+dfih+dfph+dfpih.

* pointers/counters.
compute cntfirst = 1.
compute cntlast = i.

* raw data computations.
compute pmean = make(p,1,0).
compute hmean = make(h,1,-9999).
compute phmean = make(p,h,-9999).
compute ihmean = make(h,i,-9999).
loop #cols = 1 to h.
compute hABCD = scores(:, cntfirst:cntlast).
compute ihmean(#cols,:) = csum(hABCD)/p.
compute phmean(:,#cols) = rsum(hABCD)/i.
compute cntfirst = cntfirst + i.
compute cntlast = cntlast + i.
end loop.

compute pmean = rsum(phmean)/h.
compute hmean = csum(phmean)/p.
compute mean = csum(pmean)/p.

compute Tp = (i*h)*(mssq(pmean)).
compute Th = (p*i)*(rssq(hmean)).
compute Tih = p*(mssq(ihmean)).
compute Tph = i*(mssq(phmean)).
compute Tpih = mssq(scores).
compute Tu = p*i*h*mean*mean.

* sum of squares.
compute pss = Tp-Tu.
compute hss = Th-Tu.
compute ihss = Tih-Th.
compute phss = Tph-Tp-Th+Tu.
compute pihss = Tpih-Tph-Tih+Th.
compute sstot = pss+hss+ihss+phss+pihss.

* mean squares.
compute pms = pss/dfp.
compute hms = hss/dfh.
compute ihms = ihss/dfih.
compute phms = phss/dfph.
compute pihms = pihss/dfpih.

* variance components: Brennan, 2001, p 79, 83, 85, 442.
compute vcs = t(inv({ i*h,0,0,i,1; 0,p*i,p,i,1; 0,0,p,0,1;
  0,0,0,i,1; 0,0,0,0,1 }) *  { pms; hms; ihms; phms; pihms }).
* setting negative variances to zero.
loop #luper = 1 to ncol(vcs).
do if (vcs(1,#luper) < 0).
compute vcs(1,#luper) = 0.
print /title=
  'One or more negative variance estimates have been set to zero'.
end if.
end loop.
compute pvar   = vcs(1,1).
compute hvar   = vcs(1,2).
compute ihvar  = vcs(1,3).
compute phvar  = vcs(1,4).
compute pihvar = vcs(1,5).
compute totvar = msum(vcs).

* relative and absolute error variances.
compute relv = (pihvar/(i*h))+(phvar/h).
compute absv = (hvar/h)+(ihvar/(i*h)) + relv.

* matrices for D-studies.
compute persons  = { 1, 0, 0, 1, 1 }.
compute vfacet1  = { 0, 0, i, 0, i }.
compute vfacet2  = { 0, h, h, h, h }.

print {dfp,pss,pms,pvar,(pvar/totvar);
  dfh,hss,hms,hvar,(hvar/totvar);
  dfih,ihss,ihms,ihvar,(ihvar/totvar);
  dfph,phss,phms,phvar,(phvar/totvar);
  dfpih,pihss,pihms,pihvar,(pihvar/totvar)}
 /format "f12.3"
 /title = "ANOVA Table:"
 /clabels = "df","SS","MS","Variance","Proport."
 /rlabels = "P","F2","F1:F2","P*F2","P*F1:F2".

end if.


* two-facet nested design, as in (F1 : P) * F2.
do if type = 5.

* degrees of freedom.
compute dfp = (nrow(scores) -1).
compute dfh = h-1.
compute dfip = p*(i-1).
compute dfph = (p-1)*(h-1).
compute dfhip = p*(i-1)*(h-1).
compute dftot = dfp+dfh+dfip+dfph+dfhip.

* initializing pointers/counters.
compute cntfirst = 1.
compute cntlast = i.

* raw data computations.
compute pmean = make(p,1,0).
compute hmean = make(h,1,-9999).
compute phmean = make(p,h,-9999).
compute ipmean = make(p,i,0).
loop #cols = 1 to h.
compute hABCD = scores(:, cntfirst:cntlast).
compute phmean(:,#cols) = rsum(hABCD)/i.
compute ipmean = ipmean+ hABCD.
compute cntfirst = cntfirst + i.
compute cntlast = cntlast + i.
end loop.

compute pmean = rsum(phmean)/h.
compute hmean = csum(phmean)/p.
compute mean = csum(pmean)/p.
compute ipmean = ipmean/h.

compute Tp = (i*h)*(mssq(pmean)).
compute Th = (p*i)*(rssq(hmean)).
compute Tip = h*(mssq(ipmean)).
compute Tph = (i*(mssq(phmean))).
compute Thip = mssq(scores).
compute Tu = p*i*h*mean*mean.

* sum of squares.
compute pss = Tp-Tu.
compute hss = Th-Tu.
compute ipss = Tip-Tp.
compute phss = Tph-Tp-Th+Tu.
compute hipss = Thip-Tph-Tip+Tp.
compute sstot = pss+hss+ipss+phss+hipss.

* mean squares.
compute pms = pss/dfp.
compute hms = hss/dfh.
compute ipms = ipss/dfip.
compute phms = phss/dfph.
compute hipms = hipss/dfhip.

* variance components: Brennan, 2001, p 79, 83, 85, 442.
compute vcs = t(inv({ i*h,0,0,i,1; 0,p*i,0,i,1; 0,0,h,0,1;
   0,0,0,i,1; 0,0,0,0,1 }) *  { pms; hms; ipms; phms; hipms }).
* setting negative variances to zero.
loop #luper = 1 to ncol(vcs).
do if (vcs(1,#luper) < 0).
compute vcs(1,#luper) = 0.
print /title=
  'One or more negative variance estimates have been set to zero'.
end if.
end loop.
compute pvar   = vcs(1,1).
compute hvar   = vcs(1,2).
compute ipvar  = vcs(1,3).
compute phvar  = vcs(1,4).
compute hipvar = vcs(1,5).
compute totvar = msum(vcs).

* relative and absolute error variances.
compute relv = (ipvar/i)+(phvar/h)+(hipvar/(i*h)).
compute absv = (hvar/h)+relv.

* matrices for D-studies.
compute persons  = { 1, 0, 1, 1, 1 }.
compute vfacet1  = { 0, 0, i, 0, i }.
compute vfacet2  = { 0, h, 0, h, h }.

print  {dfp,pss,pms,pvar,(pvar/totvar);
  dfh,hss,hms,hvar,(hvar/totvar);
  dfip,ipss,ipms,ipvar,(ipvar/totvar);
  dfph,phss,phms,phvar,(phvar/totvar);
  dfhip,hipss,hipms,hipvar,(hipvar/totvar)}
 /format "f12.3"
 /title = "ANOVA Table:"
 /clabels = "df","SS","MS","Variance","Proport."
 /rlabels = "P","F2","F1:P","P*F2","F2*F1:P".

end if.


* two-facet nested design, as in F1 : (P * F2).
do if type = 6.

* degrees of freedom.
compute dfp = (nrow(scores) -1).
compute dfh = h-1.
compute dfph = (p-1)*(h-1).
compute dfiph = p*h*(i-1).
compute dftot = dfp+dfh+dfph+dfiph.

* pointers/counters.
compute cntfirst = 1.
compute cntlast = i.

* raw data computations.
compute pmean = make(p,1,0).
compute hmean = make(h,1,-9999).
compute phmean = make(p,h,-9999).
loop #cols = 1 to h.
compute hABCD = scores(:, cntfirst:cntlast).
compute phmean(:,#cols) = rsum(hABCD)/i.
compute cntfirst = cntfirst + i.
compute cntlast = cntlast + i.
end loop.

compute pmean = rsum(phmean)/h.
compute hmean = csum(phmean)/p.
compute mean = csum(pmean)/p.

compute Tp = (i*h)*(mssq(pmean)).
compute Th = (p*i)*(rssq(hmean)).
compute Tph = (i*(mssq(phmean))).
compute Tiph = mssq(scores).
compute Tu = p*i*h*mean*mean.

* sum of squares.
compute pss = Tp-Tu.
compute hss = Th-Tu.
compute phss = Tph-Tp-Th+Tu.
compute iphss = Tiph-Tph.
compute sstot = pss+hss+phss+iphss.

* mean squares.
compute pms = pss/dfp.
compute hms = hss/dfh.
compute phms = phss/dfph.
compute iphms = iphss/dfiph.

* variance components: Brennan, 2001, p 79, 83, 85, 442.
compute vcs = t(inv({ i*h,0,i,1; 0,p*i,i,1; 0,0,i,1; 0,0,0,1 })
            * { pms; hms; phms; iphms }).
* setting negative variances to zero.
loop #luper = 1 to ncol(vcs).
do if (vcs(1,#luper) < 0).
compute vcs(1,#luper) = 0.
print /title=
  'One or more negative variance estimates have been set to zero'.
end if.
end loop.
compute pvar   = vcs(1,1).
compute hvar   = vcs(1,2).
compute phvar  = vcs(1,3).
compute iphvar = vcs(1,4).
compute totvar = msum(vcs).

* relative and absolute error variances & G & phi coefficients.
compute relv = (phvar/h)+(iphvar/(i*h)).
compute absv = (hvar/h)+relv.

* matrices for D-studies.
compute persons  = { 1, 0, 1, 1 }.
compute vfacet1  = { 0, 0, 0, i }.
compute vfacet2  = { 0, h, h, h }.

print {dfp,pss,pms,pvar,(pvar/totvar); 
  dfh,hss,hms,hvar,(hvar/totvar); 
  dfph,phss,phms,phvar,(phvar/totvar); 
  dfiph,iphss,iphms,iphvar,(iphvar/totvar)}
 /format "f12.3"
 /title = "ANOVA Table:"
 /clabels = "df","SS","MS","Variance","Proport."
 /rlabels = "P","F2","P*F2","F1:P*F2".

end if.


* two-facet nested design, as in (F1 * F2) : P.
do if type = 7.

* degrees of freedom.
compute dfp = (nrow(scores) -1).
compute dfip = p*(i-1).
compute dfhp = p*(h-1).
compute dfihp = p*(i-1)*(h-1).
compute dftot = dfp+dfip+dfhp+dfihp.

* pointers/counters.
compute cntfirst = 1.
compute cntlast = i.

* raw data computations.
compute pmean = make(p,1,0).
compute phmean = make(p,h,-9999).
compute ipmean = make(p,i,0).
compute hpmean = make(p,h,-9999).
loop #cols = 1 to h.
compute hABCD = scores(:, cntfirst:cntlast).
compute phmean(:,#cols) = rsum(hABCD)/i.
compute ipmean = ipmean+ hABCD.
compute hpmean(:,#cols) = rsum(hABCD)/i.
compute cntfirst = cntfirst + i.
compute cntlast = cntlast + i.
end loop.

compute pmean = rsum(hpmean)/h.
compute hmean = csum(phmean)/p.
compute mean = csum(pmean)/p.
compute ipmean = ipmean/h.

compute Tp = (i*h)*(mssq(pmean)).
compute Th = (p*i)*(mssq(hmean)).
compute Tip = h*(mssq(ipmean)).
compute Thp = (i*(mssq(hpmean))).
compute Tihp = mssq(scores).
compute Tu = p*i*h*mean*mean.

* sum of squares.
compute pss = Tp-Tu.
compute ipss = Tip-Tp.
compute hpss = Thp-Tp.
compute ihpss = Tihp-Tip-Thp+Tp.
compute sstot = pss+ipss+hpss+ihpss.

* mean squares.
compute pms = pss/dfp.
compute ipms = ipss/dfip.
compute hpms = hpss/dfhp.
compute ihpms = ihpss/dfihp.

* variance components: Brennan, 2001, p 79, 83, 85, 442.
compute vcs = t(inv({ i*h,h,i,1; 0,h,0,1; 0,0,i,1; 0,0,0,1 })
              *  { pms; ipms; hpms; ihpms }).
* setting negative variances to zero.
loop #luper = 1 to ncol(vcs).
do if (vcs(1,#luper) < 0).
compute vcs(1,#luper) = 0.
print /title=
  'One or more negative variance estimates have been set to zero'.
end if.
end loop.
compute pvar   = vcs(1,1).
compute ipvar  = vcs(1,2).
compute hpvar  = vcs(1,3).
compute ihpvar = vcs(1,4).
compute totvar = msum(vcs).

* relative and absolute error variances.
compute relv = (ipvar/i)+(hpvar/h)+(ihpvar/(i*h)).
compute absv = relv.

* matrices for D-studies.
compute persons  = { 1, 1, 1, 1 }.
compute vfacet1  = { 0, i, 0, i }.
compute vfacet2  = { 0, 0, h, h }.

print {dfp,pss,pms,pvar,(pvar/totvar);
  dfip,ipss,ipms,ipvar,(ipvar/totvar); 
  dfhp,hpss,hpms,hpvar,(hpvar/totvar);
  dfihp,ihpss,ihpms,ihpvar,(ihpvar/totvar) }
 /format "f12.3"
 /title = "ANOVA Table:"
 /clabels = "df","SS","MS","Variance","Proport."
 /rlabels = "P","F1*P","F2*P","F1*F2:P".

end if.


* two-facet nested design, as in F1 : F2 : P.
do if type = 8.

* degrees of freedom.
compute dfp = (nrow(scores) -1).
compute dfhp = p*(h-1).
compute dfihp = p*h*(i-1).
compute dftot = dfp+dfhp+dfihp.

* pointers/counters.
compute cntfirst = 1.
compute cntlast = i.

* raw data computations.
compute pmean = make(p,1,0).
compute phmean = make(p,h,-9999).
compute hpmean = make(p,h,-9999).
loop #cols = 1 to h.
compute hABCD = scores(:, cntfirst:cntlast).
compute phmean(:,#cols) = rsum(hABCD)/i.
compute hpmean(:,#cols) = rsum(hABCD)/i.
compute cntfirst = cntfirst + i.
compute cntlast = cntlast + i.
end loop.

compute pmean = rsum(hpmean)/h.
compute hmean = csum(phmean)/p.
compute mean = csum(pmean)/p.

compute Tp = (i*h)*(mssq(pmean)).
compute Th = (p*i)*(rssq(hmean)).
compute Thp = (i*(mssq(hpmean))).
compute Tihp = mssq(scores).
compute Tu = p*i*h*mean*mean.

* sum of squares.
compute pss = Tp-Tu.
compute hpss = Thp-Tp.
compute ihpss = Tihp-Thp.
compute sstot = pss+hpss+ihpss.

* mean squares.
compute pms = pss/dfp.
compute hpms = hpss/dfhp.
compute ihpms = ihpss/dfihp.

* variance components: Brennan, 2001, p 79, 83, 85, 442.
compute vcs = t(inv({ i*h,i,1; 0,i,1; 0,0,1 }) 
              * { pms; hpms; ihpms }).
* setting negative variances to zero.
loop #luper = 1 to ncol(vcs).
do if (vcs(1,#luper) < 0).
compute vcs(1,#luper) = 0.
print /title=
  'One or more negative variance estimates have been set to zero'.
end if.
end loop.
compute pvar   = vcs(1,1).
compute hpvar  = vcs(1,2).
compute ihpvar = vcs(1,3).
compute totvar = msum(vcs).

* relative and absolute error variances.
compute relv =  (hpvar/h)+(ihpvar/(i*h)).
compute absv = relv.

* matrices for D-studies.
compute persons  = { 1, 1, 1 }.
compute vfacet1  = { 0, 0, i }.
compute vfacet2  = { 0, h, h }.

print {dfp,pss,pms,pvar,(pvar/totvar); 
 dfhp,hpss,hpms,hpvar,(hpvar/totvar);
 dfihp,ihpss,ihpms,ihpvar,(ihpvar/totvar)}
 /format "f12.3"
 /title = "ANOVA Table:"
 /clabels = "df","SS","MS","Variance","Proport."
 /rlabels = "P","F2:P","F1:F2:P".

end if.


* G & phi coefficients.
compute relG = pvar/(pvar+relv).
compute absG = pvar/(pvar+absv).

print { relv,absv } /format "f12.3"
 /title = "Error Variances:" /clabels = "Relative","Absolute".

print { relG,absG } /format "f12.3"
 /title = "G-coefficients:" /clabels = "G", "Phi".


* D study.

print /title = 'D-Study:' / space = 2.
print dfacet1 /title = 'Entered D-Study values for Facet 1:'.
print dfacet2 /title = 'Entered D-Study values for Facet 2:' .

compute dabsv  = t(dfacet1).
compute drelv  = dabsv.
compute drelG  = dabsv.
compute dabsG  = dabsv.
compute dabsv2  = { -9999, -9999, -9999 }.
compute drelv2  = dabsv2.
compute drelG2  = dabsv2.
compute dabsG2  = dabsv2.

do if (type le 2).
compute dfacet2 = 1.
compute vfacet2 = make(1,ncol(vcs),1).
end if.
loop #f2 = 1 to ncol(dfacet2).
compute resdum = make(ncol(dfacet1),4,-9999).
compute counter = 1.
loop #f1 = 1 to ncol(dfacet1).

compute absvdum = 0.
compute relvdum = 0.
loop #lupe = 2 to ncol(vcs).
compute f2dum = 1.
compute f1dum = 1.
do if ( vfacet1(1,#lupe)  > 1 ).
compute f1dum = dfacet1(1,#f1).
end if.
do if ( vfacet2(1,#lupe) > 1 ).
compute f2dum = dfacet2(1,#f2).
end if.
compute absvdum = absvdum + ( vcs(1,#lupe) / (f1dum * f2dum ) ).
do if ( persons(1,#lupe) ne 0 ).
compute relvdum = relvdum + ( vcs(1,#lupe) / (f1dum * f2dum ) ).
end if.
end loop.
compute gdum = vcs(1,1) / ( vcs(1,1) + relvdum ).
compute pdum = vcs(1,1) / ( vcs(1,1) + absvdum ).

compute resdum(counter,:) = { absvdum, relvdum, gdum, pdum }.

compute dabsv2 = { dabsv2; dfacet2(1,#f2), dfacet1(1,#f1), absvdum }.
compute drelv2 = { drelv2; dfacet2(1,#f2), dfacet1(1,#f1), relvdum }.
compute drelG2 = { drelG2; dfacet2(1,#f2), dfacet1(1,#f1), gdum }.
compute dabsG2 = { dabsG2; dfacet2(1,#f2), dfacet1(1,#f1), pdum }.

compute counter = counter + 1.
end loop.

compute dabsv = { dabsv , resdum(:,1) }.
compute drelv = { drelv , resdum(:,2) }.
compute drelG = { drelG , resdum(:,3) }.
compute dabsG = { dabsG , resdum(:,4) }.
end loop.

compute dabsv2 = dabsv2(2:nrow(dabsv2),:).
compute drelv2 = drelv2(2:nrow(drelv2),:).
compute drelG2 = drelG2(2:nrow(drelG2),:).
compute dabsG2 = dabsG2(2:nrow(dabsG2),:).

print /title=
 "In the D-study results below, the levels of Facet 1 appear in"/space=2.
print /title=
 "the first column, and the levels of Facet 2 appear in the first row.".

print {0,dfacet2;dabsv} /format "f8.3"
  /title="D-Study Absolute Error Variances".
print {0,dfacet2;drelv} /format "f8.3"
  /title="D-Study Relative Error Variances".
print {0,dfacet2;drelG} /format "f8.3"
  /title="D-Study G Coefficients".
print {0,dfacet2;dabsG} /format "f8.3"
  /title="D-Study Phi Coefficients".

* saving data for plots.
do if ( graphdat = 1).
save dabsv2 /outfile=* / var = facet2 facet1 gstat.
end if.
do if ( graphdat = 2).
save drelv2 /outfile=* / var = facet2 facet1 gstat.
end if.
do if ( graphdat = 3).
save drelG2 /outfile=* / var = facet2 facet1 gstat.
end if.
do if ( graphdat = 4).
save dabsG2 /outfile=* / var = facet2 facet1 gstat.
end if.

end matrix.


GRAPH title=
 'Gstat is the coefficient you specified on the COMPUTE GRAPHDAT= statement'
  /LINE(MULTIPLE) = mean(gstat) by facet1 by facet2 .

* The PLOT command is not available in SPSS 12, but
  it can be used for earlier versions.
* plot vsize=15 / hsize=50 / format=contour(3)
   / plot = gstat with facet1 by facet2.


