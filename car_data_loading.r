# this totally works, but takes a while on slow connections, use the file loader in general
# carData <- read.table(
#   'http://www.win-vector.com/dfiles/car.data.csv',
#   sep=',', header=T
# )

# comment this out if using the online loader^
carData <- read.csv("~/Code/data-analysis/practical-data-science-with-R/data/car.data.csv")

class(carData)  # data.frame
dim(carData)    # 1728 7