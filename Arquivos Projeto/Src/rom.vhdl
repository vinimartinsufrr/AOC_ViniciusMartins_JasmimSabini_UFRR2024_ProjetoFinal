LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY rom IS
    PORT (
        Addr  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- Endereço da instrução (PC fornecerá)
        Data  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  -- Instrução armazenada na ROM
    );
END ENTITY rom;

ARCHITECTURE behavior OF rom IS
    -- Memória ROM com 16 posições, cada uma armazenando 8 bits (instrução)
    TYPE rom_array IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL rom_mem : rom_array := (
        -- Programa de Teste na ROM:
		  --"01111000", -- beq
        -- OPCODE (4 bits) | REGDST (2 bits) | REGSRC / IMEDIATO (2 bits)
        --"00100011", --addi de +3 para r0
		  --"00110001", --subi de -1
		  
		  "00100010", --addi de +2 para r0
		  "00100110", --addi de +2 para r1
		  --"01111000", -- beq para 1000
		  "01001110", -- jump para 1110
		  --"01010001", --add de r0 (4) + r1 (2) = 6
		  --"01100001", --sub r0 = r0 (6) - r1 (2) = 4

  
        OTHERS => "00000000" -- Preenche o restante da ROM com NOPs
    );

BEGIN
    -- A saída da ROM é a instrução armazenada no endereço fornecido pelo PC
    PROCESS (Addr)
    BEGIN
        Data <= rom_mem(CONV_INTEGER(Addr)); -- Busca a instrução no endereço correto
    END PROCESS;

END ARCHITECTURE behavior;
