-- This module will use mux_64x1_64bit to combine input changes with clusters that are saved in the mux
-- and will add all the data
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity
entity cluster_finder is

 generic (
        WIDTH : integer := 16  -- Parameter with a default value
    );

    port(
        data_in   : in std_logic_vector(195 downto 0);
        data_out  : out std_logic_vector(WIDTH-1 downto 0);
        en_reg    : in std_logic_vector(48 downto 0)
       
    );
end cluster_finder;

-- Architecture
architecture cluster_finder_arch of cluster_finder is

    -- Component Declaration
    component mux_16x1_1 is
        port (
            sel        : in std_logic_vector(3 downto 0); -- 4-bit select line
            enable     : in std_logic;                    -- Enable signal
            output     : out std_logic_vector(WIDTH-1 downto 0)          -- 64-bit output
        );
    end component;

    -- Type Declaration for Array of Mux Outputs
    type mux_array_t is array (0 to 48) of std_logic_vector(WIDTH-1 downto 0); -- Adjust array size as per your mux count
    signal mux_outputs : mux_array_t;
    signal sum_result   : signed(WIDTH-1 downto 0);

begin

    -- Generate block for repeated mux instantiation
    gen_mux: for i in 0 to 48 generate -- Adjust range based on the number of muxes
        mux_inst: mux_16x1_1
            port map(
                sel        => data_in((i * 4 + 3) downto (i * 4)), -- 4-bit chunks for selection
                enable     => en_reg(i),
                output     => mux_outputs(i)
            );
    end generate;

    -- Structural Summation Logic

    sum_result <= signed(mux_outputs(0))  + signed(mux_outputs(1))  + signed(mux_outputs(2))  +
                  signed(mux_outputs(3))  + signed(mux_outputs(4))  + signed(mux_outputs(5))  +
                  signed(mux_outputs(6))  + signed(mux_outputs(7))  + signed(mux_outputs(8))  +
                  signed(mux_outputs(9))  + signed(mux_outputs(10)) + signed(mux_outputs(11)) +
                  signed(mux_outputs(12)) + signed(mux_outputs(13)) + signed(mux_outputs(14)) +
                  signed(mux_outputs(15)) + signed(mux_outputs(16)) + signed(mux_outputs(17)) +
                  signed(mux_outputs(18)) + signed(mux_outputs(19)) + signed(mux_outputs(20)) +
                  signed(mux_outputs(21)) + signed(mux_outputs(22)) + signed(mux_outputs(23)) +
                  signed(mux_outputs(24)) + signed(mux_outputs(25)) + signed(mux_outputs(26)) +
                  signed(mux_outputs(27)) + signed(mux_outputs(28)) + signed(mux_outputs(29)) +
                  signed(mux_outputs(30)) + signed(mux_outputs(31)) + signed(mux_outputs(32)) +
                  signed(mux_outputs(33)) + signed(mux_outputs(34)) + signed(mux_outputs(35)) +
                  signed(mux_outputs(36)) + signed(mux_outputs(37)) + signed(mux_outputs(38)) +
                  signed(mux_outputs(39)) + signed(mux_outputs(40)) + signed(mux_outputs(41)) +
                  signed(mux_outputs(42)) + signed(mux_outputs(43)) + signed(mux_outputs(44)) +
                  signed(mux_outputs(45)) + signed(mux_outputs(46)) + signed(mux_outputs(47)) +
                  signed(mux_outputs(48));
  

    -- Assign the result to the output
    data_out <= std_logic_vector(sum_result);

end cluster_finder_arch;

