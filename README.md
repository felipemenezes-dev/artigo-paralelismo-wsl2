# Artigo — Paralelismo em Arquiteturas Multicore com WSL2

Repositório com os dados experimentais e scripts utilizados no artigo científico sobre avaliação de desempenho de aplicações paralelas em arquiteturas multicore, executadas sobre o WSL2.

## Objetivo

Analisar como o desempenho de uma aplicação CPU-intensiva escala com o aumento do número de threads em um ambiente virtualizado (WSL2), discutindo os efeitos práticos da Lei de Amdahl e o impacto da camada de virtualização sobre os resultados.

## Ambiente Experimental

### Hardware

| Componente | Especificação |
|---|---|
| Processador | Intel Core i5-10210U |
| Núcleos físicos | 4 |
| Threads lógicas | 8 (Hyper-Threading) |
| Cache L3 | 6 MB |

### Software

| Componente | Versão |
|---|---|
| Sistema Operacional | Ubuntu 24.04 LTS (WSL2) |
| Kernel | 6.6.87.2-microsoft-standard-WSL2 |
| Compilador | GCC 13.3.0 |
| Benchmark CPU | sysbench 1.0.20 |
| Benchmark I/O | fio 3.36 |

## Metodologia

O script `executar_sysbench.sh` executa o benchmark de CPU do sysbench variando o número de threads entre **1, 2, 4 e 8**, com **30 repetições por configuração** para garantir confiabilidade estatística.

A carga de trabalho consiste no cálculo de números primos até 20.000. A métrica coletada é **events per second** (throughput de operações paralelas por segundo).

```bash
# Como reproduzir
chmod +x executar_sysbench.sh
./executar_sysbench.sh
```

Os resultados são salvos automaticamente em `resultados.csv`.

## Arquivos

| Arquivo | Descrição |
|---|---|
| `executar_sysbench.sh` | Script de automação dos experimentos |
| `resultados.csv` | Dados coletados (threads × events/s, 30 amostras cada) |

## Estrutura do CSV

```
threads,events_per_second
1,<valor>
2,<valor>
...
```

## Observações

- Os experimentos foram executados exclusivamente no WSL2, o que introduz uma camada de virtualização em relação ao Linux nativo (*bare metal*). Essa diferença é discutida no artigo.
- As 30 repetições por configuração permitem calcular média, desvio padrão e intervalos de confiança.
- Os resultados ilustram na prática os limites de escalabilidade previstos pela Lei de Amdahl.

## Autores

- Felipe Menezes — [@felipemenezes-dev](https://github.com/felipemenezes-dev)
- Natan Luis Pereira dos Santos 
