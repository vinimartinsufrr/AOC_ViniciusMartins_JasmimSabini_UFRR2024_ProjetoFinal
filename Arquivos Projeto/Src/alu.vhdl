LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY alu IS
    PORT (
        A        : IN STD_LOGIC_VECTOR(7 DOWNTO 0);   -- Operando A (registrador ou valor da memória)
        B        : IN STD_LOGIC_VECTOR(7 DOWNTO 0);   -- Operando B (registrador ou valor imediato)
        ALUOp    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);   -- ALUOp de 4 bits para selecionar a operação (add, sub, etc.)
        CIN      : IN STD_LOGIC;                      -- Carry in (usado para addi e subi)
        S        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Resultado da operação
        COUT     : OUT STD_LOGIC;                     -- Carry out ou borrow
        ZeroFlag : OUT STD_LOGIC                      -- Ativado se resultado == 0 (para BEQ)
    );
END ENTITY alu;

ARCHITECTURE BEHAVIOR OF alu IS

    -- Instância do somador de 8 bits
    COMPONENT somador_8bits IS
        PORT (
            A      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            B      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            CIN    : IN STD_LOGIC;
            COUT   : OUT STD_LOGIC;
            S      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Instância do subtrator de 8 bits
    COMPONENT subtrator_8bits IS
        PORT (
            A      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            B      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            COUT   : OUT STD_LOGIC;
            S      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL sum_result  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL sum_carry   : STD_LOGIC;
    SIGNAL sub_result  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL sub_borrow  : STD_LOGIC;

BEGIN

    -- Instanciando o somador
    sum_inst : somador_8bits
        PORT MAP (
            A    => A,
            B    => B,
            CIN  => CIN,
            COUT => sum_carry,
            S    => sum_result
        );

    -- Instanciando o subtrator
    sub_inst : subtrator_8bits
        PORT MAP (
            A    => A,
            B    => B,
            COUT => sub_borrow,
            S    => sub_result
        );

    -- Lógica para selecionar a operação com base no ALUOp (4 bits)
    PROCESS (ALUOp, sum_result, sub_result)
    BEGIN
        CASE ALUOp IS
            WHEN "0101" => -- ADD
                S <= sum_result;
                COUT <= sum_carry;
                ZeroFlag <= '0';  -- Soma nunca afeta BEQ
            
            WHEN "0110" => -- SUB (usado para BEQ)
                S <= sub_result;
                COUT <= sub_borrow;
                -- Ativa ZeroFlag se o resultado for 00000000
                IF sub_result = "00000000" THEN
                    ZeroFlag <= '1';
                ELSE
                    ZeroFlag <= '0';
                END IF;

            WHEN "0010" => -- ADDI
                S <= sum_result;
                COUT <= sum_carry;
                ZeroFlag <= '0';  -- Soma nunca afeta BEQ
            
            WHEN "0011" => -- SUBI
                S <= sub_result;
                COUT <= sub_borrow;
                ZeroFlag <= '0';  -- SUBI não afeta BEQ
				
				WHEN "0100" => -- Salto Incondicional
					ZeroFlag <= '1'; -- Flag zero é acionada diretamente, para o salto ocorrer.
            
            WHEN OTHERS => 
                S <= (others => '0');
                COUT <= '0';
                ZeroFlag <= '0';
        END CASE;
    END PROCESS;

END ARCHITECTURE BEHAVIOR;