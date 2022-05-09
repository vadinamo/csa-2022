`include "rooms.sv"
`include "treasure.sv"

import rooms::*;
import treasure::*;

module treasure_state_machine(input logic clk,
								  input logic reset,
								  input room_states room,
								  output logic treasure);
		
	treasure_state current, next;
	
	always_ff @(posedge clk, posedge reset)
		if(reset) current <= T0;
		else current <= next;
		
	always_comb
		case (current)
			T0: if (room == R8) next = T1;
				  else next = T0;
			T1: next = T1;
		endcase
		
	assign treasure = (next == T1);
endmodule