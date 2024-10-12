# -----------------------------------------------------------------------------
# Verifica se os pacotes "readxl", "dplyr", "ggplot2", "forcats" e "scales" estão instalados.
# Caso contrário, realiza a instalação automaticamente.
if (!require(readxl)) install.packages("readxl")
if (!require(dplyr)) install.packages("dplyr")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(forcats)) install.packages("forcats")  # Necessário para ordenação de fatores
if (!require(scales)) install.packages("scales")    # Necessário para exibir porcentagens

# -----------------------------------------------------------------------------
# Importa as bibliotecas necessárias para ler arquivos Excel, manipular dados e criar gráficos.
library(readxl)
library(dplyr)
library(ggplot2)
library(forcats)
library(scales)

# -----------------------------------------------------------------------------
# Define o caminho do arquivo Excel contendo os dados agrícolas.
# Substitua "file_path" pelo caminho correto no seu sistema.
file_path <- "C:/Users/Matheus/Desktop/R fase 2/dados_agricola.xlsx"  # Substitua pelo caminho correto

# -----------------------------------------------------------------------------
# Verifica se o arquivo Excel especificado existe antes de tentar carregá-lo.
# Caso o arquivo não seja encontrado, o script interrompe e emite uma mensagem de erro.
if (file.exists(file_path)) {
  dados_agricola <- read_excel(file_path)
} else {
  stop("Arquivo não encontrado: Verifique o caminho do arquivo")
}

# -----------------------------------------------------------------------------
# Utiliza a função "str()" para mostrar a estrutura do dataframe e "head()" para exibir as primeiras linhas
# do arquivo carregado, ajudando a verificar se os dados foram importados corretamente.
str(dados_agricola)
head(dados_agricola)

# -----------------------------------------------------------------------------
# Calcula e armazena estatísticas básicas da variável "Produção Total (milhões de toneladas)".
# São calculados a média, mediana, desvio padrão, variância e os quartis (25%, 50%, 75%).
estatisticas_producao <- list(
  media = mean(dados_agricola$`Produção Total (milhões de toneladas)`, na.rm = TRUE),
  mediana = median(dados_agricola$`Produção Total (milhões de toneladas)`, na.rm = TRUE),
  desvio_padrao = sd(dados_agricola$`Produção Total (milhões de toneladas)`, na.rm = TRUE),
  variancia = var(dados_agricola$`Produção Total (milhões de toneladas)`, na.rm = TRUE),
  quartis = quantile(dados_agricola$`Produção Total (milhões de toneladas)`, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)
)

# Exibir estatísticas descritivas
# -----------------------------------------------------------------------------
# Mostra as estatísticas calculadas da produção total no console.
cat("Estatísticas da Produção Total:\n")
cat("Média: ", estatisticas_producao$media, "\n")
cat("Mediana: ", estatisticas_producao$mediana, "\n")
cat("Desvio Padrão: ", estatisticas_producao$desvio_padrao, "\n")
cat("Variância: ", estatisticas_producao$variancia, "\n")
cat("Quartis:\n")
print(estatisticas_producao$quartis)

# Verificar valores ausentes
# -----------------------------------------------------------------------------
# Conta e exibe o total de valores ausentes (NA) no dataset.
# Isso ajuda a identificar se há dados faltantes que podem impactar as análises.
cat("\nTotal de valores ausentes:\n")
sum(is.na(dados_agricola))

# Gráficos

# -----------------------------------------------------------------------------
# Cria um histograma da variável "Produção Total (milhões de toneladas)" com uma curva de densidade.
# Utiliza o binwidth para definir a largura dos intervalos, além de cores e transparências para melhorar a visualização.
# O gráfico mostra a densidade da distribuição da produção total.
ggplot(dados_agricola, aes(x = `Produção Total (milhões de toneladas)`)) +
  geom_histogram(aes(y = ..density..), binwidth = 5, fill = "steelblue", color = "black", alpha = 0.7) +
  geom_density(color = "red", alpha = 0.6) +
  labs(title = "Distribuição da Produção Total (milhões de toneladas)",
       x = "Produção Total (milhões de toneladas)",
       y = "Densidade") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))  # Centraliza o título

# -----------------------------------------------------------------------------
# Cria um gráfico de barras para mostrar a frequência das diferentes regiões.
# As barras são ordenadas pela frequência e incluem rótulos de porcentagem.
ggplot(dados_agricola, aes(x = reorder(Região, -table(Região)[Região]))) +
  geom_bar(fill = "orange", color = "black", alpha = 0.7) +
  labs(title = "Distribuição das Regiões",
       x = "Região",
       y = "Contagem") +
  geom_text(stat = 'count', aes(label = scales::percent(..count../sum(..count..))), vjust = -0.5) +  # Exibe porcentagens
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(angle = 45, hjust = 1))

# -----------------------------------------------------------------------------
# Cria um gráfico de barras para exibir a contagem de cada categoria da variável ordinal "Produtividade".
# Utiliza uma paleta de cores personalizada para destacar as diferentes categorias.
ggplot(dados_agricola, aes(x = fct_inorder(Produtividade))) +
  geom_bar(aes(fill = Produtividade), color = "black", alpha = 0.7) +
  labs(title = "Distribuição de Produtividade",
       x = "Nível de Produtividade",
       y = "Contagem") +
  geom_text(stat = 'count', aes(label = ..count..), vjust = -0.5) +  # Exibe contagens sobre as barras
  scale_fill_manual(values = c("red", "yellow", "green")) +  # Paleta de cores manual para ordinal
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(angle = 45, hjust = 1))
