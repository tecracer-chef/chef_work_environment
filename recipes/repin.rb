#
# Cookbook:: chef_work_environment
# Recipe:: source_config
#
# Copyright:: 2021, tecRacer Opensource, Apache-2.0.

gem_versions = node['chef_work_environment']['repin']

wrappers = %w(kitchen inspec chef-client knife cookstyle chef-solo)
wrappers.each do |wrapper|
  repin_dependencies wrapper do
    override gem_versions

    not_if { gem_versions&.empty? }
  end
end
