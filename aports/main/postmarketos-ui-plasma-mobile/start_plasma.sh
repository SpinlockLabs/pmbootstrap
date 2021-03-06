if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=/tmp/$(id -u)-runtime-dir
	if ! test -d "${XDG_RUNTIME_DIR}"; then
		mkdir "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi

	if [ $(tty) = "/dev/tty1" ]; then
		udevadm trigger
		udevadm settle
	
		console-kit-daemon
		dbus-launch

		sleep 2
		ck-launch-session kwin_wayland --drm --xwayland -- plasma-phone 2>&1 | logger -t "$(whoami):plasma-mobile"
	fi
fi
