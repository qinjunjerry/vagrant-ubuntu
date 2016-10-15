# Type: eclipse::plugin
#
# This type installs a Eclipse plugin via the Eclipse p2 director
#
define eclipse::plugin (
  $iu          = '',
  $repository  = '',
  $releasename = '',
  $ensure      = present,
) {

  if $iu == '' {
    fail("plugin IU must not be empty")
  }

  if $repository == '' {
    $repositoryurl = "http://download.eclipse.org/releases/$releasename"
  } else {
    $repositoryurl = $repository
  }

  $eclipsecmd = "${eclipse::installdir}/eclipse/eclipse -application org.eclipse.equinox.p2.director -noSplash"
  $checkcmd   = "${eclipsecmd} -listInstalledRoots | egrep '^${iu}(/|$)'"

  if $ensure == present {
    exec { "eclipse-p2-director: install ${title}":
      command => "${eclipsecmd} -repository '${repositoryurl}' -installIU '${iu}'",
      unless  => $checkcmd,
    }
  } else {
    exec { "eclipse-p2-director: uninstall ${title}":
      command => "${eclipsecmd} -uninstallIU '${iu}'",
      onlyif  => $checkcmd,
    }
  }

}
