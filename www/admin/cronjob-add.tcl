ad_page_contract {
    
    Cronjobs Add Page 2
    @author tom@junom.com
    @creation-date 22 Sept 2001
    @cvs-id $Id$

} {

    description:trim,notnull,html
    minute:notnull,trim
    hr:notnull,trim
    mon:notnull,trim
    day:notnull,trim
    dayofweek:notnull,trim
    run_sql:trim,allhtml
    run_tcl:trim,html
    email:trim

}

set user_id [ad_maybe_redirect_for_registration]

set approved_p "f"
set disabled_p "t"


db_exec_plsql add_cronjob {}

ad_returnredirect cronjobs
