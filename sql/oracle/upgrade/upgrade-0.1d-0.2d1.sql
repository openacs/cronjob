--
-- Cronjob in sql
-- @author tom jackson <tom@zmbh.com>
-- @creation-date 22 Sept 2001
-- @cvs-id $Id$
--

create or replace package cronjob
as
    function cronjob_p (
      cronjob_id  in cronjobs.cronjob_id%TYPE
    ) return char;

    function new ( 
      cronjob_id  in cronjobs.cronjob_id%TYPE default null,
      user_id  in cronjobs.user_id%TYPE,
      description  in cronjobs.description%TYPE,
      approved_p  in cronjobs.approved_p%TYPE default 'f',
      disabled_p  in cronjobs.disabled_p%TYPE,
      minute  in cronjobs.minute%TYPE default '0',
      hr  in cronjobs.hr%TYPE default '0',
      mon  in cronjobs.mon%TYPE default '0',
      day  in cronjobs.day%TYPE default '0',
      dayofweek  in cronjobs.dayofweek%TYPE default '0',
      run_sql  in cronjobs.run_sql%TYPE default null,
      run_tcl  in cronjobs.run_tcl%TYPE default null,
      email  in cronjobs.email%TYPE default null,
      object_type  in acs_objects.object_type%TYPE default 'cronjob',
      creation_date  in acs_objects.creation_date%TYPE default sysdate,
      creation_user  in acs_objects.creation_user%TYPE default null,
      creation_ip  in acs_objects.creation_ip%TYPE default null,
      context_id  in acs_objects.context_id%TYPE default null
    ) return cronjobs.cronjob_id%TYPE;

    procedure del (
      cronjob_id  in cronjobs.cronjob_id%TYPE
    );
    procedure set_attrs ( 
      cronjob_id in cronjobs.cronjob_id%TYPE,
      user_id in cronjobs.user_id%TYPE default null,
      description in cronjobs.description%TYPE default null,
      approved_p in cronjobs.approved_p%TYPE default null,
      disabled_p in cronjobs.disabled_p%TYPE default null,
      minute in cronjobs.minute%TYPE default null,
      hr in cronjobs.hr%TYPE default null,
      mon in cronjobs.mon%TYPE default null,
      day in cronjobs.day%TYPE default null,
      dayofweek in cronjobs.dayofweek%TYPE default null,
      run_sql in cronjobs.run_sql%TYPE default null,
      run_tcl in cronjobs.run_tcl%TYPE default null,
      email in cronjobs.email%TYPE default null
    );
    procedure reset_attr ( 
      cronjob_id in cronjobs.cronjob_id%TYPE,
      column_name in varchar
    );
end cronjob;
/
show errors;

