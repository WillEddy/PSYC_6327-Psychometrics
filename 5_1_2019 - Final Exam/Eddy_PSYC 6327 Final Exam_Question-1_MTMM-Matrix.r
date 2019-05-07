# Question 1: MTMM

Ave_MTHM <- (mean(c(.63,.55,.53,.72,.68,
                    .62,.49,.8,.54,.44,.5,.7)))
C1 <- Ave_MTHM
C1


# Easiest to copy paste matrix in this vertical format 
# and less chance of typos - less typing
Ave_HTHM <- (mean(c(.4,
                    .39,
                    .27,
                    .42,
                    .22,
                    .17,
                    0.48,
                    0.45,
                    0.31,
                    0.41,
                    0.28,
                    0.27,
                    0.37,
                    0.30,
                    0.40,
                    0.32,
                    0.20,
                    0.24,
                    0.38,
                    0.42,
                    0.24,
                    0.23,
                    0.39,
                    0.41,
                    0.34,
                    0.28,
                    0.22,
                    0.36,
                    0.31,
                    0.26,
                    0.34,
                    0.21,
                    0.28
                    )))
D1 <- Ave_MTHM - Ave_HTHM
D1


Ave_HTMM <- (mean(c(0.43,
                    0.38,
                    0.31,
                    0.48,
                    0.22,
                    0.30,
                    0.51,
                    0.45,
                    0.51,
                    0.38,
                    0.28,
                    0.24,
                    0.60,
                    0.49,
                    0.51,
                    0.38,
                    0.32,
                    0.30
)))

D2 <- Ave_MTHM - Ave_HTMM
D2

MV <- Ave_HTMM - Ave_HTHM
MV
