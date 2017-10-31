require 'net/http'

module OpenWeatherMap

  class Responce
    attr_accessor :responce

    def initialize(responce)
      @responce = responce
    end

    def handle_responce
      if responce.is_a?(Net::HTTPSuccess)
        JSON.parse(responce.body)
      else
        raise 'Error!!! ' + responce.body.to_s
      end
    end
  end

  class Client

    CURRENT_PATH = '/data/2.5/weather'

    attr_reader :host, :api_key

    def initialize
      @host = Rails.application.secrets.weather[:host]
      @api_key = Rails.application.secrets.weather[:api_key]
    end

    def current(city = nil)

      raise 'Error!!! City undefined' unless city.present?

      params = {
          'APPID' => api_key,
          'q' => city.to_s,
          'units' => 'metric'
      }

      responce = Responce.new(Net::HTTP.get_response(build_url(CURRENT_PATH, params)))
      responce.handle_responce

    end

    private

    def build_url(path, params = {})
      uri = URI(host.to_s + path.to_s)
      uri.query = URI.encode_www_form(params)
      uri
    end

  end
end