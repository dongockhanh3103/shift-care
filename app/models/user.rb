# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  name                   :string
#  encrypted_password     :string           not null
#  role                   :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord

  enum role: { admin: 'admin' }
  validates :email, :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
