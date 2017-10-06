library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity cofre is
	port(
		I: in std_logic_vector(7 downto 0);
		reg_seg1: out std_logic_vector(7 downto 0);
		reg_conf1: out std_logic_vector(7 downto 0);
		conf_seg: in std_logic;
		reset: in std_logic;
		clock: in std_logic;
		modo: out std_logic;
		aberto_fechado: out std_logic
	);
end cofre;

architecture cofre of cofre is

	component mux_2to1_8bits is
		port(S : in  STD_LOGIC;
           S0   : in  STD_LOGIC_VECTOR (7 downto 0);
           S1   : in  STD_LOGIC_VECTOR (7 downto 0);
           D   : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component reg8 is
		port(	D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				Resetn, Clock: IN STD_LOGIC;
				Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component;
	
	component comp8 is
		port( A,B: in std_logic_vector(7 downto 0);
				maior, menor, igual: out std_logic);
	end component;
	
	signal out_mux1: std_logic_vector(7 downto 0); 
	signal out_mux2: std_logic_vector(7 downto 0);
	signal out_comp_maior: std_logic;
	signal out_comp_menor: std_logic;
	signal out_comp_igual: std_logic;
	signal out_reg_conf: std_logic_vector(7 downto 0);
	signal out_reg_seg: std_logic_vector(7 downto 0);
	
	begin
	reg_seg: reg8 port map (I,(reset and conf_seg),(clock and conf_seg),out_reg_seg);	
	reg_seg1 <= out_reg_seg;
	reg_conf: reg8 port map (I,(reset and not(conf_seg)),(clock and not(conf_seg)),out_reg_conf);	
	reg_conf1 <= out_reg_conf;
	mux1: mux_2to1_8bits port map (conf_seg,out_reg_conf,out_reg_seg, out_mux1);
	mux2: mux_2to1_8bits port map ((conf_seg and '1'),out_mux1,out_reg_seg, out_mux2);
	comp: comp8 port map(out_mux2,out_reg_conf,out_comp_maior, out_comp_menor, out_comp_igual);
	aberto_fechado <= not(out_comp_igual);
	modo <= not(conf_seg);
end cofre;