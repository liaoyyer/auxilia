class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets

  before_create :set_default_type










  acts_as_messageable






  def set_default_type
    self.type = self.class.name if type.blank?
  end




 def mailboxer_email(object)
 	email
 end








end









  


