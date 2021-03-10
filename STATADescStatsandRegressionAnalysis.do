*****Main Codes for Senior Thesis: Sol

***Clear Space
clear
set more off
***Import Data
import excel "/Users/solbenishay/Desktop/School/2020:21/Winter/Thesis/Econometric Analysis/Data/stata_data.xlsx", sheet("Sheet1") firstrow

***Summary Statistics

**Descriptive Statistics for % Change in Share Price & Volume
asdoc tabstat one_m_diff_shareprice three_m_diff_shareprice six_m_diff_shareprice one_y_diff_shareprice one_m_diff_volume three_m_diff_volume six_m_diff_volume one_y_diff_volume, stat(count mean median sd min max) format(%9.3g) varwidth(35) ///
columns(statistics), replace save(/Users/solbenishay/Desktop/descriptivestats.doc)

**Frequency Table of Categorical Variables
asdoc tab1 Exchange SharingFirmIntroduced RelatednesswithSharingFirm, replace save(/Users/solbenishay/Desktop/catfreqtable.doc)
*tabulate twoway Exchange SharingFirmIntroduced RelatednesswithSharingFirm, col sc contents(freq) replace 
**tabout SharingFirmIntroduced RelatednesswithSharingFirm Exchange using "/Users/solbenishay/Desktop/catfreqtable.doc", replace ///
**c(freq col) f(0c 1) style(docx)

***Convert Dates to Dates
gen one_m_period_ending = date(Date_Endt1, "YMDhms")
format one_m_period_ending %td
gen three_m_period_ending = date(Date_Endt3, "YMDhms")
format three_m_period_ending %td
gen six_m_period_ending = date(Date_Endt6, "YMDhms")
format six_m_period_ending %td
gen one_y_period_ending = date(Date_Endt12, "YMDhms")
format one_y_period_ending %td


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
reg one_m_diff_shareprice ISF CI one_m_diff_volume NASDAQ NYSE c.ISF#c.CI c.ISF#c.one_m_diff_volume c.ISF#c.NASDAQ c.ISF#c.NYSE, vce(robust)
est store a4
**Residuals vs. Fits
rvfplot, yline(0)
predict r1, residual
qnorm r1
**Residuals vs. Time
scatter r1 one_m_period_ending

esttab a1 a2 a3 a4 using "/Users/solbenishay/Desktop/onemonthregoutput.rtf", ///
star( * 0.10 ** 0.05 *** 0.01 ) ar2 nodepvars interaction(!) onecell replace title("Regression Output for t = One Month") notes addnotes("[1] Standard Errors are 'STATA' heteroscedasticity robust")


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
reg three_m_diff_shareprice ISF CI three_m_diff_volume NASDAQ NYSE c.ISF#c.CI c.ISF#c.three_m_diff_volume c.ISF#c.NASDAQ c.ISF#c.NYSE, vce(robust)
est store b4
**Residuals vs. Fits
rvfplot, yline(0)
predict r2, residual
qnorm r2
**Residuals vs. Time
scatter r2 three_m_period_ending

esttab b1 b2 b3 b4 using "/Users/solbenishay/Desktop/threemonthregoutput.rtf", ///
star( * 0.10 ** 0.05 *** 0.01 ) ar2 nodepvars interaction(!) onecell replace title("Regression Output for t = Three Months") notes addnotes("[1] Standard Errors are 'STATA' heteroscedasticity robust")


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
reg six_m_diff_shareprice ISF CI six_m_diff_volume NASDAQ NYSE c.ISF#c.CI c.ISF#c.six_m_diff_volume c.ISF#c.NASDAQ c.ISF#c.NYSE, vce(robust)
est store c4
**Residuals vs. Fits
rvfplot, yline(0)
predict r3, residual
qnorm r3
**Residuals vs. Time
scatter r3 six_m_period_ending

esttab c1 c2 c3 c4 using "/Users/solbenishay/Desktop/sixmonthregoutput.rtf", ///
star( * 0.10 ** 0.05 *** 0.01 ) ar2 nodepvars interaction(!) onecell replace title("Regression Output for t = Six Months") notes addnotes("[1] Standard Errors are 'STATA' heteroscedasticity robust")


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
reg one_y_diff_shareprice ISF CI one_y_diff_volume NASDAQ NYSE c.ISF#c.CI c.ISF#c.one_y_diff_volume c.ISF#c.NASDAQ c.ISF#c.NYSE, vce(robust)
est store d4
**Residuals vs. Fits
rvfplot, yline(0)
predict r4, residual
qnorm r4
**Residuals vs. Time
scatter r4 one_y_period_ending


esttab d1 d2 d3 d4 using "/Users/solbenishay/Desktop/oneyearregoutput.rtf", ///
star( * 0.10 ** 0.05 *** 0.01 ) ar2 nodepvars interaction(!) onecell replace title("Regression Output for t = One Year") notes addnotes("[1] Standard Errors are 'STATA' heteroscedasticity robust")

