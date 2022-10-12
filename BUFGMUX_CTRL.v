 `ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// CARRY4 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//
module BUFGMUX_CTRL
(
    input  I0,
    input  I1,
    input  S,
    output O /* verilator clocker */
);
    assign O = S ? I1 : I0;

endmodule
