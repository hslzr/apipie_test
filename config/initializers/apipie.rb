Apipie.configure do |config|
  config.app_name                = "ApipieTest"
  config.api_base_url            = "/"
  config.doc_base_url            = "/api_doc"
  config.copyright               = "&copy; #{Time.now.year} made with ❤️ by " + "<a href='https://github.com/hslzr' style='text-decoration: none;'>hslzr</a>".html_safe
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"


  config.reload_controllers = Rails.env.development?
  config.app_info["1.0"] = "
  This is a dummy app. This is where you'd put general information about your api.
  "

  config.authenticate = Proc.new do
    authenticate_or_request_with_http_basic do |username, password|
      username == 'demo' && password == 'demo'
    end
  end
end
