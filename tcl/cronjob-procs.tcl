# Procs for cronjog package

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

		set sql "
select 
 cronjob_id
from
 cronjobs
where 
 disabled_p = 'f' AND
 approved_p = 't' AND
 ((minute = :minute) OR (minute = '*')) AND
 ((hr = :hr ) OR (hr = '*')) AND
 ((mon = :mon ) OR (mon = '*')) AND
 ((day = :day ) OR (day = '*')) AND
 ((dayofweek = :dayofweek ) OR (dayofweek = '*'))"
	
		db_foreach cronjob_sched_foreach $sql {

				ad_schedule_proc -once t -thread t 1 cronjob_run $cronjob_id
		}

}


ad_proc cronjob_run { cronjob_id } { 

		Proc to run cronjobs 

} {
		set table "No SQL"
		set sql "
select 
 description,
 run_sql,
 run_tcl,
 email
from
 cronjobs
where 
 cronjob_id = :cronjob_id"
		ns_log Notice "Cronjob_id is $cronjob_id"
		db_1row "crontab_query" $sql
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
				ns_log notice "sending cronjob email to $email"
				set headers [ns_set create]
				ns_set put $headers "Content-Type" "text/html"
				ns_sendmail $email "negeen@zmbh.com" "Cronjob $cronjob_id" "Description: <br>$description<br> $table" $headers
		}
		return

}
