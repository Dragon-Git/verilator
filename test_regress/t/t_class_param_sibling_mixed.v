// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain.
// SPDX-FileCopyrightText: 2026 Wilson Snyder
// SPDX-License-Identifier: CC0-1.0

// verilog_format: off
`define stop $stop
`define checkd(gotv,expv) do if ((gotv) !== (expv)) begin $write("%%Error: %s:%0d:  got=%0d exp=%0d (%s !== %s)\n", `__FILE__, `__LINE__, (gotv), (expv), `"gotv`", `"expv`"); `stop; end while (0);
// verilog_format: on

class driver #(parameter int IW = 8);
  typedef bit [IW-1:0] data_t;
endclass

module t;
  // A local alias for one sibling must not override an explicit reference
  // to another sibling of the same template in the same scope.
  typedef driver#(5) drv5_t;
  drv5_t::data_t data5;
  driver#(6)::data_t data6;

  initial begin
    $display("WIDTHS %0d %0d", $bits(data5), $bits(data6));
    `checkd($bits(data5), 5);
    `checkd($bits(data6), 6);
    $write("*-* All Finished *-*\n");
    $finish;
  end
endmodule
