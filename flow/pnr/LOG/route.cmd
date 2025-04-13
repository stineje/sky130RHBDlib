#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Thu Apr 10 15:17:11 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.16-s078_1 (64bit) 12/07/2022 12:07 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.16-s078_1 NR221206-1807/21_16-UB (database version 18.20.600) {superthreading v2.17}
#@(#)CDS: AAE 21.16-s035 (64bit) 12/07/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.16-s024_1 () Dec  5 2022 05:41:45 ( )
#@(#)CDS: SYNTECH 21.16-s009_1 () Nov  9 2022 03:47:50 ( )
#@(#)CDS: CPE v21.16-s066
#@(#)CDS: IQuantus/TQuantus 21.1.1-s939 (64bit) Wed Nov 9 09:34:24 PST 2022 (Linux 3.10.0-693.el7.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
setDistributeHost -local
setMultiCpuUsage -localCpu 1
restoreDesign DBS/place.enc.dat fsm
um::push_snapshot_stack
setAnalysisMode -cppr both
setDelayCalMode -siAware true -engine aae
setNanoRouteMode -routeWithLithoDriven false
routeDesign
setExtractRCMode -engine postRoute
um::pop_snapshot_stack
set ::db::dbgUseOverlapObsForArea 1
set ::db::dbgUseOverlapObsForArea 0
reportMultiBitFFs -statistics
get_message -id IMPSP-9105 -suppress
set_message -id IMPSP-9105 -suppress
redirect -variable spots {reportCongestion -hotSpot}
set_message -id IMPSP-9105 -unsuppress
::um::set_metric -name flow.machine.os -value {Linux 3.10.0-1160.119.1.el7.x86_64}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.model -value { AMD EPYC 74F3 24-Core Processor}
::um::set_metric -name flow.machine.cpu.frequency -value {3193.844 Mhz}
::um::set_metric -name flow.machine.cpu.number -value 96
::um::set_metric -name flow.machine.memory.total -value {131513436 kB}
::um::set_metric -name flow.machine.memory.free -value {1583880 kB}
::um::set_metric -name flow.machine.swap.total -value {4194300 kB}
::um::set_metric -name flow.machine.swap.free -value {4193276 kB}
::um::get_metric -raw -id current -uuid 87ef08f2-f9d7-41a3-8e7c-266bba8fd7ab clock.Routing.area.total
::um::get_metric -raw -id current -uuid 87ef08f2-f9d7-41a3-8e7c-266bba8fd7ab clock.PostConditioning.area.total
::um::get_metric -raw -id current -uuid 87ef08f2-f9d7-41a3-8e7c-266bba8fd7ab clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 87ef08f2-f9d7-41a3-8e7c-266bba8fd7ab clock.Routing.area.total
::um::get_metric -raw -id current -uuid 87ef08f2-f9d7-41a3-8e7c-266bba8fd7ab clock.Implementation.area.total
::um::get_metric -raw -id current -uuid 87ef08f2-f9d7-41a3-8e7c-266bba8fd7ab clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 87ef08f2-f9d7-41a3-8e7c-266bba8fd7ab clock.Construction.area.total
::um::get_metric -raw -id current -uuid 87ef08f2-f9d7-41a3-8e7c-266bba8fd7ab clock.Implementation.area.total
um::get_metric -id current -uuid 87ef08f2-f9d7-41a3-8e7c-266bba8fd7ab messages.instant -exclude_inherited
::um::get_metric -raw -id current -uuid c9715a76-442b-45d9-bda9-03ee87ab0e5c clock.Routing.area.total
::um::get_metric -raw -id current -uuid c9715a76-442b-45d9-bda9-03ee87ab0e5c clock.PostConditioning.area.total
::um::get_metric -raw -id current -uuid c9715a76-442b-45d9-bda9-03ee87ab0e5c clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid c9715a76-442b-45d9-bda9-03ee87ab0e5c clock.Routing.area.total
::um::get_metric -raw -id current -uuid c9715a76-442b-45d9-bda9-03ee87ab0e5c clock.Implementation.area.total
::um::get_metric -raw -id current -uuid c9715a76-442b-45d9-bda9-03ee87ab0e5c clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid c9715a76-442b-45d9-bda9-03ee87ab0e5c clock.Construction.area.total
::um::get_metric -raw -id current -uuid c9715a76-442b-45d9-bda9-03ee87ab0e5c clock.Implementation.area.total
um::get_metric -id current -uuid c9715a76-442b-45d9-bda9-03ee87ab0e5c messages.instant -exclude_inherited
::um::get_metric -raw -id current -uuid aac1feb8-ab7c-43e4-82ea-8b0d6cbd0784 clock.Routing.area.total
::um::get_metric -raw -id current -uuid aac1feb8-ab7c-43e4-82ea-8b0d6cbd0784 clock.PostConditioning.area.total
::um::get_metric -raw -id current -uuid aac1feb8-ab7c-43e4-82ea-8b0d6cbd0784 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid aac1feb8-ab7c-43e4-82ea-8b0d6cbd0784 clock.Routing.area.total
::um::get_metric -raw -id current -uuid aac1feb8-ab7c-43e4-82ea-8b0d6cbd0784 clock.Implementation.area.total
::um::get_metric -raw -id current -uuid aac1feb8-ab7c-43e4-82ea-8b0d6cbd0784 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid aac1feb8-ab7c-43e4-82ea-8b0d6cbd0784 clock.Construction.area.total
::um::get_metric -raw -id current -uuid aac1feb8-ab7c-43e4-82ea-8b0d6cbd0784 clock.Implementation.area.total
um::get_metric -id current -uuid aac1feb8-ab7c-43e4-82ea-8b0d6cbd0784 messages.instant -exclude_inherited
::um::get_metric -raw -id current -uuid 8e0a275b-d7a2-41d3-b71b-bf967f5cbca5 clock.Routing.area.total
::um::get_metric -raw -id current -uuid 8e0a275b-d7a2-41d3-b71b-bf967f5cbca5 clock.PostConditioning.area.total
::um::get_metric -raw -id current -uuid 8e0a275b-d7a2-41d3-b71b-bf967f5cbca5 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 8e0a275b-d7a2-41d3-b71b-bf967f5cbca5 clock.Routing.area.total
::um::get_metric -raw -id current -uuid 8e0a275b-d7a2-41d3-b71b-bf967f5cbca5 clock.Implementation.area.total
::um::get_metric -raw -id current -uuid 8e0a275b-d7a2-41d3-b71b-bf967f5cbca5 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 8e0a275b-d7a2-41d3-b71b-bf967f5cbca5 clock.Construction.area.total
::um::get_metric -raw -id current -uuid 8e0a275b-d7a2-41d3-b71b-bf967f5cbca5 clock.Implementation.area.total
um::get_metric -id current -uuid 8e0a275b-d7a2-41d3-b71b-bf967f5cbca5 messages.instant -exclude_inherited
::um::get_metric -raw -id current -uuid 5104061d-b4de-43eb-93ba-b59235fc16d8 clock.Routing.area.total
::um::get_metric -raw -id current -uuid 5104061d-b4de-43eb-93ba-b59235fc16d8 clock.PostConditioning.area.total
::um::get_metric -raw -id current -uuid 5104061d-b4de-43eb-93ba-b59235fc16d8 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 5104061d-b4de-43eb-93ba-b59235fc16d8 clock.Routing.area.total
::um::get_metric -raw -id current -uuid 5104061d-b4de-43eb-93ba-b59235fc16d8 clock.Implementation.area.total
::um::get_metric -raw -id current -uuid 5104061d-b4de-43eb-93ba-b59235fc16d8 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 5104061d-b4de-43eb-93ba-b59235fc16d8 clock.Construction.area.total
::um::get_metric -raw -id current -uuid 5104061d-b4de-43eb-93ba-b59235fc16d8 clock.Implementation.area.total
um::get_metric -id current -uuid 5104061d-b4de-43eb-93ba-b59235fc16d8 messages.instant -exclude_inherited
::um::get_metric -raw -id current -uuid 86f54deb-2fb0-491e-83f2-aaf235184fd2 clock.Routing.area.total
::um::get_metric -raw -id current -uuid 86f54deb-2fb0-491e-83f2-aaf235184fd2 clock.PostConditioning.area.total
::um::get_metric -raw -id current -uuid 86f54deb-2fb0-491e-83f2-aaf235184fd2 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 86f54deb-2fb0-491e-83f2-aaf235184fd2 clock.Routing.area.total
::um::get_metric -raw -id current -uuid 86f54deb-2fb0-491e-83f2-aaf235184fd2 clock.Implementation.area.total
::um::get_metric -raw -id current -uuid 86f54deb-2fb0-491e-83f2-aaf235184fd2 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 86f54deb-2fb0-491e-83f2-aaf235184fd2 clock.Construction.area.total
::um::get_metric -raw -id current -uuid 86f54deb-2fb0-491e-83f2-aaf235184fd2 clock.Implementation.area.total
um::get_metric -id current -uuid 86f54deb-2fb0-491e-83f2-aaf235184fd2 messages.instant -exclude_inherited
::um::get_metric -raw -id current -uuid f341d530-9073-4ddb-8508-956daf679d5b clock.Routing.area.total
::um::get_metric -raw -id current -uuid f341d530-9073-4ddb-8508-956daf679d5b clock.PostConditioning.area.total
::um::get_metric -raw -id current -uuid f341d530-9073-4ddb-8508-956daf679d5b clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid f341d530-9073-4ddb-8508-956daf679d5b clock.Routing.area.total
::um::get_metric -raw -id current -uuid f341d530-9073-4ddb-8508-956daf679d5b clock.Implementation.area.total
::um::get_metric -raw -id current -uuid f341d530-9073-4ddb-8508-956daf679d5b clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid f341d530-9073-4ddb-8508-956daf679d5b clock.Construction.area.total
::um::get_metric -raw -id current -uuid f341d530-9073-4ddb-8508-956daf679d5b clock.Implementation.area.total
um::get_metric -id current -uuid f341d530-9073-4ddb-8508-956daf679d5b messages.instant -exclude_inherited
::um::get_metric -raw -id current -uuid 41e48cb9-f1dc-43ae-a453-acb998e32673 clock.Routing.area.total
::um::get_metric -raw -id current -uuid 41e48cb9-f1dc-43ae-a453-acb998e32673 clock.PostConditioning.area.total
::um::get_metric -raw -id current -uuid 41e48cb9-f1dc-43ae-a453-acb998e32673 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 41e48cb9-f1dc-43ae-a453-acb998e32673 clock.Routing.area.total
::um::get_metric -raw -id current -uuid 41e48cb9-f1dc-43ae-a453-acb998e32673 clock.Implementation.area.total
::um::get_metric -raw -id current -uuid 41e48cb9-f1dc-43ae-a453-acb998e32673 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 41e48cb9-f1dc-43ae-a453-acb998e32673 clock.Construction.area.total
::um::get_metric -raw -id current -uuid 41e48cb9-f1dc-43ae-a453-acb998e32673 clock.Implementation.area.total
um::get_metric -id current -uuid 41e48cb9-f1dc-43ae-a453-acb998e32673 messages.instant -exclude_inherited
::um::get_metric -raw -id current -uuid 917e5a36-a1ec-40c4-bbeb-b397b00bbfe3 clock.Routing.area.total
::um::get_metric -raw -id current -uuid 917e5a36-a1ec-40c4-bbeb-b397b00bbfe3 clock.PostConditioning.area.total
::um::get_metric -raw -id current -uuid 917e5a36-a1ec-40c4-bbeb-b397b00bbfe3 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 917e5a36-a1ec-40c4-bbeb-b397b00bbfe3 clock.Routing.area.total
::um::get_metric -raw -id current -uuid 917e5a36-a1ec-40c4-bbeb-b397b00bbfe3 clock.Implementation.area.total
::um::get_metric -raw -id current -uuid 917e5a36-a1ec-40c4-bbeb-b397b00bbfe3 clock.eGRPC.area.total
::um::get_metric -raw -id current -uuid 917e5a36-a1ec-40c4-bbeb-b397b00bbfe3 clock.Construction.area.total
::um::get_metric -raw -id current -uuid 917e5a36-a1ec-40c4-bbeb-b397b00bbfe3 clock.Implementation.area.total
um::get_metric -id current -uuid 917e5a36-a1ec-40c4-bbeb-b397b00bbfe3 messages.instant -exclude_inherited
um::get_metric -id current -uuid b55f03f0-d66d-4f46-bfb1-d2c61437447c messages.instant -exclude_inherited
um::get_metric_definition -name *.drc
um::get_metric_definition -name *.drc.layer:*
um::get_metric_definition -name *.drc.layer:*.type:*
um::get_metric_definition -name *.drc.type:*
um::get_metric_definition -name check.drc
um::get_metric_definition -name check.drc.antenna
um::get_metric_definition -name check.place.*
um::get_metric_definition -name clock.area.buffer
um::get_metric_definition -name clock.area.clkgate
um::get_metric_definition -name clock.area.inverter
um::get_metric_definition -name clock.area.logic
um::get_metric_definition -name clock.area.nonicg
um::get_metric_definition -name clock.area.total
um::get_metric_definition -name clock.area_distribution.buffer.base_cell:*
um::get_metric_definition -name clock.area_distribution.clkgate.base_cell:*
um::get_metric_definition -name clock.area_distribution.inverter.base_cell:*
um::get_metric_definition -name clock.area_distribution.logic.base_cell:*
um::get_metric_definition -name clock.area_distribution.nonicg.base_cell:*
um::get_metric_definition -name clock.buffer_depth_constraint.skew_group:*.*
um::get_metric_definition -name clock.capacitance.gate.leaf
um::get_metric_definition -name clock.capacitance.gate.top
um::get_metric_definition -name clock.capacitance.gate.trunk
um::get_metric_definition -name clock.capacitance.sink.*
um::get_metric_definition -name clock.capacitance.total.leaf
um::get_metric_definition -name clock.capacitance.total.top
um::get_metric_definition -name clock.capacitance.total.trunk
um::get_metric_definition -name clock.capacitance.wire.leaf
um::get_metric_definition -name clock.capacitance.wire.top
um::get_metric_definition -name clock.capacitance.wire.trunk
um::get_metric_definition -name clock.drv.nets.capacitance.*
um::get_metric_definition -name clock.drv.nets.capacitance.count
um::get_metric_definition -name clock.drv.nets.capacitance.max
um::get_metric_definition -name clock.drv.nets.fanout.*
um::get_metric_definition -name clock.drv.nets.fanout.count
um::get_metric_definition -name clock.drv.nets.fanout.max
um::get_metric_definition -name clock.drv.nets.length.*
um::get_metric_definition -name clock.drv.nets.length.count
um::get_metric_definition -name clock.drv.nets.length.max
um::get_metric_definition -name clock.drv.nets.remaining
um::get_metric_definition -name clock.drv.nets.resistance.*
um::get_metric_definition -name clock.drv.nets.resistance.count
um::get_metric_definition -name clock.drv.nets.resistance.max
um::get_metric_definition -name clock.drv.nets.unfixable
um::get_metric_definition -name clock.halo.clock_tree:*.count
um::get_metric_definition -name clock.halo.clock_tree:*.violations
um::get_metric_definition -name clock.instances.buffer
um::get_metric_definition -name clock.instances.buffer.creator.*
um::get_metric_definition -name clock.instances.clkgate
um::get_metric_definition -name clock.instances.inverter
um::get_metric_definition -name clock.instances.inverter.creator.*
um::get_metric_definition -name clock.instances.logic
um::get_metric_definition -name clock.instances.nonicg
um::get_metric_definition -name clock.instances.total
um::get_metric_definition -name clock.instances_distribution.buffer.base_cell:*
um::get_metric_definition -name clock.instances_distribution.clkgate.base_cell:*
um::get_metric_definition -name clock.instances_distribution.inverter.base_cell:*
um::get_metric_definition -name clock.instances_distribution.logic.base_cell:*
um::get_metric_definition -name clock.instances_distribution.nonicg.base_cell:*
um::get_metric_definition -name clock.latency.primary_reporting_skew_group.primary_half_corner.*
um::get_metric_definition -name clock.latency.skew_group:*.delay_corner:*.early.*
um::get_metric_definition -name clock.latency.skew_group:*.delay_corner:*.late.*
um::get_metric_definition -name clock.nets.length.leaf
um::get_metric_definition -name clock.nets.length.top
um::get_metric_definition -name clock.nets.length.total
um::get_metric_definition -name clock.nets.length.trunk
um::get_metric_definition -name clock.skew.primary_reporting_skew_group.primary_half_corner.*
um::get_metric_definition -name clock.skew.primary_reporting_skew_group.primary_half_corner.skew_band.*
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.early.gate
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.early.skew_band.*
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.early.target
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.early.target_met
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.early.total
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.early.wire
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.late.gate
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.late.skew_band.*
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.late.target
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.late.target_met
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.late.total
um::get_metric_definition -name clock.skew.skew_group:*.delay_corner:*.late.wire
um::get_metric_definition -name clock.stage_depth_constraint.*
um::get_metric_definition -name clock.transition.auto_target.delay_corner:*.early.clock_tree:*
um::get_metric_definition -name clock.transition.auto_target.delay_corner:*.late.clock_tree:*
um::get_metric_definition -name clock.transition.primary_half_corner.leaf.*.*
um::get_metric_definition -name clock.transition.primary_half_corner.leaf.*.max
um::get_metric_definition -name clock.transition.primary_half_corner.top.*.*
um::get_metric_definition -name clock.transition.primary_half_corner.top.*.max
um::get_metric_definition -name clock.transition.primary_half_corner.trunk.*.*
um::get_metric_definition -name clock.transition.primary_half_corner.trunk.*.max
um::get_metric_definition -name clock.transition.target.delay_corner:*.early.leaf.clock_tree:*
um::get_metric_definition -name clock.transition.target.delay_corner:*.early.top.clock_tree:*
um::get_metric_definition -name clock.transition.target.delay_corner:*.early.trunk.clock_tree:*
um::get_metric_definition -name clock.transition.target.delay_corner:*.late.leaf.clock_tree:*
um::get_metric_definition -name clock.transition.target.delay_corner:*.late.top.clock_tree:*
um::get_metric_definition -name clock.transition.target.delay_corner:*.late.trunk.clock_tree:*
um::get_metric_definition -name clock.transition.target.primary_half_corner.leaf.*
um::get_metric_definition -name clock.transition.target.primary_half_corner.top.*
um::get_metric_definition -name clock.transition.target.primary_half_corner.trunk.*
um::get_metric_definition -name design.area
um::get_metric_definition -name design.area.always_on
um::get_metric_definition -name design.area.blackbox
um::get_metric_definition -name design.area.buffer
um::get_metric_definition -name design.area.combinatorial
um::get_metric_definition -name design.area.hinst:*
um::get_metric_definition -name design.area.icg
um::get_metric_definition -name design.area.inverter
um::get_metric_definition -name design.area.io
um::get_metric_definition -name design.area.isolation
um::get_metric_definition -name design.area.latch
um::get_metric_definition -name design.area.level_shifter
um::get_metric_definition -name design.area.logical
um::get_metric_definition -name design.area.macro
um::get_metric_definition -name design.area.physical
um::get_metric_definition -name design.area.power_switch
um::get_metric_definition -name design.area.register
um::get_metric_definition -name design.area.std_cell
um::get_metric_definition -name design.area.vth:*
um::get_metric_definition -name design.area.vth:*.ratio
um::get_metric_definition -name design.blockages.place.area
um::get_metric_definition -name design.blockages.route.area
um::get_metric_definition -name design.blockages.route.area.layer:*
um::get_metric_definition -name design.congestion.hotspot.max
um::get_metric_definition -name design.congestion.hotspot.total
um::get_metric_definition -name design.density
um::get_metric_definition -name design.floorplan.image
um::get_metric_definition -name design.instances
um::get_metric_definition -name design.instances.always_on
um::get_metric_definition -name design.instances.blackbox
um::get_metric_definition -name design.instances.buffer
um::get_metric_definition -name design.instances.combinatorial
um::get_metric_definition -name design.instances.hinst:*
um::get_metric_definition -name design.instances.icg
um::get_metric_definition -name design.instances.inverter
um::get_metric_definition -name design.instances.io
um::get_metric_definition -name design.instances.isolation
um::get_metric_definition -name design.instances.latch
um::get_metric_definition -name design.instances.level_shifter
um::get_metric_definition -name design.instances.logical
um::get_metric_definition -name design.instances.macro
um::get_metric_definition -name design.instances.physical
um::get_metric_definition -name design.instances.power_switch
um::get_metric_definition -name design.instances.register
um::get_metric_definition -name design.instances.std_cell
um::get_metric_definition -name design.instances.vth:*
um::get_metric_definition -name design.instances.vth:*.ratio
um::get_metric_definition -name design.multibit.*
um::get_metric_definition -name design.name
um::get_metric_definition -name design.route.drc.image
um::get_metric_definition -name flow.cputime
um::get_metric_definition -name flow.cputime.total
um::get_metric_definition -name flow.last_child_snapshot
um::get_metric_definition -name flow.log
um::get_metric_definition -name flow.machine
um::get_metric_definition -name flow.machine.cpu.frequency
um::get_metric_definition -name flow.machine.cpu.model
um::get_metric_definition -name flow.machine.cpu.number
um::get_metric_definition -name flow.machine.hostname
um::get_metric_definition -name flow.machine.load
um::get_metric_definition -name flow.machine.memory.free
um::get_metric_definition -name flow.machine.memory.total
um::get_metric_definition -name flow.machine.os
um::get_metric_definition -name flow.machine.swap.free
um::get_metric_definition -name flow.machine.swap.total
um::get_metric_definition -name flow.memory
um::get_metric_definition -name flow.memory.resident
um::get_metric_definition -name flow.memory.resident.peak
um::get_metric_definition -name flow.realtime
um::get_metric_definition -name flow.realtime.total
um::get_metric_definition -name flow.root_config
um::get_metric_definition -name flow.run_directory
um::get_metric_definition -name flow.run_tag
um::get_metric_definition -name flow.step.tcl
um::get_metric_definition -name flow.template.feature_enabled
um::get_metric_definition -name flow.template.type
um::get_metric_definition -name flow.tool_list
um::get_metric_definition -name flow.user
um::get_metric_definition -name flowtool.status
um::get_metric_definition -name messages
um::get_metric_definition -name name
um::get_metric_definition -name power
um::get_metric_definition -name power.clock
um::get_metric_definition -name power.hinst:*
um::get_metric_definition -name power.internal
um::get_metric_definition -name power.internal.hinst:*
um::get_metric_definition -name power.internal.type:*
um::get_metric_definition -name power.leakage
um::get_metric_definition -name power.leakage.hinst:*
um::get_metric_definition -name power.leakage.type:*
um::get_metric_definition -name power.switching
um::get_metric_definition -name power.switching.hinst:*
um::get_metric_definition -name power.switching.type:*
um::get_metric_definition -name route.drc
um::get_metric_definition -name route.drc.antenna
um::get_metric_definition -name route.drc.layer:*
um::get_metric_definition -name route.map.*
um::get_metric_definition -name route.overflow
um::get_metric_definition -name route.overflow.horizontal
um::get_metric_definition -name route.overflow.layer:*
um::get_metric_definition -name route.overflow.vertical
um::get_metric_definition -name route.shielding.*
um::get_metric_definition -name route.via
um::get_metric_definition -name route.via.layer:*
um::get_metric_definition -name route.via.multicut
um::get_metric_definition -name route.via.multicut.layer:*
um::get_metric_definition -name route.via.multicut.percentage
um::get_metric_definition -name route.via.singlecut
um::get_metric_definition -name route.via.singlecut.layer:*
um::get_metric_definition -name route.via.singlecut.percentage
um::get_metric_definition -name route.via.total
um::get_metric_definition -name route.wirelength
um::get_metric_definition -name timing.drv.max_cap.total
um::get_metric_definition -name timing.drv.max_cap.worst
um::get_metric_definition -name timing.drv.max_fanout.total
um::get_metric_definition -name timing.drv.max_fanout.worst
um::get_metric_definition -name timing.drv.max_length.total
um::get_metric_definition -name timing.drv.max_length.worst
um::get_metric_definition -name timing.drv.max_tran.total
um::get_metric_definition -name timing.drv.max_tran.worst
um::get_metric_definition -name timing.hold.feps
um::get_metric_definition -name timing.hold.feps.analysis_view:*
um::get_metric_definition -name timing.hold.feps.path_group:*
um::get_metric_definition -name timing.hold.feps.path_group:*.analysis_view:*
um::get_metric_definition -name timing.hold.feps.path_group:reg2reg
um::get_metric_definition -name timing.hold.histogram
um::get_metric_definition -name timing.hold.histogram.views
um::get_metric_definition -name timing.hold.tns
um::get_metric_definition -name timing.hold.tns.analysis_view:*
um::get_metric_definition -name timing.hold.tns.path_group:*
um::get_metric_definition -name timing.hold.tns.path_group:*.analysis_view:*
um::get_metric_definition -name timing.hold.tns.path_group:reg2reg
um::get_metric_definition -name timing.hold.type
um::get_metric_definition -name timing.hold.wns
um::get_metric_definition -name timing.hold.wns.analysis_view:*
um::get_metric_definition -name timing.hold.wns.path_group:*
um::get_metric_definition -name timing.hold.wns.path_group:*.analysis_view:*
um::get_metric_definition -name timing.hold.wns.path_group:reg2reg
um::get_metric_definition -name timing.min_pulse_width.clocktree.feps
um::get_metric_definition -name timing.min_pulse_width.clocktree.feps.analysis_view:*
um::get_metric_definition -name timing.min_pulse_width.clocktree.feps.analysis_view:*.clock:*
um::get_metric_definition -name timing.min_pulse_width.clocktree.feps.clock:*
um::get_metric_definition -name timing.min_pulse_width.clocktree.tns
um::get_metric_definition -name timing.min_pulse_width.clocktree.tns.analysis_view:*
um::get_metric_definition -name timing.min_pulse_width.clocktree.tns.analysis_view:*.clock:*
um::get_metric_definition -name timing.min_pulse_width.clocktree.tns.clock:*
um::get_metric_definition -name timing.min_pulse_width.clocktree.wns
um::get_metric_definition -name timing.min_pulse_width.clocktree.wns.analysis_view:*
um::get_metric_definition -name timing.min_pulse_width.clocktree.wns.analysis_view:*.clock:*
um::get_metric_definition -name timing.min_pulse_width.clocktree.wns.clock:*
um::get_metric_definition -name timing.min_pulse_width.endpoints.feps
um::get_metric_definition -name timing.min_pulse_width.endpoints.feps.analysis_view:*
um::get_metric_definition -name timing.min_pulse_width.endpoints.feps.analysis_view:*.clock:*
um::get_metric_definition -name timing.min_pulse_width.endpoints.feps.clock:*
um::get_metric_definition -name timing.min_pulse_width.endpoints.tns
um::get_metric_definition -name timing.min_pulse_width.endpoints.tns.analysis_view:*
um::get_metric_definition -name timing.min_pulse_width.endpoints.tns.analysis_view:*.clock:*
um::get_metric_definition -name timing.min_pulse_width.endpoints.tns.clock:*
um::get_metric_definition -name timing.min_pulse_width.endpoints.wns
um::get_metric_definition -name timing.min_pulse_width.endpoints.wns.analysis_view:%.clock:*
um::get_metric_definition -name timing.min_pulse_width.endpoints.wns.analysis_view:*
um::get_metric_definition -name timing.min_pulse_width.endpoints.wns.analysis_view:*.clock:*
um::get_metric_definition -name timing.min_pulse_width.endpoints.wns.clock:*
um::get_metric_definition -name timing.setup.feps
um::get_metric_definition -name timing.setup.feps.analysis_view:*
um::get_metric_definition -name timing.setup.feps.path_group:*
um::get_metric_definition -name timing.setup.feps.path_group:*.analysis_view:*
um::get_metric_definition -name timing.setup.feps.path_group:reg2reg
um::get_metric_definition -name timing.setup.histogram
um::get_metric_definition -name timing.setup.histogram.views
um::get_metric_definition -name timing.setup.tns
um::get_metric_definition -name timing.setup.tns.analysis_view:*
um::get_metric_definition -name timing.setup.tns.path_group:*
um::get_metric_definition -name timing.setup.tns.path_group:*.analysis_view:*
um::get_metric_definition -name timing.setup.tns.path_group:reg2reg
um::get_metric_definition -name timing.setup.type
um::get_metric_definition -name timing.setup.wns
um::get_metric_definition -name timing.setup.wns.analysis_view:*
um::get_metric_definition -name timing.setup.wns.path_group:*
um::get_metric_definition -name timing.setup.wns.path_group:*.analysis_view:*
um::get_metric_definition -name timing.setup.wns.path_group:reg2reg
um::get_metric_definition -name timing.si.double_clocking.analysis_view:*
um::get_metric_definition -name timing.si.double_clocking.frequency_violations.analysis_view:*
um::get_metric_definition -name timing.si.double_clocking.report_file.analysis_view:*
um::get_metric_definition -name timing.si.glitches
um::get_metric_definition -name timing.si.noise
um::get_metric_definition -name transition.*
um::get_metric_definition -name transition.count
um::get_metric_definition -name transition.max
saveDesign DBS/route.enc -compress
saveNetlist DBS/LEC/route.v.gz
