# encoding: utf-8
require 'digest/sha1'
class User < ActiveRecord::Base
  has_and_belongs_to_many :books
  
  
  attr_accessor :email_confirmation, :password, :password_confirmation, :postplace
  attr_protected :id, :salt
  validates_presence_of :username, :password, :email, :postcode, :birthdate, :on => "create"
  validates_presence_of :place, :on => "update"
  validates_confirmation_of :password, :email
  validates_uniqueness_of :email, :username
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "- Feil format på epost"
  validates_format_of :postcode, :with => /^\d{4}$/, :message => "- Postnummeret må være av norsk type. Fire siffer uten mellomrom"
  
  validates_length_of :username, :within => 5..20, :on => :save, :message => "Brukernavn må være mellom 5 og 20 tegn"
  validates_length_of :password, :within => 5..20, :on => :save, :message => "Brukernavn må være mellom 5 og 20 tegn"
  
  geocoded_by :place
  after_validation :geocode
  
  scope :search, lambda {|query| where(["fullname LIKE ?", "%#{query}%"])}
  
  
  def place
    placestring = "" #Generates a placestring
    placestring << self.address unless self.address.nil? #Adds address
    placestring << " , " #Adds separator for geocode function
    self.postplace = self.class.find_city(self.postcode) if self.postplace.nil? # Sets postplace if this does not exists, generates from number
    placestring << self.postplace
    puts "THIS IS THE PLACE WE ARE LOOKING FOR #{placestring}"
    return placestring
  end
  
  def self.find_city(number)
    file = File.new("#{Rails.root}/app/assets/data/postoversikt.txt", "r")
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
  
  
  def self.find_by_username(username)
    u = find(:first, :conditions=>["username =?", username])
    return nil if u.nil? 
    return u
  end
    
  
  
  
end
