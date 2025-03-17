LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY instruction_decoder_tb IS
END ENTITY instruction_decoder_tb;

ARCHITECTURE behavior OF instruction_decoder_tb IS

    -- Sinais de entrada e saída do Instruction Decoder
    SIGNAL Instr      : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL Opcode     : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL RegDst     : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL RegSrc     : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL ImmOffset  : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL BranchAddr : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Instância do Instruction Decoder
    COMPONENT instruction_decoder
        PORT (
            Instr      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            Opcode     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            RegDst     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            RegSrc     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            ImmOffset  : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            BranchAddr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    -- Instanciando o Instruction Decoder
    uut: instruction_decoder
        PORT MAP (
            Instr      => Instr,
            Opcode     => Opcode,
            RegDst     => RegDst,
            RegSrc     => RegSrc,
            ImmOffset  => ImmOffset,
            BranchAddr => BranchAddr
        );

    -- Processo de Teste do Instruction Decoder
    PROCESS
    BEGIN
        -- Teste 1: ADD R1, R2 (Opcode 0101, R1 = 01, R2 = 10)
        Instr <= "01010110"; -- ADD R1, R2
        WAIT FOR 10 ns;
        ASSERT (Opcode = "0101") REPORT "Erro: Opcode errado para ADD!" SEVERITY ERROR;
        ASSERT (RegDst = "01") REPORT "Erro: RegDst errado para ADD!" SEVERITY ERROR;
        ASSERT (RegSrc = "10") REPORT "Erro: RegSrc errado para ADD!" SEVERITY ERROR;
        ASSERT (ImmOffset = "10") REPORT "Erro: ImmOffset errado para ADD!" SEVERITY ERROR;

        -- Teste 2: SUB R3, R0 (Opcode 0110, R3 = 11, R0 = 00)
        Instr <= "01101100"; -- SUB R3, R0
        WAIT FOR 10 ns;
        ASSERT (Opcode = "0110") REPORT "Erro: Opcode errado para SUB!" SEVERITY ERROR;
        ASSERT (RegDst = "11") REPORT "Erro: RegDst errado para SUB!" SEVERITY ERROR;
        ASSERT (RegSrc = "00") REPORT "Erro: RegSrc errado para SUB!" SEVERITY ERROR;
        ASSERT (ImmOffset = "00") REPORT "Erro: ImmOffset errado para SUB!" SEVERITY ERROR;

        -- Teste 3: ADDI R2, 3 (Opcode 0010, R2 = 10, Imediato = 11)
        Instr <= "00101011"; -- ADDI R2, 3
        WAIT FOR 10 ns;
        ASSERT (Opcode = "0010") REPORT "Erro: Opcode errado para ADDI!" SEVERITY ERROR;
        ASSERT (RegDst = "10") REPORT "Erro: RegDst errado para ADDI!" SEVERITY ERROR;
        ASSERT (ImmOffset = "11") REPORT "Erro: ImmOffset errado para ADDI!" SEVERITY ERROR;

        -- Teste 4: LW R1, 2(R0) (Opcode 0001, R1 = 01, Offset = 10)
        Instr <= "00010110"; -- LW R1, 2(R0)
        WAIT FOR 10 ns;
        ASSERT (Opcode = "0001") REPORT "Erro: Opcode errado para LW!" SEVERITY ERROR;
        ASSERT (RegDst = "01") REPORT "Erro: RegDst errado para LW!" SEVERITY ERROR;
        ASSERT (ImmOffset = "10") REPORT "Erro: ImmOffset errado para LW!" SEVERITY ERROR;

        -- Teste 5: SW R2, 1(R0) (Opcode 0000, R2 = 10, Offset = 01)
        Instr <= "00001001"; -- SW R2, 1(R0)
        WAIT FOR 10 ns;
        ASSERT (Opcode = "0000") REPORT "Erro: Opcode errado para SW!" SEVERITY ERROR;
        ASSERT (RegDst = "10") REPORT "Erro: RegDst errado para SW!" SEVERITY ERROR;
        ASSERT (ImmOffset = "01") REPORT "Erro: ImmOffset errado para SW!" SEVERITY ERROR;

        -- Teste 6: BEQ Endereço 7 (Opcode 0111, Endereço = 0111)
        Instr <= "01110111"; -- BEQ para endereço 7
        WAIT FOR 10 ns;
        ASSERT (Opcode = "0111") REPORT "Erro: Opcode errado para BEQ!" SEVERITY ERROR;
        ASSERT (BranchAddr = "0111") REPORT "Erro: BranchAddr errado para BEQ!" SEVERITY ERROR;

        -- Fim da simulação
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
