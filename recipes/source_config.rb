#
# Cookbook:: chef_work_environment
# Recipe:: source_config
#
# Copyright:: 2021, tecRacer Opensource, Apache-2.0.

# https://docs.chef.io/packages/
case node['platform_family']
when 'debian'
  # Completely switch to internal repos, if any given
  internal_repos = Array(node['chef_work_environment']['source']['debian']['internal'])

  file '/etc/apt/sources.list' do
    action :delete
    not_if { internal_repos.empty? }
  end

  internal_repos.each do |internal_repo|
    signing_key = internal_repo['key'].to_s

    apt_repository internal_repo['name'] do
      uri internal_repo['uri']
      components internal_repo['components'] || ['main']
      key signing_key unless signing_key.empty?
      action :add
    end
  end

  # Add Chef repository
  signing_key = node['chef_work_environment']['source']['debian']['key'].to_s
  apt_repository 'chef' do
    uri node['chef_work_environment']['source']['debian']['uri']
    components ['main']
    key signing_key unless signing_key.empty?
    action :add
  end

when 'rhel', 'amazon', 'suse'
  # TODO: Allow internal repos for these distributions

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
