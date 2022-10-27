# == Schema Information
#
# Table name: plumbers
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  address    :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Plumber < ApplicationRecord

  has_many :jobs
  has_many :plumber_vehicles
  has_many :vehicles, through: :plumber_vehicles
  has_many :plumber_jobs
  has_many :jobs, through: :plumber_jobs

  validates :name, :address, presence: true

end
