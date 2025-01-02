doedit "E:\桌面\数据\12.26（Did基准）.do" 
import excel "D:\github\xiaonuo\data treat\12.28.xlsx", sheet("Sheet1") firstrow
clear
import excel "D:\github\xiaonuo\data treat\12.28.xlsx", sheet("import") firstrow

destring Stkcd Year , replace
xtset Stkcd Year
gen Salary_1= Salary_per/1000000
gen Size_1= Size/1000000
global x1 Age Salary_per Leverage Tax PPE RD RDPerson Agdp lnJobh lnpopul lnWage InvcscT Exp Fin lnFinvstct Salary_1 Size_1
oneclick lnNumber $x1, method(xtreg) pvalue( 0.1) fixvar(Swap) options(fe)
generate lnNumber = log(Number)
oneclick lnNumber $x1, method(xtreg) pvalue( 0.1) fixvar(Swap) options(fe)
winsor2 lnNumber, cuts(1 99)
ssc install winsor2
winsor2 lnNumber, cuts(1 99)
oneclick lnNumber $x1, method(xtreg) pvalue( 0.1) fixvar(Swap) options(fe)
gen lnNumber= log(Number+1)


drop lnNumber
gen lnNumber= log(Number+1)
winsor2 lnNumber, cuts(1 99)
drop lnNumber_w

