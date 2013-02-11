library("utils")
library("XML")

baseDir = "/Users/yasuaki/Downloads/20130104/"
setwd(baseDir)
dZipFilesName <- dir()
for( i in 1:length(dZipFilesName)){
  if( regexpr(".zip", dZipFilesName[[i]]) > 0 ){
    zipFileName <- dZipFilesName[[i]]
    dirName <- strsplit(zipFileName , split=".zip")
    workDir <- paste(baseDir,dirName[[1]],"/", sep="")
    unzip(zipFileName, files = NULL, list = FALSE, overwrite = TRUE,
          junkpaths = FALSE, exdir = workDir, unzip = "internal", setTimes = FALSE)

    dFilesName <- dir(workDir)
    if( length(dFilesName) > 0){
      for( j in 1:length(dFilesName) ){
        fileName <- paste(workDir, dFilesName[[j]], sep="")
        
        if( regexpr(".xsd", fileName) > 0){
          #xsdファイルの読み込み処理
          xsd = xmlParse(fileName, isSchema =TRUE)
        }
        
        if( regexpr(".xbrl", fileName) > 0 ){
          #xbrlファイルの読み込み処理
          doc <- xmlInternalTreeParse(fileName)
          xmlData <- xmlRoot(doc)
          for( nodeNum in 1:xmlSize(xmlData)){
              print(xmlName(xmlData[[nodeNum]]))
              print(xmlAttrs(xmlData[[nodeNum]]))
              print(xmlValue(xmlData[[nodeNum]]))
              
          }
        }
      }
    }
  }
}
