`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// ODDR primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

module ODDR
  #(
     parameter [0:0] DDR_CLK_EDGE = "SAME_EDGE",
     parameter [0:0] INIT = 1'b0,
     parameter SRTYPE = "SYNC"
   )
   (
     input  C,
     input  CE,
     input  D1,
     input  D2,
     input  R,
     output Q
   );


  wire       w_CLK = C&CE;
  wire       w_D1  = D1;
  wire       w_D2  = D2;
  wire       w_SR;

  reg  [2:0] r_SR_cdc;

  reg        r_Q_p;
  reg        r_D2_p;
  reg        r_Q_n;

  always @(posedge w_CLK)
  begin
    r_SR_cdc <= { r_SR_cdc[1:0], R };
  end
  assign w_SR = |{ R, r_SR_cdc };

  always @(posedge w_CLK)
  begin

    if (w_SR)
    begin
      r_Q_p  <= INIT ;
      r_D2_p <= INIT;
    end
    else
    begin
      r_Q_p  <= w_D1 ^ r_Q_n;
      r_D2_p <= w_D2;
    end
  end

  always @(negedge w_CLK)
  begin

    if (w_SR)
    begin
      r_Q_n <= INIT;
    end
    else
    begin
      r_Q_n <= r_D2_p ^ r_Q_p;
    end
  end

  assign Q = r_Q_p ^ r_Q_n;

endmodule
