# Rush.K 
# 비만 환자의 삶의 질 예측 모델 개발 : 영향 요인 분석을 위한 데이터 정제 
# For Decision Tree & Random Forest
# Using R

Data = read.csv("/Users/rush-k/Desktop/hn18_all.csv") 
# 국민영양조사자료(2016-2018) 로딩
Data <- Data[Data$HE_BMI >= 25, ]
# BMI >= 25 해당자 추출
Data <- subset(Data, select=c(mh_PHQ_S, BP1, Total_slp_wk, EC_wht_23, BE3_32, ainc_1, age, marri_1, HE_HPdg, HE_DMdg, DC3_dg, DM1_dg, BD2_31, BD1_11, BS3_2, EQ5D))
# 가설모형 근거 16개의 변수 추출

Data <- na.omit(Data)
# 결측치 제거

Data <- Data[!(Data$ainc_1 == 999999), ]
# 가구총소득액 999999 : 모름, 무응답이므로 삭제
Data <- Data[!(Data$BD2_31 == 9), ]
# 폭음빈도 9 : 모름이므로 삭제
Data <- Data[!(Data$BD1_11 == 9), ]
# 1년간 음주빈도 9 : 모름이므로 삭제
Data <- Data[!(Data$BS3_2 == 999), ]
# 하루 평균 흡연량 999 : 모름이므로 삭제
Data <- Data[!(Data$marri_1 == 9), ]
# 결혼 여부 9 : 삭제

Data$EC_wht_23 = ifelse(Data$EC_wht_23 == 888, as.integer(0), Data$EC_wht_23)
# 주당 평균 근로시간 888 : 해당 없음으로 0으로 대체
Data$BE3_32 = ifelse(Data$BE3_32 == 88, as.integer(0), Data$BE3_32)
# 걷기 지속시간 88 : 해당 없음으로 0으로 대체
Data$BD2_31 = ifelse(Data$BD2_31 == 8, as.integer(1), Data$BD2_31)
# 폭음 빈도 8.  해당 없음으로 0으로 대체
Data$BD1_11 = ifelse(Data$BD1_11 == 8, as.integer(1), Data$BD1_11)
# 1년간 음주빈도 8 : 해당 없음으로 0으로 대체
Data$BS3_2 = ifelse(Data$BS3_2 == 888, as.integer(0), Data$BS3_2)
# 하루평균 흡연량 888 : 해당 없음으로 0으로 대체

# 범주형 변수 처리
Data$EQ5D = ifelse(Data$EQ5D >= 0.88, '1', '2')
Data$EQ5D <- as.factor(Data$EQ5D)
levels(Data$EQ5D) <- c("Good", "Normal")

Data$HE_HPdg = ifelse(Data$HE_HPdg == 1, '1', '2')
Data$HE_HPdg <- as.factor(Data$HE_HPdg)
levels(Data$HE_HPdg) <- c("Yes", "No")

Data$HE_DMdg = ifelse(Data$HE_DMdg == 1, '1', '2')
Data$HE_DMdg <- as.factor(Data$HE_DMdg)
levels(Data$HE_DMdg) <- c("Yes", "No")

Data$DC3_dg = ifelse(Data$DC3_dg == 1, '1', '2')
Data$DC3_dg<- as.factor(Data$DC3_dg)
levels(Data$DC3_dg) <- c("Yes", "No")

Data$DM1_dg = ifelse(Data$DM1_dg == 1, '1', '2')
Data$DM1_dg <- as.factor(Data$DM1_dg)
levels(Data$DM1_dg) <- c("Yes", "No")

Data$marri_1 = ifelse(Data$marri_1 == 1, '1', '2')
Data$marri_1 <- as.factor(Data$marri_1)
levels(Data$marri_1) <- c("Yes", "No")

Data$BP1 <- as.character(Data$BP1)
Data$BD2_31 <- as.character(Data$BD2_31)
Data$BD1_11 <- as.character(Data$BD1_11)
