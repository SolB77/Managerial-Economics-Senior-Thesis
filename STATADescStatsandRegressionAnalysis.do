*****Main Codes for Senior Thesis: Sol

***Clear Space
clear
set more off
***Import Data
import excel "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Data/stata_data.xlsx", sheet("Sheet1") firstrow

***Summary Statistics

**Descriptive Statistics for % Change in Share Price/Volume/S&P500
outreg2 using "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Regression Output:Visualizations/Summary Statistics/descriptivestats.tex",tex(frag) replace sum(log) keep(six_m_diff_shareprice one_y_diff_shareprice two_y_diff_shareprice three_y_diff_shareprice six_m_diff_volume one_y_diff_volume two_y_diff_volume three_y_diff_volume six_m_diff_sp500 one_y_diff_sp500 two_y_diff_sp500 three_y_diff_sp500) eqkeep(N mean median sd min max)
*one_m_diff_shareprice three_m_diff_shareprice one_m_diff_volume three_m_diff_volume one_m_diff_sp500 three_m_diff_volume

**Frequency Tables of Categorical Variables

*Exchange
tabout Exchange using "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Regression Output:Visualizations/Summary Statistics/ExchangeFreqTable.tex", replace body style(tex) c(freq col)
*SharingFirmIntroduced
tabout SharingFirmIntroduced using "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Regression Output:Visualizations/Summary Statistics/ISFFreqTable.tex", replace body style(tex) c(freq col)
*RelatednesswithSharingFirm
tabout RelatednesswithSharingFirm using "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Regression Output:Visualizations/Summary Statistics/CIFreqTable.tex", replace body style(tex) c(freq col)


***Convert Datetimes to Dates

gen one_m_period_ending = dofc(Date_Endt1)
format one_m_period_ending %td
gen three_m_period_ending = dofc(Date_Endt3)
format three_m_period_ending %td
gen six_m_period_ending = dofc(Date_Endt6)
format six_m_period_ending %td
gen one_y_period_ending = dofc(Date_Endt12)
format one_y_period_ending %td
gen two_y_period_ending = dofc(Date_Endt24)
format two_y_period_ending %td
gen three_y_period_ending = dofc(Date_Endt36)
format three_y_period_ending %td


****Regression Analyses/Residual Plots

***Regression Analysis for One Month
**Model 1: 
reg one_m_diff_shareprice ISF CI, vce(robust)
est store a1
**Model 2: 
reg one_m_diff_shareprice ISF CI one_m_diff_volume, vce(robust)
est store a2
**Model 3: 
reg one_m_diff_shareprice ISF CI one_m_diff_volume NASDAQ NYSE, vce(robust)
est store a3
**Model 4: 
reg one_m_diff_shareprice ISF CI one_m_diff_volume NASDAQ NYSE one_m_diff_sp500, vce(robust)
est store a4
**Model 5: 
reg one_m_diff_shareprice ISF CI one_m_diff_volume NASDAQ NYSE one_m_diff_sp500 c.ISF#c.CI c.ISF#c.one_m_diff_volume c.ISF#c.NASDAQ c.ISF#c.NYSE c.ISF#c.one_m_diff_sp500, vce(robust)
est store a5
**Residuals vs. Fits
rvfplot, yline(0)
**Q-Q Plot
predict r1, residual
qnorm r1
**Residuals vs. Time
scatter r1 one_m_period_ending

esttab a1 a2 a3 a4 a5 using "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Regression Output:Visualizations/Regression Output/STATA/onemonthregoutput.tex", ///
tex star( * 0.10 ** 0.05 *** 0.01 ) b(3) ar2 nodepvars interaction(!) scalar(F) replace title("Regression Output for t = One Month") notes addnotes("[1] Standard Errors are 'STATA' heteroscedasticity robust")


***Regression Analysis for Three Months
**Model 1: 
reg three_m_diff_shareprice ISF CI, vce(robust)
est store b1
**Model 2: 
reg three_m_diff_shareprice ISF CI three_m_diff_volume, vce(robust)
est store b2
**Model 3: 
reg three_m_diff_shareprice ISF CI three_m_diff_volume NASDAQ NYSE, vce(robust)
est store b3
**Model 4: 
reg three_m_diff_shareprice ISF CI three_m_diff_volume NASDAQ NYSE three_m_diff_sp500, vce(robust)
est store b4
**Model 5: 
reg three_m_diff_shareprice ISF CI three_m_diff_volume NASDAQ NYSE three_m_diff_sp500 c.ISF#c.CI c.ISF#c.three_m_diff_volume c.ISF#c.NASDAQ c.ISF#c.NYSE c.ISF#c.three_m_diff_sp500, vce(robust)
est store b5
**Residuals vs. Fits
rvfplot, yline(0)
**Q-Q Plot
predict r2, residual
qnorm r2
**Residuals vs. Time
scatter r2 three_m_period_ending

esttab b1 b2 b3 b4 b5 using "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Regression Output:Visualizations/Regression Output/STATA/threemonthregoutput.tex", ///
tex star( * 0.10 ** 0.05 *** 0.01 ) b(3) ar2 nodepvars interaction(!) scalar(F) replace title("Regression Output for t = Three Months") notes addnotes("[1] Standard Errors are 'STATA' heteroscedasticity robust")


