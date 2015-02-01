# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif slider.css style.css users.css jquery.mmenum.all *.js)
Rails.application.config.action_view.field_error_proc = Proc.new { |html_tag, instance|
  "#{html_tag}".html_safe
}
