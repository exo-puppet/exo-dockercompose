class dockercompose::install {
  if $dockercompose::present {
    exec {
      "docker-compose" :
        command => "/usr/bin/curl -L https://github.com/docker/compose/releases/download/${dockercompose::version}/docker-compose-${kernel}-${hardwaremodel} > /usr/bin/docker-compose",
        creates => "/usr/bin/docker-compose",
        require => [Package["curl"]];
    }
  }
  file {
    "/usr/bin/docker-compose" :
      ensure => $docker::present ? {
        true    => present,
        default => absent
      },
      mode => 755,
      require => [Exec["docker-compose"]];
  }
}
