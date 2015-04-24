business_sample <- read.csv("yelp_academic_dataset_business.csv")
library(dplyr)
library(ggplot2)
library(reshape)
library(gplots)
library(shiny)
library(markdown)
install.packages("BH")
install.packages("wordcloud")

ind_rest=grep("Restaurants",business_sample$categories) 
ind_city1=grep("Charlotte",business_sample$city)
ind_city2=grep("Champaign",business_sample$city)
ind_city3=which(business_sample$city=="Las Vegas")

target_set1=intersect(ind_rest,ind_city1)
target_set2=intersect(ind_rest,ind_city2)
target_set3=intersect(ind_rest,ind_city3)

ind_comb1=sort(c(target_set1))
ind_comb2=sort(c(target_set2))
ind_comb3=sort(c(target_set3))
sub_data1=business_sample[ind_comb1,]
sub_data2=business_sample[ind_comb2,]
sub_data3=business_sample[ind_comb3,]
new_data=rbind(sub_data1,sub_data2,sub_data3)

fter<-c("name","city","review_count","stars")
rests<-business_sample[ind_rest,fter]
#SubData
sub<-group_by(new_data,city,stars)
#city,stars,review
rv<-summarise(sub,length(review_count))
names(rv)<-c("city","stars","review_cn")
#city,stars,Wifi
sub_wf<-group_by(new_data,city,stars,attributes_Wi.Fi)
wf<-summarise(sub_wf,length(attributes_Wi.Fi))
names(wf)<-c("city","stars","WiFi","cn")
wf<-filter(wf,WiFi %in% c("no","free","paid"))
#city,stars,price
sub_p<-group_by(new_data,city,stars,attributes_Price.Range)
p<-data.frame(summarise(sub_p,length(attributes_Price.Range)))
names(p)<-c("city","stars","Price_Range","cn")
p<-filter(p,Price_Range %in% c("1","2","3","4"))
p$Price_Range<-as.character(p$Price_Range)
#city,stars,noise
sub_n<-group_by(new_data,city,stars,attributes_Noise.Level)
n<-summarise(sub_n,length(attributes_Noise.Level))
names(n)<-c("city","stars","Noise","cn")
n<-filter(n,Noise %in% c("quiet","average","loud","very_loud"))
#city,stars,hh
sub_h<-group_by(new_data,city,stars,attributes_Happy.Hour)
h<-summarise(sub_h,length(attributes_Happy.Hour))
names(h)<-c("city","stars","Happy_Hour","cn")
h<-filter(h,Happy_Hour %in% c("True","False"))

sub_tv<-group_by(new_data,city,stars,attributes_Has.TV)
tv<-data.frame(summarise(sub_h,length(attributes_Has.TV)))
names(tv)<-c("city","stars","TV","cn")
tv<-filter(tv,TV %in% c("True","False"))

#RESTARANT
rest_g<-group_by(rests,name)
rest_r<-summarise(rest_g,length(review_count))
names(rest_r)<-c("name","review")
rest_rv<-arrange(rest_r,desc(review))
rest_rv$rank<-seq(1:nrow(rest_rv))

rest_st<-group_by(rests,name,stars)
test_s<-summarise(rest_st,length(stars))

rest_st1<-group_by(rests,name,city,stars)
test_s1<-summarise(rest_st1,length(stars))

stars_plot<-data.frame(rests$stars)
names(stars_plot)<-"stars"
review_plot<-data.frame(cbind(rests$review_count,rests$stars))
names(review_plot)<-c("review","stars")
  
sum_city<-summarise(group_by(rests,city),length(city))




library(tm)
library(wordcloud)
library(memoise)

# The list of valid books
books <<- list("1Star" = "newt1",
               "2Star" = "newt2",
               "3Star" = "newt3",
               "4Star" = "newt4",
               "5Star" = "newt5")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(book %in% books))
    stop("Unknown book")
  
  a = read.table(sprintf("./%s.txt", book))
  idx = a$word
  a = a[,2]
  names(a) = idx
  sqrt(a)
  
  
})


