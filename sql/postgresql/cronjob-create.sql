--
-- Cronjob in sql
-- @author tom jackson <tom@zmbh.com>
-- @creation-date 22 Sept 2001
-- @cvs-id $Id$
--

create table cronjobs (
	cronjob_id integer not null
   constraint cj_cronjob_id_fk references acs_objects(object_id)
   constraint cj_cronjob_id_pk primary key,
  user_id integer not null
   constraint cj_user_id_fk references users,
	description varchar(100) not null,
  approved_p char(1) default 'f' not null
   constraint cj_approved_p_ck check (approved_p in ('f','t')),
  disabled_p char(1) default 'f' not null
   constraint cj_disabled_p_ck check (disabled_p in ('f','t')),
  minute char(2)  default '0' not null,
  hr  char(2)  default '0' not null,
  mon char(2)  default '0' not null,
  day char(2)  default '0' not null,
  dayofweek char(2)  default '0' not null,
  run_sql text,
  run_tcl text,
  email   varchar(255)
);
 
-- DRB: since I had to remove the various "drop" commands that caused install-stopping
-- errors in the APM, I got rid of the inline function that used to surround this call
-- as well.  The inline func approach is great when you need to initialize a bunch
-- of things in a single transaction (in order to get a clean rollback on failure) but
-- IMO it just sorta obfuscates the source code if you're just doing a single
-- command.  All those ugly double apostrophes that are required, etc...

select acs_object_type__create_type (  
  'cronjob', -- object_type  
  'CronJob', -- pretty_name 
  'CronJobs', -- pretty_plural 
  'acs_object',   -- supertype 
  'cronjobs', -- table_name 
  'cronjob_id', -- id_column 
  null, -- package_name 
  'f', -- abstract_p 
  null, -- type_extension_table 
  null -- name_method 
); 

create function cronjob__cronjob_p (integer)
returns boolean
as '
declare
 p_cronjob_id alias for $1;
 v_check_cronjob_id integer;
begin
 select count(cronjob_id) into v_check_cronjob_id
  from cronjobs
  where cronjob_id = p_cronjob_id;
 if v_check_cronjob_id = 1 
 then 
   return true;
 else 
   return false;
 end if;
end;' language 'plpgsql';

create function cronjob__new (integer, integer, varchar, char, char, char(2), char(2), char(2), char(2), char(2), text, text, varchar, integer, varchar, integer)
returns integer as '
declare 
  p_cronjob_id  alias for $1; -- default null 
  p_user_id  alias for $2; -- default null 
  p_description  alias for $3; -- default null 
  p_approved_p  alias for $4; -- default ''f'' 
  p_disabled_p  alias for $5; -- default ''f''
  p_minute  alias for $6; -- default ''0'' 
  p_hr  alias for $7; -- default ''0'' 
  p_mon  alias for $8; -- default ''0'' 
  p_day  alias for $9; -- default ''0'' 
  p_dayofweek  alias for $10; -- default ''0'' 
  p_run_sql  alias for $11; -- default null 
  p_run_tcl  alias for $12; -- default null 
  p_email  alias for $13; -- default null
  p_creation_user  alias for $14; -- default null 
  p_creation_ip  alias for $15; -- default null 
  p_context_id  alias for $16; -- default null
  v_cronjob_id cronjobs.cronjob_id%TYPE;
  v_object_type  acs_objects.object_type%TYPE; -- default ''cronjob'' 
  v_creation_date  acs_objects.creation_date%TYPE; -- default now() 
begin
  v_cronjob_id := acs_object__new ( 
    p_cronjob_id, 
    ''cronjob'',
    now(),
    p_creation_user,
    p_creation_ip,
    p_context_id
  );  

  insert into cronjobs
    (cronjob_id, user_id, description, approved_p, disabled_p, minute, hr, mon, day, dayofweek, run_sql, run_tcl, email)
  values
    (v_cronjob_id, p_user_id, p_description, p_approved_p, p_disabled_p, p_minute, p_hr, p_mon, p_day, p_dayofweek, p_run_sql, p_run_tcl, p_email);

  return v_cronjob_id;

