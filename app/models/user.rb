class User < ActiveRecord::Base
  ROLES = %w{member leader admin}
  #@@ROLE = ["member","leader","admin"]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,:registrable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :address, :phone_number, :employee_number, :started_date,
                  :date_of_birth,:role, :team_id

  #===Associations====
  belongs_to :team

  #======Scopes========

  scope :non_admin, lambda {where("role != 'admin'")}

  # attr_accessible :title, :body
  validates :name,:employee_number, :role, :date_of_birth, presence: true
  validates :role, inclusion: {in: ROLES }

  def admin?
     self.role == "admin"
  end

  def member?
    self.role == "member"
  end

  def leader?
    self.role == "leader"
  end



end
