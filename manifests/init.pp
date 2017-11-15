class dehydrated (
  String                      $contact_email,

  String                      $apache_user,
  String                      $bin,
  String                      $config,
  String                      $etcdir,
  String                      $group,
  Optional[String]            $package,
  String                      $user,

  Boolean                     $apache_integration = false,
  Boolean                     $cron_integration   = false,

  Optional[Boolean]           $private_key_renew = undef,
) {

  include dehydrated::user
  if $package {
    include dehydrated::package

    Class['dehydrated::user']
    -> Class['dehydrated::package']
    -> Class['dehydrated::config']
  } else {
    include dehydrated::repo

    Class['dehydrated::user']
    -> Class['dehydrated::repo']
    -> Class['dehydrated::config']
  }
  include dehydrated::config
  include dehydrated::domains
  include dehydrated::changed

  Class['dehydrated::config']
  -> Class['dehydrated::domains']
  -> Class['dehydrated::changed']

  Class['dehydrated::domains']
  ~> Class['dehydrated::changed']

  if $apache_integration {
    include dehydrated::apache
  }

  include dehydrated::cron
}
