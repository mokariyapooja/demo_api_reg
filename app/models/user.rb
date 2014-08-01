class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :auth_tokans, :dependent => :destroy

  has_attached_file :photo, :styles => { :small => "150x150", :large => "320x240" }
  validates_attachment :photo,:content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  def photo_upload(photo)
    cid = URI.unescape(photo)
    filename = "photo#{Time.now.to_i}"
    file = File.open("#{Rails.root.to_s}/tmp/#{filename}.png", "wb")
    temp = Base64.decode64(cid)
    file.write(temp)
    file.close
    f = File.open("#{Rails.root.to_s}/tmp/#{filename}.png")
    self.photo = f
    f.close
    File.delete("#{Rails.root.to_s}/tmp/#{filename}.png")
  end
  #  def convert(photo)
  #   cid = URI.unescape(photo)
  #   filename = "photo#{Time.now.to_i}"
  #   file = File.open("#{Rails.root.to_s}/tmp/#{filename}.png","wb")
  #   temp2 = Base64.decode64(cid)
  #   file.write(temp2)
  #   file.close
  #   f = File.open("#{Rails.root.to_s}/tmp/#{filename}.png")
  #   self.avatar = f
  #   f.close
  #   File.delete("#{Rails.root.to_s}/tmp/#{filename}.png")
  # end
end
 