end;' language 'plpgsql';

create function cronjob__delete (integer)
returns integer as '
declare
 p_cronjob_id    alias for $1;
 v_return integer := 0; 
begin
   if not cronjob__cronjob_p(p_cronjob_id)
   then
    return v_return;
   end if;
   delete from acs_permissions
     where object_id = p_cronjob_id;

   delete from cronjobs
     where cronjob_id = p_cronjob_id;

   raise NOTICE ''Deleting cronjob...'';

   return v_return;

end;' language 'plpgsql';

create function cronjob__set_attrs (integer, integer, varchar, char, char, char(2), char(2), char(2), char(2), char(2), text, text, varchar)
returns integer 
as '
declare 
  p_cronjob_id alias for $1;
  p_user_id alias for $2; -- default null
  p_description alias for $3; -- default null
  p_approved_p alias for $4; -- default null
  p_disabled_p alias for $5; -- default null
  p_minute alias for $6; -- default null
  p_hr alias for $7; -- default null
  p_mon alias for $8; -- default null
  p_day alias for $9; -- default null
  p_dayofweek alias for $10; -- default null
  p_run_sql alias for $11; -- default null
  p_run_tcl alias for $12; -- default null
  p_email alias for $13; -- default null
  v_return integer := 0;
begin
  if p_user_id is not null
  then
   update cronjobs set user_id = p_user_id 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_description is not null
  then
   update cronjobs set description = p_description 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_approved_p is not null
  then
   update cronjobs set approved_p = p_approved_p 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_disabled_p is not null
  then
   update cronjobs set disabled_p = p_disabled_p 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_minute is not null
  then
   update cronjobs set minute = p_minute 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_hr is not null
  then
   update cronjobs set hr = p_hr 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_mon is not null
  then
   update cronjobs set mon = p_mon 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_day is not null
  then
   update cronjobs set day = p_day 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_dayofweek is not null
  then
   update cronjobs set dayofweek = p_dayofweek 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_run_sql is not null
  then
   update cronjobs set run_sql = p_run_sql 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_run_tcl is not null
  then
   update cronjobs set run_tcl = p_run_tcl 
    where cronjob_id = p_cronjob_id;
  end if;
  if p_email is not null
  then
   update cronjobs set email = p_email 
    where cronjob_id = p_cronjob_id;
  end if;
  return v_return;
end;' language 'plpgsql';

create function cronjob__reset_attr (integer,varchar)
returns integer 
as '
declare 
  p_cronjob_id alias for $1;
  p_column_name  alias for $2;
  v_return integer := 0;
begin
  if p_column_name = ''approved_p''
  then
   update cronjobs set approved_p = ''f''
    where cronjob_id = p_cronjob_id;
  end if;
  if p_column_name = ''disabled_p''
  then
   update cronjobs set disabled_p = ''f''
    where cronjob_id = p_cronjob_id;
  end if;
  if p_column_name = ''minute''
  then
   update cronjobs set minute = ''0''
    where cronjob_id = p_cronjob_id;
  end if;
  if p_column_name = ''hr''
  then
   update cronjobs set hr = ''0''
    where cronjob_id = p_cronjob_id;
  end if;
  if p_column_name = ''mon''
  then
   update cronjobs set mon = ''0''
    where cronjob_id = p_cronjob_id;
  end if;
  if p_column_name = ''day''
  then
   update cronjobs set day = ''0''
    where cronjob_id = p_cronjob_id;
  end if;
  if p_column_name = ''dayofweek''
  then
   update cronjobs set dayofweek = ''0''
    where cronjob_id = p_cronjob_id;
  end if;
  return v_return;
end;' language 'plpgsql';

