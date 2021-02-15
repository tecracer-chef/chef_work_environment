#
# Cookbook:: chef_work_environment
# Recipe:: source_config
#
# Copyright:: 2020, The Authors, All Rights Reserved.


# https://docs.chef.io/packages/

puts node['platform_family']

case node['platform_family']
when 'debian'
  apt_repository 'chef' do
    uri 'https://packages.chef.io/repos/apt/stable' # TODO: as attribute
    # distribution '/'
    components ['main']
    key 'https://packages.chef.io/chef.asc'
    action :add
  end

when 'rhel', 'amazon', suse
  include_recipe 'yum-epel::default' if node['chef_work_environment']['packages']['use_epel']

  pversion =  if amazon?
                '7'
              elsif suse?
                '8'
              else
                node['platform_version'].split('.').first
              end

  yum_repository 'chef' do
    baseurl "https://packages.chef.io/repos/yum/stable/el/#{pversion}/$basearch/"
    gpgkey 'https://packages.chef.io/chef.asc'
    action :create
    only_if rhel? || amazon?
  end

  zypper_repository 'chef' do
    baseurl "https://packages.chef.io/repos/yum/stable/el/#{pversion}/$basearch/"
    gpgkey 'https://packages.chef.io/chef.asc'
    action :create
    only_if suse?
  end
end


# apt source
# rhel source
# gem source
