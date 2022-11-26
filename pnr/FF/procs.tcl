
namespace eval ff_procs:: {
    proc load_path_groups {file} {

      read_dc_script $file

   } 

    proc report_time {} {
      global vars
   
      set run_time [expr [clock seconds] - $vars($vars(step),start_time)]
   
      if {$run_time > 86400} {
         set days [expr $run_time / 86400]
      } else {
         set days 0
      }
      set run_time [clock format $run_time -format %H:%M:%S -gmt true]
      Puts "<FF> =============================================="
      Puts "<FF>          COMPLETED STEP : $vars(step)"
      Puts "<FF>         ELAPSED RUNTIME : $days days, $run_time"
      Puts "<FF> =============================================="
   }
   
    proc insert_welltaps_endcaps {} {
   
      global vars
   
      if {[info exists vars(cpf_file)] && ([info exists vars(power_domains)] && ([llength $vars(power_domains)] > 0))} {
         set vars(power_domains) [::ff_procs::get_power_domains]
         foreach domain $vars(power_domains) {
            if {[info exists vars($domain,pre_endcap)] && 
                [info exists vars($domain,post_endcap)]} {
               addEndCap -prefix $domain \
                         -preCap $vars($domain,pre_endcap) \
                         -postCap $vars($domain,post_endcap) \
                         -powerDomain $domain 
            } elseif {[info exists vars(pre_endcap)] && 
                      [info exists vars(post_endcap)]} {
                  addEndCap -prefix $domain \
                            -preCap $vars(pre_endcap) \
                            -postCap $vars(post_endcap) \
                            -powerDomain $domain 
            }
            if {[info exists vars($domain,welltaps)] || [info exists vars(welltaps)]} {
               if {[info exists vars($domain,welltaps)]} {
                  set command "addWellTap -prefix $domain -cell $vars($domain,welltaps) -powerDomain $domain"
                  set vcommand "verifyWellTap -cells $vars($domain,welltaps) -powerDomain $domain -report $vars(rpt_dir)/welltap.rpt"
               } elseif {[info exists vars(welltaps)]} {
                  set command "addWellTap -prefix $domain -cell $vars(welltaps) -powerDomain $domain"
                  set vcommand "verifyWellTap -cells $vars(welltaps) -powerDomain $domain -report $vars(rpt_dir)/welltap.rpt"
               }
               if {[info exists vars($domain,welltaps,max_gap)] || [info exists vars($domain,welltaps,cell_interval)]} {
                  if {[info exists vars($domain,welltaps,max_gap)]} {
                     append command " -maxGap $vars($domain,welltaps,max_gap)"
                  } else {
                      append command " -cellInterval $vars($domain,welltaps,cell_interval)"
                  }
               } elseif {[info exists vars(welltaps,max_gap)] || [info exists vars(welltaps,cell_interval)]} {
                  if {[info exists vars(welltaps,max_gap)]} {
                     append command " -maxGap $vars(welltaps,max_gap)"
                  } else {
                      append command " -cellInterval $vars(welltaps,cell_interval)"
                  }
               }
               if {[info exists vars($domain,welltaps,row_offset)]} {
                  if {$vars($domain,welltaps,row_offset)} {
                     append command " -inRowOffset $vars($domain,welltaps,row_offset)"
                  }
               } elseif {[info exists vars(welltaps,row_offset)]} {
                  if {$vars(welltaps,row_offset)} {
                     append command " -inRowOffset $vars(welltaps,row_offset)"
                  }
               }
               if {[info exists vars($domain,welltaps,checkerboard)]} {
                  if {$vars($domain,welltaps,checkerboard)} {
                     append command " -checkerboard"
                  }
               } elseif {[info exists vars(welltaps,checkerboard)]} {
                  if {$vars(welltaps,checkerboard)} {
                     append command " -checkerboard"
                  }
               }
               eval $command
               if {[info exists vars(welltaps,verify_rule)]} {
                  append vcommand " -rule $vars(welltaps,verify_rule)"
                  eval $vcommand
               } else {
                  puts "<FF> Cannot run verifyWellTap because vars(welltaps,verify_rule) is not defined"
               }
            }
         }
      } else {
         if {[info exists vars(pre_endcap)] && 
             [info exists vars(post_endcap)]} {
            addEndCap -prefix ENDCAP \
                      -preCap $vars(pre_endcap) \
                      -postCap $vars(post_endcap)
         }
         if {[info exists vars(welltaps)]} {
            set command "addWellTap -prefix WELLTAP -cell $vars(welltaps) "
            set vcommand "verifyWellTap -cells $vars(welltaps) -report $vars(rpt_dir)/welltap.rpt"
            if {[info exists vars(welltaps,max_gap)] || [info exists vars(welltaps,cell_interval)]} {
               if {[info exists vars(welltaps,max_gap)]} {
                  append command " -maxGap $vars(welltaps,max_gap)"
               } else {
                  append command " -cellInterval $vars(welltaps,cell_interval)"
               }
            }
            if {[info exists vars(welltaps,row_offset)]} {
                  append command " -inRowOffset $vars(welltaps,row_offset)"
            }
            if {[info exists vars(welltaps,checkerboard)]} {
               if {$vars(welltaps,checkerboard)} {
                  append command " -checkerboard"
               }
            }
            eval $command
            if {[info exists vars(welltaps,verify_rule)]} {
               append vcommand " -rule $vars(welltaps,verify_rule)"
               eval $vcommand
            } else {
               puts "<FF> CANNOT RUN verifyWellTap BECAUSE vars(welltaps,verify_rule) IS NOT DEFINED"
            }
         }
      }
   }

