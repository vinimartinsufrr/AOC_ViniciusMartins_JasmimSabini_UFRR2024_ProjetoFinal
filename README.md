# Projeto Processador RISC Uniciclo 8 Bits - **CPU_JV**

## Descrição do Projeto
O projeto **CPU_JV** é uma implementação de uma CPU baseada em um processador RISC de 8 bits, com arquitetura uniciclo. Ela foi projetada para executar as seguintes operações:

- **ADD** (Adição)
- **SUB** (Subtração)
- **SUBI** (Subtração com Imediato)
- **ADDI** (Adição com Imediato)
- **LOAD** (Carregamento de dados da memória)
- **STORE** (Armazenamento de dados na memória)
- **BEQ** (Branch if Equal - Ramificação condicional se igual)
- **JUMP** (Salto incondicional)

A CPU foi desenvolvida pelos alunos **Jasmim Sabini** e **Vinicius Cavalcante Martins**, como parte da disciplina de **Arquitetura de Computadores**, solicitada pelo professor **Hebert Rocha**.

---

## Estrutura do Projeto


### Descrição das Pastas:

- **Arquivos_Projeto/**
  - **Src/**: Contém os arquivos principais de código VHDL do projeto, incluindo o arquivo da CPU e o arquivo de testbench.
  - **Testbenches/**: Contém os arquivos de testbench para testar individualmente os componentes e a CPU.

- **Datapath/**: Contém o diagrama do datapath do processador (arquivo `datapath.png`).

- **Relatorio_Processador_JV/**: Contém o relatório do projeto (arquivo `Relatório_AOC.pdf`).

- **Testes/**: Contém os testes realizados para os componentes e para a CPU.
  - **Teste_de_Componentes/**: Contém os testes realizados para os componentes individuais.
  - **Testes_da_CPU_JV/**: Contém os testes realizados para verificar o funcionamento da CPU integrada.

---


## Como Executar o Projeto

### Requisitos
Para executar e simular o projeto **CPU_JV**, recomenda-se usar o **Intel Quartus 18.0 Lite** instalado em sua máquina. Além disso, é utilizado o **ModelSim** para a simulação. Outra opção é o **EDA Playground** para simulações online.

### Passos para Executar

1. **Instalar o Intel Quartus 18.0 Lite**: Se ainda não tiver o Quartus instalado, baixe e instale a versão **18.0 Lite** da [página oficial](https://www.intel.com/content/www/us/en/programmable/downloads/download-center.html).

2. **Baixar os Arquivos do Repositório**:
   - Faça o download de todos os arquivos dentro da pasta `Arquivos Projeto/Src`.

3. **Configurar o Arquivo de Topo e Testbench**:
   - No **Intel Quartus**, abra o projeto e set o arquivo **`CPU_JV.vhdl`** como o **arquivo de topo**.
   - Set o arquivo **`CPU_JV_tb.vhdl`** como o **arquivo de testbench** (este arquivo está localizado na pasta `Src`, enquanto os outros arquivos de testbench estão na pasta `Testbenches`).

4. **Escrever as Instruções na ROM**:
   - As instruções para a execução das operações devem ser escritas diretamente na **ROM** do processador.

5. **Configuração do Clock**:
   - O clock da CPU opera a 10ns, sendo 5ns na borda de descida (falling edge) e 5ns na borda de subida (rising edge).

6. **Simulação**:
   - Execute a simulação utilizando **ModelSim** ou, se estiver utilizando o **EDA Playground**, faça as configurações necessárias para simular o design.

---

## Detalhes Adicionais

- O **clock** de 10ns foi escolhido para garantir que o processador opere dentro de um tempo realista para simulações.
- As operações de **branching** como o **BEQ** e o **JUMP** são essenciais para o controle do fluxo de execução das instruções.
- O projeto inclui todos os testes necessários para verificar cada componente individualmente e a CPU integrada.

---

## Contribuições
- **Jasmim Sabini**
- **Vinicius Cavalcante Martins**

### Professor Solicitante:
- **Hebert Rocha**

---

## Licença
Este projeto está licenciado sob a licença XYZ (se necessário). Consulte o arquivo de licença para mais detalhes.

