node default {

### This changes the system default setttings, and works only for newly created users
# 	file { "50_unity-settings-daemon.gschema.override":
# 		ensure  => file,
# 		path    => "/usr/share/glib-2.0/schemas/50_unity-settings-daemon.gschema.override",
# 		content => "[com.canonical.Unity.Launcher]
# favorites=['application://org.gnome.Nautilus.desktop', 'application://gnome-terminal.desktop', 'application://firefox.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']
# ",
# 	} ->
# 	exec { "glib-compile-schemas":
# 		command => "/usr/bin/glib-compile-schemas /usr/share/glib-2.0/schemas/",
# 		logoutput => on_failure,
# 	}

	### This works when user is not logged in yet
	exec { 'set-launcher-favorites-dbus':
		user    => 'vagrant',
		command => "/usr/bin/dbus-run-session /usr/bin/gsettings set com.canonical.Unity.Launcher favorites \"[
							'application://org.gnome.Nautilus.desktop',
							'application://gnome-terminal.desktop',
							'application://firefox.desktop',
							'unity://running-apps',
							'unity://expo-icon',
							'unity://devices'
					]\"
		",
		logoutput => on_failure,
	}

	### This works only when user logged into X: meaning there is an active dbus session seen in
	### /run/user/$UID/dbus-session
	# exec { 'set-launcher-favorites':
	# 	user    => 'vagrant',
	# 	command => "/bin/bash -c \"
	# 					. /vagrant/discover_session_bus_address.sh;
	# 					/usr/bin/gsettings set com.canonical.Unity.Launcher favorites \\\"[
	# 						'application://org.gnome.Nautilus.desktop',
	# 						'application://gnome-terminal.desktop',
	# 						'application://firefox.desktop',
	# 						'unity://running-apps',
	# 						'unity://expo-icon',
	# 						'unity://devices'
	# 					]\\\"
	# 				\"
	# 	",
	# 	logoutput => on_failure,
	# }
}