clear all
set more off

use "/Users/parmismey/Desktop/University of Toronto/Fall 2022/ECO375/375 project/Chevalier_Mehdiyar.dta"


// summary stats table

estpost summarize sf12p sf12m net_fam_inc hgcr avg_parental_educ white has_healthcare_provider
esttab using summaries.csv, cells("count mean sd min max") noobs




/*
Project estimation calculations
*/


/*
0. summarize:
*/
sum sf12p
sum sf12m
sum avg_parental_educ


/*
1. Simple OLS:
*/

reg sf12p avg_parental_educ, robust
estimates store a_1

reg sf12m avg_parental_educ, robust
estimates store a_2


//non-linearity through the educ_sq:
reg sf12p avg_parental_educ parental_educ_sq, robust   
estimates store b_1

reg sf12m avg_parental_educ parental_educ_sq, robust
estimates store b_2



// simple reg with controls:
reg sf12p avg_parental_educ hgcr white net_fam_inc has_healthcare_provider, robust
estimates store c_1

reg sf12m avg_parental_educ hgcr white net_fam_inc has_healthcare_provider, robust
estimates store c_2

//non-linearity through the educ_sq with controls:

reg sf12p avg_parental_educ parental_educ_sq hgcr white net_fam_inc has_healthcare_provider, robust
estimates store d_1

reg sf12m avg_parental_educ parental_educ_sq hgcr white net_fam_inc has_healthcare_provider, robust
estimates store d_2


esttab a_1 b_1 c_1 d_1 using physical.csv, ar2 label
esttab a_2 b_2 c_2 d_2 using mental.csv, ar2 label


