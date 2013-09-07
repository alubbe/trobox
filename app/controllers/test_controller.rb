class TestController < ApplicationController

	require 'open-uri'
  def expose
  	page = Nokogiri::HTML(open("http://www.immobilienscout24.de/expose/#{params[:id]}/"))   
  	
  	@peter = {
  	  title: page.css('#expose-title').text,
  	  picture_url: page.css('#is24-gallery-main-image').attribute('src').value,
  	  #fullprice: page.css('.is24qa-gesamtmiete').children[2].text.gsub("\n","").gsub("\r","").gsub(" ","").gsub("EUR",""),#[15,6],
  	  #fullprice: page.css('.is24qa-gesamtmiete').children[2].text.gsub(/[\n\r\ ()a-z]/i,"").to_f,
  	  price: page.css('.is24qa-gesamtmiete').children[2].text.gsub(/[\n\r]/,"").gsub("   ", ""),
  	  living_space: page.css('.is24qa-wohnflaeche-ca').text.gsub(/[\n\r\ m²]/,"").to_f,
  	  rooms: page.css('.is24qa-zimmer').text.gsub(/[\n\r\ ]/,"").to_f,
  	  immo_id: "http://www.immobilienscout24.de/expose/70631213?referrer=RESULT_LIST_LISTING%2CHIGHLIGHTED&navigationServiceUrl=%2FSuche%2Fcontroller%2FexposeNavigation%2Fnavigate.go%3FsearchUrl%3D%2FSuche%2FS-T%2FP-4%2FWohnung-Miete%2FBerlin%2FBerlin%26exposeId%3D70631213&navigationHasPrev=true&navigationHasNext=true&navigationBarType=RESULT_LIST".gsub(/[htpswimobilencutdx.\:\/]/, "")[2,8],
  	  landline: page.css('.is24-phone').children[1].children[2].text.gsub(/[\n\r\t]/,"").gsub("   ", ""),
  	  address: page.css('#is24-content').children[1].children[7].children[3].children[1].text.gsub(/[\n\r]/,"").gsub("   ", ""),
  	  city: page.css('#is24-content').children[1].children[7].children[3].children[3].text.gsub(/[\n\r]/,"").gsub("   ", "")
  	  #address: page.css('.is24-ex-address').css('p')[2].text,
  	  #housenumber: page.css('#expose-title').text,
  	  #postcode: page.css('#expose-title').text,
  	  #city: page.css('#expose-title').text
  	}
  	render json: @peter
  end

end

