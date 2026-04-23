# Return the full path to a certificate chain file
# @param hostname The name of the host to consider
# @return [String] The path of the certificate chain file
function dehydrated::ssl_chain_file(String $hostname) >> String {
  "${dehydrated::certsdir()}/${hostname}/chain.pem"
}
