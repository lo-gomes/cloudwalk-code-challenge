install:
	bundle install

run:
	ruby app.rb logs/qgames.log

test:
	bundle exec rspec spec
