# Carregar bibliotecas necessárias
# install.packages("readxl")
# install.packages("dplyr")
# install.packages("ggplot2")
library(readxl)  # Para ler arquivos Excel
library(dplyr)   # Para manipulação de dados
library(ggplot2) # Para visualização

# file_path: Caminho do arquivo Excel contendo os dados agrícolas
# dados_agricola: Dataframe resultante da leitura do arquivo Excel
file_path <- "../dados_agricola.xlsx"  # Substitua pelo caminho correto
dados_agricola <- read_excel(file_path)

# head(): Exibe as primeiras linhas do dataframe 'dados_agricola' para conferir sua estrutura
head(dados_agricola)

# media_producao: Calcula a média da coluna 'Produção Total (milhões de toneladas)', ignorando valores ausentes (NA)
# mediana_producao: Calcula a mediana da coluna 'Produção Total (milhões de toneladas)', ignorando valores ausentes
media_producao <- mean(dados_agricola$`Produção Total (milhões de toneladas)`, na.rm = TRUE)
mediana_producao <- median(dados_agricola$`Produção Total (milhões de toneladas)`, na.rm = TRUE)

# desvio_padrao_producao: Calcula o desvio padrão da coluna 'Produção Total (milhões de toneladas)', ignorando valores ausentes
# variancia_producao: Calcula a variância da coluna 'Produção Total (milhões de toneladas)', ignorando valores ausentes
desvio_padrao_producao <- sd(dados_agricola$`Produção Total (milhões de toneladas)`, na.rm = TRUE)
variancia_producao <- var(dados_agricola$`Produção Total (milhões de toneladas)`, na.rm = TRUE)

# quartis_producao: Calcula os quartis (25%, 50%, 75%) da produção total, usando a função quantile() para separar os dados
quartis_producao <- quantile(dados_agricola$`Produção Total (milhões de toneladas)`, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)

# cat(): Exibe as medidas calculadas para média, mediana, desvio padrão, variância e quartis da Produção Total
cat("Média da Produção Total: ", media_producao, "\n")
cat("Mediana da Produção Total: ", mediana_producao, "\n")
cat("Desvio Padrão da Produção Total: ", desvio_padrao_producao, "\n")
cat("Variância da Produção Total: ", variancia_producao, "\n")
cat("Quartis da Produção Total: \n")
print(quartis_producao)

# Gráficos

# Mostra a distribuição da variável quantitativa Produção Total
# ggplot(): Função usada para criar gráficos; geom_histogram(): Gera histograma com a produção total
ggplot(dados_agricola, aes(x = `Produção Total (milhões de toneladas)`)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribuição da Produção Total (milhões de toneladas)",
       x = "Produção Total (milhões de toneladas)",
       y = "Frequência") +
  theme_minimal()

# Mostra a distribuição da variável qualitativa nominal 'Região'
# geom_bar(): Cria um gráfico de barras para contar as frequências das regiões
ggplot(dados_agricola, aes(x = Região)) +
  geom_bar(fill = "orange", color = "black", alpha = 0.7) +
  labs(title = "Distribuição das Regiões",
       x = "Região",
       y = "Contagem") +
  theme_minimal()

# Mostra a distribuição da variável qualitativa ordinal 'Produtividade'
# geom_bar(): Cria um gráfico de barras para contar as categorias de produtividade
ggplot(dados_agricola, aes(x = Produtividade)) +
  geom_bar(fill = "green", color = "black", alpha = 0.7) +
  labs(title = "Distribuição de Produtividade",
       x = "Produtividade",
       y = "Contagem") +
  theme_minimal()
