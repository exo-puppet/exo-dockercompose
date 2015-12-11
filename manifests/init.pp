class dockercompose (
  $present = true,
  $version,
) {
  include dockercompose::params
  include dockercompose::install
}
