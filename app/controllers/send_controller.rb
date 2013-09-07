require 'tropo-webapi-ruby'
require 'net/http'
require 'uri'

class SendController < ApplicationController
  protect_from_forgery :except => :callback

  def view
  end

  def post
    token = '686b62647a714d79664c796a534b746f4b6e764358465570675a4a6c747556506f794f545a42774e616e7946'
    url = 'https://tropo.developergarden.com/api/sessions?action=create&token=' + token + '&phone=' + url_encode(request[:phone]) + '&msg=' + url_encode(request[:message])
    uri = URI.parse(url)
    Net::HTTP.get(uri)
    flash[:notice] = "Message sent to " + request[:phone] +  "!"
    redirect_to :send_view
  end

  def callback
    puts "printing the parameters"
    puts params[:session][:parameters].inspect
    t = Tropo::Generator.new
    t.call :to => params[:session][:parameters][:phone], :network => "SMS"
    #t.await 3000
    t.say :value => params[:session][:parameters][:msg]#, :voice => "Katrin"
    render json: t.response
  end
end

