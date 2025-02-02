# Log Archive Tool

## Overview

The Log Archive Tool is a Bash script that automates log file management by archiving logs, sending email notifications, and performing secure remote backups. It's designed for system administrators who need efficient log management with reliable backup capabilities.

## Features

- Automatically compresses log files into timestamped `.tar.gz` archives
- Sends email notifications when archiving completes successfully
- Securely transfers archived logs to remote servers using `scp`
- Excludes frequently changing files to prevent read errors

## Prerequisites

- Ubuntu or compatible Linux distribution running on EC2
- Access permissions for the target log directory
- `sendmail` package installed
- SSH key pairs configured between source and destination servers

## Installation

1. Get the repository:
   ```bash
   git clone https://github.com/kaalpanikh/log-archive-tool
   cd log-archive-tool
   ```

2. Make the script executable:
   ```bash
   chmod +x log_archive.sh
   ```

3. Install sendmail if needed:
   ```bash
   # For Ubuntu/Debian
   sudo apt-get install sendmail -y
   
   # For Amazon Linux/CentOS
   sudo yum install sendmail -y
   ```

## Usage

Run the tool using:
```bash
sudo ./log_archive.sh <log_directory> <email_address> <remote_user@remote_host:/path/to/backup>
```

### Parameters

- `<log_directory>`: Directory containing logs (e.g., `/var/log`)
- `<email_address>`: Where to send notifications (e.g., `admin@example.com`)
- `<remote_user@remote_host:/path/to/backup>`: Remote backup destination (e.g., `ec2-user@172.31.1.145:/backup/`)

### Example

```bash
sudo ./log_archive.sh /var/log admin@example.com ec2-user@172.31.1.145:/backup/
```

## Important Notes

- Verify read permissions for log directories and write permissions for archive locations
- Ensure proper SSH configuration between EC2 instances
- The tool automatically excludes journal logs and other frequently changing files

## Contributing

We welcome contributions! Please feel free to:
1. Fork the repository
2. Create your feature branch
3. Submit a pull request

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Contact

For questions or feedback:
Email: nm30472@gmail.com
GitHub: [kaalpanikh/log-archive-tool](https://github.com/kaalpanikh/log-archive-tool)
Project page : [projectpageurl](https://roadmap.sh/projects/log-archive-tool)
