ad_page_contract {
   
    Cronjobs Edit Page 2

    @author tom@zmbh.com
    @creation-date 22 Sept 2001
    @cvs-id $Id$

} {
    cronjob_id:integer,trim,notnull
    {description:trim,html ""}
    {minute:trim ""}
    {hr:trim ""}
    {mon:trim ""}
    {day:trim ""}
    {dayofweek:trim ""}
    {run_sql:trim ""}
    {run_tcl:trim ""}
    {email:trim,email ""}
    {approved_p:trim ""}
    {disabled_p:trim ""}
}

db_exec_plsql edit_cronjob {
 
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
}

ad_returnredirect cronjobs
