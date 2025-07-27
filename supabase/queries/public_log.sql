-- name: LogCreate :one
INSERT INTO log (
  log_title,
  action_type,
  status_code,
  user_id,
  record_id,
  duartion_milliseconds,
  api_error_message,
  permission_name
) VALUES (
  sqlc.arg(log_title),
  sqlc.arg(action_type),
  sqlc.arg(status_code),
  sqlc.arg(user_id),
  sqlc.arg(record_id),
  sqlc.arg(duartion_milliseconds),
  sqlc.arg(api_error_message),
  sqlc.arg(permission_name)
)
RETURNING *;
