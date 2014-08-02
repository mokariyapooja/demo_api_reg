class AuthTokan < ActiveRecord::Base
  before_create :generate_tokan
  belongs_to :user
  
  private
  def generate_tokan
    begin
      self.tokan = SecureRandom.hex
    end while self.class.exists?(tokan: tokan)      
  end
end
 