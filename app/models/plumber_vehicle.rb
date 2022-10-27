# == Schema Information
#
# Table name: plumber_vehicles
#
#  id         :bigint           not null, primary key
#  plumber_id :bigint
#  vehicle_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PlumberVehicle < ApplicationRecord

  belongs_to :plumber
  belongs_to :vehicle

end
