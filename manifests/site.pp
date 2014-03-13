stage { 'bootstrap':
  before => Stage['main'],
}

Exec {
  path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
}

node 'grunt' {
  class { 'kickstandproject::grunt::init': }
}
