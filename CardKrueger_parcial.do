* Set directory to data file directory
*****CardKrueger1994****

rename t post
describe

***Balanced data
list id fte treated post bk kfc roys wendys in 1/10, sep(2) nolabel

***Baseline
sum treated bk kfc roys wendys if treated ==1 & post ==0

sum treated bk kfc roys wendys if treated ==0 & post ==0

***Estimate and compare means
* Treated
sum fte if treated ==1 & post==1

* Control
sum fte if treated ==0 & post==1

* DiD estimator
di y_tpost - y_tpre - (y_cpost - y_cpre)

**DiD estimator is not statistically significant at 0.05
reg fte i.treated##i.post, robust

*Predictions with marginal effects
* Predictive margins
margins treated, at(post=(0 1))

* Marginal effects
margins, dydx(treated) at(post=(0 1))


obs: dy/dx for factor levels is the discrete change from the base level.

*Adding covariates
reg fte i.treated##i.post kfc roys wendys, robust

*And next?
tab chaintype treated if post ==0

tabstat fte, by(chaintype) stats(N mean sd)
Summary for variables: fte by categories of: chaintype