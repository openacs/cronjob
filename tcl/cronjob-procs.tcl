ad_library { 
    Cronjog support procs

    @author Tom Jackson <tom@zmbh.com>
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
    set table "No SQL"
    ns_log Debug "cronjob_run: Cronjob_id is $cronjob_id"
    db_1row cronjob_query {}
    db_release_unused_handles
    if {![string match "" $run_sql]} {
	set table "<table cellspacing=0 cellpadding=2 border=1>"
	set db [ns_db gethandle "log"]
	set sel [ns_db select $db $run_sql]
	set rownum 0
	if {![string match "" $sel]} {
	    while {[ns_db getrow $db $sel]} {
		set size [ns_set size $sel]
		if {$rownum == 0} {
		    for {set i 0 } {$i < $size} {incr i} {
			append table "\n<th>[ns_set key $sel $i]</th>"		
		    }
		}
		append table "<tr>"
		for {set i 0 } {$i < $size} {incr i} {
		    append table "\n<td>[ns_set value $sel $i]</td>"
		}
		append table "</tr>"
		incr rownum
	    }
	}
	append table "</table>"
	if {$rownum == 0} {
	    set table "No Rows Returned"
	}
	ns_db releasehandle $db
    }

    # evaluate the run_tcl code
    eval $run_tcl

    if {![string match "" $email]} {
	ns_log Debug "cronjob_run: sending cronjob email to $email"
	set headers [ns_set create]
	ns_set put $headers "Content-Type" "text/html"
	ns_sendmail $email  [ad_host_administrator] "Cronjob $cronjob_id" "Description: <br>$description<br> $table" $headers
    }
    return

}
