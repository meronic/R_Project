# 컴퓨터소프트웨어공학과 20162908 유명현


####### 기말고사 대체과제 1번 문제 ########

# install.packages(rvest) 패키지가 없다면 설치
library(rvest) #사용할 라이브러리 등록

# 대기시간 설정, 윈도우에서 버벅임
Sys.sleep(3)

# 다음에서 본인 이름 검색
url.api <- "https://search.daum.net/search?w=web&DA=PGD&enc=utf8&lpp=10&q=%EC%9C%A0%EB%AA%85%ED%98%84&p="


titles <- NULL # 문서 타이틀들을 담을 변수
addressALL <- NULL # 주소들을 담을 변수


# 웹문서 내용 3페이지까지 스크랩핑
for (page in 1:3){
  
  url <- paste(url.api, page, sep="")
  html <- read_html(url)
  
  # class명은 .
  # id명은 #
  
  # 문서 제목 title변수에 저장
  title <- html_nodes(html, "#webdocColl.type_fulltext.wid_n")%>%
    html_nodes(".f_link_b")%>% 
    html_text(trim = TRUE) # 공백제거
  
  #필요없는 \코드 제거
  title <-gsub("\r\n\t",'',title)
  
  
  # 링크 사이트 주소 address변수에 저장장
  address <- html_nodes(html, "#webdocColl.type_fulltext.wid_n")%>%
    html_nodes(".f_url")%>%
    html_text(trim = TRUE) # 공백제거
  
  
  # 제목과 주소를 처음 선언한 변수에 추가 저장장
  titles <- c(titles, title)
  addressALL <- c(addressALL, address)
  
}


#'문서 제목', '링크사이트주소' 2가지 내용 가져와서 데이터 프레임으로 저장
api = data.frame(title=titles, www=addressALL)

#테이블 형식으로 출력
View(api)

#### 출력시 대기시간 설정 윈도우에서 실행시 버벅임 #####
Sys.sleep(3)

######## 1번문제 끝 ##############



############ 기말고사 대체과제 2번 문제 ###########

# 사용하는 라이브러리 올리기기
# install.packages("rvest") 패키지가 없다면 설치
# install.packages("XML") 패키지가 없다면 설치

library(rvest) #사용할 라이브러리 등록
library(XML) #사용할 라이브러리 등록

# 학번
studentNumber <- "20162908"

# api관련 검색

# api 정보
api <- "http://openapi.q-net.or.kr/api/service/rest/InquiryRgnQualSVC/getYearList"
api_key <-"lwDKSK7DSVTyedqIe8YCWlknOzQbgd6WN2LOD%2BMlnd1qIlCespH9fnunDeWfLWUmL3t2YLvJ5G5dXOloVYD%2BRA%3D%3D"


# 특정년도 3년간 '기능장'자격층 취득정보 수집
#요청변수 정보 및 설정

# 시작년도 (2014년도)
baseYY <- 2014 

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
    
    #저장하는 size결정 1개 이상 경우만 파일로 저장함
    if (size > 0){
      
      print(paste("데이터의 개수", size,"저장"))
      
      #(매우중요) 현 디렉토리에 csv파일로 저장
      setwd(getwd()) # 작업디렉토리를 현 경로로 설정
      
      # 파일 이름 지정
      path = paste(studentNumber,"_",baseYY,"_",quart,".csv")
      
      # 지정된 이름으로 파일 저장
      write.csv(df,path)
    }
    
    else{
      print(paste("데이터의 개수가", size,"입니다 저장하지 않습니다."))
    }
  }
}
########## 2번문제 끝 ###########




########## 기말고사 대체과제 3번 문제 ##########

# 사용하는 라이브러리 올리기기
library(animation)

# 학번
studentNumber = "20162908"

#요청변수 정보 및 설정

# 시작년도 (2014년도)
baseYY = 2014 

# 특정지역 (전라남도)
rgnCd <- "A113" #지역코드

# '기능장' 자격증 설정 
seriesCd <- "02"  #계열코드

# 분기
quart <- "1"      #분기코드


# Q2에서 저장된 파일 불러오기

for (baseYY in (baseYY:(baseYY+2))) { # baseYY포함하으로 + 2 
  
  # 4분기 반복
  for (quart in 1:4) {
    
    # 파일경로를 설정하는 path변수 지정
    path = paste(studentNumber,"_",baseYY,"_",quart,".csv")
    
    # file.exists함수를 사용하여 파일의 유무를 확인하고 진행
    fileCheck <- file.exists(path) 
    
    # csv파일이 존재하는 경우
    if (fileCheck == TRUE){
      
      df <- read.csv(path) # df변수에 데이터 저장
      # 진행 상황 출력
      print(paste("전남지역",baseYY,"년도",quart,"분기 데이터"))
      
      jm <-c(df$jmNm) # 데이터에서 '종목'을 가지고있는 jmNm항목을 jm변수에 저장
      count <- c(df$totcnt) # 데이터에서 '취득자 수'를 가지고 있는 totcnt항목을 count변수에 저장
      
      # 그래프 작성 과제 그래프 색상 Rainbow #legend추가
      # 실행시 legend 사이즈가 크게 출력됩니다. 창의 크기를 충분히 늘려주세요
      result <- barplot(height = count, names.arg = jm, main = paste("전남지역",baseYY,"년도",quart,"분기"), 
                        col = rainbow(length(count)), xlab="기능장 명", ylab="취득자 수",
                        legend=jm) 
      # 그래프 출력
      result
      
      # 그래프의 평균 선 추가
      abline(h=mean(count), col="orange", lty=1)
      
      
      #그래프 시간간격 설정
      ani.pause(1)
    }
    
    
    # 파일이 존재하지 않는 경우 메세지 출력
    else{
      print(paste(baseYY,"_",quart,"분기 파일 없음"))
    }
  }
}
######## 3번문제 끝 ###########





