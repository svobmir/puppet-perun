class perun::config (
  $ensure,
  $user,
  $allow_from,
  $ssh_key,
  $ssh_type,
  $perun_conf
) {
  $_ensure = $ensure ? {
    latest    => present,
    default   => $ensure
  }

  ssh_authorized_key { 'perunv3':
    ensure  => $_ensure,
    key     => $ssh_key,
    type    => $ssh_type,
    user    => $user,
    options => [
      "from=\"${allow_from}\"",
      'command="/opt/perun/bin/perun"',
      'no-pty',
      'no-X11-forwarding',
      'no-agent-forwarding',
      'no-port-forwarding',
      'no-user-rc'
    ],
  }

  if $perun_conf {
    concat { $perun_conf:
      ensure => $_ensure,
      mode   => '0644',
    }

    perun::conf { 'header':
      perun_conf => $perun_conf,
      order      => 0,
      content    => '# This file is managed by Puppet!',
    }
  }
}
