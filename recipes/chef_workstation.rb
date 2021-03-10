#
# Cookbook:: chef_work_environment
# Recipe:: chef_workstation
#
# Copyright:: 2021, tecRacer Opensource, Apache-2.0.

# TODO: set environment variables (maybe via script?) for kitchen.vcenter etc.
chef_workstation = node['chef_work_environment']['chef_workstation']

package 'chef-workstation' do
  source chef_workstation['source_path'] unless chef_workstation['source_path'].nil?
  version chef_workstation['version'] unless chef_workstation['version'].nil?
  action :install
end

template '/etc/profile.d/chef-init.sh' do
  source 'profiled-chef-init.sh.erb'
  variables(
    use_shell: chef_workstation['shell']
  )
  mode '0755'
end

template '/etc/profile.d/chef-env-vars.sh' do
  source 'profiled-chef-env-vars.sh.erb'
  variables(
    rubygems_host: node['chef_work_environment']['source']['gems'],
    chef_omnitruck: node['chef_work_environment']['source']['omnitruck'],
    chef_server: node['chef_work_environment']['source']['chef_server'],
    chef_supermarket: node['chef_work_environment']['source']['supermarket'],

    attribute_env_vars: Hash(node['chef_work_environment']['env-vars'])
  )
  mode '0755'
end

# create skeleton for first login of a user
directory '/etc/skel/.chef' do
  action :create
end

# TODO: Use environment variable OR defaults in config.rb?
# TODO: Should we put this really into skel file or loop through users? -> Put in profile.d chef-init.sh
# TODO: What are we doing in here when this file is used by gitlab-runner?
# TODO: Force client override as attribute!!!
# create skeleton file for default config.rb
template '/etc/skel/.chef/config.rb' do
  source 'skel-chef-config.rb.erb'
end

# System-wide client configuration
template '/etc/chef/client.rb' do
  source 'skel-chef-config.rb.erb'
end

# gem source
gem_sources = Array(node['chef_work_environment']['source']['gems'])
unless gem_sources.empty?
  gem_output = shell_out('gem environment')
  raise 'Could not find `gem` command' unless gem_output.exitstatus.zero?

  gemrc_dir = gem_output.stdout.match(/SYSTEM CONFIGURATION DIRECTORY: (.*)$/).captures&.first
  raise 'Could not find RubyGems system configuration directory' if gemrc_dir.empty?

  # Point to Chef Workstation, not Chef Client
  template '/opt/chef-workstation/embedded/etc/gemrc' do
    source 'gemrc.erb'
    variables(
      gem_sources: gem_sources
    )
    mode '0644'

    not_if { gem_sources.empty? }
  end
end
