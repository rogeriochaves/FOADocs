class YesWww

  def initialize(app)
    @app = app
  end

  def call(env)

    request = Rack::Request.new(env)

    if !request.host.include? "herokuapp" and !request.host.include? "reactweb" and !request.host.starts_with?("www.")
      [301, {"Location" => request.url.sub("//", "//www.")}, self]
    else
      @app.call(env)
    end
  end

  def each(&block)
  end

end