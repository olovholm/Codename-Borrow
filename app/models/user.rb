require 'digest/sha1'
class User < ActiveRecord::Base
  
  
  attr_accessor :email_confirmation, :password, :password_confirmation, :postplace
  attr_protected :id, :salt
  validates_presence_of :username, :password, :email, :postcode, :birthdate, :on => "create"
  validates_presence_of :place, :on => "update"
  validates_confirmation_of :password, :email
  validates_uniqueness_of :email, :username
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  
  geocoded_by :place
  after_validation :geocode
  
  scope :search, lambda {|query| where(["fullname LIKE ?", "%#{query}%"])}
  
  
  def place
     self.address unless self.address.nil?
     puts "No Address. We continiue"
     self.postplace unless self.postplace.nil?
     puts "No postplace. We continiue"
     self.postplace = self.find_city(self.postcode)
     puts "Will procede with #{self.postplace}, the generated place from postcode"
     self.postplace
  end
  
  def self.find_city(number)
    file = File.new("#{Rails.root}/assets/data/postoversikt.txt", "r")
    puts file
    while (line = file.gets)
      place = line.split(/\t/)
      return place[1] if place[0] == number
    end
      nil
  end
  
  def self.random_string(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)]}
    return newpass
  end
  
  def password= (pass)
    @password = pass
    self.salt = User.random_string(10) if !self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
  end
  
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end
  
  def self.authenticate(username, pass)
    u = find(:first, :conditions=>["username =?", username])
    return nil if u.nil?
    return u if User.encrypt(pass, u.salt)==u.hashed_password
    nil
  end
  
  
  
end
