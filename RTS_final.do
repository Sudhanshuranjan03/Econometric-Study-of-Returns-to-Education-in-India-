use "C:\Users\dunge\Downloads\PLFS2017-18_HH_Person_merged(main).dta" //Importing the dataset for performing regression
replace ERSWA_1=1 if ERSWA_1==0 // Imputing missing values for regular salaried/ wage employees
tab GEL // checking various categories of the general education level
tab GEL, nolabel // checking numeric codes of various categories of the general education level
recode GEL (2=.) (3=.) (4=.), gen(GEL_newf) //Excluding the categories which are not neccesary for our analysis and forming a new variable which conatins only the relevant variable
label variable GEL_newf "New GEL Variable" //imputing label for the new variable
label values GEL_newf GEL // copying the labels to the new variable
gen age_sq=age^2 // forming a new variable which is the sqauare of age
tab TEL // checking various categories of the techincal education level
tab TEL, nolabel // checking numeric codes of various categories of the techincal education level
recode TEL (7=.) (8=.) (9=.) (10=.)(11=.)(12=.)(13=.)(14=.)(15=.)(16=.), gen(TEL_newf) //Excluding the categories which are not neccesary for our analysis and forming a new variable which conatins only the relevant variable
label variable TEL_newf "New TEL Variable" //imputing label for the new variable
label values TEL_newf TEL // copying the labels to the new variable
keep if P_status_cd==31 // removing all other categories other than "Worked as regular salaried/ wage employees"
gen logwage=log( ERSWA_1 ) // taking log of ERSWA_1 to tackle skewness in data
reg logwage i.TEL_newf i.sex age age_sq YFE hh_size i.MS  ib(2).sector ib(3).social_grp // regression of logwage on techincal education level and other control variables
reg logwage i.GEL_newf i.sex age age_sq YFE hh_size i.MS  ib(2).sector ib(3).social_grp // regression of logwage on techincal education level and other control variables