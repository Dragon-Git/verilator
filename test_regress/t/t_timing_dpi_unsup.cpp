// -*- mode: C++; c-file-style: "cc-mode" -*-
//
// This file ONLY is placed under the Creative Commons Public Domain.
// SPDX-FileCopyrightText: 2023 Toru Niina
// SPDX-License-Identifier: CC0-1.0

#include "Vt_timing_dpi_unsup__Dpi.h"
#include "Vt_timing_dpi_unsup.h"

#include <cstdio>

int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    Vt_timing_dpi_unsup* topp = new Vt_timing_dpi_unsup{contextp};

    // Run initial eval to register scopes and start processes
    topp->eval();

    // Set DPI scope (required when calling DPI exports from C)
    svSetScope(svGetScopeFromName("TOP.t"));

    // Call DPI export from C side (Scope A - outside eval loop).
    // The dispatcher drives the eval loop internally until the coroutine completes.
    printf("calling tb_sv_wait(3) from C...\n");
    tb_sv_wait(3);
    printf("tb_sv_wait returned\n");

    printf("*-* All Finished *-*\n");

    topp->final();
    delete topp;
    delete contextp;
    return 0;
}
