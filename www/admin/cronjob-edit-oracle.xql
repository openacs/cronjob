<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="edit_cronjob">      
    <querytext>
      begin
        cronjob.set_attrs(
          cronjob_id => :cronjob_id,
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
