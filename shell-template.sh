#!/usr/bin/env bash 

# Copyright (c) 2012  Marin Atanasov Nikolov  <dnaeon@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

set -u
#set -e

export LANG=C

#umask 022

#
# ${_PROG_NAME} -- a tool for <description-of-the-program>
#

# Program global variables
_PROG_NAME="${0##*/}"					# program name
_PROG_VERSION="1.0"					# program version
_PROG_PREFIX="/usr/local"				# program prefix (e.g. /usr/local), if applicable
_PROG_CONFIG="${_PROG_PREFIX}/etc/${_PROG_NAME}.conf" 	# program configuration file, if applicable
_PROG_LOGFILE="/var/log/${_PROG_NAME}.log"	 	# program log file

#_PROG_LOCKFILE=""					# lock file

# Other global variables, if applicable
# _GLOBAL_VAR1="value1"
# _GLOBAL_VAR2="value2"
# _GLOBAL_VAR3="value3"

# Options configurable variables
a_var="" # -a <arg> 
b_var="" # -b <arg>
c_var="" # -c <arg>
debug="" # -d

## Read the configuration file, if present
if [[ -f "${_PROG_CONFIG}" ]]; then
    source "${_PROG_CONFIG}"
fi

# Set default variables' values
: ${prog_var1:="prog_var1_value"}
: ${prog_var2:="prog_var2_value"}
: ${prog_var3:="prog_var3_value"}
# ...
# ...
# ${prog_varN:="prog_varN_value"}

# Available commands and description
# Commands are being in the following format
# <TAB> <COMMAND> <TAB> <COMMAND-DESCRIPTION>
COMMANDS="\
	cmd1	Executes <cmd1>
	cmd2	Executes <cmd2>
	cmdN	Executes <cmdN>"

# Display an INFO message
# $1: Message to display
_msg_info() {
    local _msg="${1}"

    echo "[${_PROG_NAME}] INFO: ${_msg}"
}

# Display a DEBUG message
# $1: Message to display
_msg_debug() {
    local _msg="${1}"
    
    if [[ -n "${debug}" ]]; then
	echo "[${_PROG_NAME}] DEBUG: ${_msg}"
    fi
}

# Display an ERROR message
# $1: Message to display
# $2: Exit code
_msg_error() {
    local _msg="${1}"
    local _rc=${2}
    
    echo "[${_PROG_NAME}] ERROR: ${_msg}"

    if [[ ${_rc} -ne 0 ]]; then
	exit ${_rc}
    fi
}

# Displays usage messages for the available commands
# $1: Command which we want to display info about
_exec_help() {
    local _cmd
    local _help_cmd="${1}"
    local _found_cmd=0
    
    for _cmd in ${COMMANDS}; do
	if [[ "${_cmd}" == "${_help_cmd}" ]]; then
	    _found_cmd=1
	    break
	fi
    done

    # display usage function if command was found or error otherwise
    if [[ ${_found_cmd} -eq 1 ]]; then
	usage_"${_help_cmd}"
    else
	_msg_error "Invalid command name specified." 0
	_msg_error "No such command '${_help_cmd}' found." 64 # EX_USAGE
    fi

    exit 0 # EX_OK
}

#
# USER-DEFINED FUNCTIONS IMPLEMENTING CERTAIN FUNCTIONALLITY
# 
# 	THIS IS WHERE YOU NEED TO START HACKING ;)
# 

# Display usage information and exit
_usage() {

    echo "usage: ${_PROG_NAME} [options] <command> <args>"
    echo 
    echo "Global options supported:"
    echo "	-d	Debug log level"
    echo
    echo "Commands supported:"
    echo "${COMMANDS}"
    # ...
    # ...
    echo
    echo "For more information on the different commands see '${_PROG_NAME} help <command>'"
    
    exit 64 # EX_USAGE
}

# Perform a sanity check
_sanity_check() {

    [[ -f "${_PROG_CONFIG}" ]] && _msg_error "Missing configuration file ${_PROG_CONFIG}" 78 # EX_CONFIG
    # ...
    # ...
    # ... and other sanity checks if needed 
}

# Display usage information for <cmd1>
usage_cmd1() {
    
    echo "usage: ${_PROG_NAME} [options] <cmd1> <args>"
    # ...
    # ...
    
    exit 64 # EX_USAGE
}

