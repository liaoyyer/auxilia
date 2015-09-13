class Admin < User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets

  acts_as_messageable





	include PublicActivity::Model

	tracked only: :create, owner: :itself







  def mailboxer_email(object)
 	email
  end




end
