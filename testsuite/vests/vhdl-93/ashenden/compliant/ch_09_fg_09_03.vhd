
-- Copyright (C) 1996 Morgan Kaufmann Publishers, Inc

-- This file is part of VESTs (Vhdl tESTs).

-- VESTs is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at
-- your option) any later version. 

-- VESTs is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-- for more details. 

-- You should have received a copy of the GNU General Public License
-- along with VESTs; if not, write to the Free Software Foundation,
-- Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 

-- ---------------------------------------------------------------------
--
-- $Id: ch_09_fg_09_03.vhd,v 1.2 2001-10-26 16:29:34 paw Exp $
-- $Revision: 1.2 $
--
-- ---------------------------------------------------------------------

package cpu_types is

  constant word_size : positive := 16;
  constant address_size : positive := 32;

  subtype word is bit_vector(word_size - 1 downto 0);
  subtype address is bit_vector(address_size - 1 downto 0);

  type status_value is ( halted, idle, fetch, mem_read, mem_write,
                         io_read, io_write, int_ack );

end package cpu_types;



package bit_vector_unsigned_arithmetic is

  function "+" ( bv1, bv2 : bit_vector ) return bit_vector;

end package bit_vector_unsigned_arithmetic;


package body bit_vector_unsigned_arithmetic is

  function "+" ( bv1, bv2 : bit_vector ) return bit_vector is

    alias norm1 : bit_vector(1 to bv1'length) is bv1;
    alias norm2 : bit_vector(1 to bv2'length) is bv2;

    variable result : bit_vector(1 to bv1'length);
    variable carry : bit := '0';

  begin
    if bv1'length /= bv2'length then
      report "arguments of different length" severity failure;
    else
      for index in norm1'reverse_range loop
        result(index) := norm1(index) xor norm2(index) xor carry;
        carry := ( norm1(index) and norm2(index) )
                 or ( carry and ( norm1(index) or norm2(index) ) );
      end loop;
    end if;
    return result;
  end function "+";

end package  body bit_vector_unsigned_arithmetic;




-- code from book

package DMA_controller_types_and_utilities is

  alias word is work.cpu_types.word;
  alias address is work.cpu_types.address;
  alias status_value is work.cpu_types.status_value;

  alias "+" is work.bit_vector_unsigned_arithmetic."+"
    [ bit_vector, bit_vector return bit_vector ];

  -- . . .

end package DMA_controller_types_and_utilities;

-- end code from book

