#!/usr/bin/env ruby

require 'fileutils'
require 'open3'

require_relative '../../ruby_task_helper/files/task_helper.rb'

class OldCertificatesCleaner < TaskHelper
  def task(dehydrated_dir: nil, **kwargs)
    noop = kwargs[:_noop]

    if dehydrated_dir.nil?
      stdout, _stderr, _status = Open3.capture3('facter', 'osfamily')
      osfamily = stdout.strip
      dehydrated_dir = case osfamily
                       when 'FreeBSD'
                         '/usr/local/etc/dehydrated'
                       else
                         '/home/dehydrated'
                       end
    end

    domains_txt = File.join(dehydrated_dir, 'domains.txt')
    managed_domains = File.readlines(domains_txt).map(&:split).map(&:first)

    res = []

    Dir[File.join(dehydrated_dir, 'certs', '*')].each do |directory|
      next if managed_domains.include?(File.basename(directory))

      FileUtils.rm_r(directory, noop: noop)
      res << File.basename(directory)
    end

    res
  end
end

OldCertificatesCleaner.run if $PROGRAM_NAME == __FILE__
