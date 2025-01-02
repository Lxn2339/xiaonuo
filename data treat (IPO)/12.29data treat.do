doedit "E:\桌面\数据\12.26（Did基准）.do" 
do "D:\stata15\temp\STD17ec_000000.tmp"
destring Stkcd Year , replace
xtset Stkcd Year
gen Salary_1= Salary_per/1000000
gen Size_1= Size/1000000
generate Number_1 = Number/1000
gen lnSize=log(Size)
gen lnSalary=log( Salary_per )
gen lnAgdp=log(Agdp)
gen lnNumber=log(Number)
gen lnSwap=log(Swap)
sum
drop lnSwap
gen lnSwap=log(Swap+1)
sum
label variable AM "第三产业占GDP比值"
scatter lnSwap Leverage
drop if Leverage > 50
scatter lnSwap Leverage
drop if Leverage > 20
scatter lnSwap Leverage
scatter lnSwap Tax
drop if Tax < -50 | Tax > 50
scatter lnSwap Tax
drop if Tax < -20 | Tax > 20
scatter lnSwap Tax
sum
save "D:\github\xiaonuo\data treat\12.29.dta"
global x1 Age Leverage Tax PPE  lnpopul Fin Exp lnInvcscT lnWage lnJobh lnSalary lnAgdp lnSize
oneclick lnNumber $x1, method(xtreg) pvalue( 0.1) fixvar(lnSwap) options(fe)
global x1 Age Leverage Tax PPE  lnpopul Fin Exp InvcscT lnWage lnJobh lnSalary lnAgdp lnSize
oneclick lnNumber $x1, method(xtreg) pvalue( 0.1) fixvar(lnSwap) options(fe)

replace lnSwap = 0 if missing(lnSwap)
global x1 Age Leverage Tax PPE  lnpopul Fin Exp lnWage lnJobh lnSalary lnAgdp lnSize
xtreg lnNumber lnSwap $x1 if Year >= 2010 & Year <= 2018 , fe i(Year)
estimates store h1
outreg2 h1 using xtreg_1.doc, replace


save "D:\github\xiaonuo\data treat\12.29.dta", replace
