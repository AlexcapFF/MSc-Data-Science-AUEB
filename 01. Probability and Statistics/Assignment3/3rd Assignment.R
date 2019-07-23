#=============================
#       3rd Assignment
#=============================

#install.packages("TeachingDemos")
library(TeachingDemos)
#install.packages("XLConnect")
library(XLConnect)
#install.packages("nortest")
library(nortest)
#install.packages("gplots")
library(gplots)
#install.packages("agricolae")
library(agricolae)
library(lattice)
#install.packages("alr3")
library(alr3)
#install.packages("leaps")
library(leaps)


wb = loadWorkbook("C:/Users/akaplanis/Desktop/MSc_Data_Science/Courses/1st_Trimester/Probability&Statistics_for_DataAnalysis/3. Assignment/Assignment 3/Assignment_3_Data.xlsx")
df1 = readWorksheet(wb, sheet = "Data1", header = TRUE)
df2 = readWorksheet(wb, sheet = "Data2", header = TRUE)

#==============================
#          Exercise 1
#==============================


#Boxplots

df1_temp <- melt(df1, id.vars='W', measure.vars=c('Y','X1','X2','X3'))


boxplot(value~W, df1_temp ,col=5:7)
legend("topleft",title="W",c("A","B","C"),fill=2:4)


#Anova
fit1<-aov(value~factor(W), df1_temp)
summary(fit1)


#Test normality of the residuals
qqnorm(fit1$residuals,main="NPP for residuals")
qqline(fit1$residuals,col="red",lty=1,lwd=2)

shapiro.test(fit1$residuals)
lillie.test(fit1$residuals)

#The residual are not normally distributed.
# As alternatives, I would either transform the data to approach normality or
# or use non-parametric methods (Kruskal-Wallis)

#There is no use to proceed with homoscedasticity check since it requires normally
#distributed residuals.

#Scatterplot

super.sym <- trellis.par.get("superpose.symbol")

splom(df1[c(1,2,3,4)], groups=df1$W, data=df1,
      panel=panel.superpose, key=list(title="Scatter Plot",
      columns=3, points=list(pch=super.sym$pch[3:5], col=super.sym$col[3:5]),
      text=list(c("A","B","C"))))


#Linear Regression Model

fit2 <- lm(Y~X1+X2+X3+W, df1)
summary(fit2)


#Regression Assumptions

par(mfrow=c(2,2))
plot(fit2)
#According to the plots, the assumptions are true.The residuals are normally distributed
#and they seem to have equal variances.

#Normality Test
shapiro.test(fit2$residuals)
lillie.test(fit2$residuals)

#p-values are significantly high so we can't reject the normality of the residuals

#A possible alternative if the assumptions weren't true, would be to use the logY.


#Model Selection

fitnull<-lm(Y ~ 1, df1)
stepFS<-step(fitnull, scope=list(lower = ~ 1, upper= ~ X1 +X2 + X3 +W), direction="both", data=df1)

#The stepwise regression shows that the model cannot be reduced further

leaps<-regsubsets(Y ~ X1 + X2 + X3 +W,data= df1, nbest=1)
summary(leaps)

#Same with all subsets regression

#Predictions

X1 = 3.1
X2 = 3.75
X3 = 1.2
W = 'A'

df1_pe <- data.frame(X1,X2,X3,W)

predict(fit2, df1_pe, interval="predict") 



#==============================
#          Exercise 2
#==============================

#Boxplots

boxplot(Y~W, df2)
boxplot(Y~Z, df2)

boxplot(Y~W*Z,df2, main="Y versus interaction of W and Z",xlab="Combinations of W and Z", lab="Y",col=2:5)

#Interaction Plot

interaction.plot(df2$W,df2$Z,df2$Y,type="b",
                 col=c(1:4), 
                 leg.bty="o", 
                 lwd=2, 
                 pch=c(18,24), 
                 trace.label="Z",
                 xlab="W", 
                 ylab="Mean of Y")

#Anova

fit3<-aov(Y~W*Z,df2)
summary(fit3)


layout(matrix(1:4,2,2))
plot(fit3)

#According to the plots, it is obvious that the residuals are not normally distributed
#so the Anova results cannot be trusted.