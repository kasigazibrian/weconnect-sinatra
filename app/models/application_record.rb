# frozen_string_literal: true

require_relative 'concerns/model_concern'
# Base class for active record
class ApplicationRecord < ActiveRecord::Base
  include ModelConcern
  self.abstract_class = true
end
