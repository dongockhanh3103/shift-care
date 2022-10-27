# frozen_string_literal: true

module Plumbers
  class CreateService < BaseService

    def initialize(attributes)
      @attributes = attributes
    end

    def execute
      ActiveRecord::Base.transaction do
        vehicles = attributes[:vehicles] || []
        plumber = Plumber.create!(attributes.except(:vehicles))

        if vehicles.present?
          build_plumber_vehices_attributes = vehicles.map do |vehicle_id|
            {
              vehicle_id: vehicle_id,
              plumber_id: plumber.id,
              created_at: Time.current,
              updated_at: Time.current
            }
          end

          PlumberVehicle.insert_all(build_plumber_vehices_attributes)
        end

        plumber
      end
    end

    private

    attr_reader :attributes

  end
end
