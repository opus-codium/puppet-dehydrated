# Return the full path to a certificate fullchain file
# @param hostname The name of the host to consider
# @return [String] The path of the cerificate fullchain file
function dehydrated::ssl_fullchain_file(String $hostname) {
  $certsdir = dehydrated::certsdir()
  $ssl_chain_file  = "${certsdir}/${hostname}/fullchain.pem"
}
