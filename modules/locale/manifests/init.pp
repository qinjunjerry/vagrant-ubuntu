# This puppet module manages locale

class locale (
  $user      = 'vagrant',
  $lc_time   = 'en_US.UTF-8',
) {

	file { '.pam_environment':
	  ensure => present,
	  path   => "/home/$user/.pam_environment",
	} ->

	file_line { '.pam_environment':
	  ensure => present,
	  path   => "/home/$user/.pam_environment",
	  line   => "LC_TIME=$lc_time",
	  match  => '^LC_TIME\=',
	}
}