onerror {exit -code 1}
vlib work
vlog -work work add_half.vo
vlog -work work add_half.vwf.vt
vsim -c -t 1ps -L fiftyfivenm_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.add_half_vlg_vec_tst
vcd file -direction add_half.msim.vcd
vcd add -internal add_half_vlg_vec_tst/*
vcd add -internal add_half_vlg_vec_tst/i1/*
proc simTimestamp {} {
    echo "Simulation time: $::now ps"
    if { [string equal running [runStatus]] } {
        after 2500 simTimestamp
    }
}
after 2500 simTimestamp
run -all
quit -f
