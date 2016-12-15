# This puppet module manages ubuntu gnome settings

class gsettings (
  String $user             = 'vagrant',
  String $time_format      = '24-hour',
  Array[String] $favorites = [],
) {

	##### set time format
	exec { 'set-time-format':
		user      => $user,
		command   => join( ["/usr/bin/dbus-run-session /usr/bin/gsettings set com.canonical.indicator.datetime time-format", " ", $time_format] ),
		logoutput => on_failure,
		require   => Package['ubuntu-desktop']
	}

	##### set Launcher favorite (app icons on Launcher bar)
	if size($favorites) > 0 {
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
			user      => $user,
			command   => join( ["/usr/bin/dbus-run-session /usr/bin/gsettings set com.canonical.Unity.Launcher favorites \"[\'", join($favorites,'\',\''), "\']\""] ),
			logoutput => on_failure,
			require   => Package['ubuntu-desktop']
		}

		### This works only when user logged into X: meaning there is an active dbus session seen in
		### /run/user/$UID/dbus-session
		# exec { 'set-launcher-favorites':
		# 	user    => $user,
		# 	command => "/bin/bash -c \"
		# 					. /vagrant/discover_session_bus_address.sh;
		# 					/usr/bin/gsettings set com.canonical.Unity.Launcher favorites \\\"[
		#                   join($favorites,',')
		# 					]\\\"
		# 				\"
		# 	",
		# 	logoutput => on_failure,
		# }

	}
}