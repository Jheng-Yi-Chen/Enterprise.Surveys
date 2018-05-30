
# R Language Workshop, May 17, 2017
# https://ling32342.github.io/2017_NCCU_R/RDataVisualization.html#1

library(ggplot2)
# list all geom
ls(pattern = '^geom_', env = as.environment('package:ggplot2'))

# ���w�q�@�Ӹ�ƪ�
data <- data.frame(���� = c("�j�ǳ�", "��s��", "�б�", "���v", "�U��"), �H�� = c(20, 15, 5, 2, 3))
# plot
ggplot(data = data, aes(x = ����, y = �H��)) + 
  geom_bar(stat = "identity") +
  theme_grey(base_family = "STHeiti") 

# install.packages(c("ggplot2", "dplyr", "reshape2"), repos = "http://cran.csie.ntu.edu.tw/")

library(ggplot2)
library(dplyr)
library(reshape2)

############### ������| ###############
# �п�J���㪺�ɮ׸��|
data <- read.csv("/Users/hsiaoling/Desktop/data/transaction.csv") #�p�G�A�Omac
data <- read.csv("C:\\Users\\transaction.csv") #�p�G�A�Owindows
data <- read.csv("C:/Users/CJY/Desktop/transaction.csv", fileEncoding = "utf-8")
data <- data[,-1]
data$trac_month <- factor(data$trac_month)

############### �۹���| ###############
# �A�Ѳ{�b�ڭ̩ҳB�b�����|
getwd()
# �]�w�ڭ��ɮצs�񪺸��|
setwd() 
# Ū�ɰ_�⦡
data <- read.csv("transaction.csv") 
# �YŪ�J���O�ýX�A�ոեH�U
data <- read.csv("transaction.csv", fileEncoding = "big5")  #�p�G�A�Omac
data <- read.csv("transaction.csv", fileEncoding = "utf-8") #�p�G�A�Owindows

str(data)
summary(data)

# Bar chart
# geom_bar
# ���Ӭݬ�2013�~�b�U�������ץ����q
thm <- function() theme(text = element_text(size = 15, family = "STHeiti")) # ����r��P�j�p
# STHeiti�O�u��Mac�~�����r��, �ΨӸѨMMac�t�Τ�����ܿ��~�����D
# Windows�t�ΨϥΪ̽Щ��� `+ thm()` ���O
data %>% 
  ggplot(aes(x = city)) + geom_bar(stat = "count") + thm()  # stat = "count" ��Ӽ�

# Change labels!
data %>% 
  ggplot(aes(x = city)) + geom_bar(stat = "count") + thm() +
  labs(title = "�U��������q", x = "����", y = "����q") # lab�Ψ����ϧΪ����D�Bx�b�Py�b���R�W

# �C��վ�Gcolor vs fill?
data %>% 
  ggplot(aes(x = city)) + geom_bar(stat = "count") + thm() +
  labs(title = "�U��������q", x = "����", y = "����q") +
  geom_bar(fill = "red", color = "green")
colors() # see colors() if you're picky

# �ݻO�_���U��F�Ϫ��ץ����q
# ��ƾ�z
data %>% 
  filter(city == "�O�_��") %>% 
  group_by(district) %>% 
  summarise(amount = n()) -> table # dplyr::n �Ψӭp��

table %>% 
  ggplot(aes(x = district, y = amount)) +
  geom_bar(stat = "identity") + thm() + # stat='identity'�H���檺�Ȱ���bar������
  theme(axis.text.x = element_text(angle = 80, hjust = 1)) # ����r����V

# Reoder x
table %>% 
  ggplot(aes(x = reorder(district, -amount), y = amount)) +
  geom_bar(stat = "identity") + thm() +
  labs(titles = "�O�_���U��F�ϥ���q", x = "��F��", y = "�ץ��")

# �p��O�_��&���������U�ϥΤ��ϩνs�w(use_type)�Ҧ����
data %>%
  filter(city %in% c("�O�_��", "������")) %>%
  group_by(city, use_type) %>% 
  summarise(amount = n()) %>% 
  mutate(rate = round(amount/sum(amount), 2) ) -> table

data %>% 
  filter(city == "�O�_��" | city == "������" ) %>% 
  group_by(city, use_type) %>% 
  summarise(amount = n()) %>% 
  mutate(cityamount = )
  mutate(rate = round(amount/sum(amount),2) ) -> table

# Grouping�Gstack
table %>% 
  ggplot(aes(x = city, y = rate, fill = use_type)) +
  geom_bar(stat = "identity", position = "stack") + thm() # stack���O���|

# Grouping�Gdodge
table %>% 
  ggplot(aes(x = city, y = rate, fill = use_type)) +
  geom_bar(stat = "identity", position = "dodge")  + # dodge���O�ñ�
  thm() + scale_fill_discrete(name  ="�ϥΤ��ϩνs�w")  # �]�w�ϨҪ����

test <- data.frame(district = c("�j�w","�_��"), area = c(10,15))

# stat = "count"
test %>% 
  ggplot(aes(x = district)) +
  geom_bar(stat = "count") + thm()

# stat = "identity"
test %>% 
  ggplot(aes(x = district, y = area)) +
  geom_bar(stat = "identity") + thm()

# Line chart
# geom_line
# �U�������q
data %>% 
  group_by(trac_month) %>% 
  summarise(amount = n()) -> table
