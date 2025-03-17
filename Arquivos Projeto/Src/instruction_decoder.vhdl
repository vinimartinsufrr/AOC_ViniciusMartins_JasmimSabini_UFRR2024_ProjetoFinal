LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY instruction_decoder IS
    PORT (
        Instr     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Instrução de 8 bits da ROM
        Opcode    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Código da operação
        RegDst    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Registrador de destino
        RegSrc    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Registrador de origem
        ImmOffset : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Valor imediato ou Offset
        BranchAddr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Endereço de salto (para BEQ)
    );
END ENTITY instruction_decoder;

ARCHITECTURE behavior OF instruction_decoder IS
BEGIN
    PROCESS(Instr)
    BEGIN
        -- O Opcode é sempre os 4 primeiros bits
        Opcode <= Instr(7 DOWNTO 4);

        -- Se for BEQ, o segundo campo representa um endereço absoluto de 4 bits
        IF Instr(7 DOWNTO 4) = "0111" THEN
            BranchAddr <= Instr(3 DOWNTO 0);
            RegDst     <= "00"; -- Sempre faremos a subtração R0 = R0 - R1
            RegSrc     <= "01";
            ImmOffset  <= "00";

        -- Se for Jump, o segundo campo representa um endereço absoluto de 4 bits
        ELSIF Instr(7 DOWNTO 4) = "0100" THEN
            BranchAddr <= Instr(3 DOWNTO 0);
            RegDst     <= "00"; -- Registradores não importam, nenhuma operação é feita na alu, ela só ativa a zero flag
            RegSrc     <= "00";
            ImmOffset  <= "00";				
        ELSE
            -- Nos outros casos, seguimos a estrutura normal 4/2/2
            RegDst    <= Instr(3 DOWNTO 2);
            RegSrc    <= Instr(1 DOWNTO 0);
            ImmOffset <= Instr(1 DOWNTO 0); -- Apenas relevante para ADDI, SUBI, LW e SW
            BranchAddr <= "0000"; -- Não é relevante exceto para BEQ
        END IF;
    END PROCESS;

END ARCHITECTURE behavior;
