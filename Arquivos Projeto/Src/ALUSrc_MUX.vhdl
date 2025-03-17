LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ALUSrc_MUX IS
    PORT (
        ALUSrc   : IN  STD_LOGIC;  -- Sinal de controle ALUSrc
        RegData  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Dado do banco de registradores
        ImmOffsetExtended: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Offset (para operações de Load/Store)
        ALUB     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)   -- Operando B da ALU
    );
END ENTITY ALUSrc_MUX;

ARCHITECTURE behavior OF ALUSrc_MUX IS
BEGIN
    PROCESS (ALUSrc, RegData, ImmOffsetExtended)
    BEGIN
        IF ALUSrc = '0' THEN
            ALUB <= RegData;  -- Vem da ALU
        ELSE
            ALUB <= ImmOffsetExtended;  -- Vem da memória
        END IF;
    END PROCESS;
END ARCHITECTURE behavior;
