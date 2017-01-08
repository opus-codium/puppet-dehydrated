class dehydrated::apache {
  include ::dehydrated

  include ::apache

  $etcdir = $dehydrated::etcdir

  apache::custom_config { 'dehydrated':
    ensure  => present,
    content => template('dehydrated/apache_alias.conf.erb'),
  }
}
