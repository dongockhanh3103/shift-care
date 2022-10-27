# == Schema Information
#
# Table name: plumber_jobs
#
#  id         :bigint           not null, primary key
#  plumber_id :bigint
#  job_id     :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PlumberJob < ApplicationRecord

  belongs_to :plumber
  belongs_to :job

end
