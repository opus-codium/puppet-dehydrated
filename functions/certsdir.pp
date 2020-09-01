# Return the root directory of dehydrated certificates
# @return [String] The directory of dehydrated certificates
function dehydrated::certsdir() {
  "${dehydrated::etcdir}/certs"
}
