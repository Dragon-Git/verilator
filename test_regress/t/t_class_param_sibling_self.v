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
  data_t current_data;
  // Explicit #(...) is not a bare self-reference (IEEE 1800-2023 8.25.1).
  driver#(6)::data_t sibling_data;

  function void check();
    $display("WIDTHS %0d %0d", $bits(current_data), $bits(sibling_data));
    `checkd($bits(current_data), IW);
    `checkd($bits(sibling_data), 6);
  endfunction
endclass

module t;
  driver#(5) d;
  initial begin
    d = new;
    d.check();
    $write("*-* All Finished *-*\n");
    $finish;
  end
endmodule
