## Generated SDC file "with-sync.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Intel and sold by Intel or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 17.0.0 Build 595 04/25/2017 SJ Lite Edition"

## DATE    "Tue Jun 12 00:40:58 2018"

##
## DEVICE  "EP4CE115F29C7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLK_RECEIVER }]
create_clock -name {clk_src_min} -period 16.949 -waveform { 0.000 8.474 } [get_ports {CLK_SENDER}] -add
create_clock -name {clk_src_max} -period 16.393 -waveform { 0.000 8.196 } [get_ports {CLK_SENDER}] -add


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {inst1|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {inst1|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 6 -divide_by 5 -master_clock {clk50} [get_pins {inst1|altpll_component|auto_generated|pll1|clk[0]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk_src_min}] -rise_to [get_clocks {clk_src_min}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_src_min}] -fall_to [get_clocks {clk_src_min}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_src_min}] -rise_to [get_clocks {clk_src_max}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {clk_src_min}] -fall_to [get_clocks {clk_src_max}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {clk_src_min}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk_src_min}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {clk_src_min}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk_src_min}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {clk_src_min}] -rise_to [get_clocks {clk_src_min}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_src_min}] -fall_to [get_clocks {clk_src_min}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_src_min}] -rise_to [get_clocks {clk_src_max}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {clk_src_min}] -fall_to [get_clocks {clk_src_max}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {clk_src_min}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk_src_min}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {clk_src_min}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk_src_min}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {clk_src_max}] -rise_to [get_clocks {clk_src_min}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {clk_src_max}] -fall_to [get_clocks {clk_src_min}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {clk_src_max}] -rise_to [get_clocks {clk_src_max}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_src_max}] -fall_to [get_clocks {clk_src_max}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_src_max}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk_src_max}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {clk_src_max}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {clk_src_max}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {clk_src_max}] -rise_to [get_clocks {clk_src_min}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {clk_src_max}] -fall_to [get_clocks {clk_src_min}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {clk_src_max}] -rise_to [get_clocks {clk_src_max}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_src_max}] -fall_to [get_clocks {clk_src_max}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_src_max}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk_src_max}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {clk_src_max}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {clk_src_max}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -rise -max -clock [get_clocks {clk_src_min}]  5.000 [get_ports {RESET_BUTTON}]
set_input_delay -add_delay -rise -min -clock [get_clocks {clk_src_min}]  1.000 [get_ports {RESET_BUTTON}]
set_input_delay -add_delay -rise -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {RESET_BUTTON}]
set_input_delay -add_delay -rise -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {RESET_BUTTON}]
set_input_delay -add_delay -rise -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {RESET_BUTTON}]
set_input_delay -add_delay -rise -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {RESET_BUTTON}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {ACK_OUT}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {ACK_OUT}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {CLK_SENDER_OUT}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[0]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[0]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[1]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[1]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[2]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[2]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[3]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[3]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[4]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[4]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[5]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[5]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[6]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[6]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[7]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[7]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[8]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[8]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[9]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[9]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[10]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[10]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  5.000 [get_ports {DATA_DST_OUT[11]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {DATA_DST_OUT[11]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[0]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[0]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[1]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[1]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[2]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[2]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[3]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[3]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[4]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[4]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[5]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[5]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[6]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[6]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[7]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[7]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[8]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[8]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[9]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[9]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[10]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[10]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {DATA_SRC_OUT[11]}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DATA_SRC_OUT[11]}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  3.000 [get_ports {DEBUG_LED}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {DEBUG_LED}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  5.000 [get_ports {REQ_OUT}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {REQ_OUT}]
set_output_delay -add_delay -max -clock [get_clocks {clk_src_max}]  3.000 [get_ports {RESET_OUT}]
set_output_delay -add_delay -min -clock [get_clocks {clk_src_max}]  1.000 [get_ports {RESET_OUT}]


#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {clk_src_max}] -group [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] 
set_clock_groups -asynchronous -group [get_clocks {clk_src_min}] -group [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  -to  [get_clocks {clk_src_max}]
set_false_path  -from  [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  -to  [get_clocks {clk_src_min}]
set_false_path  -from  [get_clocks {clk_src_max}]  -to  [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]
set_false_path  -from  [get_clocks {clk_src_min}]  -to  [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]
set_false_path  -from  [get_clocks {clk_src_min}]  -to  [get_clocks {clk_src_max}]
set_false_path  -from  [get_clocks {clk_src_max}]  -to  [get_clocks {clk_src_min}]

set_false_path -from [get_registers {withsync:inst|dst:dst_inst|ackreg}] -to [get_registers {withsync:inst|sync:sync_ack|sync[1]}]
set_false_path -from [get_registers {withsync:inst|src:src_inst|reqreg}] -to [get_registers {withsync:inst|sync:sync_req|sync[1]}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************




