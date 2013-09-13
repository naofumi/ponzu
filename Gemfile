source "http://rubygems.org"

# Declare your gem's dependencies in ponzu.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

gem "sprockets-dotjs", :git => 'git://github.com/jamifsud/sprockets-dotjs.git'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# Use qunit-rails in dummy
# We don't put it in :development, :test group because
# for some reason, it doesn't get read it in.
gem 'qunit-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
end
