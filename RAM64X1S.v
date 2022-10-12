`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// RAM64X1S primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

module RAM64X1S
#(
    parameter  [63:0] INIT = 64'h0,
    parameter   [0:0] IS_WCLK_INVERTED = 1'b0
)
(
    // Write clock
    input  wire       WCLK,
    // Write enable
    input  wire       WE,
    // Read / Write address
    input  wire       A0,
    input  wire       A1,
    input  wire       A2,
    input  wire       A3,
    input  wire       A4,
    input  wire       A5,
    // Data in
    input  wire       D,
    // Data out
    output wire       O
);
    // Read / Write address
    wire  [5:0] _w_A = { A5, A4, A3, A2, A1, A0 };
    // 64 x 1-bit Select RAM
    reg  [63:0] _r_mem;
    
    // Power-up value
    initial begin : INIT_STATE
        _r_mem = INIT;
    end
    
    // Synchronous memory write
    generate
        if (IS_WCLK_INVERTED) begin : GEN_WCLK_NEG
            always @(negedge WCLK) begin : MEM_WRITE
            
                if (WE) begin
                    _r_mem[_w_A] <= D;
                end
            end
        end
        else begin : GEN_WCLK_POS
            always @(posedge WCLK) begin : MEM_WRITE
            
                if (WE) begin
                    _r_mem[_w_A] <= D;
                end
            end
        end
    endgenerate
    
    // Asynchronous memory read
    assign O = _r_mem[_w_A];

endmodule
