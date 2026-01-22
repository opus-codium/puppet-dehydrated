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
# @param dehydrated_user Which user should dehydrated run as? This will be implicitly enforced when running as root.
# @param dehydrated_group Which group should dehydrated run as? This will be implicitly enforced when running as root.
# @param ip_version Resolve names to addresses of IP version only. (curl)
# @param ca URL to certificate authority or internal preset.
# @param oldca Path to old certificate authority
# @param challengetype Challenge type to be used.
# @param config_d Path to a directory containing additional config files.
# @param domains_d Directory for per-domain configuration files.
# @param basedir Base directory for account key, generated certificates and list of domains.
# @param domains_txt File containing the list of domains to request certificates for.
# @param certdir Output directory for generated certificates.
# @param alpncertdir Output directory for alpn verification certificates
# @param accountdir Directory for account keys and registration information.
# @param wellknown Output directory for challenge-tokens to be served by webserver or deployed in HOOK.
# @param keysize Default keysize for private keys.
# @param openssl_cnf Path to openssl config file.
# @param openssl Path to OpenSSL binary.
# @param curl_opts Extra options passed to the curl binary.
# @param hook Program or function called in certain situations.
# @param hook_chain Chain clean_challenge|deploy_challenge arguments together into one hook call per certificate.
# @param renew_days Minimum days before expiration to automatically renew certificate.
# @param private_key_renew Regenerate private keys instead of just signing new certificates on renewal.
# @param private_key_rollover Create an extra private key for rollover.
# @param key_algo Which public key algorithm should be used?
# @param contact_email E-mail address Let's Encrypt can use to reach you regarding your certificates.
# @param lockfile Lockfile location, to prevent concurrent access.
# @param ocsp_must_staple Option to add CSR-flag indicating OCSP stapling to be mandatory.
# @param ocsp_fetch Fetch OCSP responses.
# @param ocsp_days OCSP refresh interval.
# @param chaincache Issuer chain cache directory.
# @param auto_cleanup Automatic cleanup.
# @param auto_cleanup_delete Delete files during automatic cleanup instead of moving to archive.
# @param api ACME API version.
# @param preferred_chain Preferred issuer chain.
# @param acme_profile Request certificate with specific profile.
# @param order_timeout Amount of seconds to wait for processing of order until erroring out.
# @param keep_going Skip over errors during certificate orders and updating of OCSP stapling information.
# @param timeout Execution timeout for dehydrated tool.
class dehydrated (
  String                      $apache_user,
  String                      $bin,
  String                      $etcdir,
  Optional[String]            $package,

  String                      $group         = 'dehydrated',
  String                      $user          = 'dehydrated',
  String                      $repo_source   = 'https://github.com/dehydrated-io/dehydrated.git',
  String                      $repo_revision = 'v0.7.2',

  Array[String]               $dependencies = [],

  Boolean                     $apache_integration = false,
  Boolean                     $cron_integration   = false,

  Optional[String[1]]                              $dehydrated_user      = undef,
  Optional[String[1]]                              $dehydrated_group     = undef,
  Optional[Variant[Integer[4,4],Integer[6,6]]]     $ip_version           = undef,
  Optional[String[1]]                              $ca                   = undef,
  Optional[Stdlib::Httpurl]                        $oldca                = undef,
  Optional[Enum['http-01', 'dns-01']]              $challengetype        = undef,
  Optional[String[1]]                              $config_d             = undef,
  Optional[String[1]]                              $domains_d            = undef,
  Optional[String[1]]                              $basedir              = undef,
  Optional[String[1]]                              $domains_txt          = undef,
  Optional[String[1]]                              $certdir              = undef,
  Optional[String[1]]                              $alpncertdir          = undef,
  Optional[String[1]]                              $accountdir           = undef,
  String[1]                                        $wellknown            = "${dehydrated::etcdir}/.acme-challenges",
  Optional[Integer[0]]                             $keysize              = undef,
  Optional[String]                                 $openssl_cnf          = undef,
  Optional[String[1]]                              $openssl              = undef,
  Optional[String[1]]                              $curl_opts            = undef,
  Optional[String]                                 $hook                 = undef,
  Optional[Boolean]                                $hook_chain           = undef,
  Optional[Integer[0]]                             $renew_days           = undef,
  Optional[Boolean]                                $private_key_renew    = undef,
  Optional[Boolean]                                $private_key_rollover = undef,
  Optional[Enum['rsa', 'prime256v1', 'secp384r1']] $key_algo             = undef,
  String                                           $contact_email, # lint:ignore:parameter_order
  Optional[String[1]]                              $lockfile             = undef,
  Optional[Boolean]                                $ocsp_must_staple     = undef,
  Optional[Boolean]                                $ocsp_fetch           = undef,
  Optional[Integer[0]]                             $ocsp_days            = undef,
  Optional[String[1]]                              $chaincache           = undef,
  Optional[Boolean]                                $auto_cleanup         = undef,
  Optional[Boolean]                                $auto_cleanup_delete  = undef,
  Optional[String[1]]                              $api                  = undef,
  Optional[String[1]]                              $preferred_chain      = undef,
  Optional[String[1]]                              $acme_profile         = undef,
  Optional[Integer[0]]                             $order_timeout        = undef,
  Optional[Boolean]                                $keep_going           = undef,

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
