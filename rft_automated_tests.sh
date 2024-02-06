#!/bin/bash

# Enable debugging
#set -x

# Path varaibles
ROOT_PATH="/datascience-folder"
ROOT_DIR_NAMES="dir"

# Define log file path relative to script location
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"
LOG_FILE="$SCRIPT_DIR/rft_automated_tests_$(date +'%Y%m%d_%H%M%S').txt"

# Flush all caches (JBT)
sudo sync; echo 3 > /proc/sys/vm/drop_caches

# Checking accessibility of the root path
if [ ! -d "$ROOT_PATH" ]; then
    echo "Error: Root path '$ROOT_PATH' is not accessible."
    exit 1
fi

# Function for ls/pls commands
run_ls() {
    echo -e "\n*** RUN LS / PLS ***" | tee -a "$LOG_FILE"

    echo "  *** Executing 'ls' Unix Standard command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { time ls -lR "$ROOT_PATH"/"$ROOT_DIR_NAMES"* | wc -l; } 2>&1 | tee -a "$LOG_FILE"
    #time ls -lR "$ROOT_PATH"/"$ROOT_DIR_NAMES"* | wc -l | tee -a "$LOG_FILE"

    echo    "*** Executing 'pls' RapidFile Toolkit Optimized command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { time pls -lR "$ROOT_PATH"/"$ROOT_DIR_NAMES"* | wc -l; } 2>&1 | tee -a "$LOG_FILE"
}

# Function for find/pfind commands
run_find() {
    echo -e "\n*** RUN FIND / PFIND ***" | tee -a "$LOG_FILE"

    echo "  *** Executing 'find' Unix Standard command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { time find "$ROOT_PATH"/"$ROOT_DIR_NAMES"* -type f -name *gutemb* ; } 2>&1 | tee -a "$LOG_FILE"

    echo "  *** Executing 'find' RapidFile Toolkit Optimized command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { time pfind "$ROOT_PATH"/"$ROOT_DIR_NAMES"* -type f -name *gutemb* ; } 2>&1 | tee -a "$LOG_FILE"
}

# Function for du/pdu commands
run_du() {
    echo -e "\n*** RUN DU / PDU ***" | tee -a "$LOG_FILE"

    echo "  *** Executing 'du' Unix Standard command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { time du -s "$ROOT_PATH"/"$ROOT_DIR_NAMES"* ; } 2>&1 | tee -a "$LOG_FILE"

    echo "  *** Executing 'pdu' RapidFile Toolkit Optimized command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { time pdu -s "$ROOT_PATH"/"$ROOT_DIR_NAMES"* ; } 2>&1 | tee -a "$LOG_FILE"
}

# Function for chmod/pchmod commands
run_chmod() {
    echo -e "\n*** RUN CHMOD / PCHMOD ***" | tee -a "$LOG_FILE"

    echo "  *** Executing 'chmod' Unix Standard command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { time chmod -R 777 "$ROOT_PATH"/"$ROOT_DIR_NAMES"* ; } 2>&1 | tee -a "$LOG_FILE"

    echo "  *** Executing 'pchmod' RapidFile Toolkit Optimized command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { time pchmod -R 644 "$ROOT_PATH"/"$ROOT_DIR_NAMES"* ; } 2>&1 | tee -a "$LOG_FILE"
}

# Function for chown/pchown commands
run_chown() {
    echo -e "\n*** RUN CHOWN / PCHOWN ***" | tee -a "$LOG_FILE"

    echo "  *** Executing 'chown' Unix Standard command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { time chown -R pureuser "$ROOT_PATH"/"$ROOT_DIR_NAMES"* ; } 2>&1 | tee -a "$LOG_FILE"

    echo "  *** Executing 'pchown' RapidFile Toolkit Optimized command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { time pchown -R root "$ROOT_PATH"/"$ROOT_DIR_NAMES"* ; } 2>&1 | tee -a "$LOG_FILE"
}

