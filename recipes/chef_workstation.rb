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
