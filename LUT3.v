`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// LUT3 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

module LUT3
#(
    parameter [7:0] INIT = 8'b00000000
)
(
    input  wire I0, I1, I2,
    output wire O
);
    wire [2:0] _w_idx = { I2, I1, I0 };

    assign O = INIT[_w_idx];

endmodule
