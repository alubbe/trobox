class Application < ActiveRecord::Base

  belongs_to :user

  attr_accessor :immo_url

  before_create :set_data_from_immo


  def set_data_from_immo
    self.attributes = expose(immo_id_from_url)
  end

  def get_data_from_immo
    {'immo_id' => ''}
  end

  def immo_id_from_url
    immo_url.gsub(/[htpswimobilencutdx.\:\/]/, "")[2,8]
  end

  def expose(id)
    page = Nokogiri::HTML(open("http://www.immobilienscout24.de/expose/#{id}/"))

   {
      title: page.css('#expose-title').text,
      picture_url: page.css('#is24-gallery-main-image').attribute('src').value,
      #fullprice: page.css('.is24qa-gesamtmiete').children[2].text.gsub("\n","").gsub("\r","").gsub(" ","").gsub("EUR",""),#[15,6],
      #fullprice: page.css('.is24qa-gesamtmiete').children[2].text.gsub(/[\n\r\ ()a-z]/i,"").to_f,
      price: page.css('.is24qa-gesamtmiete').children[2].text.gsub(/[\n\r]/,"").gsub("   ", ""),
      living_space: page.css('.is24qa-wohnflaeche-ca').text.gsub(/[\n\r\ m²]/,"").to_f,
      rooms: page.css('.is24qa-zimmer').text.gsub(/[\n\r\ ]/,"").to_f,
      immo_id: id,
      landline: page.css('.is24-phone').children[1].children[2].text.gsub(/[\n\r\t]/,"").gsub("   ", ""),
      address: page.css('#is24-content').children[1].children[7].children[3].children[1].text.gsub(/[\n\r]/,"").gsub("   ", ""),
      city: page.css('#is24-content').children[1].children[7].children[3].children[3].text.gsub(/[\n\r]/,"").gsub("   ", "")
      #address: page.css('.is24-ex-address').css('p')[2].text,
      #housenumber: page.css('#expose-title').text,
      #postcode: page.css('#expose-title').text,
      #city: page.css('#expose-title').text
    }
  end
end