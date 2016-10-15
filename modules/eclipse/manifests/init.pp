# Class: eclipse
#
# This module installs Eclipse and plugins
#
class eclipse (
  $packagetype  = 'jee',
  $releasename  = 'neon',
  $releaselevel = '1a',
  $mirrorurl    = 'http://ftp.fau.de',
  $installdir   = '/opt',
  $plugins      = {},
  $ensure       = present
) {

  $archsuffix = $::architecture ? {
    /i.86/           => '',
    /(amd64|x86_64)/ => '-x86_64',
    default          => "-${::architecture}"
  }

  $filename   = "eclipse-${packagetype}-${releasename}-${releaselevel}-linux-gtk${archsuffix}"
  $localfile  = "/opt/${filename}.tar.gz"
  $remotefile = "${mirrorurl}/eclipse/technology/epp/downloads/release/${releasename}/${releaselevel}/${filename}.tar.gz"
  # get plugins from hiera
  $pluginnames = keys($plugins)

  # first, create a directory
  file { "$installdir/$filename":
    ensure => directory,
  } ->
  # then, extract to the created directory with --strip-components=1
  archive { $localfile:
    ensure          => $ensure,
    extract         => true,
    extract_command => 'tar zxf %s --strip-components=1',
    extract_path    => "$installdir/$filename",
    creates         => "$installdir/$filename/eclipse",
    source          => $remotefile,
    # cleanup       => true, # do not set to true for idempotency reasons
  } ->
  # finally, create a symbolic link
  file { "$installdir/eclipse":
    ensure => 'link',
    target => "$installdir/$filename",
  } ->
  # create desktop file to be used on the launcher
  file { '/usr/share/applications/eclipse.desktop':
    ensure  => $ensure,
    content => template('eclipse/eclipse.desktop.erb'),
    mode    => 644,
    require => Archive[$localfile]
  } ->
  # install eclipse plugins
  eclipse::plugins { $pluginnames:
    plugins     => $plugins,
    releasename => $releasename,
  }

}