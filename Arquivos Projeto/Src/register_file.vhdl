LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY register_file IS
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
END ENTITY register_file;

ARCHITECTURE behavior OF register_file IS
    TYPE reg_array IS ARRAY (0 TO 3) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL registers : reg_array := (
        "00000000",  -- R0
        "00000000",  -- R1
        "00000000",  -- R2
        "00000000"   -- R3
    );

BEGIN
    -- Processo de Escrita (sincronizado com o Clock)
    PROCESS(CLK)
    BEGIN
        IF rising_edge(CLK) THEN
            IF RegWrite = '1' THEN
                registers(to_integer(unsigned(WriteReg))) <= WriteDataReg;
            END IF;
        END IF;
    END PROCESS;

    -- Leitura assíncrona dos registradores
    PROCESS(ReadReg1, ReadReg2, registers)
    BEGIN
        IF (ReadReg1 /= "UU") AND (ReadReg2 /= "UU") THEN
            ReadData1 <= registers(to_integer(unsigned(ReadReg1)));
            ReadData2 <= registers(to_integer(unsigned(ReadReg2)));
        ELSE
            ReadData1 <= "00000000";
            ReadData2 <= "00000000";
        END IF;
    END PROCESS;

END ARCHITECTURE behavior;

