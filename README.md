# 📊 Datacenter Tool

This repository contains scripts for a menu-driven tool for datacenter operations. The tools are available in both BASH and PowerShell to cater to different operating system environments.

## ✨ Features

1. **🖥️ Show top 5 processes by CPU usage**: Displays the processes that are currently consuming the most CPU.
2. **💾 Show connected filesystems**: Lists the filesystems or disks connected to the machine along with their usage information.
3. **📂 Show largest file in a specified directory**: Finds and displays the largest file in a user-specified directory.
4. **🔋 Show free memory and swap usage**: Displays the amount of free memory and the swap space usage.
5. **🌐 Show active network connections**: Counts and displays the number of currently active network connections.
6. **❌ Exit**: Exits the tool.

## 📋 Requirements

### 🐧 BASH Script

- A Unix-like operating system (Linux, macOS).
- `bash` shell.
- Basic Unix commands (`ps`, `df`, `find`, `free`, `netstat`).

### 🪟 PowerShell Script

- Windows operating system.
- PowerShell installed.

## 🚀 Usage

### 🐧 BASH Script

1. Install git:
   
    ```bash
    sudo apt-get install git
    ```
    
3. Clone the repository:

    ```bash
    git clone https://github.com/GeorgeU2030/ProyectoSO.git
    cd ProyectoSO
    ```

4. Make the BASH script executable:

    ```bash
    chmod +x datacentertool.sh
    ```

5. Run the BASH script:

    ```bash
    ./datacentertool.sh
    ```

6. Follow the on-screen menu to select the desired operation.

### PowerShell Script

1. Clone the repository:

    ```powershell
    git clonehttps://github.com/GeorgeU2030/ProyectoSO.git
    cd ProyectoSO
    ```

2. Run the PowerShell script:

    ```powershell
    .\datacentertool.ps1
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


## 📖 Explanation of Code
* **Powershell**

### 1. Display the five processes that are consuming the most CPU
- **Usage of `Get-Process`**: Retrieves the list of processes currently running.
- **Usage of `Sort-Object -Property CPU -Descending`**: Sorts the processes by CPU usage in descending order.
- **Usage of `Select-Object -First 5`**: Selects the top 5 processes.
- **Usage of `Format-Table -Property Id, ProcessName, CPU`**: Formats the output to display the process ID, name, and CPU usage.

### 2. Deploy the filesystems or disks connected to the machine
- **Usage of `Get-PSDrive -PSProvider FileSystem`**: Retrieves the drives of the FileSystem provider.
- **Usage of calculated properties (`@{Name="...";Expression={...}}`)**: Calculates and formats the size, used space, and free space in megabytes and gigabytes.

### 3. Display the name and size of the largest stored file
- **Usage of `Get-ChildItem -Path $path -Recurse`**: Retrieves all items in the specified path recursively.
- **Usage of `Where-Object { -not $_.PSIsContainer }`**: Filters out directories to only include files.
- **Usage of `Sort-Object -Property Length -Descending`**: Sorts the files by size in descending order.
- **Usage of `Select-Object -First 1`**: Selects the largest file.
- **Usage of `Format-Table -Property FullName, Length`**: Formats the output to display the full path and size of the file.

### 4. Amount of free memory and amount of swap space in use
- **Usage of `Get-WmiObject -Class Win32_OperatingSystem`**: Retrieves system information, including free physical memory.
- **Usage of `Get-WmiObject -Class Win32_PageFileUsage`**: Retrieves page file (swap) usage information.
- **Calculation of memory and swap usage**: Converts memory and swap usage to bytes and calculates the swap usage percentage.

### 5. Number of currently active network connections
- **Usage of `Get-NetTCPConnection -State Established`**: Retrieves the list of established network connections.
- **Usage of `.Count`**: Counts the number of established connections.

--------------

* **Bash**
### 1. Show top 5 processes by CPU usage
- **Usage of `ps`**: The `ps` command is used to display the current processes.
- **Option `-eo`**: Specifies the output format to show PID, PPID, command, % of memory, and % of CPU.
- **Option `--sort=-%cpu`**: Sorts the processes by CPU usage in descending order.
- **Usage of `head -n 6`**: Displays the top 6 lines of the result, including the header.

### 2. Show connected filesystems
- **Usage of `df -B1`**: The `df` command shows disk usage. The `-B1` option shows sizes in bytes.
- **Usage of `tail -n +2`**: Excludes the header line from the result.
- **Usage of `awk`**: Extracts and formats the fields for filesystem, size, used space, and available space.

### 3. Show largest file in a specified directory
- **Usage of `find`**: Searches for files in the specified directory.
- **Option `-type f`**: Limits the search to files only (no directories).
- **Usage of `ls -s`**: Lists the files with their sizes.
- **Usage of `sort -n`**: Sorts the files by size.
- **Usage of `tail -n 1`**: Selects the largest file.
- **Redirection `2>/dev/null`**: Suppresses error messages for inaccessible directories.

### 4. Show free memory and swap usage
- **Usage of `free -b`**: Displays memory and swap space in bytes.
- **Usage of `grep Mem` and `grep Swap`**: Filters lines containing memory and swap information.
- **Usage of `awk`**: Extracts and formats memory and swap data.
- **Calculation of swap usage percentage**: Uses `bc` for decimal calculations to determine swap usage percentage.

### 5. Show active network connections
- **Usage of `netstat -an`**: Displays all network connections and ports.
- **Usage of `grep ESTABLISHED`**: Filters connections in the ESTABLISHED state.
- **Usage of `wc -l`**: Counts the number of lines, representing the number of active connections.



