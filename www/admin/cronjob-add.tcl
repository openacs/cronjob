ad_page_contract {
   
    Cronjobs Add Page 2
		@author: tom@zmbh.com
		@creation-date: 22 Sept 2001
		@cvs-id: $Id$

} {

		description:trim,notnull,html
		minute:notnull,trim
    hr:notnull,trim
    mon:notnull,trim
    day:notnull,trim
    dayofweek:notnull,trim
    run_sql:trim
    run_tcl:trim
    email:trim,email

}

set user_id [ad_maybe_redirect_for_registration]

set approved_p "t"
set disabled_p "f"


db_exec_plsql add_cronjob {
 
   declare
	 v_cronjob_id integer;
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
      email => :email
			);
	 end;
}

ad_returnredirect cronjobs