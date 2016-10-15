# Type: eclipse::plugins
#
# This type installs Eclipse plugins via eclipse::plugin
#

define eclipse::plugins (
	$plugins,
	$releasename,
) {
	eclipse::plugin { $name:
		iu          => $plugins[$name]['iu'],
		repository  => $plugins[$name]['repository'],
		releasename => $releasename,
	}

}