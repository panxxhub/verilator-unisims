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
     parameter       DDR_CLK_EDGE  = "SAME_EDGE_PIPELINED",
     parameter [0:0] INIT_Q1 = 1'b0,
     parameter [0:0] INIT_Q2 = 1'b0,
     parameter       SRTYPE = "ASYNC"
   )
   (
     input  C,
     input  CE,

     input  D,

     output Q1,
     output Q2,

     input  R, /* Active-High Reset */
     input  S  /* Active-High Set */
   );


  // the iddr core logic
  reg q1,q1_stage,q2,q2_stage;
  reg q1_s2,q2_s2;

  assign Q1 = q1_s2;
  assign Q2 = q2_s2;


  always @(negedge C or posedge R)
  begin
    if(R)
    begin
      q2 <= 1'b0;
    end
    else if(CE)
    begin
      q2 <= D;
      q2_stage <= q2;
      q1_stage <= q1;
    end
  end

  always @(posedge C or posedge R)
  begin
    if(R)
    begin
      q1 <= 1'b0;
    end
    else if(CE)
    begin
      q1 <= D;

      q1_s2 <= q1_stage;
      q2_s2 <= q2_stage;
    end
  end





endmodule
