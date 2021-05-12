class Check < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: { message: "No se ha introducido el email" }
    validates :email, format: { with: VALID_EMAIL_REGEX, message: "El email introducido no es válido", allow_blank: true }
    validates :expire_time, presence: { message: "No se ha introducido fecha y hora" }

    before_create :generate_token

    private 
    def generate_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end
end
