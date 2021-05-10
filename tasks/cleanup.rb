#!/usr/bin/env ruby

require 'fileutils'

managed_domains = []

[
  '/home/dehydrated/domains.txt',
  '/usr/local/etc/dehydrated/domains.txt',
].each do |domains_txt|
  next unless File.readable?(domains_txt)

  managed_domains = File.readlines(domains_txt).map(&:split).map(&:first)
end

Dir['/home/dehydrated/certs/*', '/usr/local/etc/dehydrated/certs/*'].each do |directory|
  next if managed_domains.include?(File.basename(directory))

  FileUtils.rm_r(directory)
end
