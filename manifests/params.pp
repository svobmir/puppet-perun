class perun::params {
  $user = 'root'
  $allow_from = 'perun.ics.muni.cz'
  $ssh_key = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC26+QiDtZ3bnLiLllySgsImSPUX0/sFBmo//3PmqOsuJIBdWB5BLU5Ws+pTRxefqC8SHfI92ZQoGXe7aJniTXxbRPa0FZJ3fskAHwpbiJfstGVZ1hddBcHIvial3v5Rd++zRiKslDVTkXLlb+b1pTnjyTVbD/6kGILgnUz7RKY5DnXADVnmTdPliQCabhE41AhkWdcuWpHBNwvxONKoZJJpbuouDbcviX4lJu9TF9Ij62rZjcoNzg5/JiIKTcMVi8L04FTjyCMxKRzlo00IjSuapFnXQNNZUL5u/mfPA/HpyIkSAOiPXLhWy9UuBNo7xdrCmfTh1qUvzbuWXJZN3d9'
  $ssh_type = 'ssh-rsa'
  $ensure = latest
  $use_repo = true
  $own_repo_class = ''
  $require_class = ''
  $perun_dir = '/opt/perun/bin'
  $perun_conf = '/etc/perunv3.conf'
  $conf_append = true
  $packages_base = ['perun-slave-base','perun-slave-process-k5login-root']
  $packages_standard = ['perun-slave-process-group','perun-slave-process-passwd',
                        'perun-slave-process-mailaliases','perun-slave-process-mailaliases-generic']
                        
  $packages_extra = []
  $service = undef

  case $::operatingsystem {
    debian: {
      $baseurl = 'ftp://repo.metacentrum.cz/'
      $apt_repos = 'main'
      $apt_pin = 490
    }

    redhat,centos: {
      $baseurl = 'https://homeproj.cesnet.cz/rpm/perunv3/stable/noarch'
      $gpgkey = '/etc/pki/rpm-gpg/RPM-GPG-KEY-perunv3'
    }

    sles,sled: {
      $baseurl = 'https://homeproj.cesnet.cz/rpm/perunv3/stable/noarch'
      $gpgkey = '/etc/pki/RPM-GPG-KEY-perunv3'
    }

    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }
}
