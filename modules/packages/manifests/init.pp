# Class: package
#
# This module installs simple packages via puppet package resource
#
class packages (
  $toinstall = [],
  $toremove  = [],
) {

  $toinstall.each |$name| {
    package { $name:
      ensure => present,
    }
  }

  $toremove.each |$name| {
    package { $name:
      ensure => absent,
    }
  }

}