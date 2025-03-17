# Informações Importantes

Este documento descreve o funcionamento e a localização de cada componente no processador RISC uniciclo de 8 bits. Abaixo estão detalhes sobre onde cada componente age, incluindo a borda de clock em que operam.

## Componentes e suas Funcionalidades

### 1. **Unidade de Controle (Control Unit)**
   - **Função:** Responsável por decodificar as instruções e gerar os sinais de controle para os demais componentes.
   - **Borda de Clock:** Operação assíncrona.

### 2. **Banco de Registradores (Register File)**
   - **Função:** Armazena os registradores de uso geral do processador.
   - **Borda de Clock:** Escrita ocorre na borda de subida do clock, leitura é assíncrona.

### 3. **ULA (Unidade Lógica e Aritmética)**
   - **Função:** Realiza operações aritméticas e lógicas.
   - **Borda de Clock:** Operação assíncrona. (Devido a erro na inicialização da ALUResult, que inicializava apenas na primeira borda positiva, impactando o funcionamento.

### 4. **ROM (Memória de Instruções)**
   - **Função:** Armazena as instruções do programa.
   - **Borda de Clock:** Leitura assíncrona.

### 5. **RAM (Memória de Dados)**
   - **Função:** Armazena dados utilizados pelo programa.
   - **Borda de Clock:** Escrita ocorre na borda de subida do clock, leitura é assíncrona.

### 6. **PC (Program Counter)**
   - **Função:** Mantém o endereço da próxima instrução a ser executada.
   - **Borda de Clock:** Atualizado na borda de descida do clock. Com a ALU realizando a operação imediatamente.

### 7. **Multiplexadores (MUX)**
   - **Função:** Seleciona entre diferentes entradas com base em sinais de controle.
   - **Borda de Clock:** Operação assíncrona.

### 8. **Extensor de Sinal (Sign Extender)**
   - **Função:** Estende o sinal de valores imediatos para o tamanho correto.
   - **Borda de Clock:** Operação assíncrona.

### 9. **Somador (Adder)**
   - **Função:** Realiza a soma para cálculos de endereços.
   - **Borda de Clock:** Operação assíncrona.

### 10. **Decoder**
   - **Função:** Decodifica as instruções recebidas da ROM em sinais de controle para outros componentes.
   - **Borda de Clock:** Operação assíncrona.

## Observações
- Todos os componentes que operam na borda de subida do clock são sincronizados com o sinal de clock global.
- Componentes assíncronos não dependem diretamente do clock para operar, mas podem ser influenciados por sinais de controle gerados sincronamente.

