# Reading the csv file
mydata = read.csv("Cotton_2021.csv")

# Retrieving Gujarat subset
mydata.gujarat = subset(mydata, state == "Gujarat")
summary(mydata.gujarat)

# Cotton sold in month of January
january = c('01/01/2021', '02/01/2021', '03/01/2021','04/01/2021','05/01/2021','06/01/2021','07/01/2021','08/01/2021',
            '09/01/2021','10/01/2021','11/01/2021','12/01/2021','13/01/2021','14/01/2021','15/01/2021','16/01/2021',
            '17/01/2021','18/01/2021','19/01/2021','20/01/2021','21/01/2021','22/01/2021','23/01/2021','24/01/2021',
            '25/01/2021','26/01/2021','27/01/2021','28/01/2021','29/01/2021','30/01/2021','31/01/2021')
print(class(january))
mydata.gujarat.january = subset(mydata.gujarat, arrival_date %in% january)
mydata.gujarat.january

# Getting the summary of January data

summary(mydata.gujarat.january)

min_price_mean = mean(mydata.gujarat.january$min_price)
max_price_mean = mean(mydata.gujarat.january$max_price)
modal_price_mean = mean(mydata.gujarat.january$modal_price)

min_price_mean
max_price_mean
modal_price_mean

# Data on days that the values are above all the means

mydata.gujarat.january.min_price.above_mean = subset(mydata.gujarat.january, min_price >= min_price_mean)
max(mydata.gujarat.january.min_price.above_mean$min_price)
min(mydata.gujarat.january.min_price.above_mean$min_price)
min_price_mean
boxplot(mydata.gujarat.january.min_price.above_mean$min_price)

mydata.gujarat.january.below_mean = subset(mydata.gujarat.january, min_price < min_price_mean && max_price < max_price_mean && modal_price < modal_price_mean)
mydata.gujarat.january.below_mean


max_price >= max_price_mean && modal_price >= modal_price_mean