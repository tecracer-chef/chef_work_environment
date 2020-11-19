#
# Cookbook:: chef_work_environment
# Recipe:: chef_workstation
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# chef-workstation
#   - with pre-defined version
#   - set environment variables (maybe via script?) for kitchen.vcenter etc.

chef_workstation = node['chef_work_environment']['chef_workstation']

package 'chef-workstation' do
  source chef_workstation['source_path'] unless chef_workstation['source_path'].nil?
  version chef_workstation['version'] unless chef_workstation['version'].nil?
  action :install
end

# TODO: bash config -> echo 'eval "$(chef shell-init SHELL_NAME)"' >> ~/.YOUR_SHELL_RC_FILE
# TODO: config.rb configuration with environment variables
