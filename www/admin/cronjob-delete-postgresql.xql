<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.1</version></rdbms>

  <fullquery name="edit_cronjob">      
    <querytext>
      select [qd_write_query_select cronjob__delete {
      cronjob_id => :cronjob_id } ]
    </querytext>
  </fullquery>

  
</queryset>
