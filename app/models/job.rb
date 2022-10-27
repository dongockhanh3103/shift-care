# == Schema Information
#
# Table name: jobs
#
#  id          :bigint           not null, primary key
#  client_id   :bigint
#  state       :string           default("open")
#  entry_time  :datetime
#  start_at    :datetime
#  assigned_at :datetime
#  finish_at   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Job < ApplicationRecord

  include AASM

  belongs_to :client
  has_many :plumber_jobs
  has_many :plumbers, through: :plumber_jobs

  validates :entry_time, presence: true
  validates :assigned_at, presence: true, if: -> { assigned? }
  validates :start_at, presence: true, if: -> { in_progress? }
  validates :finish_at, presence: true, if: -> { done? }

  enum state: { open: 'open', assigned: 'assigned', in_progress: 'in_progress', done: 'done' }

  aasm column: :state, enum: true do
    state :open, initial: true, before_enter: :before_re_open

    state :assigned, before_enter: :before_assigned

    state :in_progress, before_enter: :before_in_progress

    state :done, before_enter: :before_finish

    event :assigned do
      transitions from: %i[open in_progress], to: :assigned
    end

    event :in_progress do
      transitions from: %i[assigned done], to: :in_progress
    end

    event :done do
      transitions from: :in_progress, to: :done
    end
  end

  def before_re_open
    self.assigned_at = nil
    self.start_at = nil
    self.finish_at = nil
  end

  def before_assigned
    self.start_at = nil
    self.assigned_at = Time.current
  end

  def before_in_progress
    self.start_at = Time.current
  end

  def before_finish
    self.finish_at = Time.current
  end

end
