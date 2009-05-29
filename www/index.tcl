ad_page_contract {

    A place holder for access to the admin pages.

    @author Bart Teeuwisse <bart.teeuwisse@7-sisters.com>
    @cvs-id $Id$
    @creation-date Oct 2002

} {
} -properties {
    title:onevalue
    context:onevalue
}

# Authenticate the user

set user_id [ad_maybe_redirect_for_registration]

# Check for admin privileges

set package_id [ad_conn package_id]
set admin_p [ad_permission_p $package_id admin]

# Get the name of the package

if {[db_0or1row get_package_name ""]} {
    set title "$instance_name"
} else {
    set title "Cronjob"
}

# Set the context bar.

set context [list]
