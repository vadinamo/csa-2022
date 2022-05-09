`include "rooms.sv"
import rooms::*;

module task2(input logic clk, input logic reset,
				input logic n, s, w, e,
				output logic win, lose);
				room_states current;
				logic sword, treasure;
				
				room_state_machine r(clk, reset,
											n, s, w, e,
											sword, treasure,
											current);
				sword_state_machine sw(clk, reset,
											current,
											sword);
				treasure_state_machine tr(clk, reset,
											current, treasure);
										
				assign win = (current == R6);
				assign lose = (current == R7);
endmodule