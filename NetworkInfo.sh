#!/bin/bash

# Linux Network Survey and Assessment Script

# Function to display network interfaces
function display_network_interfaces() {
    echo "### Network Interfaces ###"
    ifconfig
    echo
}

# Function to check ARP and DNS settings
function check_arp_dns_settings() {
    echo "### ARP and DNS Settings ###"
    echo "/etc/resolv.conf:"
    cat /etc/resolv.conf
    echo
    echo "/etc/hosts:"
    cat /etc/hosts
    echo
}

# Function to find specific IP addresses
function find_ip_addresses() {
    echo "### Finding Specific IP Addresses ###"
    find / -type f -exec grep "192.168" {} \; 2>/dev/null
    echo
}

# Function to display open sockets
function display_open_sockets() {
    echo "### Open Sockets ###"
    netstat -tuln
    echo
}

# Function to display routing table
function display_routing_table() {
    echo "### Routing Table ###"
    route -n
    echo
}

# Function to list open files
function list_open_files() {
    echo "### Open Files ###"
    lsof -i
    echo
}

# Function to list active ports using a script
function list_active_ports() {
    echo "### Active Ports ###"
    netstat -nlatp | grep tcp | grep LIST | awk '{print $4$7}' | awk -F: '{print $2}' | awk -F/ '{print $1 $2}' | awk '{print $1$3}' | sort -nu
    echo
    
    # Display header
    echo "Open Sockets and Associated PIDs"
    # Use 'ss' to get open sockets with process info and loop through each line
    ss -lptun | while read -r line; do
        # Extract PID and associated socket details
        pid=$(echo "$line" | grep -oP 'pid=\K\d+')
        socket=$(echo "$line" | awk '{print $5}')
        # Check if PID is not empty
        if [[ ! -z "$pid" ]]; then
            # Display PID and socket
            echo "PID: $pid - Socket: $socket"
        fi
}

# Function to display established connections
function display_established_connections() {
    echo "### Established Connections ###"
    cd /proc
    for p in `find * -type d -prune`; do 
        pfiles $p | grep port >> /tmp/ports && echo "PID: $p" >> /home/student
    done
    echo
}



# Main script execution
echo "Starting Linux Network Survey and Assessment..."
display_network_interfaces
check_arp_dns_settings
find_ip_addresses
display_open_sockets
display_routing_table
list_open_files
list_active_ports
display_established_connections
echo "Network survey and assessment completed."

