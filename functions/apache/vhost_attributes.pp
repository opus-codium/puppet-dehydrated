function dehydrated::apache::vhost_attributes($hostname) {
  {
    'ssl_cert'  => dehydrated::ssl_fullchain_file($hostname),
    'ssl_key'   => dehydrated::ssl_privkey_file($hostname),
  }
}
