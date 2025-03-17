LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CPU_JV_tb IS
END ENTITY CPU_JV_tb;

ARCHITECTURE behavior OF CPU_JV_tb IS

    COMPONENT CPU_JV
        PORT (
            CLK        : IN STD_LOGIC;
            Reset      : IN STD_LOGIC;
            
            -- Sinais de Saída
            PCOut      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Endereço da instrução
            Instr      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Instrução de 8 bits
            
            -- Sinais de Controle
            RegDst     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); 
            RegSrc     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); 
            ImmOffset  : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); 
            BranchAddr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            ALUOp      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 
            RegWrite   : OUT STD_LOGIC;
            ALUSrc     : OUT STD_LOGIC;
            MemWrite   : OUT STD_LOGIC;
            MemRead    : OUT STD_LOGIC;
            MemToReg   : OUT STD_LOGIC;
            Branch     : OUT STD_LOGIC; 

            -- Dados de leitura e escrita
            ReadData1  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); 
            ReadData2  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); 
            ALUResult  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  
            ZeroFlag   : OUT STD_LOGIC; 
            COUT       : OUT STD_LOGIC;
				WriteDataReg  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
				MUXData    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
				WriteDataRAM: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            AddrRAM    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            ReadData   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            
            -- Declaração da porta Opcode
            Opcode     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);  
				ALUData  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Declaração de sinais internos para o testbench
    SIGNAL CLK        : STD_LOGIC := '0';
    SIGNAL Reset      : STD_LOGIC := '0';
    SIGNAL Instr      : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    SIGNAL PCOut      : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL RegDst     : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL RegSrc     : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL ImmOffset  : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL BranchAddr : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL ALUOp      : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL RegWrite   : STD_LOGIC;
    SIGNAL ALUSrc     : STD_LOGIC;
    SIGNAL MemWrite   : STD_LOGIC;
    SIGNAL MemRead    : STD_LOGIC;
    SIGNAL MemToReg   : STD_LOGIC;
    SIGNAL Branch     : STD_LOGIC;
    SIGNAL ReadData1  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ReadData2  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ALUResult  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ZeroFlag   : STD_LOGIC;
    SIGNAL COUT       : STD_LOGIC;
	 SIGNAL WriteDataReg  : STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL MUXData    : STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL WriteDataRAM: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL AddrRAM    : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ReadData   : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Opcode     : STD_LOGIC_VECTOR(3 DOWNTO 0);
	 SIGNAL ALUData : STD_LOGIC_VECTOR(7 DOWNTO 0);
    

BEGIN

    -- Instanciando o Datapath
    UUT: CPU_JV
        PORT MAP (
            CLK         => CLK,
            Reset       => Reset,
            PCOut       => PCOut,
            Instr       => Instr,
            RegDst      => RegDst,
            RegSrc      => RegSrc,
            ImmOffset   => ImmOffset,
            BranchAddr  => BranchAddr,
            ALUOp       => ALUOp,
            RegWrite    => RegWrite,
            ALUSrc      => ALUSrc,
            MemWrite    => MemWrite,
            MemRead     => MemRead,
            MemToReg    => MemToReg,
            Branch      => Branch,
            ReadData1   => ReadData1,
            ReadData2   => ReadData2,
            ALUResult   => ALUResult,
            ZeroFlag    => ZeroFlag,
            COUT        => COUT,
				WriteDataReg   => WriteDataReg,
				MUXData     => MUXData,
				WriteDataRAM => WriteDataRAM,
            AddrRAM     => AddrRAM,
            ReadData    => ReadData,
            Opcode      => Opcode,
				ALUData => ALUData
        );

    -- Geração do Clock (período de 10ns)
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

    -- Processo de Teste do Datapath
    PROCESS
    BEGIN
        Reset <= '1';
        WAIT FOR 10 ns;
        Reset <= '0';

        WAIT FOR 100 ns;
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
