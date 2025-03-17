# Testes do Projeto CPU_JV

Esta pasta contém os testes realizados para o projeto do processador RISC Uniciclo de 8 bits, CPU_JV. Os testes estão organizados em duas pastas principais: uma para os testes dos componentes separados e outra para os testes da CPU integrada. Cada pasta contém informações e arquivos relacionados aos testes realizados.

## Estrutura de Pastas


### **Teste de Componentes (SEPARADOS)**

Esta pasta contém os testes realizados para os **componentes individuais** do processador. Cada componente do processador foi testado de forma isolada para garantir seu funcionamento correto antes de integrá-los no design completo. Os testes podem incluir verificações de operações básicas, como somas e subtrações, ou de comportamentos mais complexos, dependendo de cada componente.

#### Exemplos de testes:
- Testes da ALU
- Testes de registradores
- Testes de unidades de controle

### **Testes da CPU_JV**

Esta pasta contém os **testes realizados na CPU integrada**, onde todos os componentes são testados juntos para garantir que o processador funcione corretamente como um todo. Esses testes verificam a execução de instruções como ADD, SUB, LOAD, STORE, BEQ, JUMP, entre outras. 

#### Exemplos de testes:
- Testes para garantir o correto funcionamento da execução das instruções.
- Verificação do controle de fluxo de execução com instruções de salto (JUMP, BEQ).
- Teste da interação entre registradores e memória.

## Como Executar os Testes

Os testes foram implementados em **VHDL** e podem ser executados utilizando o **Intel Quartus 18.0 Lite** com o **ModelSim** para simulações.

1. Depois de baixar os arquivos base do projeto, baixe todos os testbenches desejados na pasta **Arquivos Projeto/ Testbenches**.
2. Abra o arquivo de teste correspondente no ModelSim, e o configure devidamente como arquivo de Testbench.
3. Execute a **RTL Simulation** para observar os resultados dos testes.
4. Verifique se as saídas dos testes estão corretas de acordo com as expectativas definidas nos testbenches.

## Importância dos Testes

Os testes realizados para o projeto visam validar a funcionalidade de cada componente, bem como o comportamento da CPU como um todo. Cada teste fornece feedback importante sobre a integridade do design e se ele cumpre os requisitos do projeto.

---

Por favor, consulte a documentação adicional nas pastas **Relatório** e **Arquivos do Projeto** para mais informações sobre o desenvolvimento do processador e seu comportamento.