    proc save_results {{step ""}} {

      global vars
      global errors
      global env

      if {$step != ""} {
         set vars(step) $step
      } else {
         Puts "<FF> Argument 'step' required ..."
         return
      }

      set commands ""

      set args ""
      if {[info exists vars(save_rc)] && $vars(save_rc)} {
         if {[regexp "route" $vars(step)]} {
            append args " -rc"
          }
      }
      if {[info exists vars(save_constraints)] && $vars(save_constraints)} {
         append args " -tcon"
      }
  
      set dir [subst $vars(dbs_dir)]
      set design $vars(design)
      if {[string compare -nocase $vars(dbs_format) "oa"]==0} {
         if {[lindex [split $vars(version) "."]  0] > 10} {
            if {$hier} {
               set command "saveDesign $args -cellview {$vars(oa_partition_lib) $vars(design) $vars(step)}\n"
            } else {
               set command "saveDesign $args -cellview {$vars(oa_design_lib) $vars(design) $vars(step)}\n"
            }
         } else {
            set command "saveOaDesign $vars(oa_design_lib) $design $vars(step)\n"
         }
      } else {
         if {[info exists vars(relative_path)] && $vars(relative_path)} {
            append args " -relativePath"
         }
         if {[info exists vars(absolute_lib_path)] && $vars(absolute_lib_path)} {
            append args " -absoluteLibPath"
         }
         set command "saveDesign $args $dir/$vars(step).enc -compress\n"
      }

      append commands $command

      if {![info exists env(VPATH)]} {
         set env(VPATH) "make"
      }

      if {$vars(makefile)} {
         append commands "exec /bin/touch $env(VPATH)/$step\n"
      }

      set header "#---------------------------------------------------------------------\n"
      append header "# <FF> GENERATING REPORTS\n"
      append header "#---------------------------------------------------------------------\n"

      if {$vars(report_power)} {
         set command "report_power -outfile $vars(rpt_dir)/$vars(step).power.rpt\n"
         append commands $command
      }

      if {[info exists vars(cpf_file)] && ([info exists vars(power_domains)] && ([llength $vars(power_domains)] > 0))} {
         append commands $header
         set header ""


         set command "verifyPowerDomain -bind -gconn"
         append command " -isoNetPD $vars(rpt_dir)/$vars(step).isonets.rpt"
         append command " -xNetPD $vars(rpt_dir)/$vars(step).xnets.rpt\n"

         append commands $command


         if {$vars(run_clp) && ([auto_execok lec] != "")} {
            set command "runCLP "
            if {[info exists vars(clp_options)]} {
               append command $vars(clp_options)
            }
            append command "\n"
            append commands $command
         } else {
            if {![info exists vars(clp_warning)]} {
               puts "<FF> WARNING: UNABLE TO RUN CLP ... PLEASE MAKE SURE IT IS IN YOUR PATH"
               set vars(clp_warning) true
            }
         }
      }


      if {[info exists vars(mail,to)]} {
         if {![info exists vars(mail,steps)] || \
             ([info exists vars(mail,steps)] && ([lsearch $vars(mail,steps) $vars(step)] != -1))} {
            append commands "Puts \"<FF> MAILING RESULTS TO $vars(mail,to)\"\n"
            append commands "if {\[file exists $vars(rpt_dir)/$vars(step).summary\]} {\n"
            append commands "   exec /bin/mail -s \"FF: $vars(design), $vars(step) completed (\[pwd\])\" < $vars(rpt_dir)/$vars(step).summary $vars(mail,to)\n"
            append commands "} else {\n"
            append commands "   exec /bin/mail -s \"FF: $vars(design), $vars(step) completed (\[pwd\])\" < /dev/null $vars(mail,to)\n"
            append commands "}\n"
         }
      }


      append commands [::FF::source_plug final_always_source_tcl]

      if {$vars(makefile)} { 
         append commands "if {\[info exists env(VPATH)\]} {\n"
         append commands "exec /bin/touch \$env(VPATH)/$vars(step)\n"
         append commands "}\n"
      }

      uplevel #0 eval $commands
   }

