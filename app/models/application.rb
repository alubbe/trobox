class Application < ActiveRecord::Base

  belongs_to :user

  attr_accessor :immo_url

  before_create :set_data_from_immo


  def set_data_from_immo
    self.attributes = get_data_from_immo
  end

  def get_data_from_immo
    {'immo_id' => immo_url.gsub(/[htpswimobilencutdx.\:\/]/, "")[2,8]}
  end
end