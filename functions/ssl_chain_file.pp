function dehydrated::ssl_chain_file($hostname) {
  $certsdir = dehydrated::certsdir()
  $ssl_chain_file  = "${certsdir}/${hostname}/chain.pem"
}
