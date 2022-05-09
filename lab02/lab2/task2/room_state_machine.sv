`include "rooms.sv"
import rooms::*;

module room_state_machine(input logic clk,
								  input logic reset,
								  input logic n, s, w, e,
								  input logic sword, treasure,
								  output room_states room);
								  
									room_states current, next;
									always_ff @(posedge clk, posedge reset)
										if (reset) current <= R1;
										else current <= next;
										
									always_comb
										case (current)
											R1:	if (e) next = R2;
													else if (w) next = R8;
													else next = R1;
												 
											R2: 	if (w) next = R1;
													else if (s) next = R3;
													else next = R2;
											
											R3:	if (n) next = R2;
													else if (w) next = R4;
													else if (e) next = R5;
													else if (s) next = R9;
													else next = R3;
											
											R4:	if (e) next = R3;
													else next = R4;
													
											R5: 	if (w) next = R3;
													else if (e && sword) next = R6;
													else if (e && !sword) next = R7;
													else next = R5;
											
											R6: next = R6;
											
											R7: next = R7;
											
											R8: 	if (e) next = R1;
													else next = R8;
											
											R9:	if (n) next = R3;
													else if (e && treasure) next = R6;
													else next = R9;
												 
											default: next = R1;
										endcase
									
									assign room = next;
										
endmodule