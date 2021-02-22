#
# Cookbook:: chef_work_environment
# Recipe:: source_config
#
# Copyright:: 2021, tecRacer Opensource, Apache-2.0.

# https://docs.chef.io/packages/
case node['platform_family']
when 'debian'
  apt_repository 'chef' do
    uri node['chef_work_environment']['source']['debian']['uri']
    # distribution '/'
    components ['main']
    key node['chef_work_environment']['source']['debian']['key']
    action :add
  end

when 'rhel', 'amazon', 'suse'
  include_recipe 'yum-epel::default' if node['chef_work_environment']['packages']['use_epel']

  yum_repository 'chef' do
    baseurl node['chef_work_environment']['source']['rhel']['baseuri']
    gpgkey node['chef_work_environment']['source']['rhel']['gpgkey']
    action :create
    only_if { rhel? || amazon? }
  end

  zypper_repository 'chef' do
    baseurl node['chef_work_environment']['source']['suse']['baseuri']
    gpgkey node['chef_work_environment']['source']['suse']['gpgkey']
    action :create
    only_if { suse? }
  end
end

# apt source
# rhel source
# gem source
