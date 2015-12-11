class dockercompose::params {
  $install_directory  = '/usr/lib/docker-compose'
  $target_file          = "${install_directory}/docker-compose-${dockercompose::version}"
}
