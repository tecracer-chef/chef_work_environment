#
# Cookbook:: chef_work_environment
# Recipe:: packages
#
# Copyright:: 2021, tecRacer Opensource, Apache-2.0.

# Basic distribution packages

# TODO: Add yq as package in here again
%w(jq yamllint direnv).each do |pkg|
  next if platform_family?('rhel') && pkg == 'direnv'
  package pkg do
    action :install
  end
end

# Additional distribution packages (controlled via attributes)
node['chef_work_environment']['packages']['system']&.each do |pkg_name, pkg_version|
  package pkg_name do
    version pkg_version
    action :install
  end
end

# Basic gems
# TODO: Add current major version
%w(mdl overcommit chef-raketasks).each do |gem|
  chef_gem gem do
    clear_sources true
    include_default_source false
    source node['chef_work_environment']['source']['gems']
    action :install
  end
end

# Additional gem packages (controlled via attributes)
node['chef_work_environment']['packages']['gems']&.each do |gem_name, gem_version|
  chef_gem gem_name do
    version gem_version

    clear_sources true
    include_default_source false
    source node['chef_work_environment']['source']['gems']
    action :install
  end
end
