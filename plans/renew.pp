plan dehydrated::renew (
  TargetSpec $targets,
) {
  run_task('dehydrated::renew', $targets, _run_as => 'dehydrated')
}
