ad_library { 
    Cronjob support procs

    @author Tom Jackson <tom@junom.com>
    @creation-date 22 Sept 2001

    @cvs-id $Id$
}

ad_proc cronjob_check { } {

    Checks the database for cronjobs that need to run

} {

    # setup the vars
    set time      [ns_time]
    set minute    [ns_fmttime $time %M]
    set hr        [ns_fmttime $time %H]
    set mon       [ns_fmttime $time %m]
    set day       [ns_fmttime $time %d]
    set dayofweek [ns_fmttime $time %w]

    db_foreach cronjob_sched_foreach "" {
        ad_schedule_proc -once t -thread t 1 cronjob_run $cronjob_id
    }

}


ad_proc cronjob_run { cronjob_id } { 

    Proc to run cronjobs 

} {
    # To avoid errors
    set rownum 0
    
    
    set table "No SQL"
    ns_log Debug "Cronjob_id is $cronjob_id $rownum"
    db_1row cronjob_query {}
    db_release_unused_handles
    if {![string match "" $run_sql]} {
        set rownum 0
        set table "<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\">"
        db_foreach cronjob_run_sql $run_sql -column_set row {

            set size [ns_set size $row]
            if {$rownum == 0} {
                for {set i 0 } {$i < $size} {incr i} {
                    append table "\n<th>[ns_set key $row $i]</th>"      
                }
            }
            append table "<tr>"
            for {set i 0 } {$i < $size} {incr i} {
                append table "\n<td>[ns_set value $row $i]</td>"
            }
            append table "</tr>"
            incr rownum
        }
    }
    append table "</table>"
    if {$rownum == 0} {
        set table "No Rows Returned"
    }


    # evaluate the run_tcl code
    eval $run_tcl

    if {![string match "" $email]} {
        ns_log Debug "sending cronjob email to $email"
        acs_mail_lite::send -to_addr $email -from_addr [ad_host_administrator] \
	    -subject "Cronjob $cronjob_id" \
	    -body "Description: <br>$description<br> $table" \
	    -extraheaders [list [list "Content-Type" "text/html"]]
    }
    return

}