table

table %>% 
  ggplot(aes(x = trac_month, y = amount, group = 1)) +
  geom_line() + thm() + labs(x = "������" , y = "����ƶq")

# �U�����U�������q���
data %>% 
  group_by(city,trac_month) %>% 
  summarise(amount = n()) -> table
table

table %>% 
  ggplot(aes(x = trac_month, y = amount, group = city, color = city)) +
  geom_line() + geom_point() + thm() + 
  labs(x = "������" , y = "����ƶq")

# Histogram
# geom_histogram
data %>% 
  ggplot(aes(x = age, y = ..count..)) + 
  geom_histogram()

# aes(y=..count..) vs. aes(y=..density..)
data %>% 
  ggplot(aes(x = age, y = ..density..)) + 
  geom_histogram()

data %>% 
  ggplot(aes(x = age, y = ..density.., fill = ..count..)) + # fill �̫��w�����
  geom_histogram() 

data %>% 
  ggplot(aes(x = age, y = ..density.., fill = ..count..)) + # fill �̫��w�����
  geom_histogram(binwidth = .5) 

# Histogram + density
# geom_histogram() + geom_density()
data %>% 
  ggplot(aes(x = age, y = ..density..)) + 
  geom_histogram(color = "black", fill = "white") +
  geom_density(alpha = .2, fill = "#FF6666") # alpha�]�w�z����

# Boxplot
# geom_boxplot
data %>% 
  ggplot(aes(x = city, y = price_unit)) + 
  geom_boxplot() + thm() + 
  labs(x = "����" , y = "�C���褽�ػ���(��)")

# Change limits of axes!
data %>% 
  ggplot(aes(x = city, y = price_unit)) + 
  geom_boxplot() + thm() + 
  labs(x = "����" , y = "�C���褽�ػ���(��)") + 
  coord_cartesian(ylim = c(0, 2000000)) # �]�wy�b�W�U�ɽu

data %>% 
  ggplot(aes(x = city, y = log(price_unit))) + 
  geom_boxplot() + thm() + # geom_boxplot(outlier.shape = NA) outlier�����
  labs(x = "����" , y = "log(�C���褽�ػ���(��))")

data %>% 
  ggplot(aes(x = city, y = log(price_unit))) + 
  geom_boxplot(outlier.shape = NA) + thm() + # geom_boxplot(outlier.shape = NA) outlier�����
  labs(x = "����" , y = "log(�C���褽�ػ���(��))")

# Scatter plot
# geom_point
iris %>% 
  ggplot(aes(x = Sepal.Length, y = Petal.Length, color = Species)) + 
  geom_point()

iris %>% 
  ggplot(aes(x = Sepal.Length, y = Petal.Length, color = Species)) + 
  geom_point(shape = 1, size = 2) # shape����ϥܡFsize�����I���j�p

# �ѼƩ�baes()��Ƹ̭��A���ܸ�ƨ̾ګ��w��줺�e�����P��shape/size�ܤ�
iris %>% 
  ggplot(aes(x = Sepal.Length,
             y = Petal.Length, 
             color = Species,
             shape = Species,
             size = Species)) +
  geom_point() +
  scale_shape_manual(values = c(1, 5, 7)) +  # ���� shape ��ܹϥ�
  scale_size_manual(values = c(1, 2, 3))   # ����ϥ� size ��ܤj�p

# Fit regression line
iris %>% 
  ggplot(aes(x = Sepal.Length, y = Petal.Length)) + 
  geom_point() +
  stat_smooth(method = lm, level = .95) # add se = FALSE to disable CI

M1 <- lm(Petal.Length ~ Sepal.Length, data = iris)
summary(M1)

iris %>% 
  ggplot(aes(x = Sepal.Length, y = Petal.Length)) + 
  geom_point() +
  stat_smooth(level = .95) # add �H��϶�(se) = FALSE to disable CI

iris %>% 
  ggplot(aes(x = Sepal.Length, y = Petal.Length)) + 
  geom_point() +
  stat_smooth(method = lm, level = .95, se = FALSE) # add se = FALSE to disable CI

# facet
# ����U�����b�U����U������q
data %>% 
  group_by(city,trac_month) %>% # ��ܿ����B�������@�����s
  summarise(total = n()) -> table # �p����s�U���`��
table %>% 
  ggplot(aes(x = trac_month, y = total ,fill = city))+
  geom_bar(stat = "identity") + thm()

table %>% 
  ggplot(aes(x = trac_month, y = total, fill = city))+
  geom_bar(stat = "identity") + thm() +
  facet_wrap( ~ city , nrow = 2) +
  labs(x = "������", y = "����q")

# coord_flip()
table %>% 
  ggplot(aes(x = trac_month, y = total ,fill = city))+
  geom_bar(stat = "identity") + thm() +
  facet_wrap( ~ city , nrow = 2) +
  labs(x = "������", y = "����q") +
  coord_flip() 

ggsave("�ɮצW��")
ggsave("plot.pdf", width = 4, height = 4)
ggsave("plot.png", width = 4, height = 4, dpi = 300)

# ���ʦ���ı�Ƨe�{
install.packages("plotly")
library(plotly)

# plot with ggplot2
iris %>% 
  ggplot(aes(Petal.Width, Sepal.Length, colour = Species)) +
  geom_point() -> a
a

# plot with ggplotly
ggplotly(a)
