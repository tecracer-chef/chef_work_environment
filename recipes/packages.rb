#
# Cookbook:: chef_work_environment
# Recipe:: packages
#
# Copyright:: 2020, Patrick Schaumburg, All Rights Reserved.

# Basic distribution packages
# TODO: Add version to dist packages
%w(yq jq yamllint direnv).each do |pkg|
  package pkg do
    action :install
  end
end

# Additional distribution packages (controlled via attributes)
node['chef_work_environment']['packages']['from_distribution']&.each do |pkg|
  package pkg['name'] do
    version pkg['version']
    action :install
  end
end

# TODO: REMOVE
# + chef-raketasks
# + custom_cookstyle
# + custom_raketasks
# + cookbook_generator

# Basic gems
# TODO: Add version to gems
%w(mdl overcommit chef-raketasks custom_cookstyle custom_raketasks cookbook_generator).each do |gem|
  gem_package gem do
    action :install
  end
end

# Additional gem packages (controlled via attributes)
node['chef_work_environment']['packages']['gems']&.each do |gem|
  gem_package gem['name'] do
    version gem['version']
    action :install
  end
end

# TODO: - vault cli: install = false
