<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="edit_cronjob">      
    <querytext>
      begin
        cronjob.del(cronjob_id => :cronjob_id);
      end;
    </querytext>
  </fullquery>

</queryset>
