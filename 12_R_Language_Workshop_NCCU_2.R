
# R Language Workshop, May 10, 2017
# https://lucy0222.github.io/2017_NCCU_R/RProgramming.html#1

# �i�H�ϥ�R���O�ӤU��
url <- "https://lucy0222.github.io/2017_NCCU_R/hsb.csv"
download.file(url, destfile = "hsb.csv") # ���ɮץt�s��hbs.csv
dat <- read.csv("hsb.csv")
head(dat)

# Ū���ۤv�q���̪�csv��
# ��k1. �z�L��������ɮשҦb���|
path <- file.choose()
dat <- read.csv(path)

# ��k2. �ۦ��J�ɮשҦb���|
path <- "/Volumes/LEEF SURGE/LearnR/hsb.csv"
dat <- read.csv(path)

# ��k3. �ۦ��J�ɮ׬۹���|
dat <- read.csv("hsb.csv")

# �Q��write.csv�Ndata.frame�榡��R����t�s��csv��
write.csv(dat, "hsb_new.csv", row.names = FALSE, quote = FALSE)

# getwd �d�ߥثe�Ҧb����Ƨ����| (������|)
# setwd �]�w�Ҧb����Ƨ����| 

getwd()
dat <- read.csv("hsb.csv")

# Ū����L�n���ƶ�
# install.packages("foreign") # �w��R�M�� foreign
library(foreign) # ���J�M�� 
cars <- read.spss("data/Cars.sav", to.data.frame = TRUE)
milk <- read.dta("data/p004.dta")
# head(cars)
# head(milk)

# install.packages("sas7bdat")
library(sas7bdat)
airline <- read.sas7bdat("data/airline.sas7bdat")
head(airline)

# readLines, writeLines�A�OŪ��������l�X���n�u��
output <- file("output.txt")
writeLines(as.character(1:12), con = output)
input <- readLines(output)
input

# ��X���H�x�設��
web_page <- readLines("http://www.buzzhand.com/post_365903.html")
matches <- gregexpr("[\u4E00-\u9FA5]+�x�設���G[0-9]+cm", web_page)
tmp <- regmatches(web_page, matches)
unlist(tmp)

# ��X�M�ߺ֥��x�_���n�䩱���a�}
# gregexpr�n���ΡH��J�G?gregexpr
web_page <- readLines("http://www.319papago.idv.tw/lifeinfo/chingshin/chingshin-02.html", encoding = "utf8")
matches <- gregexpr("�x�_���n���[\u4E00-\u9FA5|0-9|(|)]+", web_page)
tmp <- regmatches(web_page, matches)
unlist(tmp) # �� list �ন vector

# ��X�M�ߺ֥��x�_���������q�ܸ��X
web_page <- readLines("http://www.319papago.idv.tw/lifeinfo/chingshin/chingshin-02.html")
matches <- gregexpr("02-[0-9]+", web_page)
tmp <- regmatches(web_page, matches)
unlist(tmp) 

# ����P�_�y�y - if
# �P�_x�O�_�j��2, �p�G�O�A�h�L�X���G
# cat�O����H��J�G?cat
x <- 4
if (x > 2) {
  cat(x, "is larger than 2")
}

# �P�_x�O�_�j��2, �p�G�O�A�h�L�X���G
x <- 4
if (x > 2) cat(x, "is larger than 2")

y <- 1
if (y > 2) {
  cat(y, "is larger than 2")
} else {
  cat(y, "is smaller than 2")
} 

y <- 1
ifelse(y > 2, "larger than 2", "smaller than 2")

z <- 1:5
ifelse(z > 2, "larger than 2", "smaller than 2")

# �Y�ݭn�h�ӧP�_����ɡA�[�Jelse if, �K, else
y <- 1
if(y > 2) {
  cat(y, "is larger than 2")
} else if (y < 2) {
  cat(y, "is smaller than 2")
} else {
  cat(y, "is equal to 2")
}

