#
# Cookbook:: chef_work_environment
# Recipe:: vault
#
# Copyright:: 2021, tecRacer Opensource, Apache-2.0.

vault_archive = File.join(Chef::Config[:file_cache_path], 'vault.zip')

remote_file vault_archive do
  source node['chef_work_environment']['vault']['uri']
  checksum node['chef_work_environment']['vault']['checksum']
end

archive_file vault_archive do
  destination '/usr/local/bin/'
  mode '0755'
  overwrite :auto
  action :extract
end

template '/etc/profile.d/vault-env-vars.sh' do
  source 'profiled-vault-env-vars.sh.erb'
  variables(
    vault_addr: node['chef_work_environment']['vault']['endpoint'],
    vault_token: node['chef_work_environment']['vault']['token'],
    vault_skip_verify: node['chef_work_environment']['vault']['skip_verify']
  )
  mode '0755'
  sensitive true
end
