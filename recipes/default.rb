#
# Cookbook:: chef_work_environment
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

include_recipe 'chef_work_environment::source_config'
include_recipe 'chef_work_environment::packages'
include_recipe 'chef_work_environment::chef_workstation'
include_recipe 'chef_work_environment::gitlab_runner'
