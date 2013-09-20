source 'https://rubygems.org'

ruby '2.0.0'

gem 'pointsable', path: '/Users/chrisgat/projects/pointsable'
gem "gibbon"
gem 'rails', '3.2.13'
gem 'carrierwave'
gem "mini_magick"
gem 'fog', '~> 1.3.1'
gem 'pg'

gem 'squeel'
gem 'wicked'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'rolify'
gem 'simple_form'
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'debugger'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'jazz_hands'
end
group :production do
  gem 'thin'
end
group :test do
  gem 'spork-rails'
  gem 'shoulda'
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
end
