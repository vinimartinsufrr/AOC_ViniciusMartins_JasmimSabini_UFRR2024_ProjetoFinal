LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ram IS
    PORT (
        CLK      : IN STD_LOGIC;                     -- Clock
        MemRead  : IN STD_LOGIC;                     -- Sinal para leitura
        MemWrite : IN STD_LOGIC;                     -- Sinal para escrita
        AddrRAM     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Endereço
        WriteDataRAM: IN STD_LOGIC_VECTOR(7 DOWNTO 0);   -- Dados para escrita
        ReadData : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  -- Dados lidos
    );
END ENTITY ram;

ARCHITECTURE behavior OF ram IS
    TYPE ram_array IS ARRAY (0 TO 255) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ram_mem : ram_array := (others => "00000000");
BEGIN
    PROCESS(CLK)
    BEGIN
        IF falling_edge(CLK) THEN
            IF MemWrite = '1' THEN
                ram_mem(to_integer(unsigned(AddrRAM))) <= WriteDataRAM;  -- Escreve na memória
            END IF;
            
            IF MemRead = '1' THEN
                ReadData <= ram_mem(to_integer(unsigned(AddrRAM)));  -- Lê da memória
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE behavior;
