# ��ǻ�ͼ���Ʈ������а� 20162908 ������
# �⸻���� ��ü���� 2�� ����

# ����ϴ� ���̺귯�� �ø����
# install.packages("rvest")
# install.packages("XML")

library(rvest)
library(XML)

# �й�
studentNumber = "20162908"

# api���� �˻�

# api ����
api <- "http://openapi.q-net.or.kr/api/service/rest/InquiryRgnQualSVC/getYearList"
api_key <-"lwDKSK7DSVTyedqIe8YCWlknOzQbgd6WN2LOD%2BMlnd1qIlCespH9fnunDeWfLWUmL3t2YLvJ5G5dXOloVYD%2BRA%3D%3D"


# Ư���⵵ 3�Ⱓ '�����'�ڰ��� ������� ����
#��û���� ���� �� ����

# ���۳⵵ (2014�⵵)
baseYY = 2014 

# Ư������ (���󳲵�)
rgnCd <- "A113" #�����ڵ�

# '�����' �ڰ��� ���� 
seriesCd <- "02"  #�迭�ڵ�

# �б�
quart <- "1"      #�б��ڵ�


# 3�� ������ Ž�� ����

for (baseYY in (baseYY:(baseYY+2))) { # baseYY���������� + 2 
  
  # 4�б� �ݺ�
  for (quart in 1:4) {
    
    # ���� ��Ȳ ���
    print(paste("��������",baseYY,"�⵵",quart,"�б� ������"))
    
    # ��û��� ����
    url <- paste(api,"?serviceKey=",api_key,"&rgnCd=",rgnCd,"&seriesCd=",seriesCd,"&baseYY=",baseYY,"&quart=",quart)
    # url��� ���� ����
    url <- gsub("\\s", "", url)
    
    #xmlParse() : xml, HTML������ R���� �ν��ϴ� ������ ��ȯ
    xmlFile <- xmlParse(url)
    
    
    #xmlRott() : xml ���� ��ü�� ��Ʈ ��忡 ����
    xmlRoot(xmlFile)
    
    
    #xmlToDataFrma() : xml�����κ��� ������ ����, �������������� ��ȯ��
    df <- xmlToDataFrame(getNodeSet(xmlFile, "//items/item")) # xml������ ��� ���� node�� �̾� ���� ����
    
    #dim() : ��ü�� ������ ��ȸ
    size <- dim(df)[1] # �������� ������ ��ȸ�Ͽ� size������ ����
    
    #�����ϴ� size���� 1�� �̻� ��츸 ���Ϸ� ������
    if (size > 0){
      
      print(paste("�������� ����", size,"����"))
      
      #(�ſ��߿�) �� ���丮�� csv���Ϸ� ����
      setwd(getwd()) # �۾����丮�� �� ��η� ����
      
      # ���� �̸� ����
      path = paste(studentNumber,"_",baseYY,"_",quart,".csv")
      
      # ������ �̸����� ���� ����
      write.csv(df,path)
    }
    
    else{
      print(paste("�������� ������", size,"�Դϴ� �������� �ʽ��ϴ�."))
    }
    
  }
}
# 2������ ��





