#!/bin/bash
# 🚨 Defence Buddy - Anti-TBomb v4.0 🚨
# Mode: RANSOM War Report Edition
# Author: Phantom Defence System 🔒

LOGFILE="$HOME/defence_tbomb_log.txt"
BLOCKED=0
ALLOWED=0

banner() {
    clear
    echo "======================================"
    echo "   🚀 DEFENCE BUDDY - ANTI-TBOMB 🚀"
    echo "   Mode: RANSOM ~ Killer of Spam 🔥"
    echo "   Created by Aryan 🔒"
    echo "======================================"
    echo
}

menu() {
    echo "1) Start Defence (RANSOM Mode)"
    echo "2) View Logs"
    echo "3) Clear Logs"
    echo "4) Exit"
    echo
}

war_report() {
    echo
    echo "======================================"
    echo "   🛡 RANSOM WAR REPORT 🛡"
    echo "======================================"
    echo "🔥 Total OTPs Blocked : $BLOCKED"
    echo "💎 Trusted OTPs Passed: $ALLOWED"
    echo "📅 Session Ended: $(date)"
    echo "======================================"
    echo
}

start_defence() {
    echo "🚨 RANSOM Defence Activated! Watching for TBomb spam..."
    echo "Started at $(date)" >> $LOGFILE

    trap 'war_report; exit 0' INT

    while true
    do
        SMS=$(termux-sms-list -l 1 | jq -r '.[0].body')
        SENDER=$(termux-sms-list -l 1 | jq -r '.[0].address')

        if [[ $SMS == *"OTP"* || $SMS == *"verification"* || $SMS == *"code"* ]]; then
            if [[ $SENDER == *"FLPKRT"* || $SENDER == *"OLACAB"* || $SENDER == *"PAYTM"* || $SENDER == *"AMAZON"* || $SENDER == *"SWIGGY"* ]]; then
                BLOCKED=$((BLOCKED+1))
                echo "⚠️ [RANSOM] Blocked $BLOCKED OTP from $SENDER at $(date)" >> $LOGFILE
                echo "RANSOM~ Blocked $BLOCKED 🔥"
                termux-notification --title "🚨 RANSOM Defence" --content "Blocked $BLOCKED spam OTP(s)"
            else
                ALLOWED=$((ALLOWED+1))
                echo "✅ Allowed $ALLOWED OTP from $SENDER at $(date)" >> $LOGFILE
                echo "💎 Trusted OTP Passed $ALLOWED"
                termux-notification --title "✅ Trusted OTP" --content "Allowed $ALLOWED OTP(s)"
            fi
        fi

        sleep 4
    done
}

# Main
banner
while true
do
    menu
    read -p "Choose an option: " choice
    case $choice in
        1) start_defence ;;
        2) cat $LOGFILE ;;
        3) echo "" > $LOGFILE && echo "Logs cleared!" ;;
        4) war_report; echo "Exiting Defence Buddy. Stay safe 🔒"; exit 0 ;;
        *) echo "Invalid option!" ;;
    esac
done