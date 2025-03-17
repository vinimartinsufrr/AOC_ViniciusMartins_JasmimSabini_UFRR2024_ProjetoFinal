LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY alu_tb IS
END ENTITY alu_tb;

ARCHITECTURE behavior OF alu_tb IS

    -- Sinais de entrada e saída da ALU
    SIGNAL A        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL B        : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL ALUOp    : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL CIN      : STD_LOGIC := '0';
    SIGNAL S        : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL COUT     : STD_LOGIC;
    SIGNAL ZeroFlag : STD_LOGIC;

    -- Instância da ALU
    COMPONENT alu
        PORT (
            A        : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            B        : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            ALUOp    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            CIN      : IN STD_LOGIC;
            S        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            COUT     : OUT STD_LOGIC;
            ZeroFlag : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN

    -- Instanciando a ALU
    uut: alu
        PORT MAP (
            A        => A,
            B        => B,
            ALUOp    => ALUOp,
            CIN      => CIN,
            S        => S,
            COUT     => COUT,
            ZeroFlag => ZeroFlag
        );

    -- Processo de Teste da ALU
    PROCESS
    BEGIN
        -- Teste 1: ADD (5 + 3 = 8)
        A     <= "00000101"; -- 5
        B     <= "00000011"; -- 3
        ALUOp <= "0101";     -- ADD
        WAIT FOR 10 ns;
        ASSERT (S = "00001000") REPORT "Erro na operação ADD (5 + 3)!" SEVERITY ERROR;
        ASSERT (ZeroFlag = '0') REPORT "Erro: ZeroFlag ativada incorretamente na ADD!" SEVERITY ERROR;

        -- Teste 2: SUB (5 - 3 = 2)
        ALUOp <= "0110";     -- SUB
        WAIT FOR 10 ns;
        ASSERT (S = "00000010") REPORT "Erro na operação SUB (5 - 3)!" SEVERITY ERROR;
        ASSERT (ZeroFlag = '0') REPORT "Erro: ZeroFlag ativada incorretamente na SUB (5 - 3)!" SEVERITY ERROR;

        -- Teste 3: SUB que resulta em zero (5 - 5 = 0)
        A <= "00000101"; -- 5
        B <= "00000101"; -- 5
        ALUOp <= "0110"; -- SUB
        WAIT FOR 10 ns;
        ASSERT (S = "00000000") REPORT "Erro na operação SUB (5 - 5), esperado 0!" SEVERITY ERROR;
        ASSERT (ZeroFlag = '1') REPORT "Erro: ZeroFlag não foi ativada corretamente para resultado zero!" SEVERITY ERROR;

        -- Teste 4: SUB que não resulta em zero (10 - 5 = 5)
        A <= "00001010"; -- 10
        B <= "00000101"; -- 5
        ALUOp <= "0110"; -- SUB
        WAIT FOR 10 ns;
        ASSERT (S = "00000101") REPORT "Erro na operação SUB (10 - 5), esperado 5!" SEVERITY ERROR;
        ASSERT (ZeroFlag = '0') REPORT "Erro: ZeroFlag ativada incorretamente para resultado diferente de zero!" SEVERITY ERROR;

        -- Teste 5: Novo exemplo de ADD
        A <= "00000001";  -- 1
        B <= "00000001";  -- 1
        ALUOp <= "0101";  -- ADD
        WAIT FOR 10 ns;
        ASSERT (S = "00000010") REPORT "Erro na operação ADD (1 + 1), esperado 2!" SEVERITY ERROR;

        -- Fim da simulação
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
