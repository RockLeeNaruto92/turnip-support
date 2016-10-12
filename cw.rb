require 'faraday'
require 'pry'
require 'colorize'

def connect
  #https://gist.github.com/mitukiii/2775321
  conn = Faraday::Connection.new(url: 'https://api.chatwork.com') do |faraday|
    faraday.use Faraday::Request::UrlEncoded
    faraday.use Faraday::Response::Logger
    faraday.use Faraday::Adapter::NetHttp
  end
  return conn
end

def mess_cw room_id, chatwork_token, messages
  conn = connect
  response = conn.post do |request|
    request.url "/v1/rooms/#{room_id}/messages"
    request.headers = {
      'X-ChatWorkToken' => chatwork_token
    }
    request.params[:body] = " [To:1017926]
                              [info][title]Auto Test[/title]
                              #{messages}[/info]"
  end
  if response.body.include?("errors")
    puts response.body.red
  end
    binding.pry

end

mess_cw ARGV[0], ARGV[1], ARGV[2]

~
~
~
~
~
~
~
~
~
~
~
-- INSERT --recording
