class Listener < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [:twitter, :facebook]
  
  class Listener < self
    def find_or_create_for_oauth(auth)
      find_or_create_by!(email: auth.info.email) do |listener|
        listener.provider = auth.provider
        listener.uid = auth.uid
        listener.email = auth.info.email
        password = Devise.friendly_token[0..5]
        logger.debug password
        listener.password = password
      end
    end
    
    def new_with_session(params, session)
      if listener_attributes = session['devise.listener_attributes']
        new(listener_attributes) { |listener| listener.attributes = params}
      else
        super
      end
    end
  end
end
