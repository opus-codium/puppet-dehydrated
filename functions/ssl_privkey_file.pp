# Return the full path to a private key file
# @param hostname The name of the host to consider
# @return [String] The path of the private key file
function dehydrated::ssl_privkey_file(String $hostname) {
  $certsdir = dehydrated::certsdir()
  $ssl_privkey_file  = "${certsdir}/${hostname}/privkey.pem"
}
