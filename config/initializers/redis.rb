options = { driver: :hiredis }
options[:url] = ENV["REDISTOGO_URL"] if Rails.env.production?
$redis = Redis.new(options)
