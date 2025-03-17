LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY pc_tb IS
END ENTITY pc_tb;

ARCHITECTURE behavior OF pc_tb IS

    -- Sinais de entrada e saída do PC
    SIGNAL CLK        : STD_LOGIC := '0';
    SIGNAL Reset      : STD_LOGIC := '0';
    SIGNAL Branch     : STD_LOGIC := '0';
    SIGNAL ZeroFlag   : STD_LOGIC := '0';
    SIGNAL BranchAddr : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL PCOut      : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Instância do Program Counter (PC)
    COMPONENT program_counter
        PORT (
            CLK        : IN  STD_LOGIC;
            Reset      : IN  STD_LOGIC;
            Branch     : IN  STD_LOGIC;
            ZeroFlag   : IN  STD_LOGIC;
            BranchAddr : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            PCOut      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    -- Instanciando o Program Counter
    uut: program_counter
        PORT MAP (
            CLK        => CLK,
            Reset      => Reset,
            Branch     => Branch,
            ZeroFlag   => ZeroFlag,
            BranchAddr => BranchAddr,
            PCOut      => PCOut
        );

    -- Processo para gerar o Clock (período de 10ns)
    PROCESS
    BEGIN
        WHILE NOW < 300 ns LOOP
            CLK <= '0';
            WAIT FOR 5 ns;
            CLK <= '1';
            WAIT FOR 5 ns;
        END LOOP;
        WAIT;
    END PROCESS;

    -- Processo de Teste do PC
    PROCESS
    BEGIN
        -- Teste 1: Reset do PC
        Reset <= '1';
        WAIT FOR 10 ns;
        Reset <= '0';
        WAIT FOR 10 ns;
        ASSERT (PCOut = "0001") REPORT "Erro: Reset falhou! PC deveria estar em 0001 após o primeiro ciclo." SEVERITY ERROR;

        -- Teste 2: Incremento normal do PC
        WAIT FOR 10 ns;
        ASSERT (PCOut = "0010") REPORT "Erro: PC não incrementou corretamente para 0010!" SEVERITY ERROR;
        WAIT FOR 10 ns;
        ASSERT (PCOut = "0011") REPORT "Erro: PC não incrementou corretamente para 0011!" SEVERITY ERROR;

        -- Teste 3: Tentativa de salto quando ZeroFlag = 0 (deve ignorar o Branch)
        Branch     <= '1';
        ZeroFlag   <= '0';
        BranchAddr <= "0001"; -- Endereço de destino (não deve ser pulado)
        WAIT FOR 10 ns;
        ASSERT (PCOut = "0100") REPORT "Erro: PC pulou sem ZeroFlag ativado! Deveria ter continuado incrementando." SEVERITY ERROR;

        -- Teste 4: BEQ correto (ZeroFlag = 1 e Branch = 1)
        Branch     <= '1';
        ZeroFlag   <= '1';
        BranchAddr <= "0110"; -- Deve pular para esse endereço
        WAIT FOR 10 ns;
        ASSERT (PCOut = "0110") REPORT "Erro: BEQ não executou o salto corretamente!" SEVERITY ERROR;

        -- Teste 5: Continuação após o BEQ
        Branch     <= '0'; -- Voltar ao comportamento normal
        ZeroFlag   <= '0';
        WAIT FOR 10 ns;
        ASSERT (PCOut = "0111") REPORT "Erro: PC não continuou corretamente após BEQ!" SEVERITY ERROR;
		  
        -- Teste 6: Resetando o PC novamente
        Reset <= '1';
        WAIT FOR 10 ns;
        Reset <= '0';
        WAIT FOR 10 ns;
        ASSERT (PCOut = "0001") REPORT "Erro: Reset falhou após segundo reset! PC deveria estar em 0001." SEVERITY ERROR;

        -- Fim da simulação
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
