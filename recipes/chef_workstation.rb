#
# Cookbook:: chef_work_environment
# Recipe:: chef_workstation
#
# Copyright:: 2021, tecRacer Opensource, Apache-2.0.

# TODO: set environment variables (maybe via script?) for kitchen.vcenter etc.
chef_workstation = node['chef_work_environment']['chef_workstation']
alternate_sources = node['chef_work_environment']['source']

# Parameter parity between Debian/Ubuntu and other platforms
chef_workstation_version = chef_workstation['version']
chef_workstation_version += '-1' if debian? && chef_workstation_version

package 'chef-workstation' do
  source chef_workstation['source_path'] unless chef_workstation['source_path'].nil?
  version chef_workstation_version unless chef_workstation_version.nil?
  action :install
end

# Setup autocompletion globally
template '/etc/profile.d/chef-init.sh' do
  source 'profiled-chef-init.sh.erb'
  variables(
    use_shell: chef_workstation['shell']
  )
  mode '0755'
end

# Setup environment variables globally
template '/etc/profile.d/chef-env-vars.sh' do
  source 'profiled-chef-env-vars.sh.erb'
  variables(
    rubygems_host: alternate_sources['gems'],
    chef_omnitruck: alternate_sources['omnitruck'],
    chef_server: alternate_sources['chef_server'],
    chef_server_org: alternate_sources['chef_server_org'],
    chef_supermarket: alternate_sources['supermarket'],

    attribute_env_vars: Hash(node['chef_work_environment']['env-vars'])
  )
  mode '0755'
  sensitive true
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
#   Users might be in a different org interacting with the Chef Server
template '/etc/skel/.chef/config.rb' do
  source 'skel-chef-config.rb.erb'

  variables(
    chef_server: alternate_sources['chef_server'],
    # chef_server_org override via CHEF_SERVER_ORG environment variable
    chef_supermarket: alternate_sources['supermarket'],
    rubygems_host: alternate_sources['gems'],

    ssl_verify: chef_workstation['chef_config']['ssl_verify']
  )
end

directory '/etc/chef/client.d' do
  recursive true
  action :create
end

# System-wide client configuration
#   This system might be bootstrapped for continuous management
template '/etc/chef/client.rb' do
  source 'etc-chef-client.rb.erb'

  variables(
    chef_server: alternate_sources['chef_server'],
    chef_server_org: alternate_sources['chef_server_org'],
    chef_supermarket: alternate_sources['supermarket'],
    rubygems_host: alternate_sources['gems'],

    ssl_verify: chef_workstation['chef_config']['ssl_verify']
  )
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
      gem_sources: gem_sources,
      ssl_verify: chef_workstation['chef_config']['ssl_verify']
    )
    mode '0644'

    not_if { gem_sources.empty? }
  end
end
