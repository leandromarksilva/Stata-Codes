*** Set directory to data file directory Woman.DTA******

table tempo if tratado == 1, c(mean renda)
table tempo, c(mean renda) by (tratado)
bysort tempo: sum renda if tratado == 1

table tempo if tratado == 1, c(mean escolaridade mean idade mean luz mean conjuge)
ttest escolaridade if tratado == 1, by(tempo)
ttest idade if tratado == 1, by(tempo)
ttest luz if tratado == 1, by(tempo) 
ttest conjuge if tratado == 1, by(tempo) 


reg escolaridade tempo if tratado == 1
reg idade tempo if tratado == 1
reg luz tempo if tratado == 1
reg conjuge tempo if tratado == 1

table tratado if tempo==1, c(mean renda)
bysort tratado: tabstat renda if tempo ==1

table tratado if tempo ==1, c(mean escolaridade mean idade mean luz mean conjuge)

ttest renda if tempo == 1, by(tratado)

ttest escolaridade if tempo == 1, by(tratado)
ttest idade if tempo==1, by(tratado) 
ttest luz if tempo == 1, by(tratado)
ttest conjuge if tempo == 1, by(tratado)

reg renda tratado if tempo == 1
ttest renda if tempo == 1, by(tratado)
table tratado if tempo==1, c(mean renda)

reg escolaridade tratado if tempo == 1
reg idade tratado if tempo==1
reg luz tratado if tempo == 1
reg conjuge tratado if tempo==1