# �ۭq��� - function
foo <- function(x) { # �o��function���@���ܼ�x
  if(x > 2) {
    cat(x, "is larger than 2")
  } else if (x < 2){
    cat(x, "is smaller than 2")
  } else {
    cat(x, "is equal to 2")
  }  
}
foo(1); foo(2); foo(3)

# �`���y�y - for
# �`���y�y�A�i�Ψӭ��ư���Y�q�{���X
x <- 0
for(i in 1:10) {
  if(i %% 2 != 0) { # x�O�_���_�ơA
    x <- x + i # �ۨ��֥[
  }
}
x

# �ˬd
1+3+5+7+9

#�����`���y�y�A�i�Ψӭ��ư���Y�q�{���X
# \t = tab��, \n = �Ŧ�
x <- 0
k <- 0
for(i in 1:3) {
  for(j in 1:3) {
    cat(paste(i, "*", j,  "=", i*j, ",\t", sep=""))
    k <- k + 1
    x[k] <- i*j
  }
  cat("\n")
}

# �i��movies��Ƨ��U�Ҧ����ɮ�
# dir�O����H��J�G?dir
fname <- dir("C:/Users/CJY/Desktop/movies")
fname
# �ݤ@�Ufname����������Aclass(fname)
class(fname)

# �m��Ū�@��csv�� (movies-1995.csv)
path <- paste("C:/Users/CJY/Desktop/movies/", fname[1], sep="")
mov95 <- read.csv(path)
head(mov95)

# �m��Ū�h��csv��
mov <- list() # �w�]�@�ӦW�� mov ��list�e��
for(i in 1:length(fname)) {
  path <- paste("C:/Users/CJY/Desktop/movies/", fname[i], sep="")
  mov[[i]] <- read.csv(path)
}
head(mov[[1]])

# �Nlist�ΦC�X��(rbind)��X��data.frame
# do.call�O����H��J�G?do.call
# df����������H
df <- do.call(rbind, mov) 
head(df)

# �uŪ��1995-1999�q�v���
matches <- gregexpr("movies-199[5-9]+.csv", fname)
tmp <- regmatches(fname, matches)
fname90 <- unlist(tmp)
mov90 <- list() # �w�]�@�ӦW�� mov ��list�e��
for(i in 1:length(fname90)) {
  path <- paste("C:/Users/CJY/Desktop/movies/", fname90[i], sep="")
  mov90[[i]] <- read.csv(path)
}
df90 <- do.call(rbind, mov90)
# tail(df90) # �̫�6��

# �m�߼g�@�ӧ妸Ū�ɨ��
myRead <- function(fname, path0 = "C:/Users/CJY/Desktop/movies/") {
  mov <- list()
  for(i in 1:length(fname)) {
    path <- paste(path0, fname[i], sep="")
    mov[[i]] <- read.csv(path)
  }
  do.call(rbind, mov)
}
df <- myRead(fname90, path0 = "C:/Users/CJY/Desktop/movies/")
head(df)

# Pipe Line Coding Style
# https://blog.gtwang.org/r/r-pipes-magrittr-package/

# %>% <- ctrl + shift + m

library(magrittr)
x <- 1:10
mean(x)
x %>% mean

# �Q�ΤT���έ��n��������%>%��l���X�ص����Ϊk
tri_area <- function(a, h = 5) a*h/2 # �j�A���ٲ�
a <- 10
tri_area(a)

a %>% tri_area          # �ٲ��A��
a %>% tri_area(h = 5)     # �O�d�A��
a %>% tri_area(., h = 5)  # �H "." �Ӫ��ܱ��ǤJ���ܼ�

# ���O���Y
plot(density(sample(mtcars$mpg, size = 10000, replace = TRUE), kernel = "gaussian"), col = "red", main = "density of mpg")

# Pipe Line
mtcars$mpg %>% 
  sample(size = 10000, replace = TRUE) %>% 
  density(kernel = "gaussian") %>% 
  plot(col = "red", main = "density of mpg")

