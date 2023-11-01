`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// IDDR primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 PanX
// License : BSD
//

module IDDR
  #(
     parameter       DDR_CLK_EDGE  = "OPPOSITE_EDGE",
     parameter [0:0] IS_CB_INVERTED = 1'b0,
     parameter [0:0] IS_C_INVERTED  = 1'b0
   )
   (
     input  C,
     input  CE,

     input  D,

     output Q1,
     output Q2,

     input  R /* Active-High Asynchronous Reset */
   );

  reg q1,q1_stage,q2,q2_stage;

  assign Q1 = q1_stage;
  assign Q2 = q2_stage;

  always @(negedge C or posedge R)
  begin
    if(R)
    begin
      q1 <= 1'b0;
    end
    else if(CE == 1'b1)
    begin
      q1 <= D;
      q1_stage <= q1;
      q2_stage <= q2;
    end
  end

  always @(posedge C or posedge R)
  begin
    if(R)
    begin
      q2 <= 1'b0;
    end
    else if (CE == 1'b1)
    begin
      q2 <= D;
    end
  end


endmodule
