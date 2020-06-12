
set design "Extension"
set top top
set sim_top top_tb
set device xcvu9p-fsgd2104-2L-e
set proj_dir ./project
set repo_dir ./ip_repo
set project_constraints constraints.xdc

set test_name "test"

# Build project.
create_project -name ${design} -force -dir "." -part ${device}
set_property source_mgmt_mode DisplayOnly [current_project]  
set_property top ${top} [current_fileset]
puts "Creating Project"

create_fileset -constrset -quiet constraints
#add_files -fileset constraints -norecurse ${project_constraints}
#set_property is_enabled false [get_files ${project_constraints}]

#Todo: Add your IP here
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name fail_prob_mem
set_property -dict [list CONFIG.Component_Name {fail_prob_mem} CONFIG.Write_Width_A {7} CONFIG.Write_Depth_A {128} CONFIG.Read_Width_A {7} CONFIG.Write_Width_B {7} CONFIG.Read_Width_B {7} CONFIG.Load_Init_File {true} CONFIG.Coe_File {/home/centos/CWM-ECAD/Extension/Temp_fail.coe}] [get_ips fail_prob_mem]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name stopping_distance_mem
set_property -dict [list CONFIG.Component_Name {stopping_distance_mem} CONFIG.Write_Width_A {9} CONFIG.Write_Depth_A {128} CONFIG.Read_Width_A {9} CONFIG.Write_Width_B {9} CONFIG.Read_Width_B {9} CONFIG.Load_Init_File {true} CONFIG.Coe_File {/home/centos/CWM-ECAD/Extension/stopping_distance.coe}] [get_ips stopping_distance_mem]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name speed_limit_mem
set_property -dict [list CONFIG.Component_Name {speed_limit_mem} CONFIG.Write_Width_A {7} CONFIG.Read_Width_A {7} CONFIG.Write_Width_B {7} CONFIG.Read_Width_B {7} CONFIG.Load_Init_File {true} CONFIG.Coe_File {/home/centos/CWM-ECAD/Extension/speed_limit.coe}] [get_ips speed_limit_mem]

create_ip -name speed_uartlite -vendor xilinx.com -library ip -version 2.0 -module_name speed_uartlite
set_property -dict [list CONFIG.C_DATA_BITS {7}] [get_ips speed_uartlite]


read_verilog "fail_prob.v"
read_verilog "stopping_distance.v"

read_verilog "check.v"

read_verilog "top.v"
read_verilog "top_tb.v"

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

set_property top ${sim_top} [get_filesets sim_1]
set_property include_dirs ${proj_dir} [get_filesets sim_1]
set_property simulator_language Mixed [current_project]
set_property verilog_define { {SIMULATION=1} } [get_filesets sim_1]
set_property -name xsim.more_options -value {-testplusarg TESTNAME=basic_test} -objects [get_filesets sim_1]
set_property runtime {} [get_filesets sim_1]
set_property target_simulator xsim [current_project]
set_property compxlib.compiled_library_dir {} [current_project]
set_property top_lib xil_defaultlib [get_filesets sim_1]
update_compile_order -fileset sim_1

launch_simulation
run 40000ns
