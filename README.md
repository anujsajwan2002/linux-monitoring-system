
# Linux System Health Monitor

A Bash-based Linux monitoring project that checks system health and automates report generation.

## Features

- Displays hostname, date, and system uptime
- Monitors disk usage with a configurable threshold
- Monitors memory usage with a configurable threshold
- Displays CPU count and top running processes
- Generates timestamped log reports
- Deletes log files older than 24 hours
- Supports automatic execution using cron
- Returns exit codes based on monitoring results

## Requirements

- Ubuntu Linux or Ubuntu on WSL
- Bash
- Standard Linux utilities: `df`, `free`, `awk`, `ps`, `find`
- Cron for scheduled execution

## Run the project

Clone the repository, or navigate to the project directory.

Make the script executable:

```bash
chmod +x monitor.sh
```

Run the monitor:

```bash
./monitor.sh
```

## Schedule with cron

Edit your crontab:

```bash
crontab -e
```

Add the following line, replacing the path if necessary:

```cron
*/5 * * * * cd /home/sajwan/projects/linux-monitoring-system && /bin/bash monitor.sh
```

## Log retention

The script removes matching monitoring logs older than 24 hours and saves new reports in the `logs/` directory.

## Learning objectives

This project demonstrates Linux commands, Bash scripting, conditional logic, exit codes, log management, cron scheduling, and Git version control.
