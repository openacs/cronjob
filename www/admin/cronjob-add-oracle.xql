<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="add_cronjob">      
    <querytext>
      declare v_cronjob_id integer;
      begin
        v_cronjob_id := cronjob.new(
        user_id => :user_id,
        description => :description,
        approved_p => :approved_p,
        disabled_p => :disabled_p,
        minute => :minute,
        hr => :hr,
        mon => :mon,
        day => :day,
        dayofweek => :dayofweek,
        run_sql => :run_sql,
        run_tcl => :run_tcl,
        email => :email);
      end;
    </querytext>
  </fullquery>
  
</queryset>
