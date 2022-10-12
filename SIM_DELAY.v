`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// IDDRE1 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 PanX
// License : BSD
//

module SIM_DELAY
(
    input  CLK,
    output CLK_90,
    input  R /* Active-High Asynchronous Reset */
);
	reg counter;
	reg q;
	assign CLK_90 = q;

always @(posedge CLK or posedge R) begin
	if(R) begin
		q <= 1'b0;
	end else if(CLK) begin
		counter <= counter + 1;
		if(counter == 1'b1) begin
			q <= ~q;
		end
	end
end 

 

endmodule
