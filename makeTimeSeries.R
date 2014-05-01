remove(list=ls())
indexCode <- read.csv(file="./indexcode.csv",header=F,sep=",")

indexData <- NULL


targetDate = as.Date("2014-04-25")
csvData <- read.csv(file=paste("./indices_", targetDate ,".csv" ,sep = ""),header=F,skip=2)
dateList <- rep(targetDate,length=nrow(csvData))
dataPerDay <- data.frame(dateList,csvData)

indexData <- rbind(indexData, dataPerDay)

#インデックス名称をコードに置き換える
gsub(dataPerDay[n,2],indexCode[match(dataPerDay[n,2],indexCode[,1]),2],dataPerDay)

#対象となるデータだけ切りだす
indexData.mothers <- subset(indexData, indexData$V1 == '東証マザーズ指数')
