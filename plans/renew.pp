# Renew certificates about to expire
# @param targets Target fifor certificates renewal
plan dehydrated::renew (
  TargetSpec $targets,
) {
  run_task('dehydrated::renew', $targets, _run_as => 'dehydrated')
}
