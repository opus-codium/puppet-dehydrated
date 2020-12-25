# @summary Manage dehydrated
#
# @param apache_user
# @param bin
# @param etcdir
# @param group
# @param package
# @param user
# @param repo_source
# @param repo_revision
# @param dependencies
# @param apache_integration
# @param cron_integration
# @param ip_version
# @param ca
# @param ca_terms
# @param license
# @param challengetype
# @param keysize
# @param openssl_cnf
# @param hook
# @param hook_chain
# @param renew_days
# @param private_key_renew
# @param private_key_rollover
# @param key_algo
# @param contact_email
# @param ocsp_must_staple
# @param timeout
class dehydrated (
  String                      $apache_user,
  String                      $bin,
  String                      $etcdir,
  Optional[String]            $package,

  String                      $group         = 'dehydrated',
  String                      $user          = 'dehydrated',
  String                      $repo_source   = 'https://github.com/lukas2511/dehydrated.git',
  String                      $repo_revision = 'v0.7.0',

  Array[String]               $dependencies = [],

  Boolean                     $apache_integration = false,
  Boolean                     $cron_integration   = false,

  Optional[Variant[Integer[4,4],Integer[6,6]]]     $ip_version           = undef,
  Optional[Stdlib::Httpurl]                        $ca                   = undef,
  Optional[Stdlib::Httpurl]                        $ca_terms             = undef,
  Optional[String]                                 $license              = undef,
  Optional[Enum['http-01', 'dns-01']]              $challengetype        = undef,
  Optional[Integer[0]]                             $keysize              = undef,
  Optional[String]                                 $openssl_cnf          = undef,
  Optional[String]                                 $hook                 = undef,
  Optional[Boolean]                                $hook_chain           = undef,
  Optional[Integer[0]]                             $renew_days           = undef,
  Optional[Boolean]                                $private_key_renew    = undef,
  Optional[Boolean]                                $private_key_rollover = undef,
  Optional[Enum['rsa', 'prime256v1', 'secp384r1']] $key_algo             = undef,
  String                                           $contact_email, # lint:ignore:parameter_order
  Optional[Boolean]                                $ocsp_must_staple     = undef,
  Optional[Integer[0]]                             $timeout              = undef,
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
