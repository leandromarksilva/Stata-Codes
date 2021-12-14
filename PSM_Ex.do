 ************************************
 * PSM
 *************************************

* PARTE I
********* 

* See the link: 
* https://www.ssc.wisc.edu/sscc/pubs/stata_psmatch.htm 

*Antes de começar, é necessário instalar o pacote teffects. Antes era o comando "psmatch2"

* Verifique se o teffects está instalado em seu computador
help teffects

* Em caso não esteja instale usando o comando "ssc install"
ssc install teffects


* An Example of Propensity Score Matching: Run the following command in Stata to load an example data set:

use http://ssc.wisc.edu/sscc/pubs/files/psm

* Estatísticas descritivas  

tabstat y x1 x2, by(t) stat(mean median sd min max n) col(stat) long 

by t, sort : summarize y x1 x2



* PARTE II - IMPACTO: O propensity score matching (PSM) é definido por Rosembaum e Rubin(1983) 
*********************

* Supondo que desejamos estimar o impacto segundo o método de seleção aleatória

ttest y, by(t)

* Usando o método de linear
reg y t


* Estimando o impacto usando o PSM

** ATE ** 

* Estimate by default ATE using logit model 

teffects psmatch (y) (t x1 x2)



* Estimate ATE (by default) using a probit model

teffects psmatch (y) (t x1 x2, probit)


** ATT ** 

* Estimate ATT and logit model

teffects psmatch (y) (t x1 x2), atet 


* Estimate ATT and probit model

teffects psmatch (y) (t x1 x2, probit), atet 


* Video - Primeiros passos PSM: https://www.youtube.com/watch?v=hnyh1cUFiOE



* * PARTE III - Postestimation: use  gen(match)
***********************************************

* For example: We need to estimate the ATT usingo logit model

* Generating a id variable: 
gen id =_n

* Put the dataset sort by id 
sort id


* Start with a clean slate by typing:

use http://ssc.wisc.edu/sscc/pubs/files/psm, replace

* Por exemplo, suponha que deseja calcular o ATT usando o logit
teffects psmatch (y) (t x1 x2), atet gen(match) 


* Generating the Propensity Score (PS)
**************************************

* Usando o comando PREDICT para mostrar o propensy score (p)

predict ps0 ps1, ps

*sort ps1

* Mostre a descrição dos dados
des


* Calculando os resultados potenciais 
predict y0 y1, po


* Resumo dos resultados

tebalance summarize  

* Distribuição do PS
tebalance density 

* Box-plot da distribuição
tebalance box


*gen dt_att = 1 if ps1_att > 0.5
*recode dt_att .= 0
*tab dt_att

*pstest bolsa trabalho horas_estudo sexo rend_perc idade, raw treated(dt_att)


*plot pms ps1_att

* ATE - LOGIT
teffects psmatch (med) (bolsa trabalho horas_estudo sexo rend_perc idade, logit), ate nn(1) gen(match_ate)
predict ps0_ate ps1_ate, ps

* ATE Com o psmatch2
* psmatch2 t x1 x2, out(y) logit ate
psmatch2 bolsa trabalho horas_estudo sexo rend_perc idade, out(med) logit ate


*plot pms ps1_ate

tebalance summarize  
tebalance density 
tebalance box

*gen dt_ate = 1 if ps1_ate > 0.5
*recode dt_ate .= 0
*tab dt_att


*gen ob=_n
*sort ob
*predict y0 y1, po



* POSESTIMATION: final
*********************

* https://www.stata.com/manuals/teteffectspostestimation.pdf#teteffectspostestimation
*teffects psmatch (med) (bolsa trabalho horas_estudo sexo rend_perc idade, probit), atet nn(1)
*teffects overlap
*tebalance summarize    // Covariate balance summary: compare means and variances in raw and balanced data
*tebalance density    // density: kernel density plots for raw and balanced data tebalance density idade
*tebalance box   // BOX-PLOT:  box plots for each treatment level for balanced data


