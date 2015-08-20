# Don't forget to set the timezone on the server to the one you want
# Wellington/Auckland is used at the moment

set :env_path,    '"$HOME/.rbenv/shims":"$HOME/.rbenv/bin"'

job_type :rake,   %q{ cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec rake :task --silent :output }
job_type :runner, %q{ cd :path && PATH=:env_path:"$PATH" bundle exec rails runner -e :environment ':task' :output }
job_type :script, %q{ cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec script/:task :output }

every :sunday, :at => '12pm' do
  runner "UpdateBestTimesToPost.run"
end

every 30.minutes do
  runner "ScheduledInteractionWorker.perform_async"
end

every :monday, :at => '03:00' do
  runner "SendDigests.run"
end
