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
		  --Teste 1 (Addi em 2 registradores, mostrar valor armazenado e JUMP
		  --"00100010",
		  --"00100110",
		  --"01001110", --jump para 1110
		  
		  --Teste 2
		  --"00100010", -- addi r0 + 2
		  --"00100110", -- add r1 + 2
		  --"01010001", -- add r0 = r0 + r1 = 2 + 2 = 4
		  --"01010001", -- add r0 = r0 + r1 = 4 + 2 = 6
		  --"01100001", -- subi r0 = 6 -2 = 4
		  --"00110010", -- sub r0 = r0- r1 = 2
		  --Nesse ponto, tanto r0 quanto r1 sao 2
		  --"01111000", --beq (sempre compara r0 e r1)
		  --"00000000", -- instrução a ser ignorada
		  --"01000000", -- jump para o inicio 0000
		  
		  --Teste 3
		  --"00100010", -- addi de +2 para r0
		  --"10000000", -- store r0
		  --"00100001", -- addi +1 para r0
		  --"00010000", -- load r0
		  
  
        OTHERS => "00000000" -- Preenche o restante da ROM com NOPs
    );

BEGIN
    -- A saída da ROM é a instrução armazenada no endereço fornecido pelo PC
    PROCESS (Addr)
    BEGIN
        Data <= rom_mem(CONV_INTEGER(Addr)); -- Busca a instrução no endereço correto
    END PROCESS;

END ARCHITECTURE behavior;
