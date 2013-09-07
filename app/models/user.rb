class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:box]


   def self.find_or_create_from_box_oauth(auth, type=nil)
     user = User.where(:provider => auth.provider, :uid => auth.uid).first
     unless user
       user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.extra.raw_info.login,
                            token:auth.credentials.token,
                            refresh_token:auth.credentials.refresh_token,
                            password:Devise.friendly_token[0,20]
                            )
     end
     user
   end
end
