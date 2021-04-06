#
# Cookbook:: chef_work_environment
# Recipe:: default
#
# Copyright:: 2021, tecRacer Opensource, Apache-2.0.

include_recipe 'chef_work_environment::source_config'
include_recipe 'chef_work_environment::packages'
include_recipe 'chef_work_environment::chef_workstation'
include_recipe 'chef_work_environment::repin'
