ad_page_contract {
   
    Run Cronjob
		@author: tom@zmbh.com
		@creation-date: 22 Sept 2001
		@cvs-id: $Id$

} {
    cronjob_id:integer,trim,notnull

}

ns_schedule_proc -once -thread 1 cronjob_run $cronjob_id

ad_returnredirect cronjobs