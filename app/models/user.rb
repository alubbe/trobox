class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:box]


  has_many :documents
  has_many :applications


   def self.find_or_create_from_box_oauth(auth, type=nil)
    user = User.where(:provider => auth['provider'], :uid => auth['uid']).first
    if user.blank?
     user = User.create(name:auth['extra']['raw_info']['name'],
                          provider:auth['provider'],
                          uid:auth['uid'],
                          email:auth['extra']['raw_info']['login'],
                          token:auth['credentials']['token'],
                          refresh_token:auth['credentials']['refresh_token'],
                          token_expires_at: DateTime.strptime("#{auth['credentials']['expires_at']}",'%s'),
                          agent: auth['agent'],
                          password:Devise.friendly_token[0,20]
                          )
    else
      user.update_attributes(token_expires_at: DateTime.strptime("#{auth['credentials']['expires_at']}",'%s'), token:auth['credentials']['token'], refresh_token:auth['credentials']['refresh_token'])
    end
    user
   end

   def receive_application(application_id)
      folder = box_client.folder("/trobox/#{application_id}") || box_client.folder('/trobox').create_subfolder(application_id)
      #folder.create_subfolder('Peter')
      # sync top level folder after building subfolder tree
      folder = box_client.folder("/trobox")
      folder.sync_state = 'synced'
      folder.update
   end

   def box_client
    update_box_auth_token if token_expires_at <= DateTime.now
    RubyBox::Client.new(box_session)
   end

   def box_session
    RubyBox::Session.new({
      client_id: AUTH['box']['client_id'],
      client_secret: AUTH['box']['client_secret'],
      access_token: self.token
    })
  end

  def update_box_auth_token
    token = box_session.refresh_token(self.refresh_token)
    update_attributes(token_expires_at: DateTime.strptime("#{token.expires_at}",'%s'), token: token.token,refresh_token: token.refresh_token)
  end

  def create_app_folder
    box_client.create_folder('trobox')
    # folder = box_client.folder('/trobox')
    # folder.sync_state = 'synced'
    # folder.update
  end
end
