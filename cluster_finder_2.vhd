-- This module will use mux_64x1_64bit to combine input changes with clusters that are saved in the mux
-- and will add all the data
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity
entity cluster_finder_2 is
 generic (
        WIDTH : integer := 16  -- Parameter with a default value
    );

    port(
        data_in   : in std_logic_vector(399 downto 0);
        data_out  : out std_logic_vector(width-1 downto 0);
        en_reg    : in std_logic_vector(99 downto 0)
       
    );
end cluster_finder_2;

-- Architecture
architecture cluster_finder_2_arch of cluster_finder_2 is

    -- Component Declaration
    component mux_16x1_2 is
        port (
            sel        : in std_logic_vector(3 downto 0); -- 4-bit select line
            enable     : in std_logic;                    -- Enable signal
            output     : out std_logic_vector(width-1 downto 0)          -- 64-bit output
        );
    end component;

    -- Type Declaration for Array of Mux Outputs
    type mux_array_t is array (0 to 99) of std_logic_vector(width-1 downto 0); -- Adjust array size as per your mux count
    signal mux_outputs : mux_array_t;
    signal sum_result   : signed(width-1 downto 0);

begin

    -- Generate block for repeated mux instantiation
    gen_mux: for i in 0 to 99 generate -- Adjust range based on the number of muxes
        mux_inst: mux_16x1_2
            port map(
                sel        => data_in((i * 4 + 3) downto (i * 4)), -- 4-bit chunks for selection
                enable     => en_reg(i),
                output     => mux_outputs(i)
            );
    end generate;

    -- Structural Summation Logic

sum_result <=     signed(mux_outputs(0))  + signed(mux_outputs(1))  + signed(mux_outputs(2))  +
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
                  signed(mux_outputs(48)) + signed(mux_outputs(49)) + signed(mux_outputs(50)) +
                  signed(mux_outputs(51)) + signed(mux_outputs(52)) + signed(mux_outputs(53)) +
                  signed(mux_outputs(54)) + signed(mux_outputs(55)) + signed(mux_outputs(56)) +
                  signed(mux_outputs(57)) + signed(mux_outputs(58)) + signed(mux_outputs(59)) +
                  signed(mux_outputs(60)) + signed(mux_outputs(61)) + signed(mux_outputs(62)) +
                  signed(mux_outputs(63)) + signed(mux_outputs(64)) + signed(mux_outputs(65)) +
                  signed(mux_outputs(66)) + signed(mux_outputs(67)) + signed(mux_outputs(68)) +
                  signed(mux_outputs(69)) + signed(mux_outputs(70)) + signed(mux_outputs(71)) +
                  signed(mux_outputs(72)) + signed(mux_outputs(73)) + signed(mux_outputs(74)) +
                  signed(mux_outputs(75)) + signed(mux_outputs(76)) + signed(mux_outputs(77)) +
                  signed(mux_outputs(78)) + signed(mux_outputs(79)) + signed(mux_outputs(80)) +
                  signed(mux_outputs(81)) + signed(mux_outputs(82)) + signed(mux_outputs(83)) +
                  signed(mux_outputs(84)) + signed(mux_outputs(85)) + signed(mux_outputs(86)) +
                  signed(mux_outputs(87)) + signed(mux_outputs(88)) + signed(mux_outputs(89)) +
                  signed(mux_outputs(90)) + signed(mux_outputs(91)) + signed(mux_outputs(92)) +
                  signed(mux_outputs(93)) + signed(mux_outputs(94)) + signed(mux_outputs(95)) +
                  signed(mux_outputs(96)) + signed(mux_outputs(97)) + signed(mux_outputs(98)) +
                  signed(mux_outputs(99));

  

    -- Assign the result to the output
    data_out <= std_logic_vector(sum_result);

end cluster_finder_2_arch;

