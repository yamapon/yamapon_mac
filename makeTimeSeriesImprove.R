#データの初期化
remove(list=ls())
#indexCode <- read.csv(file="./indexcode.csv",header=F,sep=",")
indexData <- NULL

targetDay <- as.Date("2014-01-01")
while( targetDay < Sys.Date() ){
  
  #非営業日は除去
  #土曜日曜はskip、祝日はデータを読みこんで判定
  if(weekdays(targetDay)  != "土曜日"
     && weekdays(targetDay)  != "日曜日"){
    dfIndex <- NULL
    Sys.sleep(0.1)
    print(targetDay)
    
    URL <- paste( "http://k-db.com/indices/" , targetDay ,"?download=csv" ,sep ="")
    dfIndex <- read.csv(URL ,header = FALSE , fileEncoding = "cp932",stringsAsFactors = FALSE )

    if(format(targetDay, "%Y年%m月%d日") == dfIndex[1,1]){
      dfIndex <- dfIndex[-1:-2,]
      dfIndex <- na.omit(dfIndex)
      for ( i in 2:5 ){
        dfIndex[[i]] <- as.numeric(dfIndex[[i]])
      }
        
      dateList <- rep(targetDay,length=nrow(dfIndex))
      dfIndex <- data.frame(dateList,dfIndex)
      
      indexData <- rbind(indexData, dfIndex)
    
    }
  }
  targetDay <- targetDay + 1  
}


#インデックス名称をコードに置き換える
#gsub(dataPerDay[n,2],indexCode[match(dataPerDay[n,2],indexCode[,1]),2],dataPerDay)

#対象となるデータだけ切りだす
#indexData.nikkei <- subset(indexData, indexData$V1 == '日経平均株価')
#indexData.topix <- subset(indexData, indexData$V1 == 'TOPIX')
#indexData.mothers <- subset(indexData, indexData$V1 == '東証マザーズ指数')
