library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity PlantCareSystem is
  port ( 
  
    stop : in STD_LOGIC; --stop system
	 start : in STD_LOGIC; --start system
    clk : in STD_LOGIC; --clock of system
	 stage1 : out STD_LOGIC; --stage1 lamp
	 stage2 : out STD_LOGIC; --stage2 lamp
	 servoOpen : out STD_LOGIC; --fertillizer gate open
	 servoClose : out STD_LOGIC; --fertillizer gate close
    pump : out STD_LOGIC); --water pump signal
end PlantCareSystem;

architecture System of PlantCareSystem is
 signal counter : INTEGER := 0; --time handling
 begin
  system_cont: process(clk, start, stop) --to enter every clock cycle or when stop/start changes
  begin
    if( stop ='1') then 
	    counter<= 0; --reset counter
	 
    elsif rising_edge(clk) then
      if start = '0' then
        counter <= 0;
      else
        if counter = 100000000 then --time of system cycle 10s
          counter <= 0;
        else
          counter <= cntr + 1; --increment til 10s
        end if;
      end if;
    end if;
  end process system_cont;
  pump <= start AND not stop when (counter < 50000000) else '0'; --first 5s
  stage1 <= start AND not stop when (counter < 50000000) else '0'; --first 5s
  stage2 <= start AND not stop when (counter >  50000000) else '0'; --second 5s 
  servoOpen <= start AND not stop when (counter < 50000000) else '0'; --second 5s open
  servoClose <= start AND not stop when (counter >  50000000) else '0'; --first 5s close
end System;