dat <- read.csv("LoanStats3d.csv", header = F)
head(dat)
dat = dat[-1,] #delete the first row with website

name<-as.vector(as.matrix(dat[1,]))
names(dat)<-name # set first row as names
dat<-dat[-1,]

head(dat) # finish clean data

library(ggplot2)

# 
dat.int=dat[,c(7,21)]
head(dat.int)
dat.int$int_rate = as.numeric(as.character(dat.int$int_rate))*100

ggplot(dat.int, aes(purpose, int_rate))+
  geom_boxplot(aes(fill = purpose), outlier.shape = NA)+
  geom_jitter(alpha = 0.1, position = position_jitter(width = 0.1))
# histogram of the number of default grouped by the type of home_ownership
dat.delinq=dat[,c(13,26)]
dat.delinq = cbind(dat.delinq,dat.delinq$delinq_2yrs)
dat.delinq$delinq_2yrs<-as.numeric(as.character(dat.delinq$delinq_2yrs))
names(dat.delinq)[3]<-"delinq_num"
dat.delinq$delinq_num[dat.delinq$delinq_2yrs>5]<-6
ggplot(data = dat.delinq[dat.delinq$delinq_2yrs!=0,], aes(x = delinq_num))+facet_wrap(~home_ownership)+geom_histogram(aes(fill = ..count..))