create or replace package body cronjob
as
    function cronjob_p (
      cronjob_id  in cronjobs.cronjob_id%TYPE
    ) return char
    is
    -- declare vars here
      v_check_cronjob_id integer;
    begin
      select count(cronjob_id) into v_check_cronjob_id
          from cronjobs
          where cronjob_id = cronjob_p.cronjob_id;
      if v_check_cronjob_id = 1 then
          return 't';
      else
          return 'f';
      end if;
    end cronjob_p;

    -- Context ID May need adjustment to reflect security/access model.
    function new ( 
      cronjob_id  in cronjobs.cronjob_id%TYPE default null,
      user_id  in cronjobs.user_id%TYPE,
      description  in cronjobs.description%TYPE,
      approved_p  in cronjobs.approved_p%TYPE default 'f',
      disabled_p  in cronjobs.disabled_p%TYPE,
      minute  in cronjobs.minute%TYPE default '0',
      hr  in cronjobs.hr%TYPE default '0',
      mon  in cronjobs.mon%TYPE default '0',
      day  in cronjobs.day%TYPE default '0',
      dayofweek  in cronjobs.dayofweek%TYPE default '0',
      run_sql  in cronjobs.run_sql%TYPE default null,
      run_tcl  in cronjobs.run_tcl%TYPE default null,
      email  in cronjobs.email%TYPE default null,
      object_type  in acs_objects.object_type%TYPE default 'cronjob',
      creation_date  in acs_objects.creation_date%TYPE default sysdate,
      creation_user  in acs_objects.creation_user%TYPE default null,
      creation_ip  in acs_objects.creation_ip%TYPE default null,
      context_id  in acs_objects.context_id%TYPE default null
    ) return cronjobs.cronjob_id%TYPE
    is
      v_cronjob_id integer;
    begin
      v_cronjob_id := acs_object.new (
      object_id => cronjob_id,
      object_type => object_type,
      creation_date => creation_date,
      creation_user => creation_user,
      creation_ip => creation_ip,
      context_id => context_id
    );

    insert into cronjobs
      ( cronjob_id, user_id, description, approved_p, disabled_p, minute, hr, mon, day, dayofweek, run_sql, run_tcl, email )
    values
      ( v_cronjob_id, user_id, description, approved_p, disabled_p, minute, hr, mon, day, dayofweek, run_sql, run_tcl, email );

    return v_cronjob_id;
  end new;

  procedure del (
    cronjob_id  in cronjobs.cronjob_id%TYPE
  )
  is
  begin
    if cronjob_p(cronjob.del.cronjob_id) = 'f' then
       return;
    end if;

    delete from cronjobs
    where cronjob_id = cronjob.del.cronjob_id;

    acs_object.del(cronjob_id);
  end del;

  procedure set_attrs ( 
     cronjob_id in cronjobs.cronjob_id%TYPE,
     user_id in cronjobs.user_id%TYPE default null,
     description in cronjobs.description%TYPE default null,
     approved_p in cronjobs.approved_p%TYPE default null,
     disabled_p in cronjobs.disabled_p%TYPE default null,
     minute in cronjobs.minute%TYPE default null,
     hr in cronjobs.hr%TYPE default null,
     mon in cronjobs.mon%TYPE default null,
     day in cronjobs.day%TYPE default null,
     dayofweek in cronjobs.dayofweek%TYPE default null,
     run_sql in cronjobs.run_sql%TYPE default null,
     run_tcl in cronjobs.run_tcl%TYPE default null,
     email in cronjobs.email%TYPE default null
  )
  is
    -- declared vars here
  begin
    if cronjob_p(cronjob.set_attrs.cronjob_id) = 'f' then
      return;
    end if;

  -- modify parts that are not null

    if user_id is not null then
        update cronjobs set user_id = set_attrs.user_id
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if description is not null then
        update cronjobs set description = set_attrs.description
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if approved_p is not null then
        update cronjobs set approved_p = set_attrs.approved_p
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if disabled_p is not null then
        update cronjobs set disabled_p = set_attrs.disabled_p
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if minute is not null then
        update cronjobs set minute = set_attrs.minute
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if hr is not null then
        update cronjobs set hr = set_attrs.hr
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if mon is not null then
        update cronjobs set mon = set_attrs.mon
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if day is not null then
        update cronjobs set day = set_attrs.day
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if dayofweek is not null then
        update cronjobs set dayofweek = set_attrs.dayofweek
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if run_sql is not null then
        update cronjobs set run_sql = set_attrs.run_sql
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if run_tcl is not null then
        update cronjobs set run_tcl = set_attrs.run_tcl
          where cronjob_id = set_attrs.cronjob_id;
    end if;
    if email is not null then
        update cronjobs set email = set_attrs.email
          where cronjob_id = set_attrs.cronjob_id;
    end if;

  end set_attrs;
  procedure reset_attr ( 
    cronjob_id in cronjobs.cronjob_id%TYPE,
    column_name in varchar
  )
  is 
    -- declared vars here
  begin
    if cronjob_p(cronjob.reset_attr.cronjob_id) = 'f' then
      return;
    end if;
  
    if column_name = 'approved_p' then
       update cronjobs set approved_p = 'f'
       where cronjob_id = reset_attr.cronjob_id;
    end if;
    if column_name = 'minute' then
       update cronjobs set minute = '0'
       where cronjob_id = reset_attr.cronjob_id;
    end if;
    if column_name = 'hr' then
       update cronjobs set hr = '0'
       where cronjob_id = reset_attr.cronjob_id;
    end if;
    if column_name = 'mon' then
       update cronjobs set mon = '0'
       where cronjob_id = reset_attr.cronjob_id;
    end if;
    if column_name = 'day' then
       update cronjobs set day = '0'
       where cronjob_id = reset_attr.cronjob_id;
    end if;
    if column_name = 'dayofweek' then
       update cronjobs set dayofweek = '0'
       where cronjob_id = reset_attr.cronjob_id;
    end if;
    if column_name = 'run_sql' then
       update cronjobs set run_sql = NULL
       where cronjob_id = reset_attr.cronjob_id;
    end if;
    if column_name = 'run_tcl' then
       update cronjobs set run_tcl = NULL
       where cronjob_id = reset_attr.cronjob_id;
    end if;
    if column_name = 'email' then
       update cronjobs set email = NULL
       where cronjob_id = reset_attr.cronjob_id;
    end if;

  end reset_attr;

end cronjob;
/
show errors;
