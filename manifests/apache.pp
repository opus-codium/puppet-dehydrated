# @summary Serve challenges with Apache
class dehydrated::apache {
  include dehydrated

  include apache
  include apache::mod::alias

  apache::custom_config { 'dehydrated':
    ensure  => present,
    content => epp('dehydrated/apache_alias.conf.epp'),
  }
}
