# == Schema Information
#
# Table name: refresh_tokens
#
#  id            :bigint           not null, primary key
#  crypted_token :string
#  token         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
class RefreshToken < ApplicationRecord

  belongs_to :user

end
