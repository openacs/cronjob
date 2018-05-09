ad_library {

    Initializes cronjob package

    @creation-date 22 Sept 2001
    @author Tom Jackson <tom@zmbh.com>
    @cvs-id $Id$
}


ad_schedule_proc -thread t 60 cronjob_check 

if {![info exists qd_write_query_select]} {
    
    ad_proc qd_write_query_select {package attrs} { 

        <p>Returns Postgresql function with:
        <ul>
        <li>correctly  ordered attributes
        <li>defaults filled in for un-supplied attributes.
        </ul>

    } {   
        ns_log Debug "Running qd_write_query_select with $package $attrs"
        set query [list]
        set in_args [list]
        set args [concat $attrs]
        foreach {attr sign value} $args {
            lappend in_args $attr
            set attr_array($attr) $value
        }
        set attrs_and_defaults [eval qd_choose_function $package $in_args]
        foreach {attr default_value} $attrs_and_defaults {
            # see if attr was passed in with value
            if {![info exists attr_array($attr)]} {
                
                if {[string match "" $default_value]} {
                    ns_log Debug "Attempt to call $package with no value for $attr"
                    return -code error 
                }
                lappend query $default_value
            } else {
                lappend query "$attr_array($attr)"
            } 
        }
        ns_log Debug "${package}([join $query ",\n"]);"
        return "${package}([join $query ",\n"]);" 
    } 


    ad_proc qd_add_package {package args} {
        <p>Adds a package with all the attributes for every function of the same name.
        <p>For example, if you have two functions that could be called 
        <code>foo(a,b,c)</code> and <code>foo(a,c,d)</code>,
        the package would be registered using:
        <blockquote>
        <pre>
        qd_add_package foo a b c d
        </pre>
        </blockquote>

    } {
        nsv_set qd_pg_packages $package $args
        set n 1
        foreach attr $args {
            nsv_set $package $attr $n
            set n [expr $n * 2]
        }
    }

    ad_proc qd_total_attributes {package attributes} {

        <p>Totals the attribute values.
    } {

        upvar $package package_array
        upvar $attributes attrs
        set total 0
        foreach attribute $attrs {
            incr total $package_array($attribute)
            ns_log Debug "Adding $package_array($attribute) $total"
        }
        return $total
    }

    ad_proc qd_add_function {package args} {

        <p>Adds a single function, including defaults to a package.
        <p>If one foo function has three attributes: a, b and c, where 
        a is required and b can be null and c default to 't',
        the function would be 
        registered using:
        <blockquote>
        <pre>
        qd_add_function foo a "" b "null" c "'t'"
        </pre>
        </blockquote>

    } {
        

        # total up the function value.
        array set temp_package [nsv_array get $package]
        set i 1
        foreach {attr default} $args {
            lappend attr_list $attr
        }
        set total [qd_total_attributes temp_package attr_list]
        nsv_set ${package}_functions $total $args

    }

    ad_proc qd_choose_function {package args} {

        <p>Used to choose a function based on passed in attributes.

    } {
        
        array set temp_package [nsv_array get $package]
        set total [qd_total_attributes temp_package args]
        if {[nsv_exists ${package}_functions $total]} {
            ns_log Debug "Found matching sig: '$total'"
            return [nsv_get ${package}_functions $total]
        }
        set functions [nsv_array names ${package}_functions]
        foreach sig $functions {
            ns_log Debug "checking sig '$total' against '$sig'"
            if {$total == [expr $sig & $total]} {
                ns_log Debug "Found match '$total' in '$sig'"
                return [nsv_get ${package}_functions $sig]
            }
        }
        return "!NO MATCH: $total not in $functions"
    }

    proc qd_write_query {package args} {
        
        set query [list]
        set attrs_and_defaults [eval qd_choose_function $package $args]
        foreach {attr default_value} $attrs_and_defaults {
            if {[lsearch $args $attr] < 0 } {
                if {[string match "" $default_value]} {
                    ns_log Debug "Attempt to call $package with no value for $attr"
                    return -code error 
                }
                lappend query $default_value
            } else {
                lappend query ":${attr}"
            } 
        }
        return [join $query ",\n"]
    } 

    proc qd_write_query_upvar {package listvar} {
        
        set query [list]
        upvar $listvar args
        set attrs_and_defaults [eval qd_choose_function $package $args]
        if {[string match "!NO MATCH:*" $attrs_and_defaults ]} {
            ns_log Debug "$attrs_and_defaults"
            return -code error
        }
        foreach {attr default_value} $attrs_and_defaults {
            if {[lsearch $args $attr] < 0 } {
                if {[string match "" $default_value]} {
                    ns_log Debug "Attempt to call $package with no value for $attr"
                    return -code error 
                }
                lappend query $default_value
            } else {
                lappend query ":${attr}"
            } 
        }
        return [join $query ",\n"]
    } 

}

qd_add_package cronjob__new cronjob_id user_id description approved_p disabled_p minute hr mon day dayofweek run_sql run_tcl email creation_user creation_ip context_id
qd_add_function cronjob__new "cronjob_id" "null" "user_id" "" "description" "" "approved_p" "'f'" "disabled_p" "'f'" "minute" "'0'" "hr" "'0'" "mon" "'0'" "day" "'0'" "dayofweek" "'0'" "run_sql" "" "run_tcl" "" "email" "" "creation_user" "null" "creation_ip" "null" "context_id" "null" 

qd_add_package cronjob__set_attrs "cronjob_id" "user_id" "description" "approved_p" "disabled_p" "minute" "hr" "mon" "day" "dayofweek" "run_sql" "run_tcl" "email"
qd_add_function cronjob__set_attrs "cronjob_id" "" "user_id" "null" "description" "null" "approved_p" "null" "disabled_p" "'f'" "minute" "null" "hr" "null" "mon" "null" "day" "null" "dayofweek" "null" "run_sql" "null" "run_tcl" "null" "email" "null"

qd_add_package cronjob__delete cronjob_id
qd_add_function cronjob__delete cronjob_id ""
