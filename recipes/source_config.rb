#
# Cookbook:: chef_work_environment
# Recipe:: source_config
#
# Copyright:: 2020, The Authors, All Rights Reserved.


# https://docs.chef.io/packages/

# when debian
package 'apt-transport-https' do
  action :install
end

# run: wget -qO - https://packages.chef.io/chef.asc | sudo apt-key add -
# echo "deb https://packages.chef.io/repos/apt/<CHANNEL> <DISTRIBUTION> main" > chef-<CHANNEL>.list

# apt source
# rhel source
# gem source
