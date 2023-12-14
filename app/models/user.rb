class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :roles_users
  has_many :roles, through: :roles_users
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end