# 컴퓨터소프트웨어공학과 20162908 유명현

# 기말고사 대체과제 1번 문제

# install.packages(rvest) 패키지가 없다면 설치
library(rvest) #사용할 라이브러리 등록

# 1. 다음에서 본인 이름 검색
url.api <- "https://search.daum.net/search?w=web&DA=PGD&enc=utf8&lpp=10&q=%EC%9C%A0%EB%AA%85%ED%98%84&p="


titles <- NULL # 문서 타이틀들을 담을 변수
addressALL <- NULL # 주소들을 담을 변수


# 2. 웹문서 내용 3페이지까지 스크랩핑
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


#3. '문서 제목', '링크사이트주소' 2가지 내용 가져와서 데이터 프레임으로 저장
api = data.frame(title=titles, www=addressALL)

#4. 테이블 형식으로 출력
View(api)

# 1번문제 끝