***Regression Analysis for Six Months
**Model 1: 
reg six_m_diff_shareprice ISF CI, vce(robust)
est store c1
**Model 2: 
reg six_m_diff_shareprice ISF CI six_m_diff_volume, vce(robust)
est store c2
**Model 3: 
reg six_m_diff_shareprice ISF CI six_m_diff_volume NASDAQ NYSE, vce(robust)
est store c3
**Model 4: 
reg six_m_diff_shareprice ISF CI six_m_diff_volume NASDAQ NYSE six_m_diff_sp500, vce(robust)
est store c4
**Model 5: 
reg six_m_diff_shareprice ISF CI six_m_diff_volume NASDAQ NYSE six_m_diff_sp500 c.ISF#c.CI c.ISF#c.six_m_diff_volume c.ISF#c.NASDAQ c.ISF#c.NYSE c.ISF#c.six_m_diff_sp500, vce(robust)
est store c5
**Residuals vs. Fits
rvfplot, yline(0)
**Q-Q Plot
predict r3, residual
qnorm r3
**Residuals vs. Time
scatter r3 six_m_period_ending

esttab c1 c2 c3 c4 c5 using "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Regression Output:Visualizations/Regression Output/STATA/sixmonthregoutput.tex", ///
tex star( * 0.10 ** 0.05 *** 0.01 ) b(3) ar2 nodepvars interaction(!) scalar(F) replace title("Regression Output for t = Six Months") notes addnotes("[1] Standard Errors are 'STATA' heteroscedasticity robust")


***Regression Analysis for One Year
**Model 1: 
reg one_y_diff_shareprice ISF CI, vce(robust)
est store d1
**Model 2: 
reg one_y_diff_shareprice ISF CI one_y_diff_volume, vce(robust)
est store d2
**Model 3: 
reg one_y_diff_shareprice ISF CI one_y_diff_volume NASDAQ NYSE, vce(robust)
est store d3
**Model 4: 
reg one_y_diff_shareprice ISF CI one_y_diff_volume NASDAQ NYSE one_y_diff_sp500, vce(robust)
est store d4
**Model 5: 
reg one_y_diff_shareprice ISF CI one_y_diff_volume NASDAQ NYSE one_y_diff_sp500 c.ISF#c.CI c.ISF#c.one_y_diff_volume c.ISF#c.NASDAQ c.ISF#c.NYSE c.ISF#c.one_y_diff_sp500, vce(robust)
est store d5
**Residuals vs. Fits
rvfplot, yline(0)
**Q-Q Plot
predict r4, residual
qnorm r4
**Residuals vs. Time
scatter r4 one_y_period_ending

esttab d1 d2 d3 d4 d5 using "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Regression Output:Visualizations/Regression Output/STATA/oneyearregoutput.tex", ///
tex star( * 0.10 ** 0.05 *** 0.01 ) b(3) ar2 nodepvars interaction(!) scalar(F) replace title("Regression Output for t = One Year") notes addnotes("[1] Standard Errors are 'STATA' heteroscedasticity robust")


***Regression Analysis for Two Years
**Model 1: 
reg two_y_diff_shareprice ISF CI, vce(robust)
est store e1
**Model 2: 
reg two_y_diff_shareprice ISF CI two_y_diff_volume, vce(robust)
est store e2
**Model 3: 
reg two_y_diff_shareprice ISF CI two_y_diff_volume NASDAQ NYSE, vce(robust)
est store e3
**Model 4: 
reg two_y_diff_shareprice ISF CI two_y_diff_volume NASDAQ NYSE two_y_diff_sp500, vce(robust)
est store e4
**Model 5: 
reg two_y_diff_shareprice ISF CI two_y_diff_volume NASDAQ NYSE two_y_diff_sp500 c.ISF#c.CI c.ISF#c.two_y_diff_volume c.ISF#c.NASDAQ c.ISF#c.NYSE c.ISF#c.two_y_diff_sp500, vce(robust)
est store e5
**Residuals vs. Fits
rvfplot, yline(0)
**Q-Q Plot
predict r5, residual
qnorm r5
**Residuals vs. Time
scatter r5 two_y_period_ending

esttab e1 e2 e3 e4 e5 using "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Regression Output:Visualizations/Regression Output/STATA/twoyearregoutput.tex", ///
tex star( * 0.10 ** 0.05 *** 0.01 ) b(3) ar2 nodepvars interaction(!) scalar(F) replace title("Regression Output for t = Two Years") notes addnotes("[1] Standard Errors are 'STATA' heteroscedasticity robust")

***Regression Analysis for Three Years
**Model 1: 
reg three_y_diff_shareprice ISF CI, vce(robust)
est store f1
**Model 2: 
reg three_y_diff_shareprice ISF CI three_y_diff_volume, vce(robust)
est store f2
**Model 3: 
reg three_y_diff_shareprice ISF CI three_y_diff_volume NASDAQ NYSE, vce(robust)
est store f3
**Model 4: 
reg three_y_diff_shareprice ISF CI three_y_diff_volume NASDAQ NYSE three_y_diff_sp500, vce(robust)
est store f4
**Model 5: 
reg three_y_diff_shareprice ISF CI three_y_diff_volume NASDAQ NYSE three_y_diff_sp500 c.ISF#c.CI c.ISF#c.three_y_diff_volume c.ISF#c.NASDAQ c.ISF#c.NYSE c.ISF#c.three_y_diff_sp500, vce(robust)
est store f5
**Residuals vs. Fits
rvfplot, yline(0)
**Q-Q Plot
predict r6, residual
qnorm r6
**Residuals vs. Time
scatter r6 three_y_period_ending


esttab f1 f2 f3 f4 f5 using "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Regression Output:Visualizations/Regression Output/STATA/threeyearregoutput.tex", ///
tex star( * 0.10 ** 0.05 *** 0.01 ) b(3) ar2 nodepvars interaction(!) scalar(F) replace title("Regression Output for t = Three Years") notes addnotes("[1] Standard Errors are 'STATA' heteroscedasticity robust")



