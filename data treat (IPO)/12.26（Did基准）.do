use "D:\github\xiaonuo\data treat\12.17.dta" 

xtset Stkcd Year
global x1 Salary_per Leverage Tax PPE Agdp

reg Number Swap $x1
xtreg Number Swap $x1


*******************2010-2018年Did基准回归，个体固定效应*********************

global x1 Salary_per Leverage Tax PPE Agdp
generate Did = Swap*Year

xtreg Number Swap Did Year $x1
xtreg Number Did $x1
xtreg Number Did $x1, fe
xtreg Number Did $x1  if Year >= 2010 & Year <= 2018,fe

codebook, compact
