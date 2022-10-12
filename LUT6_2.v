`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// LUT6_2 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

module LUT6_2
#(
    parameter [63:0] INIT = 64'h0000000000000000
)
(
    input  wire I0, I1, I2, I3, I4, I5,
    output wire O5,
    output wire O6
);
    wire [5:0] _w_idx_5 = { 1'b0, I4, I3, I2, I1, I0 };
    wire [5:0] _w_idx_6 = {   I5, I4, I3, I2, I1, I0 };
    
    assign O5 = INIT[_w_idx_5];
    assign O6 = INIT[_w_idx_6];

endmodule
