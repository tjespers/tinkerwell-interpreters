#!/usr/bin/env bash

#title          :tinkerwell-dynamic-interpreter-resolver.sh
#description    :This script will hack support for custom contextual PHP interpreters into tinkerwell
#author         :Tim Jespers <t.jesp3rs@gmail.com>
#date           :2020-02-14
#version        :0.1    
#usage          :in tinkerwell go to Preferences -> Advanced -> select this script as PHP binary
#notes          :Install tinkerwell to use this script
#==============================================================================

# First we need to determine if we're in CLI or HTTP tinker mode
# We can evaluate this based on the first file argument passed to PHP 
# This is either tinker.phar for CLI or http.php for HTTP
TINKERWELL_ENTRYPOINT=$1

# If we're in CLI mode, set the current working dir
if [[ "$TINKERWELL_ENTRYPOINT" == *.phar ]] 
then
    # CLI argument order:
    # $1 => The php script/phar to execute
    # $2 => A tmp file containing the current tinker code
    # $3 => The current tinkerwell working dir
    # $4 => a value currently always being null, purpose unclear
    TINKER_MODE="cli"
    TINKERWELL_WORKING_DIR=$3
else
    TINKER_MODE="http"
fi

# Check for the presence of a .tinkerwell folder in the current working directory
# If we find one also check for a usable interpreter.
# [NOTE:] currently only the CLI tinker mode is supported as the arguments / internals for HTTP mode differ from it alot.
if [ -d $TINKERWELL_WORKING_DIR/.tinkerwell -a -f "$TINKERWELL_WORKING_DIR/.tinkerwell/$TINKER_MODE.interpreter" -a "$TINKER_MODE" == 'cli' ]; then
    # Forward the call to the custom tinkerwell interpreter
    $TINKERWELL_WORKING_DIR/.tinkerwell/$TINKER_MODE.interpreter $@
    exit $?
else
    # Fallback onto native PHP binary
    NATIVE_PHP_INTERPRETER=$(which php)
    $NATIVE_PHP_INTERPRETER "$@"
    exit $?
fi