web: bundle exec puma -C config/puma.rb
release: DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rake db:schema:load && rake db:seed

