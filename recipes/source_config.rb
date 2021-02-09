#
# Cookbook:: chef_work_environment
# Recipe:: source_config
#
# Copyright:: 2020, The Authors, All Rights Reserved.


# https://docs.chef.io/packages/

case node['platform_family']
when 'debian'
  apt_repository 'chef' do
    uri 'https://packages.chef.io/repos/apt/stable' # TODO: as attribute
    # distribution '/'
    components ['main']
    key 'https://packages.chef.io/chef.asc'
    action :add
  end

when 'rhel'
  include_recipe 'yum-epel::default' if node['chef_work_environment']['packages']['use_epel']

  yum_repository 'chef' do
    baseurl "https://packages.chef.io/repos/yum/stable/el/#{node['platform_version'].split('.').first}/$basearch/"
    gpgkey 'https://packages.chef.io/chef.asc'
    action :create
  end
end


# apt source
# rhel source
# gem source