   proc load_applet {args} {

    set defAppletNS "::applet"
    set defSeverity "error"
    set defaultLocalInstall $::ns(applet)::localInstall
    set defaultLocalServer $::ns(applet)::localServer
    set reqAppletVersion ""

    switch -- [parse_options [calling_proc] {} $args \
      "-version sos required version of applet (equal or greater)" reqAppletVersion \
      "-severity sos severity (error|warning|info)" severity \
      "-namespace sos namespace to search for applet" appletNS \
      "srs name of applet" appletName] {
          -2 { return }
          0 { return -code error }
    }

    if {$appletNS eq ""} {
        set appletNS $defAppletNS
    }

    if {$severity eq ""} {
      set severity $defSeverity
    }
   
    if {![catch {set providedVersion [package present ${appletNS}::$appletName]} errorMessage]} {
      if {$reqAppletVersion ne ""} {
        if {[package vcompare $providedVersion $reqAppletVersion] == -1} {
          puts "load_applet INFO: applet $appletName was already loaded, but it's version ($providedVersion) did not meet the minimum required version ($reqAppletVersion)"
          puts "load_applet INFO: This version of the $appletName applet will be removed and the load_applet will search for a newer version of $appletName..."
          package forget ${appletNS}::$appletName
        } else {
	  puts "load_applet INFO: Found $appletName already loaded and it's version ($providedVersion) already meets the minimum required version ($reqAppletVersion). Skipping load..."
	  return
        }
      } else {
	puts "load_applet INFO: Found $appletName already loaded with version ($providedVersion). Skipping applet load..."
	return
      }
    }

    set FoundMinVersionPath 0
    set finalSearchPath "" 
    set failedPaths ""
    if {[get_tool] eq "rc"} {
      set searchPathList [get_attribute applet_search_path /]
    } else {
      set searchPathList [$::ns(compat)::get_attribute applet_search_path /]
    }
    set appletSearchPathCount [llength $searchPathList]

    set origappletSearchPathCount $appletSearchPathCount
    set origSearchPath ""
    if {$appletSearchPathCount > 1} {
      puts "load_applet INFO: Checking all applet search paths for versions of $appletName"
    }
    foreach pathComponent $searchPathList {
      incr appletSearchPathCount -1
      if {$origappletSearchPathCount > 1} {
        puts -nonewline "  $pathComponent ..."
      } else {
        puts -nonewline "load_applet INFO: Checking applet_search_path: $pathComponent ..."
      }
      if {[string match "<default>" $pathComponent]} {
        set pathComponent [$::ns(applet)::UpdateSearchPath $pathComponent]
      }
      lappend origSearchPath $pathComponent
      if {[file isdirectory $pathComponent]} {
	if {[file isfile $pathComponent/.servInfo]} {
	  if {[get_tool] eq "rc"} {
            set sourceCommand tcl_source
	  } else {
	    set sourceCommand source
	  }
	   set errorMsg ""
	  if {[catch {$sourceCommand $pathComponent/.servInfo} errorMsg] || ![info exists appInfo(${appletNS}::${appletName},version)]} {
	    if {$errorMsg ne ""} {
	      puts " $errorMsg"
	    } else {
	      puts " BAD APPLET SERVER (corrupted .servInfo file)"
	    }
          } else {
	    if {$reqAppletVersion eq "" } {
	      lappend minVersionSearchPath $pathComponent  
	      set FoundMinVersionPath 1
	    } elseif {[package vcompare $appInfo(${appletNS}::${appletName},version) $reqAppletVersion] != -1} {
	        lappend minVersionSearchPath $pathComponent  
	        set FoundMinVersionPath 1
 	    } else {
	      lappend failedPaths $pathComponent
	      set failedPathver($pathComponent) $appInfo(${appletNS}::${appletName},version)
	    }
	    puts " Found $appInfo(${appletNS}::${appletName},version)"
          }
	} else {
	  puts " BAD APPLET INSTALL"
        }
      } else {
	puts "  NONEXISTENT APPLET SERVER"
      }
    };# end first foreach loop (distilling final minimum version applet_search_path

    if {$FoundMinVersionPath} {
      foreach searchPath $minVersionSearchPath {
        set_attribute -quiet applet_search_path $searchPath /
        if {[catch {applet load $appletName} errorMsg]} {
          puts "load_applet INFO: Version check passed on applet install $appletName but applet load failed."
          if {$appletSearchPathCount > 0} {
            puts "load_applet: Trying next applet_search_path..."
          } else {
            puts "load_applet: ERROR: Failed to load applet $appletName. Please check your applet_search_path and applet installation(s)."
	    set_attribute -quiet applet_search_path $origSearchPath /
            return -code error
          }
        } else {
	  if {[catch {set providedVersion [package present ${appletNS}::$appletName]} errorMessage]} {
            puts "load_applet: ERROR: applet $appletName loaded correctly, but the applet did not correctly provide a package version. Trying next search path..."
	  } else {
            puts "load_applet: INFO: Applet $appletName $providedVersion successfully loaded from applet installation at $pathComponent, meeting min version requirement ($reqAppletVersion)"
	    set_attribute -quiet applet_search_path $origSearchPath /
	    return
	  }
        }
      }
    } else {
      switch -exact -- $severity {
        error {
          puts "load_applet ERROR: Minimum applet version for applet $appletName is $reqAppletVersion, but no applet was found meeting this requirement."
	}
        warning {
          puts "load_applet WARNING: Minimum applet version for applet $appletName is $reqAppletVersion, but no applet was found meeting this requirement."
	}
        info {
          puts "load_applet INFO: Minimum applet version for applet $appletName is $reqAppletVersion, but no applet was found meeting this requirement."
	}
      }
      puts "load_applet INFO: Search results:"
      foreach searchPath $failedPaths {
        puts "  applet_search_path: $searchPath, $appletName version found: $failedPathver($searchPath)"
      }
      puts "load_applet INFO: Note applet search path that was set:"
      puts "  $origSearchPath" 
      switch -exact -- $severity {
        error {
	  set_attribute -quiet applet_search_path $origSearchPath /
          return -code 99
        }
      }
    }
    set_attribute -quiet applet_search_path $origSearchPath /
  }
    proc system_info {} {

      global vars

      set uname [exec uname]

      if {[lsearch "Linux" $uname] != -1} {

         set inFile "$vars(script_root)/ETC/status.dat"

         if {![file exists $inFile]} {
             return
         }

         set upId [open "/proc/uptime" r]
         set info(uptime) [lindex [split [gets $upId] .] 0]
         close $upId

         foreach {var val} {mon 2592000 wks 604800 day 86400 hrs 3600 min 60 sec 1} {
           set info(uptime.${var}) [expr $info(uptime)/${val}]
           set info(uptime) [expr $info(uptime)-($info(uptime.${var})*${val})]
         }

         set info(host.fqdn) [info hostname]
         set info(host.name) [lindex [split $info(host.fqdn) .] 0]
         set info(host.domain) [string range $info(host.fqdn) [expr [string length $info(host.name)]+1] end]
         set info(host.os) $::tcl_platform(os)
         set info(host.osver) $::tcl_platform(osVersion)
         set info(host.machine) $::tcl_platform(machine)

         if {$info(host.os)=="Linux"} {
           if {[file exists /etc/slackware-version]} { set info(host.distribution) "Slackware" }
           if {[file exists /etc/redhat-release]} { set info(host.distribution) "RedHat" }
           if {[file exists /etc/mandrake-release]} { set info(host.distribution) "Mandrake" }
           if {![info exists info(host.distribution)]} { set info(host.distribution) "Unknown" }
         } else {
           return
         }

         set cpuId [open "/proc/cpuinfo" r]
         set info(cpu.total) 0
         set info(cpu.cpucores) 1
         while {![eof $cpuId]} {
           gets $cpuId ln
           set ln [split $ln :]
           set item [string trim [lindex $ln 0]]
           set value [string trim [lindex $ln 1]]
           set info(cpu.[lindex $item 0][lindex $item 1]) $value
           if {[lindex $item 0] == "processor"} {incr info(cpu.total)}
         }
         close $cpuId

         set memId [open "/proc/meminfo" r]
         set info(mem.free) 0
         while {![eof $memId]} {
           gets $memId ln
           set ln [split $ln :]
           set item [string trim [lindex $ln 0]]
           catch { set value [expr [string trim [lindex [lindex $ln 1] 0]]*1024] }
           switch -- "$item" {
             MemTotal { set info(mem.total) $value }
             SwapTotal { set info(mem.swap.total) $value }
             SwapFree { set info(mem.swap.free) $value }
             MemFree { incr info(mem.free) $value }
             Cached { incr info(mem.free) $value }
             Buffers { incr info(mem.free) $value }
           }
         }

         set parseId [open $inFile r]
         while 1 {
           gets $parseId ln
           if {[eof $parseId]} { break }
           catch { puts [subst $ln] } err
         }
         close $parseId
      }
   }


