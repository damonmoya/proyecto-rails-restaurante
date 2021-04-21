class Book < ApplicationRecord
    enum state: { pending: 0, confirmed: 1, no_show: 2 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: { message: "No se ha introducido el email" }
    validates :email, format: { with: VALID_EMAIL_REGEX, message: "El email introducido no es válido", allow_blank: true }
    validates :start_time, presence: { message: "No se ha seleccionado fecha y hora" }
    validates :diners, presence: { message: "No se ha introducido el número de comensales" }
    validates :diners, numericality: { only_integer: true, message: "No es un número" }, allow_nil: true
    validates :diners, numericality: {greater_than: 0, message: "La reserva debe contar con mínimo un comensal"}, allow_nil: true
    validates :diners, numericality: {less_than: 5, message: "La reserva solo permite un máximo de 4 comensales"}, allow_nil: true
    validates :state, inclusion: { in: states.keys }
end
