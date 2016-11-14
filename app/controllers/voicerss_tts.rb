module VoiceRSS
  require 'net/http'
  
  public
  module_function
    
  def self.speech(settings)
    _validate(settings)
    return _request(settings)
  end
  
  private
  
  def self._validate(settings)
    raise 'The settings are undefined' if settings.nil? || settings.empty?
    raise 'The API key is undefined' if settings['key'].nil? || settings['key'].empty?
    raise 'The text is undefined' if settings['src'].nil? || settings['src'].empty?
    raise 'The language is undefined' if settings['hl'].nil? || settings['hl'].empty?
  end
  
  def self._request(settings)
    response = {
      'error' => nil,
      'response' => nil
    }
        
    uri = URI((settings['ssl'] ? 'https' : 'http') + '://api.voicerss.org/')
    req = Net::HTTP::Post.new(uri)
    req.set_form_data(_buildRequest(settings))
      
    res = Net::HTTP.start(uri.hostname, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      http.request(req)
    end
    
    case res
    when Net::HTTPSuccess
      if res.body.index('ERROR') == 0
        response['error'] = res.body
      else
        response['response'] = res.body
      end
    else
      response['error'] = res.message
    end
        
    response
  end
  
  def self._buildRequest(settings)
    return {
      'key' => settings['key'],
      'src' => settings['src'],
      'hl' => settings['hl'],
      'r' => settings['r'],
      'c' => settings['c'],
      'f' => settings['f'],
      'ssml' => settings['ssml'],
      'b64' => settings['b64']
    }
  end
end