    proc get_tool {} {
     set tool_name ""
     set path_to_exe [info nameofexecutable]
     if {[regexp {/rc(64)?(-\w)?$} $path_to_exe]} {
       set tool_name "rc"
     } elseif {[regexp {/genus(64)?(-\w)?$} $path_to_exe]} {
       set tool_name "rc"
     } elseif {[regexp {.*\/(LEC|lec)} $path_to_exe]} {
       set tool_name "lec"
     } elseif {[regexp {.*\/verify} $path_to_exe]} {
       set tool_name "clp"
     } elseif {[regexp {.*\/CCD} $path_to_exe]} {
       set tool_name "ccd"
     } elseif {[regexp {.*\/ctos} $path_to_exe]} {
       set tool_name "ctos"
     } elseif {[regexp {.*\/tclsh} $path_to_exe]} {
       set tool_name "tclsh"
     } elseif {[regexp {.*\/innovus} $path_to_exe]} {
       set tool_name "edi"
     } elseif {[regexp {.*\/encounter} $path_to_exe]} {
       set tool_name "edi"
     } elseif {[regexp {.*\/velocity} $path_to_exe]} {
       set tool_name "edi"
     } elseif {[regexp {.*\/ncsim} $path_to_exe]} {
       set tool_name "ies"
     }
     return $tool_name
   }

