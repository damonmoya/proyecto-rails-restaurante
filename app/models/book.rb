class Book < ActiveRecord::Base
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: { message: "No se ha introducido el email" }
    validates :email, format: { with: VALID_EMAIL_REGEX, message: "El email introducido no es válido", allow_blank: true }
    validates :start_time, presence: { message: "No se ha seleccionado fecha y hora" }
    validates :people, presence: { message: "No se ha introducido el número de comensales" }
    validates :people, numericality: { only_integer: true, message: "No es un número" }, allow_nil: true
    validates :people, numericality: {greater_than: 0, message: "La reserva debe contar con mínimo un comensal"}, allow_nil: true
    validates :people, numericality: {less_than: 5, message: "La reserva solo permite un máximo de 4 comensales"}, allow_nil: true
end
