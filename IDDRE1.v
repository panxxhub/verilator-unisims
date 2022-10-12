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

module IDDRE1
#(
    parameter  	    DDR_CLK_EDGE  = "OPPOSITE_EDGE",
    parameter [0:0] IS_CB_INVERTED = 1'b0,
    parameter [0:0] IS_C_INVERTED  = 1'b0
)
(
    input  C,
    input  CB,

    input  D,

    output Q1,
    output Q2,

    input  R /* Active-High Asynchronous Reset */
);

	reg q1,q2;

	assign Q1 = q1;
	assign Q2 = q2;

always @(posedge C or posedge R) begin
	if(R) begin
		q1 <= 1'b0;
	end else if(C) begin
		q1 <= D;
	end
end 

always @(posedge CB or posedge R) begin
	if(R) begin
		q2 <= 1'b0;
	end else if(CB) begin
		q2 <= D;
	end
end
  

endmodule
