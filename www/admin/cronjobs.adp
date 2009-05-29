<master>
<property name="title">@page_title@</property>
<property name="context">@context@</property>

<h3>@page_title@</h3>

<if @cronjobs:rowcount@ eq 0> 
No jobs present.
</if>
<else>
<table cellspacing="0" cellpadding="2" border="1">
 <tr>
  <th>Cronjob</th>
  <th>Schedule</th>
  <th>Approved</th>
  <th>Enabled</th>
  <th width="300">Description</th>
 </tr>
 <multiple name="cronjobs">
 <tr>
  <td><a href="cronjob?cronjob_id=@cronjobs.cronjob_id@">
      @cronjobs.cronjob_id@ :: @cronjobs.user_id@ </a></td>
  <td>@cronjobs.minute@ 
@cronjobs.hr@ 
@cronjobs.mon@ 
@cronjobs.day@ 
@cronjobs.dayofweek@ </td>
 <td><if @cronjobs.approved_p@ eq t>Approved</if><else>Not Approved</else></td>
 <td><if @cronjobs.disabled_p@ eq t>Disabled</if><else>Enabled</else></td>
 <td>@cronjobs.description@</td></tr>
</multiple>

</table>
</else>
<h3>Add New Cronjob</h3>

<form action="cronjob-add" method="post">
<table cellspacing="0" cellpadding="2" border="1">
 <tr>
  <th align="left">Description</th>
  <td>
<textarea cols="60" rows="4" name="description" wrap="absolute"></textarea>
  <td></tr>

 <tr>
  <th align="left">Minute (0-59)</th>
  <td>
<select name="minute">
<option value="*">Every Minute</option>@minute_option;noquote@                          
</select><td></tr>

 <tr>
  <th align="left">Hour (0-23)</th><td>
<select name="hr">
<option value="*">Every Hour</option>@hour_option;noquote@                          
</select><td></tr>

 <tr>
  <th align="left">Month (1-12)</th><td>
<select name="mon">
<option value="*">Every Month</option>@month_option;noquote@                          
</select><td></tr>

 <tr>
  <th align="left">Day (1-31)</th><td>
<select name="day">
<option value="*">Every Day</option>@day_option;noquote@                          
</select><td></tr>

 <tr>
  <th align="left">Day of Week</th><td>
<select name="dayofweek">
<option value="*">Every Day of Week</option>@dayofweek_option;noquote@                          
</select><td></tr>

 <tr>
  <th align="left">SQL to Run</th>
  <td>
<textarea cols="60" rows="4" name="run_sql" wrap="absolute"></textarea>
  <td></tr>

 <tr>
  <th align="left">Tcl Code to Run</th>
  <td>
<textarea cols="60" rows="4" name="run_tcl" wrap="absolute"></textarea>
  <td></tr>

 <tr>
  <th align="left">Email Address</th>
  <td><input type="text" name="email" value="" size="60">
  <td></tr>

 <tr>
  <th colspan="2"><input type="submit" value="Enter Cronjob"></th>
 </tr>
</table>

</form>
