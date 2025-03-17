LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MemToReg_MUX IS
    PORT (
        MemToReg : IN  STD_LOGIC;  -- Sinal de controle MemToReg
        ALUData  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Dado da ALU
        MemData  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Dado da memória
        MUXData: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)   -- Dado a ser escrito no registrador
    );
END ENTITY MemToReg_MUX;

ARCHITECTURE behavior OF MemToReg_MUX IS
BEGIN
    PROCESS (MemToReg, ALUData, MemData)
    BEGIN
        IF MemToReg = '0' THEN
            MUXData <= ALUData;  -- Vem da ALU
        ELSE
            MUXData <= MemData;  -- Vem da memória
        END IF;
    END PROCESS;
END ARCHITECTURE behavior;

