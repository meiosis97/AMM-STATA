********************************************************************************
**					Applied Microeconometric Modelling						  **
**							    Tutorial 3									  **
**				     	    Author: MA Linxiang								  **
********************************************************************************

clear all
capture log close

//Set your working directory, path is where you store your data
cd "path..."	
log using ...													

use CardKruegerTute3, clear

***Question 5
//Generate NJ dummy
gen nj = stater
label var nj "New Jersey"

//Generate second period dummy
gen time2 = (time == 2)

//Generate interaction of NJ (treated) and time2 (post)
gen njtime2 = nj*time2

//Generate indicator for firms with both periods of wage
by id: egen x1 = count(wage_st)
by id: egen x2 = total(closed)

//Regression
reg wage_st nj time2 njtime2 if (x2 == 0 & x1 == 2), robust

***Question 6
//DD Estimator
reg emptot nj time2 njtime2 if (x2 == 0 & x1 == 2 | x2 == 1), robust

***Question 7
//DD Estimator with Controls
gen bk = (chainr == 1)
gen kfc = (chainr == 2)
gen roys = (chainr == 3)
gen wendys = (chainr == 4)

reg emptot nj time2 njtime2 bk kfc roys co_owned if (x2 == 0 & x1 == 2 | x2 == 1), robust


log close









