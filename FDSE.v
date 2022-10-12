`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// FDSE primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

module FDSE
#(
    parameter [0:0] IS_C_INVERTED = 1'b0,
    parameter [0:0] IS_D_INVERTED = 1'b0,
    parameter [0:0] IS_S_INVERTED = 1'b0,
    parameter [0:0] INIT          = 1'b1
)
(
    // Clock
    input  wire C,
    // Clock enable
    input  wire CE,
    // Synchronous set
    input  wire S,
    // Data in
    input  wire D,
    // Data out
    output wire Q
);
    reg _r_Q;

    wire _w_D = D ^ IS_D_INVERTED;
    wire _w_S = S ^ IS_S_INVERTED;
    
    initial begin : INIT_STATE
        _r_Q = INIT[0];
    end

    generate
        if (IS_C_INVERTED) begin : GEN_CLK_NEG
            always @(negedge C) begin
            
                if (_w_S) begin
                    _r_Q <= 1'b1;
                end
                else if (CE) begin
                    _r_Q <= _w_D;
                end
            end
        end
        else begin : GEN_CLK_POS
            always @(posedge C) begin
            
                if (_w_S) begin
                    _r_Q <= 1'b1;
                end
                else if (CE) begin
                    _r_Q <= _w_D;
                end
            end
        end
    endgenerate
    
    assign Q = _r_Q;
    
endmodule
