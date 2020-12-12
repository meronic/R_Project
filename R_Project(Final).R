# 기말고사 대체과제 2번 문제제
# 컴퓨터소프트웨어공학과 20162908 유명현

# 사용하는 라이브러리 올리기기
# install.packages("rvest")
# install.packages("XML")

library(rvest)
library(XML)

# 학번
studentNumber = "20162908"

# api관련 검색

# api 정보
api <- "http://openapi.q-net.or.kr/api/service/rest/InquiryRgnQualSVC/getYearList"
api_key <-"lwDKSK7DSVTyedqIe8YCWlknOzQbgd6WN2LOD%2BMlnd1qIlCespH9fnunDeWfLWUmL3t2YLvJ5G5dXOloVYD%2BRA%3D%3D"


# 특정년도 3년간 '기능장'자격층 취득정보 수집
#요청변수 정보 및 설정

# 시작년도 (2015년도)
baseYY = 2015 

# 특정지역 (전라남도)
rgnCd <- "A113" #지역코드

# '기능장' 자격증 설정 
seriesCd <- "02"  #계열코드

# 분기
quart <- "1"      #분기코드

# 3년 데이터 탐색 시작



for (baseYY in (baseYY:(baseYY+2))) { # baseYY포함하으로 + 2 
  
  # 4분기 반복
  for (quart in 1:4) {
    
    # 진행 상황 출력
    print(paste("전남지역",baseYY,"년도",quart,"분기 데이터"))
    
    # 요청경로 설정
    url <- paste(api,"?serviceKey=",api_key,"&rgnCd=",rgnCd,"&seriesCd=",seriesCd,"&baseYY=",baseYY,"&quart=",quart)
    # url모든 공백 제거
    url <- gsub("\\s", "", url)
    
    #xmlParse() : xml, HTML파일을 R에서 인식하는 구조로 변환
    xmlFile <- xmlParse(url)
    
    
    #xmlRott() : xml 문서 객체의 루트 노드에 접근
    xmlRoot(xmlFile)
    
    
    #xmlToDataFrma() : xml문서로부터 데이터 추출, 데이터프레임을 반환함
    df <- xmlToDataFrame(getNodeSet(xmlFile, "//items/item")) # xml파일의 경로 지정 node를 뽑아 오기 위해
    
    
    #dim() : 객체의 차원을 조회
    size <- dim(df)[1] # 데이터의 개수를 조회하여 size변수에 저장
    print(paste("데이터의 개수", size))
    
    
    #(매우중요) 현 디렉토리에 csv파일로 저장
    setwd(getwd()) # 작업디렉토리를 현 경로로 설정
    
    # 파일 이름 지정
    path = paste(studentNumber,"_",baseYY,"_",quart,".csv")
    
    # 지정된 이름으로 파일 저장
    write.csv(df,path)
  }
}






