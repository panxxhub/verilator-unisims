`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// MUXF7 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

module MUXF7
(
    input  wire I0, I1,
    input  wire S,
    output wire O
);

    assign O = (S) ? I1 : I0;

endmodule
