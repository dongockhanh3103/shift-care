# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id           :bigint           not null, primary key
#  name         :string           default(""), not null
#  age          :integer
#  private_note :text             default("")
#  address      :string           default("")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Client < ApplicationRecord

  validates :name, :address, presence: true

end
