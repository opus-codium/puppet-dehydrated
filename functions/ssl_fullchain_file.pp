# Return the full path to a certificate fullchain file
# @param hostname The name of the host to consider
# @return [String] The path of the certificate fullchain file
function dehydrated::ssl_fullchain_file(String $hostname) >> String {
  "${dehydrated::certsdir()}/${hostname}/fullchain.pem"
}
