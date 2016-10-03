# Don't forget to set the timezone on the server to the one you want
# Wellington/Auckland is used at the moment

set :env_path,    '"$HOME/.rbenv/shims":"$HOME/.rbenv/bin"'
set :output, '/home/deploy/linkyard/current/log/cron.log'

job_type :rake,   %q{ cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec rake :task --silent :output }
job_type :runner, %q{ cd :path && PATH=:env_path:"$PATH" bundle exec rails runner -e :environment ':task' :output }
job_type :script, %q{ cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec script/:task :output }


every :monday, :at => '03:05' do
  runner "SendDigests.run"
end

every 1.day, at: '21:10' do
  runner "RedditMailer.daily.deliver"
end

every :friday, at: '12:00' do
  runner "RedditMailer.weekly.deliver"
end
