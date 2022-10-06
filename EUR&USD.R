rm(list=ls())

#Michal Wysocki

# install.packages("ggplot2")
# install.packages("dplyr")

library(ggplot2)
library(dplyr)


getNBPRates=function(year) {http = paste ("https://www.nbp.pl/kursy/Archiwum/archiwum_tab_a_",year,".csv", sep="")
  
df=as.data.frame(read.csv2(url(http)), dec=".")
df = df[-1,]

df$data=as.Date(as.character(df$data), format = "%Y%m%d")

df=select(df, c(1, 3, 9))
names(df)[1]="date"
names(df)[2]="usd"
names(df)[3]="eur"

df$usd=sub(",",".",df$usd)
df$usd=as.numeric(df$usd)

df$eur=sub(",",".",df$eur)
df$eur=as.numeric(df$eur)
  
df

}

dane=rbind(getNBPRates(2013),getNBPRates(2014),getNBPRates(2015),getNBPRates(2016),
           getNBPRates(2017),getNBPRates(2018),getNBPRates(2019),getNBPRates(2020))
dane=dane[complete.cases(dane),]


wyk=ggplot(dane, aes(x = date)) +
  geom_line(aes(y=usd), color="blue")+
  geom_line(aes(y=eur), color="red")+
  scale_x_date(date_breaks ="2 year", date_labels = "%Y")+
  labs(x = "", y="", title="Current exchange rate EUR and USD to (PLN)")+
  theme_bw()
x11();print(wyk)