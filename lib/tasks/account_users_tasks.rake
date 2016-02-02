# see comments at https://blog.pivotal.io/labs/labs/leave-your-migrations-in-your-rails-engines
Rake::Task["db:load_config"].enhance [:environment]

# desc "Explaining what the task does"
# task :account_users do
#   # Task goes here
# end
