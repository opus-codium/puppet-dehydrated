# Return the apache::vhost SSL configuration for a host
# @param hostname The name of the host to consider
# @return [Hash[String,String]] Virtual host configuration for the host
#
# @example
#   apache::vhost { $hostname:
#     port => 443,
#     ssl  => true,
#     [...]
#     *    => dehydrated::apache::vhost_attributes($hostname)
#   }
function dehydrated::apache::vhost_attributes(String $hostname) {
  {
    'ssl_cert'  => dehydrated::ssl_fullchain_file($hostname),
    'ssl_key'   => dehydrated::ssl_privkey_file($hostname),
  }
}
