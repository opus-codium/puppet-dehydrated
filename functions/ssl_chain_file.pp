# Return the full path to a certificate chain file
# @param hostname The name of the host to consider
# @return [String] The path of the cerificate chain file
function dehydrated::ssl_chain_file(String $hostname) {
  $certsdir = dehydrated::certsdir()
  $ssl_chain_file  = "${certsdir}/${hostname}/chain.pem"
}
