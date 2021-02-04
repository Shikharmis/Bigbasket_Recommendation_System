setwd("~/Desktop/OneDrive - Goa Institute of Management/PPA Working on R")
## Libraries required:
library(arules)
library(arulesViz)
library(dplyr) ## %>% ## with dplyr libraries

## Reading the csv file:
Bigbasket <- read.csv("bigbasket.csv")
View(Bigbasket)

## Here we are the data by order and grouping them together:
big <- Bigbasket%>%group_by(Order)%>% summarise(Items = paste(Description, collapse = ","))
View(big)

## Below code is used to create the csv file which get stored in the directory set.
write.csv(big$Items,"big1.csv", quote = FALSE, row.names = FALSE)

## READ.TRANSACTION is used read the transaction dataset.
big1 <- read.transactions("big1.csv",sep = ',')
summary(big1)

## ITEMFREQUENCYPLOT is a method to create an item frequency bar plot for inspecting the
 #item frequency distribution for objects.
itemFrequencyPlot(big1, topN=100)

## Apriori algorithm is for finding frequent itemsets in a dataset for 
 #boolean association rule It proceeds by identifying the frequent individual
  #items in the database and extending them to larger and larger
  # support will be set such that we can get more number of rules or the value where support is nearly same of all product.
rules<- apriori(big1, parameter=list(supp=.0005, conf =0.0))
inspect(rules)

## These Plot is used to check the association between the item in transaction list 
plot(rules, method="grouped")
plot(rules, method = "graph",control= list(type="item"),
     interactive = T)

## Creating the final list which gives the association of the item with the buyer.
write(rules, file="grocery_rules_1.csv",sep=",")

#lift >1 , mean positive correlation and higher the lift value the best the rule.
#lift <1, negative correlation mean one item decreasing the sale of other product.


















