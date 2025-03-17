LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ram_tb IS
END ENTITY ram_tb;

ARCHITECTURE behavior OF ram_tb IS

    -- Declaração dos sinais de teste
    SIGNAL CLK      : STD_LOGIC := '0';
    SIGNAL MemRead  : STD_LOGIC := '0';
    SIGNAL MemWrite : STD_LOGIC := '0';
    SIGNAL AddrRAM  : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    SIGNAL WriteDataRAM: STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    SIGNAL ReadData : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- Instância da RAM
    COMPONENT ram
        PORT (
            CLK       : IN STD_LOGIC;
            MemRead   : IN STD_LOGIC;
            MemWrite  : IN STD_LOGIC;
            AddrRAM   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            WriteDataRAM : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            ReadData  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    -- Instanciando a RAM
    UUT: ram
        PORT MAP (
            CLK       => CLK,
            MemRead   => MemRead,
            MemWrite  => MemWrite,
            AddrRAM   => AddrRAM,
            WriteDataRAM => WriteDataRAM,
            ReadData  => ReadData
        );

    -- Geração de Clock (período de 10ns)
    PROCESS
    BEGIN
        WHILE TRUE LOOP
            CLK <= '0';
            WAIT FOR 5 ns;
            CLK <= '1';
            WAIT FOR 5 ns;
        END LOOP;
    END PROCESS;

    -- Processo de Teste da RAM
    PROCESS
    BEGIN

        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
