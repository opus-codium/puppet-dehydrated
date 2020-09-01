# Return the full path to a certificate file
# @param hostname The name of the host to consider
# @return [String] The path of the cerificate file
function dehydrated::ssl_cert_file(String $hostname) {
  $certsdir = dehydrated::certsdir()
  $ssl_cert_file  = "${certsdir}/${hostname}/cert.pem"
}
