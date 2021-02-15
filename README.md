# chef_work_environment

TODO: Enter the cookbook description here.

chef-workstation

- with pre-defined version
- set environment variables (maybe via script?) for kitchen.vcenter etc.

gitlab-runner

gem installation via attributes

- chef-raketasks
- custom_cookstyle
- custom_raketasks
- cookbook_generator

additional packages

- yq
- jq
- yamllint
- mdl gem
- direnv apt
- overcommit gem
- vault cli: install = false

Policyfiles for

- customer specific settings
  - pfgroup: gitlab-runner (CI)
  - pfgroup: gitlab-runner (CI-Canary)
  - pfgroup: workstation (WS)
  - pfgroup: workstation Canary (WS-Canary)

## Supported OS

- Windows 2012R2 and 2019

## Usage

- Use json/attributes to set parameters
- Use default recipe in RunList

```json
{
  "chef_work_environment": {
    "attrib1": "",
    "attrib2": ""
  }
}
```

TODO: More like an example for an additional gem

```ruby
default['chef_work_environment']['packages']['gems'] = [
  {
    name: 'tecracer',
    version: '0.1.0',
  },
]
```

## Attributes

The attributes used by this cookbook:

Attribute      | Description                  | Type    | Default
-------------- | ---------------------------- | ------- | ----------------------
attrib1        | Example attribute 1          | String  | example
attrib2        | Example attribute 2          | Boolean | false

## Recipes

### default

- This recipe install/configure chef_work_environment

## License and Authors

- Author: Patrick Schaumburg (pschaumburg@tecracer.de)
- Copyright tecRacer
- Licensed under Apache-2.0
