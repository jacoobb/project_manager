class Teacher < ActiveRecord::Base
  
  has_many :activity_logs
  has_and_belongs_to_many :subjects
  has_and_belongs_to_many :projects

  attr_accessor :password

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: {on: :create}, confirmation: true, length: {minimum: 6}
  validates :password_confirmation, presence: {if: proc{|o| o.password.present?}}
  
  before_save :encrypt_password

  class << self
    def authenticate email, password
      teacher = find_by(email: email)
      return teacher if teacher && teacher.password_hash == BCrypt::Engine.hash_secret(password, teacher.password_salt) 
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