# Execute <cmd1> ...
# $1: First argument ...
# $2: Second argument ...
# $N: N'th argument ...
exec_cmd1() {
    local _argv1="${1}"
    local _argv2="${2}"
    local _argvN="${N}"

    if [[ $# -ne "<n-arguments" ]]; then
	usage_cmd1
    fi

    # Need to trap signals?
    # Uncomment the next line and create the "exec_cmd1_trap_function"
    # Don't forget to untrap in "exec_cmd1_trap_function" as well,
    # using the "trap - EXIT HUP INT TERM" command

    # trap "exec_cmd1_trap_function" EXIT HUP INT TERM
    
    _msg_debug "Executing <cmd1> ..."
    
    # ...
    # function body being defined here
    # ...
}

# Display usage information for <cmd2>
usage_cmd2() {
    
    echo "usage: ${_PROG_NAME} [options] <cmd2> <args>"
    # ...
    # ...
    
    exit 64 # EX_USAGE
}

# Execute <cmd2> ...
# $1: First argument ...
# $2: Second argument ...
# $N: N'th argument ...
exec_cmd2() {
    local _argv1="${1}"
    local _argv2="${2}"
    local _argvN="${N}"

    if [[ $# -ne "<n-arguments" ]]; then
	usage_cmd2
    fi

    # Need to trap signals?
    # Uncomment the next line and create the "exec_cmd2_trap_function"
    # Don't forget to untrap in "exec_cmd2_trap_function" as well,
    # using the "trap - EXIT HUP INT TERM" command

    # trap "exec_cmd2_trap_function" EXIT HUP INT TERM

    _msg_debug "Executing <cmd2> ..."

    # ...
    # function body being defined here
    # ...
}

# Display usage information for <cmdN>
usage_cmdN() {
    
    echo "usage: ${_PROG_NAME} [options] <cmdN> <args>"
    # ...
    # ...
    
    exit 64 # EX_USAGE
}

# Execute <cmdN> ...
# $1: First argument ...
# $2: Second argument ...
# $N: N'th argument ...
exec_cmdN() {
    local _argv1="${1}"
    local _argv2="${2}"
    local _argvN="${N}"

    if [[ $# -ne "<n-arguments" ]]; then
	usage_cmdN
    fi

    # Need to trap signals?
    # Uncomment the next line and create the "exec_cmdN_trap_function"
    # Don't forget to untrap in "exec_cmdN_trap_function" as well,
    # using the "trap - EXIT HUP INT TERM" command

    # trap "exec_cmdN_trap_function" EXIT HUP INT TERM

    _msg_debug "Executing <cmdN> ..."

    # ...
    # function body being defined here
    # ...
}


# 
# MAIN
#

# Only root can execute the script?
if [[ ${EUID} -ne 0 ]]; then
    _msg_error "This program needs to be run as root" 77 # EX_PERM
fi

# Perform a sanity check
_sanity_check

# Parse any options on the command-line
while getopts 'a:b:c:dh' arg; do
    case "${arg}" in
        a) a_var="${a_var} ${OPTARG}" ;;
        b) b_var="${OPTARG}" ;;
        c) c_var="${OPTARG}" ;;
        d) debug="yes" ;;
        h|?) _usage ;;
        *)
            _msg_error "Invalid option '${arg}'"
	    _usage
            ;;
    esac
done

shift $((OPTIND - 1))

# Check if any command was specified on the command-line
if [[ $# -lt 1 ]]; then
    _msg_error "No command specified." 0
    _usage
fi

cmd_name="${1}"

case "${cmd_name}" in
    cmd1)
	exec_cmd1 $*
	;;
    cmd2)
	exec_cmd2 $*
	;;
    cmdN)
	exec_cmdN $*
	;;
    help)
    	# Display the available commands
	if [[ $# -eq 1 ]]; then
	    _msg_info "The following commands are available:"

	    echo
	    echo "${COMMANDS}"
	    echo

	    _msg_info "Fore more information on a command see '${_PROG_NAME} help <command>'"
	    exit 0 # EX_OK
	elif [[ $# -eq 2 ]]; then
	    # Display the usage information about the command
	    _exec_help "${2}"
	else
	    _msg_error "You need to specify one command name only." 0
	    _msg_error "Please check '${_PROG_NAME} help' for more information." 64 # EX_USAGE
	fi
	;;
    *)
	_msg_error "'${cmd_name}' is not a valid command name." 0
	_msg_error "See '${_PROG_NAME} help' for more information on the commands" 64 # EX_USAGE
	;;
esac

