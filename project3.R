# ��ǻ�ͼ���Ʈ������а� 20162908 ������
# �⸻���� ��ü���� 3�� ����

# ����ϴ� ���̺귯�� �ø����
library(animation)

# �й�
studentNumber = "20162908"

#��û���� ���� �� ����

# ���۳⵵ (2014�⵵)
baseYY = 2014 

# Ư������ (���󳲵�)
rgnCd <- "A113" #�����ڵ�

# '�����' �ڰ��� ���� 
seriesCd <- "02"  #�迭�ڵ�

# �б�
quart <- "1"      #�б��ڵ�


# Q2���� ����� ���� �ҷ�����

for (baseYY in (baseYY:(baseYY+2))) { # baseYY���������� + 2 
  
  # 4�б� �ݺ�
  for (quart in 1:4) {
    
    # ���ϰ�θ� �����ϴ� path���� ����
    path = paste(studentNumber,"_",baseYY,"_",quart,".csv")
    
    # �б⺰ ������ ���� ��츦 Ž���ϸ� ����ó���� ���� ��� ����
    tryCatch(
      
      # ������ �����ϴ� ���
      expr = {
        df <- read.csv(path) # df������ ������ ����
        
        # ���� ��Ȳ ���
        print(paste("��������",baseYY,"�⵵",quart,"�б� ������"))
        
        jm <-c(df$jmNm) # �����Ϳ��� '����'�� �������ִ� jmNm�׸��� jm������ ����
        count <- c(df$totcnt) # �����Ϳ��� '����� ��'�� ������ �ִ� totcnt�׸��� count������ ����
        
        # �׷��� �ۼ� ���� �׷��� ���� Rainbow #legend�߰�
        # ����� legend ����� ũ�� ��µ˴ϴ�. â�� ũ�⸦ ����� �÷��ּ���
        result <- barplot(height = count, names.arg = jm, main = paste("��������",baseYY,"�⵵",quart,"�б�"), 
                          col = rainbow(length(count)), xlab="����� ��", ylab="����� ��",
                          legend=jm) 
        # �׷��� ���
        result
        
        # �׷����� ��� �� �߰�
        abline(h=mean(count), col="orange", lty=1)
        
        
        #�׷��� �ð����� ����
        ani.pause(1)
      },

       
       # ������ ���� ���� �ʴ°��
       error = function(e) {
         next # ������ ���� ��� next���� ���� e���� �������� ����
       },
      
      # ������ ���� �޼��� ���
       warning = function(e) print(paste(baseYY,"_",quart,"�б� ���� ����")), 
      
      # finally �⺻����
       finally = NULL)
  }
}
# 3������ ��





