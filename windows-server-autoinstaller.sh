#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server version:"
    echo "1. Windows 10"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows 10
        img_file="windows10.img"
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win10_22H2_English_x64v1.iso?t=763f3f93-81c9-4890-8390-57493df6666e&P1=1739773427&P2=601&P3=2&P4=XN5K%2bd6ECXYBNaZIFPJUZwoMb2YoiVETFHNqckaRxfdcSdJm91LmwnQ5uMj3ROfUbJbGlG1OtOSMXzkGsUUq4oM2BUJUymlqubE%2bOXWfg9punEE21W3lRZRZAwzr%2b3dbES7V7XJ5LE%2fReVfreleRh9RLsdW5Pwz%2bqDXHFp3wRQbLUr0SujaAS7SKpqZlnTN079HRZkE6ALndyDeTWN1%2f05ZuAap0Cw%2fu7N9Lq4Y4G%2f%2bVLBRh8A%2bm3aerqIZLwilcEZWCBOOKx21AJrqhpLTJoogUPKMjFi2Q0eMHoWOd4QRRUAFnDyt%2bRIWIH2C6CYG%2bThXF9EMBr%2fnlGnF%2bXQwXTQ%3d%3d"
        iso_file="windows10.iso"
        ;;
    2)
        # Windows Server 2019
        img_file="windows2019.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2019.iso"
        ;;
    3)
        # Windows Server 2022
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected Windows Server version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 70G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
