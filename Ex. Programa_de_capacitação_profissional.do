*** Set directory to data file directory***

//indicador de impacto - renda
rename rendaRS renda

//variável de intervenção - T
rename TiProgramaTi1participa T

summarize renda
table T

bysort T: summarize renda

//com Teste T:
ttest renda, by(T)

regress renda T
