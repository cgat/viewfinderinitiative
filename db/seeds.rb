# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin
user.skip_confirmation!
user.save!

lorem = <<-text
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus condimentum leo non eros viverra, eget accumsan risus tincidunt.
Morbi gravida fermentum viverra. Maecenas pulvinar convallis commodo.
Duis tincidunt tellus dolor, ornare interdum nisi euismod ac.
text
project = Project.create!(name: "Moving Ice", description: lorem)
stations = Station.create!([{name: "Illecillewaet Glacier", description: lorem, project_id: project.id},{name: "Athabasca Glacier", description: lorem, project_id: project.id}])
h_image = HistoricImage.create!(station_id: stations.first.id, date: Date.new(1887))
h_image.image.store!(File.open(File.join(Rails.root, "app","assets", "images",'NOT1887_V1707_background.jpg')))
h_image.save!
r_image = RepeatImage.create!(historic_image_id: h_image.id, date: Date.new(2011))
r_image.image.store!(File.open(File.join(Rails.root, "app","assets","images","MLP2011_V1707_background.jpg")))
r_image.save!

test_user = User.find_or_create_by_email name: ENV['TEST_NAME'].dup, email: ENV['TEST_EMAIL'].dup, password: ENV['TEST_PASSWORD'].dup, password_confirmation: ENV['TEST_PASSWORD'].dup
t_image = UserRepeatImage.create!(date: Date.today)
t_image.user = test_user
t_image.image.store!(File.open(File.join(Rails.root, "app","assets","images","MLP2011_V1707_background.jpg")))
t_image.save!
