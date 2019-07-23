#=============================
#       2nd Assignment
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



wb = loadWorkbook("C:/Users/akaplanis/Desktop/MSc_Data_Science/Courses/1st_Trimester/Probability&Statistics_for_DataAnalysis/2. Assignment/Assignment_2.xlsx")
df1 = readWorksheet(wb, sheet = "1", header = TRUE)
df2 = readWorksheet(wb, sheet = "2", header = TRUE)
df3 = readWorksheet(wb, sheet = "3", header = TRUE)
df4 = readWorksheet(wb, sheet = "4", header = TRUE)


#==============================
#          Exercise 1
#==============================
 
 #=== a ===

#cl =95%

#Normality tests
#1
ad.test(df1$Pressure_Bfr)
shapiro.test(df1$Pressure_Bfr)
lillie.test(df1$Pressure_Bfr)
qqnorm(df1$Pressure_Bfr)
qqline(df1$Pressure_Bfr,col="red",lty=1,lwd=2)
abline(0,1,col="blue",lty=2,lwd=2)
#2
ad.test(df1$Pressure_Afr)
shapiro.test(df1$Pressure_Afr)
lillie.test(df1$Pressure_Afr)
qqnorm(df1$Pressure_Afr)
qqline(df1$Pressure_Afr,col="red",lty=1,lwd=2)
abline(0,1,col="blue",lty=2,lwd=2)

#Relying on both anderson-darling and shapiro-wilk's tests we cannot reject the null hypothesis
#that the samples come from a normal distribution. 
#Assumming normality, though is risky since p-value is close to a and the qq-plots do not back it up

#For the purposes of this exercise we assume that the sample's population
#follows the Normal distribution weith sigma unknown


tlowerlim1a <- mean(df1[['Pressure_Bfr']]) - qt(0.975,length(df1[['Pressure_Bfr']])-1)*sd(df1[['Pressure_Bfr']])/sqrt(length(df1[['Pressure_Bfr']]))
tupperlim1a <- mean(df1[['Pressure_Bfr']]) + qt(0.975,length(df1[['Pressure_Bfr']])-1)*sd(df1[['Pressure_Bfr']])/sqrt(length(df1[['Pressure_Bfr']]))
Com1a <- "A 95% confidence interval for the mean systolic pressure of the patients, before administering the drug is:"

CI1a <- c(tlowerlim1a, tupperlim1a)
print(Com1a)
print(CI1a)

#alternatively
e1a = t.test(df1[['Pressure_Bfr']])



  #=== b ===

#cl = 90%

#like in a, we get:

tlowerlim1b <- mean(df1[['Pressure_Afr']]) - qt(0.95,length(df1[['Pressure_Afr']])-1)*sd(df1[['Pressure_Afr']])/sqrt(length(df1[['Pressure_Afr']]))
tupperlim1b <- mean(df1[['Pressure_Afr']]) + qt(0.95,length(df1[['Pressure_Afr']])-1)*sd(df1[['Pressure_Afr']])/sqrt(length(df1[['Pressure_Afr']]))
Com1b <- "A 90% confidence interval for the mean systolic pressure of the patients, after administering the drug is:"

CI1b <- c(tlowerlim1b, tupperlim1b)
print(Com1b)
print(CI1b)

#alternatively
e1b <- t.test(df1[['Pressure_Afr']], conf.level = 0.9 )



  #=== c ===

#cl = 95%

#We must first find the difference between the pressure values and then we proceed like in 'a'
#Since we should be interested in the results after administering the drug, I use the following order:
df1$Pressure_Diff <- df1$Pressure_Afr - df1$Pressure_Bfr

tlowerlim1c <- mean(df1[['Pressure_Diff']]) - qt(0.975,length(df1[['Pressure_Diff']])-1)*sd(df1[['Pressure_Diff']])/sqrt(length(df1[['Pressure_Diff']]))
tupperlim1c <- mean(df1[['Pressure_Diff']]) + qt(0.975,length(df1[['Pressure_Diff']])-1)*sd(df1[['Pressure_Diff']])/sqrt(length(df1[['Pressure_Diff']]))
Com1c <- "A 95% confidence interval for the difference in the means of systolic pressure of the patients, before and after administering the drug is:"

CI1c <- c(tlowerlim1c, tupperlim1c)
print(Com1c)
print(CI1c)

#alternatively
e1c = t.test(df1[['Pressure_Diff']])



  #=== d ===

#cl = 95%

# We are intrested in making the following hypothesis test
# H_null: mean_Pr_Bfr - mean_Pr_Afr = 0 
# opposed to
# H_alter: mean_Pr_Bfr - mean_Pr_Afr > 0


# As a result, in the diff formula, we need to order the means differently as opposed to question 'c'

df1$Pressure_DiffB <- df1$Pressure_Bfr - df1$Pressure_Afr

