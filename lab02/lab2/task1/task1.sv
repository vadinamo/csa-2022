module task1(input logic clk,
               input logic reset,
               input logic left, right,
               output logic la, lb, lc, ra, rb, rc);
					logic [3:0] q;
					logic [3:0] q_next;
					
					assign q_next[3] = (!q[3] && q[2] && q[1] && q[0]);
					
					assign q_next[2] = (!q[3] && !q[2] && q[1] && q[0])
										|| (right && !left && !q[3] && !q[2] && !q[1] && !q[0])
										|| (!q[3] && q[2] && !q[1] && q[0])
										|| (!q[3] && q[2] && q[1] && !q[0]);
										
					assign q_next[1] = (!q[3] && !q[2] && !q[1] && q[0])
										|| (!q[3] && !q[2] && q[1] && !q[0])
										|| (!q[3] && q[2] && !q[1] && q[0])
										|| (!q[3] && q[2] && q[1] && !q[0]);
										
					assign q_next[0] = (left && !right && !q[3] && !q[2] && !q[1] && !q[0])
										|| (!q[3] && !q[2] && q[1] && !q[0])
										|| (right && !left && !q[3] && !q[2] && !q[1] && !q[0])
										|| (!q[3] && q[2] && q[1] && !q[0]);
					
					
					always_ff @(posedge clk, posedge reset)
						if (reset) q <= 4'b0;
						else q <= q_next;
						
					assign la = !q_next[3] && q_next[2] && !q_next[1] && !q_next[0];
					assign lb = !q_next[3] && !q_next[2] && q_next[1] && q_next[0];
					assign lc = !q_next[3] && !q_next[2] && q_next[1] && !q_next[0];
					assign ra = q_next[3] && !q_next[2] && !q_next[1] && !q_next[0];
					assign rb = !q_next[3] && q_next[2] && q_next[1] && q_next[0];
					assign rc = !q_next[3] && q_next[2] && q_next[1] && !q_next[0];
endmodule
						