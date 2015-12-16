require 'pusher'

Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key    = ENV["PUSHER_KEY_M"]
Pusher.secret = ENV["PUSHER_SECRET_KEY"]
Pusher.logger = Rails.logger
