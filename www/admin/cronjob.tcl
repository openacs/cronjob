ad_page_contract {
    
    Cronjobs List and Add Page
    @author tom@junom.com
    @creation-date 22 Sept 2001
    @cvs-id $Id$
} {
    cronjob_id:integer,notnull

} -properties {  

    page_title:onevalue
    context:onevalue
    hour_option:onevalue
    minute_option:onevalue
    month_option:onevalue
    day_option:onevalue
    dayofweek_option:onevalue
}

set page_title "One Cronjob"

set context [list [list "cronjobs" Cronjobs ] "One Cronjob"]

set hour_option ""
set minute_option ""
set month_option ""
set day_option ""
set dayofweek_option ""

db_1row cronjob_query ""

set dayofweek [string trim $dayofweek]

foreach {value name} [list "\*" "Every Month" 01 January 02 February 03 March 04 April 05 May 06 June 07 July 08 August 09 September 10 October 11 November 12 December] {
    if {[string match $mon $value]} {
        append month_option "
<option value=\"$value\" selected >$name</option>"
    } else {
        append month_option "
<option value=\"$value\">$name</option>"
    }
}

foreach {value name} [list "\*" "Every Day of Week" 0 Sunday 1 Monday 2 Tuesday 3 Wednesday 4 Thursday 5 Friday 6 Saturday] {
    if {"$dayofweek" eq "$value"} {
        append dayofweek_option "
<option value=\"$value\" selected >$name</option>"
    } else {
        append dayofweek_option "
<option value=\"$value\">$name</option>"

    }
}

foreach {value name} [list "\*" "Every Day" 01 1 02 2 03 3 04 4 05 5 06 6 07 7 08 8 09 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 18 18 19 19 20 20 21 21 22 22 23 23 24 24 25 25 26 26 27 27 28 28 29 29 30 30 31 31] {
    if {[string match $day $value]} {   
        append day_option "
<option value=\"$value\" selected >$name</option>"
    } else {
        append day_option "
<option value=\"$value\">$name</option>"
        
    }
}

foreach {value name} [list "\*" "Every Hour" 00 0 01 1 02 2 03 3 04 4 05 5 06 6 07 7 08 8 09 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 18 18 19 19 20 20 21 21 22 22 23 23] {
    if {[string match $hr $value]} {    
        append hour_option "
<option value=\"$value\" selected >$name</option>"
    } else {
        append hour_option "
<option value=\"$value\">$name</option>"
        
    }
}

foreach {value name} [list "\*" "Every Minute" \
                          00 0 01 1 02 2 03 3 04 4 05 5 06 6 07 7 08 8 09 9 10 10\
                          11 11 12 12 13 13 14 14 15 15 16 16 17 17 18 18 19 19 20 20\
                          21 21 22 22 23 23 24 24 25 25 26 26 27 27 28 28 29 29 30 30\
                          31 31 32 32 33 33 34 34 35 35 36 36 37 37 38 38 39 39 40 40\
                          41 41 42 42 43 43 44 44 45 45 46 46 47 47 48 48 49 49 50 50\
                          51 51 52 52 53 53 54 54 55 55 56 56 57 57 58 58 59 59 ] {
    if {[string match $minute $value]} {    
        append minute_option "
<option value=\"$value\" selected >$name</option>"
    } else {
        append minute_option "
<option value=\"$value\">$name</option>"
        
    }
}

ad_return_template
