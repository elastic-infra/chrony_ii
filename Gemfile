# frozen_string_literal: true

source 'https://rubygems.org'

group :rake do
  gem 'rake'
  gem 'tomlrb'
end

group :lint do
  gem 'foodcritic'
  gem 'rubocop', '~> 0.69'
end

group :unit do
  gem 'berkshelf', '~> 7'
  gem 'chefspec', '~> 7'
end

group :kitchen_common do
  gem 'test-kitchen', '~> 2.2.5'
end

group :kitchen_vagrant do
  gem 'kitchen-vagrant', '~> 1.5'
end

group :kitchen_inspec do
  gem 'kitchen-inspec', '~> 1.1'
end

group :kitchen_docker do
  gem 'kitchen-docker'
end
