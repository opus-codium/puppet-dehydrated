# Return the full path to a certificate file
# @param hostname The name of the host to consider
# @return [String] The path of the certificate file
function dehydrated::ssl_cert_file(String $hostname) >> String {
  "${dehydrated::certsdir()}/${hostname}/cert.pem"
}
