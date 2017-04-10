-------------------------------------------------------------------------------
--! @file ctrm.vhd
--! @brief Counter, asynchronous *and* synchronous reset, up only.
--!        (ctrm.vhd, original filename)
--! @author         Javier Valcarce García
--! @copyright      Copyright 2007 Javier Valcarce García
--! @license        LGPL version 3
--! @email          javier.valcarce@gmail.com
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrm is
	generic (M : integer := 8);
	port (
		reset : in  std_logic;              -- asynchronous reset
		clk   : in  std_logic;
		ce    : in  std_logic;              -- enable counting
		rs    : in  std_logic;              -- synchronous reset
		do    : out integer range (M-1) downto 0 := 0
	);
end ctrm;

architecture behav of ctrm is
	signal c : integer range (M-1) downto 0:= 0;
begin
	do <= c;
	process(reset, clk)
	begin
		if reset = '1' then
			c <= 0;
		elsif rising_edge(clk) then
			if ce = '1' then
				if rs = '1' then
					c <= 0;
				else
					c <= c + 1;
				end if;
			end if;
		end if;
	end process;
end behav;

