class Student < ActiveRecord::Base

  attr_accessor :password

  validates :email, presence: true, uniqueness: true
  validates :student_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :pesel, presence: true
  validates :password, presence: {on: :create}, confirmation: true, length: {minimum: 6}
  validates :password_confirmation, presence: {if: proc{|o| o.password.present?}}
  before_save :encrypt_password

  class << self
    def authenticate student_id, password
      student = find_by(student_id: student_id)
      return student if student && student.password_hash == BCrypt::Engine.hash_secret(password, student.password_salt) 
    end
  end


  private
    
    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end
end