e1d = t.test(df1[['Pressure_DiffB']])
#alternatively
#t.test(df1$Pressure_Bfr, df1$Pressure_Afr, paired= T)

print(e1d)

Com1d <- "From the results of the T test we can observe that a is significantly greater than p-value, so we can safely reject the null hypothesis, that the mean differences are equal.
This result is also hinted by the CI which does not contain zero"
print(Com1d)




#==============================
#          Exercise 2 
#==============================

  #=== a ===

#cl = 95%

ad.test(df2$Marketing)
shapiro.test(df2$Marketing)
lillie.test(df2$Marketing)
qqnorm(df2$Marketing)
qqline(df2$Marketing,col="red",lty=1,lwd=2)
abline(0,1,col="blue",lty=2,lwd=2)
#2
ad.test(df2$Accounting)
shapiro.test(df2$Accounting)
lillie.test(df2$Accounting)
qqnorm(df2$Accounting)
qqline(df2$Accounting,col="red",lty=1,lwd=2)
abline(0,1,col="blue",lty=2,lwd=2)


#Normality tests are inconclusive. The Adnerson-Darling test does not reject the normality with a =5%
#but the Shapiro-Wilk does. In the QQ plots we can see that the tails escape normality 
#However, since n = 30 we assume that the sample follows the normal distribution.


n <- length(df2$Rating)
p_hat2a <- sum(df2$Rating)/n

Zlowerlim2a <- p_hat2a - qnorm(0.975) * sqrt(p_hat2a*(1-p_hat2a)/n)
Zupperlim2a <- p_hat2a + qnorm(0.975) * sqrt(p_hat2a*(1-p_hat2a)/n)

Com2a <- "A 95% confidence interval for the percentage of students that are satisfied with the lectures is:"
CI2a <- c(Zlowerlim2a, Zupperlim2a)

print(Com2a)
print(CI2a)



  #=== b ===


#cl = 99%

n1 <- sum(df2$Sex== 1)
n2 <- sum(df2$Sex== 2)


#for male students
p1_hat2b <- sum(df2$Sex== 1 & df2$Rating ==1)/n1
#for female students
p2_hat2b <- sum(df2$Sex== 2 & df2$Rating ==1)/n2

q1_2b <- 1-p1_hat2b
q2_2b <- 1-p2_hat2b

s2b <- sqrt(((p1_hat2b*q1_2b)/n1) + ((p2_hat2b*q2_2b)/n2))

p_hat_diff2b <- p1_hat2b - p2_hat2b

Zlowerlim2b <- p_hat_diff2b - qnorm(0.995)*s2b
Zupperlim2b <- p_hat_diff2b + qnorm(0.995)*s2b

Com2b <- "A 95% confidence interval for the percentage of male students that are satisfied with the lectures, opposed to the female students is:"
CI2b <- c(Zlowerlim2b, Zupperlim2b)


print(Com2b)
print(CI2b)



  #=== c ===


#CI=95%

#we assume as H_null: p1-p2 = 0 as opposed to H_alter: p1-p2 /=0


p0 <- (n1*p1_hat2b + n2*p2_hat2b)/(n1+n2)

#under the H_null, Z is calculated as follows:

Z <- (p1_hat2b - p2_hat2b)/ sqrt((p0*(1-p0)/n1) + (p0*(1-p0)/n2))

#H_null is rejected when Z > |Z97.5%|

if (abs(Z) > abs(qnorm(0.975))) { 
  print("We reject H_null")
} else { 
  print("We cannot reject H_null")
}


  #=== d ===


#cl = 95%

# we first perform a hypothesis test for equal variances.

XY_Mar <- df2[df2$Sex == 1,]
XX_Mar <- df2[df2$Sex == 2,]

var.test( XX_Mar$Marketing, XY_Mar$Marketing)

#since p-value =58%, we cannot reject the null hypothesis that the variances are equal.

mean_diff = mean(XY_Mar$Marketing)-mean(XX_Mar$Marketing)
DFs <- length(XY_Mar$Marketing)+length(XX_Mar$Marketing)
 
Sp <- ((length(XY_Mar$Marketing)-1)*var(XY_Mar$Marketing)+ (length(XX_Mar$Marketing)-1)*var(XX_Mar$Marketing))/(DFs-2)
  
S_new <- sqrt(((Sp)/length(XY_Mar$Marketing)) + ((Sp)/length(XX_Mar$Marketing)))

Zlowerlim2d <- mean_diff - qt(0.975, DFs-2)*S_new
Zupperlim2d <- mean_diff + qt(0.975, DFs-2)*S_new

CI2d <- c(Zlowerlim2d, Zupperlim2d)

print(CI2d)


#=== e ===


#cl = 95%
#following the previous exercise we get

t.test(XY_Mar$Marketing, XX_Mar$Marketing, var.equal = T)


