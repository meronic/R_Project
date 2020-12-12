# install.packages(rvest)
library(rvest)

# 1. 다음에서 본인 이름 검색
url.api <- "https://search.daum.net/search?w=web&DA=PGD&enc=utf8&lpp=10&q=%EC%9C%A0%EB%AA%85%ED%98%84&p="


titles <- NULL
descs <- NULL
addressC <- NULL

# 2. 웹문서 내용 3페이지까지 스크랩핑
for (page in 1:3){
  url <- paste(url.api, page, sep="")
  html <- read_html(url)
  html
  
  # class명은 .을 찍어준다.
  # id는 #을 찍어준다.

  #####title  
  title <- html_nodes(html, "#webdocColl.type_fulltext.wid_n")%>%
    html_nodes(".f_link_b")%>%
    html_text(trim = TRUE) # 공백제거

  #gsub == replace
  title <-gsub("\r\n\t",'',title)
  
  #title
  
  #trimws : 공백제거
  
  
  #####address
  address <- html_nodes(html, "#webdocColl.type_fulltext.wid_n")%>%
    html_nodes(".f_url")%>%
    html_text(trim = TRUE) # 공백제거
  
  
  #address
  
  titles <- c(titles, title)
  addressC <- c(addressC, address)

}

titles
addressC

#3. '문서 제목', '링크사이트주소' 2가지 내용 가져와서 데이터 프레임으로 저장
api = data.frame(title=titles, www = addressC)

#4. 테이블 형식으로 출력
View(api)




