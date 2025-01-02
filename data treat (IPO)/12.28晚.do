import excel "D:\github\xiaonuo\data treat\12.28.xlsx", sheet("import") firstrow
destring Stkcd Year , replace
xtset Stkcd Year
gen Salary_1= Salary_per/1000000
gen Size_1= Size/1000000
generate Number_1 = Number/1000
winsor2 Number_1, cuts(1 99)

generate Post = (Year >= 2015)
drop lnDid
drop Did
gen Did = Swap*Post
gen lnDid = lnSwap*Post



xtreg lnNumber lnDid Age lnpopul Fin Salary_1 Size_1 if Year >= 2010 & Year <= 2018,fe
estimates store e1
global x2 Age Salary_per Tax lnpopul Fin Salary_1 Size_1
xtreg lnNumber lnDid $x2 if Year >= 2010 & Year <= 2018,fe i(Year)
global x2 Age Tax lnpopul Fin Salary_1 Size_1
xtreg lnNumber lnDid $x2 if Year >= 2010 & Year <= 2018,fe i(Year)
estimates store e2
esttab e1 e2 using xtreg_2ln.doc, replace


sum
gen lnSize=log(Size)
gen lnSalary=log( Salary_per )
gen lnAgdp=log(Agdp)


global x2 Age Leverage Tax PPE Agdp Finvstct Loan Exp Fin Wage Jobholders Population lnpopul lnWage lnJobh lnFinvstct lnAgdp lnSalary lnSize
oneclick lnNumber $x2, method(xtreg) pvalue( 0.1) fixvar(lnDid) options(fe)
