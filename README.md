# Análise de Dados Agrícolas com R

Este repositório contém um script em R desenvolvido para realizar análises descritivas e visualizações sobre um conjunto de dados agrícolas. O código inclui cálculos de medidas estatísticas e gráficos que ajudam a entender a distribuição dos dados relacionados à produção agrícola, regiões e produtividade.

## Requisitos

Antes de executar o script, certifique-se de que as seguintes bibliotecas estão instaladas:

- `readxl`: Para leitura de arquivos Excel.
- `dplyr`: Para manipulação de dados.
- `ggplot2`: Para visualização de dados.

Você pode instalá-las executando:

```
install.packages("readxl")
install.packages("dplyr")
install.packages("ggplot2")
```

## Instruções de Uso

### 1. Carregar os Dados

O script lê um arquivo Excel contendo dados agrícolas. Certifique-se de fornecer o caminho correto do arquivo na variável `file_path`:

```
file_path <- "C:/caminho_para_o_arquivo/dados_agricola_ajustado.xlsx"
dados_agricola <- read_excel(file_path)
```

### 2. Medidas Estatísticas

O código calcula as principais medidas descritivas para a variável quantitativa contínua "Produção Total (milhões de toneladas)":

- **Média**
- **Mediana**
- **Desvio Padrão**
- **Variância**
- **Quartis**

As medidas são exibidas diretamente no console:

```
cat("Média da Produção Total: ", media_producao, "\n")
cat("Mediana da Produção Total: ", mediana_producao, "\n")
cat("Desvio Padrão da Produção Total: ", desvio_padrao_producao, "\n")
cat("Variância da Produção Total: ", variancia_producao, "\n")
cat("Quartis da Produção Total: \n")
```

### 3. Visualização de Dados

O script gera três gráficos para ilustrar a distribuição das variáveis:

- **Histograma da Produção Total (milhões de toneladas)**: Exibe a distribuição da variável quantitativa.

```
ggplot(dados_agricola, aes(x = `Produção Total (milhões de toneladas)`)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black", alpha = 0.7) +
  labs(title = "Distribuição da Produção Total (milhões de toneladas)",
       x = "Produção Total (milhões de toneladas)",
       y = "Frequência") +
  theme_minimal()
```

- **Gráfico de Barras da Região**: Mostra a contagem das regiões.

```
ggplot(dados_agricola, aes(x = Região)) +
  geom_bar(fill = "orange", color = "black", alpha = 0.7) +
  labs(title = "Distribuição das Regiões",
       x = "Região",
       y = "Contagem") +
  theme_minimal()
```

- **Gráfico de Barras da Produtividade**: Exibe a distribuição da variável qualitativa ordinal "Produtividade".

```
ggplot(dados_agricola, aes(x = Produtividade)) +
  geom_bar(fill = "green", color = "black", alpha = 0.7) +
  labs(title = "Distribuição de Produtividade",
       x = "Produtividade",
       y = "Contagem") +
  theme_minimal()
```

### 4. Como Executar

1. Clone este repositório:

```

git clone https://github.com/seu_usuario/seu_repositorio.git

```


2. Abra o script no RStudio ou qualquer editor de código que suporte R.

3. Execute o código no ambiente de sua preferência e observe os resultados das análises e os gráficos gerados.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

Este script foi desenvolvido para fins educacionais e para demonstrar como realizar uma análise descritiva e visualização de dados usando R.