# ��ƳB�z
# ��Ʃԥ� reshape2
# melt: wide format -> long format
# dcast: long format -> wide format

library(reshape2)
WP.melt <- data.frame(WorldPhones)
WP.melt$year <- rownames(WP.melt)  
WP.melt <- melt(WP.melt, id = "year")
head(WP.melt)

WP.cast <- dcast(WP.melt, year ~ variable, value.var = "value") 
head(WP.cast)

# �ǲ�dplyr���x��覡�Gvignette
# help -> cheatsheets
library(dplyr)
vignette(all = TRUE, package = "dplyr")
vignette("introduction", package = "dplyr")

# arrange �ƦC
# filter ��C���z�� (row)
# select ���氵�z�� (column)
# mutate �����ηs�W��
# group_by + summarise ����

arrange(iris, Petal.Length) %>% head
arrange(iris, Sepal.Length) %>% tail
# �Ƨǹw�]�O�Ѥp��j�A�[�Wdesc�i�ϥλ��W�ƦC
arrange(iris, desc(Petal.Length)) %>% head
arrange(iris, -Petal.Length) %>% head
iris %>%
  arrange(desc(Petal.Length)) %>% 
  head
# �ƧǪ����إi�H���u�@���A�u�n�̧ǱN���ض�J���Y�i
arrange(iris, desc(Petal.Length), - Sepal.Length ) %>% head

# �������Ƹ��
distinct(iris)
# �H��������
sample_n(iris, 5)
# ������w�C
slice(iris, c(1, 3, 4, 5))

# ��C���z�� filter
filter(iris, Sepal.Length == 7.7)
filter(iris, Sepal.Length == 7.7, Sepal.Width == 2.8)
filter(iris, Species == "virginica")
filter(iris, Sepal.Length != 7.7)

# ������
url <- "https://lucy0222.github.io/2017_NCCU_R/%E8%B2%B7%E8%B3%A3st_A_10109_10109.csv"
dat <- read.csv(url, fileEncoding = "big5")
filter(dat, �m������ == "������") %>% View
CK <- filter(dat, �m������ == "������") %>% View
table(dat$�D�n�γ~)
table(dat$���L�޲z��´)

# ��氵��� select
tmp <- select(iris, c(Petal.Width, Species))
head(tmp)
# �έt��-����ϦV���
tmp <- select(iris, c(-Petal.Width, -Species))
head(tmp)

# �s�W��� mutate
# �p�G�Q�n�����P��춡�p���o��s�����Ӧp��B�z
# Ĵ�p Petal.Length * Petal.Width
tmpiris <- mutate(iris, Petal.Vol = Petal.Length * Petal.Width)
head(tmpiris)
new1 <- iris
new1 <- mutate(new1, ne = 5)
head(new1)

# �ϯä��R group_by + summarise
# �p�G�Q�n Sepal.Length �� mean�BSepal.Width ���зǮt�BPetal.Length ���̤j��
# �Q��summarise
summarise(iris, SL.mean = mean(Sepal.Length), SW.sd = sd(Sepal.Width), PL.max = max(Petal.Length))

# �p�G�Q�n Sepal.Length �� mean�BSepal.Width ���зǮt�BPetal.Length ���̤j��
# �̷Ӫ������O�U�ۭp��
# �Q��group_by + summarise
group_by(iris, Species) %>%
  summarise(SL.mean = mean(Sepal.Length), SW.sd = sd(Sepal.Width), PL.max = max(Petal.Length))
WW <- group_by(iris, Species) %>% 
  summarise(SL.mean = mean(Sepal.Length), SW.mean = mean(Sepal.Width), PL.mean = mean(Petal.Length), PW.mean = mean(Petal.Width))
WW

group_by(dat, �m������) %>% 
  summarise(���� = mean(���.��.���褽��., na.rm = T))

