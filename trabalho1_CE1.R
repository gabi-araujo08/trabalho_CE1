install.packages(c("here", "dplyr", "readr", "readxl", "tidyr", "knitr"))
library(dplyr)
library(here)
library(readr)
library(readxl)
library(tidyr)
library(knitr)

# Base de dados bruta CGIL (2024 e 2025)
dados_brutos <- rbind.data.frame(
  read.csv2(here("dados", "CGIL_CNIg_2024.csv"), fileEncoding = "UTF-8"),
  read.csv2(here("dados", "CGIL_CNIg_2025.csv"), fileEncoding = "UTF-8")
)

#Tabela de RNs (necessária para tabela 7.7)
rns_geral <- read.csv2(here("dados", "RNs_geral_17052025.csv"), fileEncoding = "UTF-8")

#Trimestre e ano de referência
trimestre_referencia <- 3
ano_referencia <- 2025

#Aplicação dos filtros requeridos
rns_referencia <- c("RN 01",  "RN 02", "RN 11", "RN 21", "RN 24", "RN 35",
                    "RN 62", "RN 63", "RN 70", "RN 74", "RN 76", "RN 80",
                    "RN 84", "RN 94", "RN 99", "RN 118", "RN 121", "RN 124")

rns_permitidas <- rns_geral %>%
  filter(RN %in% rns_referencia)

dados_unidos <- merge(dados_brutos, rns_permitidas, by = "amparo_legal")

dados_filtrados <- dados_unidos %>%
  filter(modalidade != "CNIg",
         escolaridade >= "5_Superior") #Perguntar se essa verificação de escolaridade está de acordo com os critérios de replicabilidade

names(rns_permitidas)
head(rns_geral)

