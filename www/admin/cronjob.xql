<?xml version="1.0"?>
<queryset>

  <fullquery name="cronjob_query">      
    <querytext>
      select *
      from cronjobs
      where cronjob_id = :cronjob_id
    </querytext>
  </fullquery>
  
</queryset>
