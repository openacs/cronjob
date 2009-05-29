<master>
<property name="title">@page_title@</property>
<property name="context">@context@</property>

<h3>@page_title@</h3>

<a href="cronjob-delete?cronjob_id=@cronjob_id@">Delete this cronjob</a>

<form action="cronjob-edit" method="post">
<input type="hidden" name="cronjob_id" value="@cronjob_id@">
<table cellspacing="0" cellpadding="2" border="1">
 <tr>
  <th align="left">Description</th>
  <td>
<textarea cols="60" rows="4" name="description" wrap="absolute">@description@</textarea>
  <td>
 </tr>
 <tr><th align="left">Enabled</th>
 <td><select name="disabled_p">
   <option value="f" <if @disabled_p@ eq f>selected</if>>Enabled</option>
    <option value="t" <if @disabled_p@ eq t>selected</if>>Disabled</option>
   </select></td>
 </tr>
 <tr><th align="left">Approved</th>
 <td><select name="approved_p">
   <option value="t" <if @approved_p@ eq t>selected</if>>Approved</option>
    <option value="f" <if @approved_p@ eq f>selected</if>>Not Approved</option>
   </select></td>
 </tr>

 <tr>
  <th align="left">Minute (0-59)</th>
  <td>
<select name="minute">
@minute_option;noquote@                          
</select><td></tr>

 <tr>
  <th align="left">Hour (0-23)</th><td>
<select name="hr">
@hour_option;noquote@                          
</select><td></tr>

 <tr>
  <th align="left">Month (1-12)</th><td>
<select name="mon">
@month_option;noquote@                          
</select><td></tr>

 <tr>
  <th align="left">Day (1-31)</th><td>
<select name="day">
@day_option;noquote@                          
</select><td></tr>

 <tr>
  <th align="left">Day of Week</th><td>
<select name="dayofweek">
@dayofweek_option;noquote@                          
</select><td></tr>

 <tr>
  <th align="left">SQL to Run</th>
  <td>
<textarea cols="80" rows="10" name="run_sql" wrap="absolute">@run_sql@</textarea>
  <td></tr>

 <tr>
  <th align="left">Tcl Code to Run</th>
  <td>
<textarea cols="60" rows="4" name="run_tcl" wrap="absolute">@run_tcl@</textarea>
  <td></tr>

 <tr>
  <th align="left">Email Address</th>
  <td><input type="text" name="email" value="@email@" size="60">
  <td></tr>

 <tr>
  <th colspan="2"><input type="submit" value="Update Cronjob"></th>
 </tr>
</table>

</form>

<a href="cronjob-run-now?cronjob_id=@cronjob_id@">Run This CronJob Now</a>
