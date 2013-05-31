define c_icap::module(
  $absent = false
) {
  include c_icap

  $bool_absent=any2bool($absent)
  $manage_package = $bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  if $c_icap::module_package_prefix {
    package {
      "c-icap-${name}":
        ensure => $manage_package,
        name   => "${c_icap::module_package_prefix}${name}${c_icap::module_package_suffix}",
        noop   => $c_icap::bool_noops,
    }
  }
}
