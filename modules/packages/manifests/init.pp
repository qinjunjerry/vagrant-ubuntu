# Class: package
#
# This module installs simple packages via puppet package resource
#
class packages (
  $packages = {},
) {

  # install eclipse plugins with iteration in puppet 4
  $packages.each |$name, $ensure| {
    package { $name:
      ensure => $ensure,
    }
  }

}