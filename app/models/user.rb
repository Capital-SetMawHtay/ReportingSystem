class User < ActiveRecord::Base
  ROLES = %w{member leader admin}
  #@@ROLE = ["member","leader","admin"]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,:registrable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :address, :phone_number, :employee_number, :started_date,
                  :date_of_birth,:role, :team_id, :photo

  #===Associations====
  belongs_to :team
  has_many :reports
  has_many :activities
  has_many :messages
  has_many :subscriptions
  has_many :groups, through: :subscriptions
  has_many :owned_groups,foreign_key: 'owner_id',class_name: 'Group' ,inverse_of: :owner
  #======Scopes========

  scope :non_admin, lambda {where("role != 'admin'")}
  scope :by_team, lambda{|t|joins(:team).where('teams.name = ?',t)}
  # attr_accessible :title, :body
  validates :name,:employee_number, :role, :date_of_birth, presence: true
  validates :role, inclusion: {in: ROLES }
  validates_attachment :photo,:presence=>true,
                       :content_type=>{:content_type=>/^image\/(png|gif|jpeg|jpg)/,:message=>'must be an image file type'},
                       :size=>{:in=>0..1.megabytes,:message=>" must not be greater than 1 Megabyte!"}


  def admin?
     self.role == "admin"
  end

  def member?
    self.role == "member"
  end

  def leader?
    self.role == "leader"
  end


  def self.get_admin
    where(role: 'admin').first
  end


end
