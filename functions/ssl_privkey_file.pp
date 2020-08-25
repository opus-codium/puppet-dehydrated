function dehydrated::ssl_privkey_file($hostname) {
  $certsdir = dehydrated::certsdir()
  $ssl_privkey_file  = "${certsdir}/${hostname}/privkey.pem"
}
