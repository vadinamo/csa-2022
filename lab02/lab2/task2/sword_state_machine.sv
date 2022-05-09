`include "rooms.sv"
`include "sword.sv"

import rooms::*;
import sword::*;

module sword_state_machine(input logic clk,
								   input logic reset,
								   input room_states room,
								   output logic sword);
		
	sword_state current, next;
	
	always_ff @(posedge clk, posedge reset)
		if(reset) current <= S0;
		else current <= next;
		
	always_comb
		case (current)
			S0:	if (room == R4) next = S1;
					else next = S0;
			S1: 	next = S1;
		endcase
		
	assign sword = (next == S1);
endmodule