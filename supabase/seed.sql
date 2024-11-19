SELECT
	*
FROM
	accounts_schema.permissions_populate (execluded_tables => ARRAY['navigation_bar_item', 'log', 'setting', 'input_type'], added_tables => ARRAY['storage.bucket', 'storage.object']);

INSERT INTO accounts_schema.role (
	role_name,
	role_description,
	role_security_level)
VALUES (
	'super admin',
	'this is the most privlidged role that can do all the permissions on the sysstem',
	100);

INSERT INTO accounts_schema.role_permission (
	role_id,
	permission_id)
SELECT
	1,
	permission_id
FROM
	accounts_schema.permission;

INSERT INTO input_type (
	input_type_name)
VALUES (
	'text'),
(
	'toggle'),
(
	'richtext'),
(
	'date');

INSERT INTO accounts_schema.user_type (
	user_type_name)
VALUES (
	'admin'),
(
	'tenant');

INSERT INTO setting (
	input_type_id,
	setting_key,
	setting_value)
VALUES (
	1,
	'site_name',
	'Abc Hotels');

INSERT INTO tenants_schema.partial_type (
	partial_type_name)
VALUES (
	'project'),
(
	'service'),
(
	'testemonial')
