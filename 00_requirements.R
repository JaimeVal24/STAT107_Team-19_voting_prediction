if (!require(readr)) {
  install.packages("readr")
  library(readr)
}

if (!require(tidyverse)) {
  install.packages("tidyverse")
  library(tidyverse)
}

if (!require(lubridate)) {
  install.packages("lubridate")
  library(lubridate)
}

if (!require(rsample)) {
  install.packages("rsample")
  library(rsample)
}

if (!require(janitor)) {
  install.packages("janitor")
  library(janitor)
}

if (!require(glmnet)) {
  install.packages("glmnet")
  library(glmnet)
}

if (!require(caret)) {
  install.packages("caret")
  library(caret)
}

if (!require(olsrr)) {
  install.packages("olsrr")
  library(olsrr)
}