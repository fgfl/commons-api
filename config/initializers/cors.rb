Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins /\Ahttp:\/\/localhost:\d+\z/
    resource "*", headers: :any, methods: :any
  end
end
