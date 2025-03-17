LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CPU_JV IS
    PORT (
        CLK        : IN STD_LOGIC;
        Reset      : IN STD_LOGIC;
        
        -- Sinais de Saída
        PCOut      : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0); -- Endereço da instrução
        Instr      : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0); -- Instrução de 8 bits
        
        -- Sinais de Controle
        RegDst     : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0); 
        RegSrc     : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0); 
        ImmOffset  : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0); 
        BranchAddr : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0);
        ALUOp      : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0); 
        RegWrite   : BUFFER STD_LOGIC;
        ALUSrc     : BUFFER STD_LOGIC;
        MemWrite   : BUFFER STD_LOGIC;
        MemRead    : BUFFER STD_LOGIC;
        MemToReg   : BUFFER STD_LOGIC;
        Branch     : BUFFER STD_LOGIC;
        -- Dados de leitura e escrita
        ReadData1  : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0); 
        ReadData2  : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0); 
        ALUResult  : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0); 
        ZeroFlag   : BUFFER STD_LOGIC; 
        COUT       : BUFFER STD_LOGIC;
		  WriteDataReg  : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
		  MUXData    : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
		  WriteDataRAM: BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
        AddrRAM    : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
        ReadData   : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
        ALUData : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
        -- Declaração da porta Opcode
        Opcode     : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0)  
    );
END ENTITY CPU_JV;

ARCHITECTURE structure OF CPU_JV IS

    -- Componentes internos
    COMPONENT program_counter
        PORT (
            CLK        : IN STD_LOGIC;
            Reset      : IN STD_LOGIC;
            Branch     : IN STD_LOGIC;  
            ZeroFlag   : IN STD_LOGIC;
            BranchAddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            PCOut      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT rom
        PORT (
            Addr  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Data  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT instruction_decoder
        PORT (
            Instr     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            Opcode    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            RegDst    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            RegSrc    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            ImmOffset : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            BranchAddr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT control_unit
        PORT (
            Opcode   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            RegWrite : OUT STD_LOGIC;
            MemWrite : OUT STD_LOGIC;
            MemRead  : OUT STD_LOGIC;
            MemToReg : OUT STD_LOGIC;
            Branch   : OUT STD_LOGIC;  
            ALUSrc   : OUT STD_LOGIC;
            ALUOp    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

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

    COMPONENT alu
        PORT (
            A        : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            B        : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            ALUOp    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            CIN      : IN STD_LOGIC;
            S        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            COUT     : OUT STD_LOGIC;
            ZeroFlag : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT ALUSrc_MUX
        PORT (
            ALUSrc   : IN  STD_LOGIC;
            RegData  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            ImmOffsetExtended: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            ALUB     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT MemToReg_MUX
        PORT (
            MemToReg : IN  STD_LOGIC;
            ALUData  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            MemData  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            MUXData  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ram
        PORT (
            CLK      : IN STD_LOGIC;
            MemRead  : IN STD_LOGIC;
            MemWrite : IN STD_LOGIC;
            AddrRAM  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            WriteDataRAM: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            ReadData : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT extensor2x8
        PORT (
            A : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Sinal interno
    SIGNAL ImmOffsetExtended : STD_LOGIC_VECTOR(7 DOWNTO 0); 

BEGIN

    -- Instanciando todos os componentes necessários
    pc_inst: program_counter
        PORT MAP (
            CLK        => CLK,
            Reset      => Reset,
            Branch     => Branch,  
            ZeroFlag   => ZeroFlag,
            BranchAddr => BranchAddr,
            PCOut      => PCOut
        );
    
    rom_inst: rom
        PORT MAP (
            Addr => PCOut,
            Data => Instr
        );
    
    instruction_decoder_inst: instruction_decoder
        PORT MAP (
            Instr      => Instr,
            Opcode     => Opcode,
            RegDst     => RegDst,
            RegSrc     => RegSrc,
            ImmOffset  => ImmOffset,
            BranchAddr => BranchAddr
        );
    
    control_unit_inst: control_unit
        PORT MAP (
            Opcode   => Opcode,  
            RegWrite => RegWrite,
            MemWrite => MemWrite,
            MemRead  => MemRead,
            MemToReg => MemToReg,
            Branch   => Branch,  
            ALUSrc   => ALUSrc,
            ALUOp    => ALUOp
        );
    
    register_file_inst: register_file
        PORT MAP (
            CLK       => CLK,
            RegWrite  => RegWrite,
            ReadReg1  => RegDst,
            ReadReg2  => RegSrc,
            WriteReg  => RegDst,
            WriteDataReg => MUXData,
            ReadData1 => ReadData1,
            ReadData2 => ReadData2
        );

    -- Instanciando o extensor2x8 para estender o immoffset
    extensor2x8_inst: extensor2x8
        PORT MAP (
            A => ImmOffset,
            S => ImmOffsetExtended
        );

    ALU_src_mux_inst: ALUSrc_MUX
        PORT MAP (
            ALUSrc   => ALUSrc,
            RegData  => ReadData2,
            ImmOffsetExtended => ImmOffsetExtended,
            ALUB     => ALUData
        );

    alu_inst: alu
        PORT MAP (
            A        => ReadData1,
            B        => ALUData,
            ALUOp    => ALUOp,
            CIN      => '0',
            S        => ALUResult,  
            COUT     => COUT,
            ZeroFlag => ZeroFlag
        );

    MemToReg_MUX_inst: MemToReg_MUX
        PORT MAP (
            MemToReg => MemToReg,
            ALUData  => ALUResult, 
            MemData  => ReadData,
            MUXData => MUXData
        );

    ram_inst: ram
        PORT MAP (
            CLK      => CLK,
            MemRead  => MemRead,
            MemWrite => MemWrite,
            AddrRAM  => ALUResult,  
            WriteDataRAM=> ReadData1,
            ReadData => ReadData
        );

END ARCHITECTURE structure;
