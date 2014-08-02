class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #associations
  has_many :auth_tokans, :dependent => :destroy
  
  #paperclip_attachment
  has_attached_file :photo, :styles => { :small => "150x150", :large => "320x240" }
 
  #validations
  validates_attachment :photo,:content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  validates :firstname, length: { maximum: 30 ,message: "bad form"}
  validates :lastname, length: { maximum: 30 ,message: "bad form"}
  validates_format_of :phonenumber, :with => /\A[0-9]{10,15}\Z/,:maximum =>15,:minimum =>10
  
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

  def display_error
    self.errors.full_messages
  end
end
 