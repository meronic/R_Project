# 컴퓨터소프트웨어공학과 20162908 유명현
# 기말고사 대체과제 3번 문제

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
    
    # 분기별 파일이 없는 경우를 탐색하며 예외처리를 통해 계속 진행
    tryCatch(
      
      # 파일이 존재하는 경우
      expr = {
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
      },

       
       # 파일이 존재 하지 않는경우
       error = function(e) {
         next # 파일이 없는 경우 next진행 변수 e에는 에러정보 저장
       },
      
      # 에러에 대한 메세지 출력
       warning = function(e) print(paste(baseYY,"_",quart,"분기 파일 없음")), 
      
      # finally 기본값값
       finally = NULL)
  }
}
# 3번문제 끝


# 기말고사 1번문제 실행 영상 (비공개 링크)
# https://youtu.be/hlu9KTECLNw

# 기말고사 2번문제 실행 영상 (비공개 링크)
# https://youtu.be/dHkKVcjwTmg

# 기말고사 3번문제 실행 영상 (비공개 링크)
# https://youtu.be/9Lp1HV7GVkM






