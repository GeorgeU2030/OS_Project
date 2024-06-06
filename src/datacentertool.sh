
# Function to display the menu
show_menu() {
    clear
    echo "==========================="
    echo "        Datacenter Tool"
    echo "==========================="
    echo "1. Show top 5 processes by CPU usage"
    echo "2. Show connected filesystems"
    echo "3. Show largest file in a specified directory"
    echo "4. Show free memory and swap usage"
    echo "5. Show active network connections"
    echo "6. Exit"
    echo "==========================="
}

# Function to show top 5 processes by CPU usage
show_top_five_cpu() {
    echo "Top 5 processes by CPU usage:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
}

# Function to show connected filesystems
show_filesystems() {
    echo "Connected filesystems (size and free space in bytes):"
    printf "%-20s %-15s %-15s %-15s\n" "Filesystem" "Size (bytes)" "Used (bytes)" "Available (bytes)"
    df -B1 | tail -n +2 | while read -r line; do
        filesystem=$(echo $line | awk '{print $1}')
        size=$(echo $line | awk '{print $2}')
        used=$(echo $line | awk '{print $3}')
        avail=$(echo $line | awk '{print $4}')
        printf "%-20s %-15s %-15s %-15s\n" "$filesystem" "$size" "$used" "$avail"
    done
}

# Function to show the largest file in a specified directory
show_largest_file() {
    read -p "Enter the directory path to search: " path
    echo "Searching for the largest file in $path..."
    largest_file=$(find "$path" -type f -exec ls -s {} + 2>/dev/null | sort -n | tail -n 1)
    if [ -z "$largest_file" ]; then
        echo "No files found in the specified directory."
    else
        file_size=$(echo $largest_file | awk '{print $1}')
        file_name=$(echo $largest_file | awk '{print $2}')
        echo "Largest file: $file_name"
        echo "Size: $file_size bytes"
    fi
}

# Function to show free memory and swap usage
show_memory_and_swap() {
    echo "Memory and swap usage (in bytes):"
    printf "%-20s %-15s %-15s %-15s\n" "Type" "Total (bytes)" "Used (bytes)" "Free (bytes)"
    free -b | grep Mem | awk '{printf "%-20s %-15s %-15s %-15s\n", "Memory", $2, $3, $4}'
    free -b | grep Swap | awk '{printf "%-20s %-15s %-15s %-15s\n", "Swap", $2, $3, $4}'
    swap_info=$(free -m | grep Swap)
    total_swap=$(echo "$swap_info" | awk '{print $2}')
    used_swap=$(echo "$swap_info" | awk '{print $3}')
    swap_percentage=$(echo "scale=2; $used_swap/$total_swap*100" | bc)
    echo "Swap usage percentage: $swap_percentage%"
}

# Function to show number of active network connections
show_active_connections() {
    echo "Number of active network connections (ESTABLISHED):"
    netstat -an | grep ESTABLISHED | wc -l
}

# Main script logic
while true; do
    show_menu
    read -p "Select an option [1-6]: " option
    case $option in
        1) show_top_five_cpu ;;
        2) show_filesystems ;;
        3) show_largest_file ;;
        4) show_memory_and_swap ;;
        5) show_active_connections ;;
        6) echo "Exiting... Goodbye!"; break ;;
        *) echo "Invalid option, please enter a number between 1 and 6." ;;
    esac
    read -p "Press Enter to continue..."
done
