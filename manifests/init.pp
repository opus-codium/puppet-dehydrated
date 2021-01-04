# @summary Main class used to setup the system.
#
# @param apache_user User account of apache httpd.
# @param bin Path to the dehydrated command.
# @param etcdir Path to the dehydrated configuration directory.
# @param group Group of the user account used to manage certificates.
# @param package Name of the package providing dehydrated.
# @param user User account used to manage certificates.
# @param repo_source URL of the repository providing dehydrated.
# @param repo_revision Revision to fetch from the repository providing dehydrated.
# @param dependencies Extra dependencies needed to run dehydrated.
# @param apache_integration Setup apache to serve the generated challenges.
# @param cron_integration Setup cron to automatically renew certificates.
# @param ip_version Use only this IP version for name resolution.
# @param ca Path to certificate authority.
# @param ca_terms Path to certificate authority license terms redirect.
# @param license Path to license agreement.
# @param challengetype Challenge type to be used.
# @param keysize Default keysize for private keys.
# @param openssl_cnf Path to openssl config file.
# @param hook Program or function called in certain situations.
# @param hook_chain Chain clean_challenge|deploy_challenge arguments together into one hook call per certificate.
# @param renew_days Minimum days before expiration to automatically renew certificate.
# @param private_key_renew Regenerate private keys instead of just signing new certificates on renewal.
# @param private_key_rollover Create an extra private key for rollover.
# @param key_algo Which public key algorithm should be used?
# @param contact_email E-mail address Let's Encrypt can use to reach you regarding your certificates.
# @param ocsp_must_staple Option to add CSR-flag indicating OCSP stapling to be mandatory.
# @param timeout Execution timeout for dehydrated tool.
class dehydrated (
  String                      $apache_user,
  String                      $bin,
  String                      $etcdir,
  Optional[String]            $package,

  String                      $group         = 'dehydrated',
  String                      $user          = 'dehydrated',
  String                      $repo_source   = 'https://github.com/dehydrated-io/dehydrated.git',
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
