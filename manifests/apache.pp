class dehydrated::apache {
  include dehydrated

  include apache

  apache::custom_config { 'dehydrated':
    ensure  => present,
    content => epp('dehydrated/apache_alias.conf.epp'),
  }
}
