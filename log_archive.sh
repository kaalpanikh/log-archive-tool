#!/bin/bash

# Usage: sudo ./log_archive.sh <log_directory> <email_address> <remote_user@remote_host:/path/to/backup>

LOG_DIR=$1              # Directory containing log files
EMAIL=$2                # Email address for notifications
REMOTE_BACKUP=$3        # Remote backup destination

# Check if the log directory is provided and exists
if [ -z "$LOG_DIR" ] || [ -z "$EMAIL" ] || [ -z "$REMOTE_BACKUP" ]; then
    echo "Usage: $0 <log_directory> <email_address> <remote_user@remote_host:/path/to/backup>"
    exit 1
fi

if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory $LOG_DIR does not exist."
    exit 1
fi

# Create an archive directory if it doesn't exist
ARCHIVE_DIR="/var/log/archive"
sudo mkdir -p "$ARCHIVE_DIR"

# Generate a timestamp for the archive filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_FILENAME="logs_archive_${TIMESTAMP}.tar.gz"

# Compress logs into a tar.gz file with elevated permissions
sudo tar -czf "$ARCHIVE_DIR/$ARCHIVE_FILENAME" -C "$LOG_DIR" .

# Inform the user of success
echo "Logs archived successfully to $ARCHIVE_DIR/$ARCHIVE_FILENAME"

# Send email notification using sendmail
{
    echo "Subject: Log Archive Notification"
    echo "To: $EMAIL"
    echo "Content-Type: text/plain"
    echo ""
    echo "Logs have been archived successfully on $(date)."
} | sendmail -t

# Remote backup using scp
REMOTE_USER=$(echo "$REMOTE_BACKUP" | cut -d'@' -f1)
REMOTE_HOST=$(echo "$REMOTE_BACKUP" | cut -d'@' -f2 | cut -d':' -f1)
REMOTE_PATH=$(echo "$REMOTE_BACKUP" | cut -d':' -f2)

# Use scp to transfer the archived log file to the remote server
sudo scp "$ARCHIVE_DIR/$ARCHIVE_FILENAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

if [ $? -eq 0 ]; then
    echo "Backup to remote server $REMOTE_BACKUP completed successfully."
else
    echo "Backup to remote server $REMOTE_BACKUP failed."
fi
