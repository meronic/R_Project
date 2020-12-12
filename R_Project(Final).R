# install.packages("rvest")
# install.packages("XML")
# install.packages("gglot2")
library(rvest)
library(XML)
library(ggplot2)

#xmlParse() : xml, HTML파일을 R에서 인식하는 구조로 변환
#xmlRott() : xml 문서 객체의 루트 노드에 접근
#xmlToDataFrma() : xml문서로부터 데이터 추출, 데이터프레임을 반환함

#geom_bar() : 막대그래프 만드는 함수
#theme() : 테마 설정 theme(x축 눈금 라벨 설정)
#scale_fill_manual() : 관점의 색 출력
#coord_flip() : 수평과 수직 축을 서로 바꿈

#api 정보
api <- "http://openapi.q-net.or.kr/api/service/rest/InquiryRgnQualSVC/getYearList"
api_key <-"lwDKSK7DSVTyedqIe8YCWlknOzQbgd6WN2LOD%2BMlnd1qIlCespH9fnunDeWfLWUmL3t2YLvJ5G5dXOloVYD%2BRA%3D%3D"

#요청변수 정보

rgnCd <- "A101" #지역코드
seriesCd <- "02"  #계열코드
baseYY <- "2018"  #기준년도
quart <- "2"      #분기


# 요청은 ?로 보낸다
# 그 다음은&

url <- paste(api,"?serviceKey=",api_key,"&rgnCd=",rgnCd,"&seriesCd=",seriesCd,"&baseYY=",baseYY,"&quart=",quart)
# url모든 공백 제거
url <- gsub("\\s", "", url)
url

xmlFile <- xmlParse(url)

xmlFile

class(xmlFile)

xmlRoot(xmlFile)


