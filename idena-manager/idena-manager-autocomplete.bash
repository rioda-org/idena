#!/usr/bin/env bash

_completions()
{
	command=${COMP_WORDS[1]}

	case $command in
		update|node-update)
			if [ "${#COMP_WORDS[@]}" != "3" ]; then
				return
			fi

			if [ -n "${COMP_WORDS[2]}" ]
			then
				COMMANDS=("force")
				COMPREPLY=($(compgen -W "${COMMANDS[*]}" "${COMP_WORDS[2]}"))
				return
			fi

			return
			;;

		*)
			if [ "${#COMP_WORDS[@]}" != "2" ]; then
				return
			fi

			COMMANDS=("status")
			COMMANDS+=("add")
			COMMANDS+=("enable")
			COMMANDS+=("disable")
			COMMANDS+=("read-logs")
			COMMANDS+=("output-logs")
			COMMANDS+=("error-logs")
			COMMANDS+=("install")
			COMMANDS+=("update")
			COMMANDS+=("node-update")
			COMMANDS+=("enable-node-update")
			COMMANDS+=("disable-node-update")
			COMMANDS+=("change-api-key")
			COMMANDS+=("change-node-key")
			COMMANDS+=("setup-autocomplete")
			COMMANDS+=("generate-ssh")
			COMMANDS+=("cron")
			COMMANDS+=("set-path")
			COMMANDS+=("regenerate")
			COMMANDS+=("stop")
			COMMANDS+=("start")
			COMMANDS+=("restart")
			COMMANDS+=("migrate")
			COMMANDS+=("adjust-sudo-permissions")
			COMMANDS+=("set-user")

			COMPREPLY=($(compgen -W "${COMMANDS[*]}" "${COMP_WORDS[1]}"))
			return
			;;
	esac

	COMPREPLY=("")
}

complete -F _completions idena-manager
