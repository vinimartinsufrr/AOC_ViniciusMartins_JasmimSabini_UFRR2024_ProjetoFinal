LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY program_counter IS
    PORT (
        CLK        : IN  STD_LOGIC;                    -- Clock do processador
        Reset      : IN  STD_LOGIC;                    -- Reset para reiniciar o PC
        Branch     : IN  STD_LOGIC;                    -- BEQ (Sinal de salto)
        ZeroFlag   : IN  STD_LOGIC;                    -- Indica se o resultado da ALU é 0
        BranchAddr : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- Endereço absoluto para BEQ
        PCOut      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)  -- Endereço atual da instrução
    );
END ENTITY program_counter;

ARCHITECTURE behavior OF program_counter IS
    SIGNAL PCReg : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"; -- Inicializa o PC

BEGIN
    PROCESS (CLK, Reset)
    BEGIN
        IF Reset = '1' THEN
            PCReg <= "0000"; -- Reinicia o PC para 0
        ELSIF falling_edge(CLK) THEN
            IF (Branch = '1' AND ZeroFlag = '1') THEN
                PCReg <= BranchAddr;  -- Salto apenas se ZeroFlag estiver ativo
            ELSE
                PCReg <= PCReg + "0001"; -- Incrementa normalmente
            END IF;
        END IF;
    END PROCESS;

    PCOut <= PCReg; -- Saída do PC

END ARCHITECTURE behavior;
