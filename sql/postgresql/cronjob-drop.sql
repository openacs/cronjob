select acs_object_type__drop_type('cronjob', 'f');
drop table cronjobs;
drop function  cronjob__cronjob_p (integer);
drop function cronjob__new (integer, integer, varchar, char, char, char(2), char(2), char(2), char(2), char(2), text, text, varchar, integer, varchar, integer);
drop function cronjob__delete (integer);
drop function cronjob__set_attrs (integer, integer, varchar, char, char, char(2), char(2), char(2), char(2), char(2), text, text, varchar);
drop function cronjob__reset_attr (integer,varchar);
