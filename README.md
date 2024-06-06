```markdown
# Datacenter Tool

This repository contains scripts for a menu-driven tool for datacenter operations. The tools are available in both BASH and PowerShell to cater to different operating system environments.

## Features

1. **Show top 5 processes by CPU usage**: Displays the processes that are currently consuming the most CPU.
2. **Show connected filesystems**: Lists the filesystems or disks connected to the machine along with their usage information.
3. **Show largest file in a specified directory**: Finds and displays the largest file in a user-specified directory.
4. **Show free memory and swap usage**: Displays the amount of free memory and the swap space usage.
5. **Show active network connections**: Counts and displays the number of currently active network connections.
6. **Exit**: Exits the tool.

## Requirements

### BASH Script

- A Unix-like operating system (Linux, macOS).
- `bash` shell.
- Basic Unix commands (`ps`, `df`, `find`, `free`, `netstat`).

### PowerShell Script

- Windows operating system.
- PowerShell installed.

## Usage

### BASH Script

1. Clone the repository:

    ```bash
    git clone <repository_url>
    cd datacenter-tool
    ```

2. Make the BASH script executable:

    ```bash
    chmod +x bash_script.sh
    ```

3. Run the BASH script:

    ```bash
    ./bash_script.sh
    ```

4. Follow the on-screen menu to select the desired operation.

### PowerShell Script

1. Clone the repository:

    ```powershell
    git clone <repository_url>
    cd datacenter-tool
    ```

2. Run the PowerShell script:

    ```powershell
    .\powershell_script.ps1
    ```

3. Follow the on-screen menu to select the desired operation.

## Example

Upon running the script, you will see the following menu:

```
===========================
        Datacenter Tool
===========================
1. Show top 5 processes by CPU usage
2. Show connected filesystems
3. Show largest file in a specified directory
4. Show free memory and swap usage
5. Show active network connections
6. Exit
===========================
Select an option [1-6]:
```

Select an option by entering the corresponding number and press `Enter`. Follow the prompts for options that require additional input (e.g., specifying a directory for the largest file search).

```
