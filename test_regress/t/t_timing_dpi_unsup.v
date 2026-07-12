// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain.
// SPDX-FileCopyrightText: 2023 Toru Niina
// SPDX-License-Identifier: CC0-1.0

// Test: DPI export with timing controls (Scope A - called from outside eval).
// C testbench calls the export directly; dispatcher drives eval loop internally.

`default_nettype none
`timescale 1ns / 1ps

module t;

  localparam cycle = 1000.0 / 100.0;
  localparam halfcycle = 0.5 * cycle;

  logic clk = '0;

  export "DPI-C" task tb_sv_wait;
  task automatic tb_sv_wait(input int n);
    repeat (n) @(negedge clk);
  endtask

  always #halfcycle clk = ~clk;

endmodule
