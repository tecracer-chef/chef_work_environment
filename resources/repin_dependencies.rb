resource_name :repin_dependencies
provides :repin_dependencies

property :wrapper, String, name_property: true
property :override, Hash, default: {}
property :base_path, String, default: '/opt/chef-workstation/bin', desired_state: false

default_action :apply

action :apply do
  wrapper_path = ::File.join(new_resource.base_path, new_resource.wrapper)
  raise "File #{wrapper_path} not found to repin dependencies" unless ::File.exist? wrapper_path

  new_contents = ::File.read(wrapper_path)
  old_contents = new_contents.dup

  new_resource.override.each do |gem, version|
    new_contents.gsub!(/(?<=#{gem.to_s}"), "= [.0-9]+"/, ", \"= #{version}\"")
  end

  ::File.write(wrapper_path, new_contents) unless old_contents == new_contents
end
