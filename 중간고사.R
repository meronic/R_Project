# 20162908 유명현 컴퓨터소프트웨어공학과
# 과학적데이터처리 중간고사 대체 과제

# animation 라이브러리 올리기
install.packages("animation")
# animation 라이브러리 사용
library(animation)

# 1번문제
q1 = function(){
  plot.new()
  
  i = 10 # while문 안에서 돌아갈 변수
  while (i >= 0) { #과제 내용 10부터 0까지 감소
    rect(xleft = 0, ybottom = 0, 1, 1, col="yellow") # plot init
    
    textSize = 11-i # 글씨 크기 변수
    text(0.5,0.5,i, cex = textSize, col = rgb(1,0,0,1)) # 사각형 안의 내용 
    i = i - 1  # 반복문에서 감소하는 조건
    
    ani.pause(interval = 0.5) #애니메이션 인터벌 간격
  }
  
  # 반복문 탈출 후 학번 이름 표시
  text(0.5,1, labels = "20162908 유명현", pos = 1)
}  
# 1번문제 끝   


# 2번 문제
q2 = function(){
  # 중간고사 대체과제 2번문제
  library(animation)
  
  
  studentNumber = 20162908 # 반복문 종료시 나올 학번
  
  for (i in 1:50) { # 과제 내용 for문 사용 50번 반복
    
    y = runif(5) # 0부터 1까지 랜던함 실수 5개를 저장할 변수
    
    # 막대 그래프 생성
    bPlot = barplot(y, ylim = c(0,1), col = rainbow(5),  main = studentNumber-50+i)
    # main 텍스트 내용을 학번으로 설정
    
    ani.pause(0.5) # 출력 간격 설정 
    # 맥에서 사용시 0.5 이하 멈춤 현상으로 0.5로 설정하였습니다.
  }
  
}
# 2번 문제 끝


# 3번 문제 
q3 = function(){
  
  # 3번 문제
  count = c(0,0,0) #초기 카운트 값
  size = 300 # 동전 던지는 횟수를 저장한 변수
  
  for( n in 1:size ){ 
    
    coin = sample(c(0,1), 2, T) #sample 
    index = sum(coin) + 1 
    count[index] = count[index] + 1
    
    resultSum = c(0,1,2) # barplot에서 표시할 값
    probability = count/n # 확률
    
    title = paste("20162908유명현 \n반복 수  : ", n, "/",size) # plot title
    
    # 그래프 그리기 y축의 범위를 고정시키기 위해 ylim 설정
    bPlot = barplot(probability, names.arg = resultSum, xlab =  "앞면이 나온 횟수", ylab = "확률", ylim=c(0,1.0), col = rainbow(3), main = title )
    
    ani.pause(0.5) # 시간 간격 
    # 제 컴퓨터로 수행하였을때 0.5 이하일시 버벅임이 있었습니다..
  }
  
  # 과제 내용
  # 탐색 완료 후 결과를 제 위치에 출력
  text(bPlot,resultSum[1]+probability, labels = paste(count), pos = 3)
  # x위치는 bplot, y의 위치는 bar위에 출력되야 되기 때문에 + probability 하여 표시
  
}
# 3번 문제 끝


# 전체 시작 
while (TRUE) {
  print("과학적데이터처리 중간고사 과제 \n")
  
 # 확인 문제의 번호를 입력해주세요
 input <-readline('insert Quiz Number : ')
 
 if (input == "1"){q1()}
 else if (input == "2"){q2()}
 else if (input == "3"){q3()}
 else { q() }
 
}
