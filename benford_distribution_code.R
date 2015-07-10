library(benford.analysis)
library(ggplot2)
digit <- seq(1:9)
Probability <-  round((log(1+(1/ digit),10))*100,0)
Probability_text <- paste(Probability,"%",sep=" ")
benf <- data.frame(digit,Probability)
ggplot(benf, aes(x=digit, y=Probability,fill=Probability)) + geom_bar(position=position_dodge(),stat="identity")+
  scale_x_discrete(breaks=digit, labels=digit)+
  geom_text(data=benf, mapping=aes(x=digit, y=Probability, label=Probability_text), size=7, vjust=-0.3)+
  ylab("Probability of x being the first digit (%)")
  