    proc source_file {file {abort 1}} {
      global vars
      global source_error
      global errorInfo
      global return_code

      if {[file exists $file]} {
         if {[info command FF::get_tool] ne "" && [FF::get_tool] eq "rc" } {
             set sourceResult [catch { uplevel tcl_source $file } source_error ]
         } else {
             set sourceResult [catch { uplevel source $file } source_error ]
         }
         if { $sourceResult } {
            puts "<FF> =============== TCL ERROR ===================="
            puts "<FF> Error loading $file file"
            puts "<FF> $errorInfo"
            puts "<FF> $source_error"
            puts "<FF> =============================================="
            set return_code 99
            if {$abort} {
               exit $return_code
            }
         }
      }
   }

   proc load_applet {args} {
    set defAppletNS "::applet"
    set defSeverity "error"
    set defaultLocalInstall $::ns(applet)::localInstall
    set defaultLocalServer $::ns(applet)::localServer
    set reqAppletVersion ""

    switch -- [parse_options [calling_proc] {} $args \
      "-version sos required version of applet (equal or greater)" reqAppletVersion \
      "-severity sos severity (error|warning|info)" severity \
      "-namespace sos namespace to search for applet" appletNS \
      "srs name of applet" appletName] {
          -2 { return }
          0 { return -code error }
    }

    if {$appletNS eq ""} {
        set appletNS $defAppletNS
    }

    if {$severity eq ""} {
      set severity $defSeverity
    }
   
    if {![catch {set providedVersion [package present ${appletNS}::$appletName]} errorMessage]} {
      if {$reqAppletVersion ne ""} {
        if {[package vcompare $providedVersion $reqAppletVersion] == -1} {
          puts "load_applet INFO: applet $appletName was already loaded, but it's version ($providedVersion) did not meet the minimum required version ($reqAppletVersion)"
          puts "load_applet INFO: This version of the $appletName applet will be removed and the load_applet will search for a newer version of $appletName..."
          package forget ${appletNS}::$appletName
        } else {
	  puts "load_applet INFO: Found $appletName already loaded and it's version ($providedVersion) already meets the minimum required version ($reqAppletVersion). Skipping load..."
	  return
        }
      } else {
	puts "load_applet INFO: Found $appletName already loaded with version ($providedVersion). Skipping applet load..."
	return
      }
    }

    set FoundMinVersionPath 0
    set finalSearchPath "" 
    set failedPaths ""
    if {[get_tool] eq "rc"} {
      set searchPathList [get_attribute applet_search_path /]
    } else {
      set searchPathList [$::ns(compat)::get_attribute applet_search_path /]
    }
    set appletSearchPathCount [llength $searchPathList]

    set origappletSearchPathCount $appletSearchPathCount
    set origSearchPath ""
    if {$appletSearchPathCount > 1} {
      puts "load_applet INFO: Checking all applet search paths for versions of $appletName"
    }
    foreach pathComponent $searchPathList {
      incr appletSearchPathCount -1
      if {$origappletSearchPathCount > 1} {
        puts -nonewline "  $pathComponent ..."
      } else {
        puts -nonewline "load_applet INFO: Checking applet_search_path: $pathComponent ..."
      }
      if {[string match "<default>" $pathComponent]} {
        set pathComponent [$::ns(applet)::UpdateSearchPath $pathComponent]
      }
      lappend origSearchPath $pathComponent
      if {[file isdirectory $pathComponent]} {
	if {[file isfile $pathComponent/.servInfo]} {
	  if {[get_tool] eq "rc"} {
            set sourceCommand tcl_source
	  } else {
	    set sourceCommand source
	  }
	   set errorMsg ""
          array unset appInfo
	  if {[catch {$sourceCommand $pathComponent/.servInfo} errorMsg] || ![info exists appInfo(${appletNS}::${appletName},version)]} {
	    if {$errorMsg ne ""} {
	      puts " $errorMsg"
	    } else {
	      puts " BAD APPLET SERVER (corrupted .servInfo file)"
	    }
          } else {
	    if {$reqAppletVersion eq "" } {
	      lappend minVersionSearchPath $pathComponent  
	      set FoundMinVersionPath 1
	    } elseif {[package vcompare $appInfo(${appletNS}::${appletName},version) $reqAppletVersion] != -1} {
	        lappend minVersionSearchPath $pathComponent  
	        set FoundMinVersionPath 1
 	    } else {
	      lappend failedPaths $pathComponent
	      set failedPathver($pathComponent) $appInfo(${appletNS}::${appletName},version)
	    }
	    puts " Found $appInfo(${appletNS}::${appletName},version)"
          }
	} else {
	  puts " BAD APPLET INSTALL"
        }
      } else {
	puts "  NONEXISTENT APPLET SERVER"
      }
    };# end first foreach loop (distilling final minimum version applet_search_path

    if {$FoundMinVersionPath} {
      foreach searchPath $minVersionSearchPath {
        set_attribute -quiet applet_search_path $searchPath /
        if {[catch {applet load $appletName} errorMsg]} {
          puts "load_applet INFO: Version check passed on applet install $appletName but applet load failed."
          if {$appletSearchPathCount > 0} {
            puts "load_applet: Trying next applet_search_path..."
          } else {
            puts "load_applet: ERROR: Failed to load applet $appletName. Please check your applet_search_path and applet installation(s)."
	    set_attribute -quiet applet_search_path $origSearchPath /
            return -code error
          }
        } else {
	  if {[catch {set providedVersion [package present ${appletNS}::$appletName]} errorMessage]} {
            puts "load_applet: ERROR: applet $appletName loaded correctly, but the applet did not correctly provide a package version. Trying next search path..."
	  } else {
            puts "load_applet: INFO: Applet $appletName $providedVersion successfully loaded from applet installation at $pathComponent, meeting min version requirement ($reqAppletVersion)"
	    set_attribute -quiet applet_search_path $origSearchPath /
	    return
	  }
        }
      }
    } else {
      switch -exact -- $severity {
        error {
          puts "load_applet ERROR: Minimum applet version for applet $appletName is $reqAppletVersion, but no applet was found meeting this requirement."
	}
        warning {
          puts "load_applet WARNING: Minimum applet version for applet $appletName is $reqAppletVersion, but no applet was found meeting this requirement."
	}
        info {
          puts "load_applet INFO: Minimum applet version for applet $appletName is $reqAppletVersion, but no applet was found meeting this requirement."
	}
      }
      puts "load_applet INFO: Search results:"
      foreach searchPath $failedPaths {
        puts "  applet_search_path: $searchPath, $appletName version found: $failedPathver($searchPath)"
      }
      puts "load_applet INFO: Note applet search path that was set:"
      puts "  $origSearchPath" 
      switch -exact -- $severity {
        error {
	  set_attribute -quiet applet_search_path $origSearchPath /
          return -code 99
        }
      }
    }
    set_attribute -quiet applet_search_path $origSearchPath /
  }
    proc source_plug {plugin {abort 1}} {

      global vars
      global plugin_error
      global errorInfo
      global return_code

  
      if {[info exists vars($plugin)]} {
         Puts "<FF> LOADING '$plugin' PLUG-IN FILE(s) "
         foreach plugin $vars($plugin) {
            if {[file exists $plugin]} {
               Puts "<FF> -> $plugin"
               if { [ catch { uplevel source $plugin } plugin_error ] } {
                  Puts "<FF> ============= PLUG-IN ERROR =================="
                  Puts "<FF> $errorInfo"
                  Puts "<FF> $plugin_error"
                  Puts "<FF> =============================================="
                  set return_code 99
                  if {[info exists vars(mail,to)]} {
                     set msg "From: [exec whoami] "
                     append msg \n "To: " [join $vars(mail,to) ,]
                     append msg \n "Cc: " [join "" ,]
                     append msg \n "Subject: " "FF: $vars(design), $vars(step) failed ([pwd])"
                     append msg \n\n $errorInfo
                     exec /usr/lib/sendmail -oi -t << $msg
                  }

                  if {$abort} {
                     exit $return_code
                  }
               }
            } else {
               if {[file exists $vars(plug_dir)/$plugin]} {
                  Puts "<FF> -> $vars(plug_dir)/$plugin"
                  if { [ catch { uplevel source $vars(plug_dir)/$plugin } plugin_error ] } {
                     if {[info exists vars(mail,to)]} {
                        set msg "From: [exec whoami] "
                        append msg \n "To: " [join $vars(mail,to) ,]
                        append msg \n "Cc: " [join "" ,]
                        append msg \n "Subject: " "FF: $vars(design), $vars(step) failed ([pwd])"
                        append msg \n\n $errorInfo
                        exec /usr/lib/sendmail -oi -t << $msg
                     }
                     set return_code 99
                     if {$abort} {
                        exit $return_code
                     }
                  }
               }
            }
         }
      }
   }
}

