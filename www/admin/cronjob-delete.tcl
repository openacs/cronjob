ad_page_contract {
    
    Cronjob Delete

    @author tom@zmbh.com
    @creation-date 22 Sept 2001
    @cvs-id $Id$

} {
    cronjob_id:integer,trim,notnull

}

db_exec_plsql edit_cronjob {
    
    begin
      cronjob.del(cronjob_id => :cronjob_id);
    end;
}

ad_returnredirect cronjobs
