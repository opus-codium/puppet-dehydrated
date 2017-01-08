class { 'dehydrated':
  contact_email => 'user@example.com',
}

dehydrated::certificate { 'example.com':
  domains => ['www.example.com'],
}
