`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// LUT1 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

module LUT1
#(
    parameter [1:0] INIT = 2'b00
)
(
    input  wire I0,
    output wire O
);
    assign O = INIT[I0];

endmodule
