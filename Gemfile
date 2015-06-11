source 'https://rubygems.org'

gem 'berkshelf'

# Uncomment these lines if you want to live on the Edge:
#
# group :development do
#   gem "berkshelf", github: "berkshelf/berkshelf"
#   gem "vagrant", github: "mitchellh/vagrant", tag: "v1.6.3"
# end
#
#group :plugins do
#   gem "vagrant-berkshelf"
#   gem "vagrant-omnibus"
#end
gem 'chefspec'

group :development do
  gem 'guard'
  gem 'guard-rspec'
end

group :integration do
    gem 'test-kitchen'
    gem 'kitchen-vagrant'
    gem 'kitchen-digitalocean'
    gem 'serverspec'
end