#with a c.l.=95% and pvalue=89% we cannot reject the null hypothesis,  that the mean difference in grades
#between sexes for Marketing, are equal.


#=== f ===

A_plus  <- df2[df2$Accounting > 84, ]

p0 <- 0.095
p_hat2f <- length(A_plus$Accounting)/length(df2$Accounting)

denom <- sqrt(p0*(1-p0)/length(df2$Accounting))

Z2f <- (p_hat2f-p0)/denom

if (Z2f > qnorm(0.95)) { 
  print("We reject H_null")
} else { 
  print("We cannot reject H_null")
}




#==============================
#          Exercise 3
#==============================

row <- c(df3$Red,df3$Green,df3$Blue)

method<-rep(1:3,rep(6,3))

method <-factor(method)



boxplot(row~factor(method),main="#Bugs per Color",xlab="Method", ylab="Number of Bugs",names=c("Red","Green","Blue"))

#A first view of the data, show overlapping for the boxplots of the Green and Blue colors.
#So we "expect" that their means will be close, as oppose to the Red color.

#ANOVA
fit <- aov(row~method)
summary(fit)
#For a=5% we reject the null hypothesis that the means between groups are equal.
#As a next step we will test if the results are trustworthy


# Test the normality assumption in the residuals
qqnorm(fit$residuals,main="NPP for residuals")
qqline(fit$residuals,col="red",lty=1,lwd=2)

shapiro.test(fit$residuals)
lillie.test(fit$residuals)

#For a =5% we conclude that the residuals follow the Normal distribution


bartlett.test(row~factor(method))
fligner.test(row~factor(method))
# For a=5% we conclude that homoscedasticity exists between variances

# Diagnostic Plots
layout(matrix(1:4,2,2))
plot(fit)

# Plot Means with Error Bars
plotmeans(row~factor(method),xlab="Method", ylab="Row", main="Mean plot with 95% CI")

#Next we will examine which mean(/means) differ from each other.

TukeyHSD(fit)
pairwise.t.test(row,factor(method),p.adjust.method="bonferroni")
pairwise.t.test(row,factor(method),p.adjust.method="holm")


#Least Significant Differences Method

DFE<-fit$df.residual
MSE<-deviance(fit)/DFE
print(LSD.test(row,factor(method),DFerror=DFE,MSerror=MSE,p.adj="bonferroni"))
LSD.test(row,factor(method),DFerror=DFE,MSerror=MSE,p.adj="bonferroni")$groups


# Scheffe's Method
DFE<-fit$df.residual
MSE<-deviance(fit)/DFE
print(scheffe.test(row,factor(method), DFerror=DFE, MSerror=MSE))
scheffe.test(row,factor(method), DFerror=DFE, MSerror=MSE)$groups

#Finally all the tests conclude that the mean number of bugs glued to green and blue paint is equal, 
#while the red color attracts more bugs and is thus, more effective.




#===============================
#          Exercise 4 
#===============================


#using all the data as training we get the following linear model
# Y = 646.483 -14.041X
#However I deemed it more appropriate to use the following method.

#training data
x4 <- df4$Age[1:8]
y4 <- df4$Mean_Time[1:8]



#scatterplot
par(mfrow= c(1,1))
plot(y4,x4)
#With the scatterplot we see a (negative) linear relationship between the age and demanded amount of sleep


cor(y4,x4)
cor.test(y4,x4)

#The visual deduction is strengthened further through the correlation test. We see a strong negative relationship
#between the two variables and with a near zero pvalue we are confident of the outcome

# === Estimate simple regression using lm function ===

# Estimate simple linear regression Y= a+bX+e
fit4<-lm(y4 ~ x4)
summary(fit4)
#Through the summary we can safely assume that the Mean_time is significant for our model

a <- coefficients(fit4)[1]
b <- coefficients(fit4)[2]


#Visual presentation of the Linear Model
plot(x4,y4, pch=19)
abline(fit4, col="red")

#Next we need to check the normality assumptions for the residuals
qqnorm(fit4$residuals,main="NPP for residuals")
qqline(fit4$residuals,col="red",lty=1,lwd=2)

shapiro.test(fit4$residuals)
lillie.test(fit4$residuals)

#Via the tests we can assume normality for the residuals

# Diagnostic plots
par(mfrow=c(2,2))
plot(fit4)
mtext("Diagnostic plots for the linear model", outer=TRUE, line=-2, font=2, cex=1.2)

#Moreover we can see that the residuals don't have a prticular pattern and their
#variance remains constant, which also proves that they homoscedastic.


#test data
X_hat <- df4$Age[9:13]

Y_hat = a +b*X_hat

Hours<-Y_hat/60
Diff <- Y_hat - df4$Mean_Time[9:13]
Final1 <- cbind(X_hat, Y_hat,Diff, Hours)
Final1

#Given our test data the model seems to be working well

