<?xml version="1.0"?>

<queryset>

  <fullquery name="cronjob_check.cronjob_sched_foreach">
    <querytext>
      select cronjob_id
      from cronjobs
      where disabled_p = 'f' 
      and approved_p = 't' 
      and ((minute = :minute) or (minute = '*')) 
      and ((hr = :hr ) or (hr = '*')) 
      and ((mon = :mon ) or (mon = '*')) 
      and ((day = :day ) or (day = '*'))
      and ((dayofweek = :dayofweek ) or (dayofweek = '*'))
    </querytext>
  </fullquery>

  <fullquery name="cronjob_run.cronjob_query">
    <querytext>
      select description, run_sql, run_tcl, email
      from cronjobs
      where cronjob_id = :cronjob_id
    </querytext>
  </fullquery>

</queryset>
