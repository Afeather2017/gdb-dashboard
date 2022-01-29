# Copy these to you shellrc file,
# then run debug when you opened an tmux window.
# I think you will like the layout.

function filter_tmux_pane_id(){
	tmux list-panes -F "#{pane_id} #{pane_tty}" | grep "$1" | grep -Po '%\d+'
}
function select_tmux_pane_by_id(){
	tmux select-pane -t "$1"
}
function neopane(){
	NEOPANE=$(tmux list-panes -F "#{pane_id} #{pane_tty}" | grep -v $1)
		for i in $@;do
            NEOPANE=$(echo $NEOPANE | grep -v $i)
		done
	echo $NEOPANE
}
TTY_SRC=""
PANEID_SRC=""
TTY_CMD=""
PANEID_CMD=""
TTY_VAR=""
PANEID_VAR=""
PANESRC_HEIGHT=31
PANEVAR_WIDTH=70
function debug(){
	TTY_CMD=$TTY
	PANEID_CMD=$(filter_tmux_pane_id $TTY_CMD)

	tmux split-window -v

	NEOPANE=($(neopane $TTY_CMD))
	TTY_SRC=${NEOPANE[2]}
	PANEID_SRC=${NEOPANE[1]}

	tmux select-pane -t $PANEID_SRC
	tmux swap-pane -t $PANEID_SRC -t $PANEID_CMD

	tmux select-pane -t $PANEID_SRC
	tmux resize-pane -y $PANESRC_HEIGHT

	tmux split-window -h;
	NEOPANE=($(neopane $TTY_SRC $TTY_CMD))
	TTY_VAR=${NEOPANE[2]}
	PANEID_VAR=${NEOPANE[1]}

	tmux select-pane -t $PANEID_VAR
	tmux resize-pane -x $PANEVAR_WIDTH

	tmux select-pane -t $PANEID_CMD

	alias gdb='gdb -q -ex "dashboard source -output $TTY_SRC" -ex "dashboard variables -output $TTY_VAR" -ex "dashboard source -style height $PANESRC_HEIGHT" '
}

function fgdb(){
	# Debugging
	echo "gdb.${1}"
	# script
	echo "break.${1}"
	# break recordings
	gdb -q -ex "dashboard source -output $TTY_SRC" -ex "dashboard variables -output $TTY_VAR" -ex "dashboard source -style height $PANESRC_HEIGHT" -x "gdb.${1}" -x "break.${1}" $*
}
