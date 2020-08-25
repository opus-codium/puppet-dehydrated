function dehydrated::ssl_cert_file($hostname) {
  $certsdir = dehydrated::certsdir()
  $ssl_cert_file  = "${certsdir}/${hostname}/cert.pem"
}
