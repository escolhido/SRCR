library(neuralnet)
library(hydroGOF)
library("arules")

setwd("~/UM/terceiro/SRCR/SRCR/ex3")

dados <- read.csv("dados/exaustao - Dados Normalizados.csv")

#dados$Performance.DMSMean <- as.numeric(discretize(dados$Performance.DMSMean, method = "frequency", categories = 10))#, labels = c(1,2,3,4)))


treino <- dados[which(seq(nrow(dados)) %/% 15 %% 2 == 0),]
teste <- dados[which(seq(nrow(dados)) %/% 15 %% 2 == 1),]


#formula01 <- ExhaustionLevel + Performance.Task ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean
formula01 <- Performance.Task ~ Performance.DMSMean + Performance.ADMSLMean + Performance.DDCMean
rnafatig <- neuralnet(formula01, treino, hidden = c(2), lifesign = "full", linear.output = FALSE, threshold = 0.1, algorithm = 'rprop+')#, learningrate = 0.3)

plot(rnafatig, rep="best")

teste.01 <- subset(teste, select = c("Performance.DMSMean", "Performance.ADMSLMean", "Performance.DDCMean"))

rnafatig.resultados <- compute(rnafatig, teste.01)

resultados <- data.frame(atual = teste$Performance.Task, previsao = rnafatig.resultados$net.result)

resultados$previsao <- round(resultados$previsao, digits = 3)

rmse(c(resultados$atual), c(resultados$previsao))
