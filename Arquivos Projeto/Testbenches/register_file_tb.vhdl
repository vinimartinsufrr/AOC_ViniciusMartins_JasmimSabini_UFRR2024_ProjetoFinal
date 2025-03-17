LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY register_file_tb IS
END ENTITY register_file_tb;

ARCHITECTURE behavior OF register_file_tb IS

    -- Sinais para conectar ao Banco de Registradores
    SIGNAL CLK       : STD_LOGIC := '0';
    SIGNAL RegWrite  : STD_LOGIC;
    SIGNAL ReadReg1  : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL ReadReg2  : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL WriteReg  : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL WriteDataReg : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ReadData1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ReadData2 : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- Instância do Banco de Registradores
    COMPONENT register_file
        PORT (
            CLK       : IN STD_LOGIC;
            RegWrite  : IN STD_LOGIC;
            ReadReg1  : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            ReadReg2  : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            WriteReg  : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            WriteDataReg : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            ReadData1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            ReadData2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    -- Instanciando o Banco de Registradores
    uut: register_file
        PORT MAP (
            CLK       => CLK,
            RegWrite  => RegWrite,
            ReadReg1  => ReadReg1,
            ReadReg2  => ReadReg2,
            WriteReg  => WriteReg,
            WriteDataReg => WriteDataReg,
            ReadData1 => ReadData1,
            ReadData2 => ReadData2
        );

    -- Processo de geração do clock (período de 10ns)
    PROCESS
    BEGIN
        WHILE NOW < 200 ns LOOP
            CLK <= '0';
            WAIT FOR 5 ns;
            CLK <= '1';
            WAIT FOR 5 ns;
        END LOOP;
        WAIT;
    END PROCESS;

    -- Processo de Teste
    PROCESS
    BEGIN
        -- Teste 1: Escrevendo no Registrador 0 (R0 = 1)
        RegWrite  <= '1';
        WriteReg  <= "00";  -- R0
        WriteDataReg <= "00000001";  -- Valor 1
        WAIT FOR 10 ns;  

        -- Teste 2: Escrevendo no Registrador 1 (R1 = 2)
        WriteReg  <= "01";  -- R1
        WriteDataReg <= "00000010";  -- Valor 2
        WAIT FOR 10 ns;  

        -- Desativar escrita
        RegWrite  <= '0';

        -- Teste 3: Lendo de R0 e R1
        ReadReg1 <= "00";  -- R0
        ReadReg2 <= "01";  -- R1
        WAIT FOR 10 ns;
        ASSERT (ReadData1 = "00000001") REPORT "Erro na leitura de R0" SEVERITY ERROR;
        ASSERT (ReadData2 = "00000010") REPORT "Erro na leitura de R1" SEVERITY ERROR;

        -- Teste 4: Escrevendo no Registrador 2 (R2 = 4)
        RegWrite  <= '1';  
        WriteReg  <= "10";  -- R2
        WriteDataReg <= "00000100";  -- Valor 4
        WAIT FOR 10 ns;

        -- Teste 5: Escrevendo no Registrador 3 (R3 = 8)
        WriteReg  <= "11";  -- R3
        WriteDataReg <= "00001000";  -- Valor 8
        WAIT FOR 10 ns;
        RegWrite  <= '0';

        -- Teste 6: Lendo de R2 e R3 por 10ns
        ReadReg1 <= "10";  -- R2
        ReadReg2 <= "11";  -- R3
        WAIT FOR 10 ns;
        ASSERT (ReadData1 = "00000100") REPORT "Erro na leitura de R2" SEVERITY ERROR;
        ASSERT (ReadData2 = "00001000") REPORT "Erro na leitura de R3" SEVERITY ERROR;

        -- Teste 7: Voltando a ler R0 e R1 para garantir que ainda mantêm os valores
        ReadReg1 <= "00";  -- R0
        ReadReg2 <= "01";  -- R1
        WAIT FOR 10 ns;
        ASSERT (ReadData1 = "00000001") REPORT "Erro: R0 perdeu o valor 1" SEVERITY ERROR;
        ASSERT (ReadData2 = "00000010") REPORT "Erro: R1 perdeu o valor 2" SEVERITY ERROR;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;

