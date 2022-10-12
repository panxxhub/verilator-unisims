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
    input  R
);

	reg q0,q1;

	assign Q1 = q0;
	assign Q2 = q1;

always @(posedge C or posedge R) begin
	if(R) begin
		q0 <= 1'b0;
	end else if(C) begin
		q0 <= D;
	end
end 

always @(posedge CB or posedge R) begin
	if(R) begin
		q1 <= 1'b0;
	end else if(C) begin
		q1 <= D;
	end
end
  

endmodule
