LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY control_unit IS
    PORT (
        Opcode   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Opcode da instrução (4 bits)
        RegWrite : OUT STD_LOGIC;                   -- Habilitação de escrita no registrador
        MemWrite : OUT STD_LOGIC;                   -- Habilitação de escrita na RAM
        MemRead  : OUT STD_LOGIC;                   -- Habilitação de leitura da RAM
        MemToReg : OUT STD_LOGIC;                   -- Define se o registrador recebe dado da RAM ou da ALU
        Branch   : OUT STD_LOGIC;                   -- Define se há um salto condicional (BEQ)
        ALUSrc   : OUT STD_LOGIC; -- Sinal de controle para o MUX antes da ALU 
        ALUOp    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)  -- Define a operação da ALU
    );
END ENTITY control_unit;

ARCHITECTURE behavior OF control_unit IS
BEGIN
    PROCESS (Opcode)
    BEGIN
        -- Valores padrão (para evitar sinais indefinidos)
        RegWrite  <= '0';
        MemWrite  <= '0';
        MemRead   <= '0';
        MemToReg  <= '0';
        Branch    <= '0';
        ALUSrc    <= '0';  -- Padrão: Operação normal entre registradores
        ALUOp     <= "0000"; -- Default

        CASE Opcode IS
            WHEN "0101" => -- ADD
                RegWrite <= '1';
                ALUOp    <= "0101"; -- Código para ADD
                ALUSrc   <= '0';  -- Operando vem de um registrador
                MemRead  <= '0';   -- Explicitamente zerando
                MemWrite <= '0';   -- Explicitamente zerando
                MemToReg <= '0';   -- Explicitamente zerando
                Branch   <= '0';   -- Explicitamente zerando
            
            WHEN "0110" => -- SUB
                RegWrite <= '1';
                ALUOp    <= "0110"; -- Código para SUB
                ALUSrc   <= '0';  -- Operando vem de um registrador
                MemRead  <= '0';   -- Explicitamente zerando
                MemWrite <= '0';   -- Explicitamente zerando
                MemToReg <= '0';   -- Explicitamente zerando
                Branch   <= '0';   -- Explicitamente zerando
            
            WHEN "0010" => -- ADDI
                RegWrite <= '1';
                ALUOp    <= "0010"; -- Código para ADDI
                ALUSrc   <= '1';  -- Operando vem de um imediato
                MemRead  <= '0';   -- Explicitamente zerando
                MemWrite <= '0';   -- Explicitamente zerando
                MemToReg <= '0';   -- Explicitamente zerando
                Branch   <= '0';   -- Explicitamente zerando
            
            WHEN "0011" => -- SUBI
                RegWrite <= '1';
                ALUOp    <= "0011"; -- Código para SUBI
                ALUSrc   <= '1';  -- Operando vem de um imediato
                MemRead  <= '0';   -- Explicitamente zerando
                MemWrite <= '0';   -- Explicitamente zerando
                MemToReg <= '0';   -- Explicitamente zerando
                Branch   <= '0';   -- Explicitamente zerando
            
            WHEN "0001" => -- LOAD (LW)
                RegWrite <= '1';
                MemRead  <= '1';
                MemToReg <= '1';
                ALUOp    <= "0101"; -- ADD (para calcular endereço)
                ALUSrc   <= '1';  -- Offset para cálculo do endereço
                MemWrite <= '0';   -- Explicitamente zerando
                Branch   <= '0';   -- Explicitamente zerando
            
            WHEN "1000" => -- STORE (SW)
                MemWrite <= '1';
                ALUOp    <= "0101"; -- ADD (para calcular endereço)
                ALUSrc   <= '1';  -- Offset para cálculo do endereço
                MemRead  <= '0';   -- Explicitamente zerando
                MemToReg <= '0';   -- Explicitamente zerando
                Branch   <= '0';   -- Explicitamente zerando
					 RegWrite <= '0';
            
            WHEN "0111" => -- BEQ (Branch if Equal)
                RegWrite <= '0';
					 Branch   <= '1';   -- Ativa salto condicional
                ALUOp    <= "0110"; -- A ALU faz SUB (R0 - R1)
                ALUSrc   <= '0';  -- A ALU opera com dois registradores
                MemRead  <= '0';   -- Explicitamente zerando
                MemWrite <= '0';   -- Explicitamente zerando
                MemToReg <= '0';   -- Explicitamente zerando
				
				WHEN "0100" => --JUMP (Salto Incondicional)
					RegWrite <= '0';
					Branch <= '1';
               ALUOp    <= "0100"; -- A ALU faz SUB (R0 - R1)
               ALUSrc   <= '0';  -- A ALU opera com dois registradores
               MemRead  <= '0';   -- Explicitamente zerando
               MemWrite <= '0';   -- Explicitamente zerando
               MemToReg <= '0';   -- Explicitamente zerando
								    
            WHEN OTHERS =>
                -- Instrução inválida, mantém sinais desativados
                RegWrite <= '0';
                MemWrite <= '0';
                MemRead  <= '0';
                MemToReg <= '0';
                Branch   <= '0';
                ALUSrc   <= '0';
                ALUOp    <= "0000";
        END CASE;
    END PROCESS;
END ARCHITECTURE behavior;
