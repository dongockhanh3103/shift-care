class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  def model_type
    self.class.name.underscore.pluralize
  end

end
