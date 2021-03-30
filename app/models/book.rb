class Book < ActiveRecord::Base
    validates :email, presence: { message: "No se ha introducido el email" }
    validates :start_time, presence: { message: "No se ha seleccionado fecha y hora" }
end
