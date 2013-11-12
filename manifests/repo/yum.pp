class perun::repo::yum (
  $ensure  = $perun::params::ensure,
  $baseurl = $perun::params::baseurl,
  $gpgkey  = $perun::params::gpgkey
) inherits perun::params {

  $_ensure = $ensure ? {
    latest  => present,
    default => $ensure
  }

  yum::gpgkey { $gpgkey:
    ensure => $_ensure,
    source => 'puppet:///modules/perun/RPM-GPG-KEY-perunv3',
  }

  yumrepo { 'perunv3':
    enabled  => 1,
    gpgcheck => 1,
    descr    => 'Perun repository',
    baseurl  => $baseurl,
    gpgkey   => "file://${gpgkey}",
    require  => Yum::Gpgkey[$gpgkey],
  }
}
