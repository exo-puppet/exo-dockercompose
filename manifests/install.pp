class dockercompose::install {
  file { '/usr/lib/docker-compose' :
    ensure  => $dockercompose::present ? {
      true    => directory,
      default => absent
    },
    owner   => 'root',
    group   => 'root',
    force   => true,
  } ->
  exec { "docker-compose" :
    command => "/usr/bin/curl -L https://github.com/docker/compose/releases/download/${dockercompose::version}/docker-compose-${kernel}-${hardwaremodel} > /usr/bin/docker-compose",
    creates => "${dockercompose::params::target_file}",
    require => [Package["curl"]],
    onlyif  => "bash -c $dockercompose::present";
  } ->
  file { "${dockercompose::params::target_file}" :
    mode    => 555,
    owner   => root,
    group   => root,
  } ->
  file { "/etc/alternatives/docker-compose" :
    ensure  => $dockercompose::present ? {
      true    => link,
      default => absent
    },
    target  => "${dockercompose::params::target_file}",
  } ->
  file { '/usr/bin/docker-compose' :
    ensure  => $dockercompose::present ? {
      true    => link,
      default => absent
    },
    target  => '/etc/alternatives/docker-compose'
  }
}
