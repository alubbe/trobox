require 'tropo-webapi-ruby'
require 'net/http'
require 'uri'

class SendController < ApplicationController
  protect_from_forgery :except => :callback

  def view
  end

  def post
    token = '526f6150554c7a59647243686e71444d79504479484c72656750705964774a536376656546736a6e4b6b4244'
    url = 'https://tropo.developergarden.com/api/sessions?action=create&token=' + token + '&phone=' + request[:phone] + '&msg=' + request[:message]
    uri = URI.parse(url)
    Net::HTTP.get(uri)
    flash[:notice] = "Message Sent to " + request[:phone] +  "!"
    redirect_to :send_view
  end

  def callback
    # puts "printing the parameters"
    # puts params[:session][:parameters].inspect
    t = Tropo::Generator.new
    t.call(:to => "+491728859128", :network => "SMS")
    t.say(:value => params[:session][:parameters][:msg])
    render text: t.response
  end
end
