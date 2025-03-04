#!/bin/bash
# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Clear screen function
clear_screen() {
    clear
    show_banner
}

# Check root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}This script must be run as root${NC}"
        echo -e "Please run with: ${YELLOW}sudo bash script.sh${NC}"
        exit 1
    fi
}

# Show banner
show_banner() {
    echo -e "${BLUE}════════════════════════════════════════${NC}"
    echo -e "${WHITE}         System Management Tools        ${NC}"
    echo -e "${BLUE}════════════════════════════════════════${NC}"
    echo
}

# Function to show script descriptions
show_description() {
    case $1 in
        1) echo -e "   ${CYAN}└─ UFW Firewall Manager${NC}" ;;
        2) echo -e "   ${CYAN}└─ Hetzner Abuse Handler${NC}" ;;
        3) echo -e "   ${CYAN}└─ Config VPS for Direct${NC}" ;;
        4) echo -e "   ${CYAN}└─ Automated Reboot${NC}" ;;
        5) echo -e "   ${CYAN}└─ HAProxy Load Balancer${NC}" ;;
        6) echo -e "   ${CYAN}└─ Unbound DNS Resolver${NC}" ;;
        7) echo -e "   ${CYAN}└─ Server Defender${NC}" ;;
        8) echo -e "   ${CYAN}└─ AS-BBR Network Optimizer${NC}" ;; # New option
    esac
}

# Main menu display function
show_menu() {
    echo -e "${YELLOW}Available Tools:${NC}"
    echo
    echo -e "${GREEN}1)${NC} UFW Manager"
    show_description 1
    echo
    echo -e "${GREEN}2)${NC} Hetzner Abuse"
    show_description 2
    echo
    echo -e "${GREEN}3)${NC} Config VPS for Direct"
    show_description 3
    echo
    echo -e "${GREEN}4)${NC} Automated Reboot"
    show_description 4
    echo
    echo -e "${GREEN}5)${NC} HAProxy Setup"
    show_description 5
    echo
    echo -e "${GREEN}6)${NC} Unbound DNS"
    show_description 6
    echo
    echo -e "${GREEN}7)${NC} Server Defender"
    show_description 7
    echo
    echo -e "${GREEN}8)${NC} AS-BBR Network Optimizer" # New option
    show_description 8
    echo
    echo -e "${RED}0)${NC} Exit"
    echo
    echo -e "${BLUE}────────────────────────────────────────${NC}"
    echo -e "${YELLOW}Enter your choice [0-8]:${NC} \c"
}

# Functions to run scripts
run_script() {
    clear_screen
    case $1 in
        1) 
            echo -e "${YELLOW}Running UFW Manager...${NC}"
            sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/Salarvand-Education/Auto-ufw/main/ufw.sh)"
            ;;
        2)
            echo -e "${YELLOW}Running Hetzner Abuse Handler...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/Salarvand-Education/Hetzner-Abuse/main/Abuse.sh)
            ;;
        3)
            echo -e "${YELLOW}Running VPS Configuration for Direct...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/Salarvand-Education/Direct/main/Direct.sh)
            ;;
        4)
            echo -e "${YELLOW}Running Automated Reboot...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/Salarvand-Education/Areboot/main/Install.sh)
            ;;
        5)
            echo -e "${YELLOW}Running HAProxy Setup...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/Salarvand-Education/Haproxy/main/Haproxy.sh)
            ;;
        6)
            echo -e "${YELLOW}Running Unbound DNS Setup...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/Salarvand-Education/Unbound/main/install.sh)
            ;;
        7)
            echo -e "${YELLOW}Running Server Defender...${NC}"
            bash <(curl -Ls https://raw.githubusercontent.com/Salarvand-Education/Server-Defender/main/install.sh)
            ;;
        8)
            echo -e "${YELLOW}Running AS-BBR Network Optimizer...${NC}"
            sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/Salarvand-Education/AS-BBR/main/AS-BBR.sh)"
            ;;
    esac
    if [ $? -ne 0 ]; then
        echo -e "${RED}An error occurred!${NC}"
    fi
    
    echo
    read -p "Press Enter to return to main menu..."
}

# Main loop
main() {
    check_root
    while true; do
        clear_screen
        show_menu
        read choice
        case $choice in
            [1-8]) run_script $choice ;; # Updated range to include the new option
            0) 
                clear
                echo -e "${GREEN}Thank you for using System Management Tools!${NC}"
                exit 0 
                ;;
            *)
                echo -e "${RED}Invalid option. Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}

# Start script
main