# Function for cp/pcopy commands
run_cp() {
    echo -e "\n*** RUN CP / PCOPY ***" | tee -a "$LOG_FILE"

    echo "  *** Executing 'cp' Unix Standard command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    for i in {1..5}; do
        { time cp -r "$ROOT_PATH"/"$ROOT_DIR_NAMES"$i "$ROOT_PATH"/cp_"$ROOT_DIR_NAMES"$i ; } 2>&1 | tee -a "$LOG_FILE"
    done

    echo "  *** Executing 'pcopy' RapidFile Toolkit Optimized command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    for i in {1..5}; do
        { time pcopy -r "$ROOT_PATH"/"$ROOT_DIR_NAMES"$i "$ROOT_PATH"/pcopy_"$ROOT_DIR_NAMES"$i ; } 2>&1 | tee -a "$LOG_FILE"
    done
}

# Function for tar/ptar commands
run_tar() {
    echo -e "\n*** RUN TAR / PTAR ***" | tee -a "$LOG_FILE"

    echo "  *** Executing 'tar' Unix Standard command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { cd "$ROOT_PATH"; time tar cf "$ROOT_PATH"/tar.out "$ROOT_DIR_NAMES"* ; } 2>&1 | tee -a "$LOG_FILE"

    echo "  *** Executing 'ptar' RapidFile Toolkit Optimized command on entire directory structure: "$ROOT_PATH"" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Running... "
    { cd "$ROOT_PATH"; time ptar cf "$ROOT_PATH"/ptar.out "$ROOT_DIR_NAMES"* ; } 2>&1 | tee -a "$LOG_FILE"
}

# Function for rm/prm commands 
# WE WILL ERASE THE FOLDERS CREATED DURING THE PCOPY  ***
run_rm() {
     echo -e "\n*** RUN RM / PRM ***" | tee -a "$LOG_FILE"

    echo "  *** Executing 'rm' Unix Standard command on entire directory structure: "$ROOT_PATH"/cp_"$ROOT_DIR_NAMES"*" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Checking cp_"$ROOT_DIR_NAMES"* to remove... "$ROOT_PATH"/cp_"$ROOT_DIR_NAMES"*"; mount -a
    for i in {1..5}; do
        if [ ! -d "$ROOT_PATH"/cp_"$ROOT_DIR_NAMES"$i ]; then
            echo "Error: "$ROOT_PATH"/cp_"$ROOT_DIR_NAMES"$i does not exists. Exiting."
            exit 1
        fi
        echo "  Running... "
        { time rm -r "$ROOT_PATH"/cp_"$ROOT_DIR_NAMES"$i ; } 2>&1 | tee -a "$LOG_FILE"
    done

    echo "  *** Executing 'prm' RapidFile Toolkit Optimized command on entire directory structure: "$ROOT_PATH"/cp_dir*" | tee -a "$LOG_FILE"
    echo "  Unmounting... "$ROOT_PATH""; umount "$ROOT_PATH"
    echo "  Remounting... "$ROOT_PATH""; mount -a
    echo "  Checking pcopy_"$ROOT_DIR_NAMES"* to remove... "$ROOT_PATH"/pcopy_"$ROOT_DIR_NAMES"*"; mount -a
    for i in {1..5}; do
        if [ ! -d "$ROOT_PATH"/pcopy_"$ROOT_DIR_NAMES"$i ]; then
            echo "Error: "$ROOT_PATH"/pcopy_"$ROOT_DIR_NAMES"$i does not exists. Exiting."
            exit 1
        fi
        echo "  Running... "
        { time prm -r "$ROOT_PATH"/pcopy_"$ROOT_DIR_NAMES"$i ; } 2>&1 | tee -a "$LOG_FILE"
    done
    
}

# Calling functions 
run_ls
run_find
run_du
run_chmod
run_chown
run_cp
run_tar
run_rm

