ad_page_contract {
    
    Cronjobs List and Add Page

    @author tom@zmbh.com
    @creation-date 22 Sept 2001
    @cvs-id $Id$

} -properties {  

    page_title:onevalue
    context:onevalue
    hour_option:onevalue
    minute_option:onevalue
    month_option:onevalue
    day_option:onevalue
    dayofweek_option:onevalue
}

set page_title "Cronjobs List and Add Page"

set context [list "Cronjobs"]

set hour_option ""
set minute_option ""
set month_option ""
set day_option ""
set dayofweek_option ""

foreach {value name} [list 01 January 02 February 03 March 04 April 05 May 06 June 07 July 08 August 09 September 10 October 11 November 12 December] {
    append month_option "
<option value=\"$value\">$name</option>"
}

foreach {value name} [list 0 Sunday 1 Monday 2 Tuesday 3 Wednesday 4 Thursday 5 Friday 6 Saturday] {
    append dayofweek_option "
<option value=\"$value\">$name</option>"
}

for {set i 1} {$i < 32} {incr i} {
    append day_option "
<option value=\"[format %-2.2d $i]\">$i</option>"
}

for {set i 0} {$i < 24} {incr i} {
    append hour_option "
<option value=\"[format %-2.2d $i]\">$i</option>"

}

append minute_option $hour_option
for {} {$i < 60} {incr i} {
    append minute_option "
<option value=\"[format %-2.2d $i]\">$i</option>"

}

db_multirow cronjobs cronjobs_query ""

ad_return_template
