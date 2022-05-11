library(usethis)
library(tidyr)
library(dplyr)
# ------pop 2014------
pop_2014 = data.frame(
  read.csv('E://Out_Elec_Acc//Ex1_Globe_14_20//excel_total_pop//zonal_globe_med3_2014.csv',
                               header = 1,na.strings = c("","NA"))) #指定字符型的NA
mean(is.na(pop_2014$NAME)) # 1.6% of the “NAME” variable is missing.
# Dropping missing data
#library(tidyr)
pop_2014_clean <- pop_2014 %>%
  drop_na(NAME)
mean(is.na(pop_2014_clean$NAME)) # 去除NA以后的数据框，NA比例为0

# ------elec pop 2014------
elecpop_2014 = data.frame(
  read.csv('E://Out_Elec_Acc//Ex1_Globe_14_20//excel_elec_pop//excel_elec_m3_2014.csv',
           header = 1,na.strings = c("","NA"))) #指定字符型的NA
mean(is.na(elecpop_2014$NAME))
elecpop_2014_clean <- elecpop_2014 %>%
  drop_na(NAME)

# ------country name------
country_name = data.frame(
  read.csv('E://Inputs_Bound_wgs84//Globe_country_0502//Globe_Country_GBK.csv',
           header = 1,na.strings = c("","NA"))) #指定字符型的NA
mean(is.na(country_name$NAME))
country_name_clean <- country_name %>%
  drop_na(NAME)
head(country_name_clean)

# ------merge elec 2014------
## 计算并增加行列
# 创建数据框
pop_2014_all = data.frame(country_name_clean$NAME, country_name_clean$FENAME,
                          country_name_clean$FCNAME, country_name_clean$SOC,
                          elecpop_2014_clean$FENAME,elecpop_2014_clean$X_sum,
                          pop_2014_clean$FENAME,pop_2014_clean$X_sum)
#head(pop_2014_all)
#tail(pop_2014_all)
# 使用dplyr包中的函数
pop_2014_all<- mutate(pop_2014_all,ElecPopRate=elecpop_2014_clean.X_sum/pop_2014_clean.X_sum)
boxplot(pop_2014_all$ElecPopRate)

# ------World bank data------
WB_data = data.frame(
  read.csv('E://Out_Elec_Acc//Worldbank//WB_Data.csv',
                              header = 1))

# import data to package
use_data(WB_data,overwrite = TRUE)
use_data(pop_2014_all,overwrite = TRUE)
use_data(country_name_clean,overwrite = TRUE)
use_data(elecpop_2014_clean,overwrite = TRUE)
use_data(pop_2014_clean,overwrite = TRUE)

