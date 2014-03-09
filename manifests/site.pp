stage { 'bootstrap':
  before => Stage['main'],
}

Exec {
  path => '/bin:/sbin:/usr/bin:/usr/sbin',
}

node 'grunt' {
  class { 'kickstandproject::grunt::init': }
}
