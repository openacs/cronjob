<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.1</version></rdbms>

  <fullquery name="add_cronjob">      
    <querytext>
      select [qd_write_query_select cronjob__new {
      user_id => :user_id
      description => :description
      approved_p => :approved_p
      disabled_p => :disabled_p
      minute => :minute
      hr => :hr
      mon => :mon
      day => :day
      dayofweek => :dayofweek
      run_sql => :run_sql
      run_tcl => :run_tcl
      email => :email } ]

    </querytext>
  </fullquery>
 
</queryset>
