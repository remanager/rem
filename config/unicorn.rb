# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/var/www/rem/current"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/var/www/rem/current/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/var/www/rem/current/log/unicorn.log"
stdout_path "/var/www/rem/current/log/unicorn.log"

# Unicorn socket
# listen "/tmp/unicorn.[app name].sock"
listen "/tmp/unicorn.rem.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
