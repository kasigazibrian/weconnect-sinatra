require_relative 'concerns/model_concern'
class Business < ApplicationRecord
  include ModelConcern
  belongs_to :user
  has_many :reviews
  belongs_to :category
  validates :business_name, presence: { message: 'is a required field' },
                            uniqueness: { message: 'has already been taken' }
  validates :business_email, presence: { message: 'is a required field' },
                             format: BUSINESS_EMAIL_REGEXP, uniqueness:
                { message: 'has already been taken' }
  validates :contact_number, uniqueness: { message: 'already exists' },
                             format: { with: CONTACT_NUMBER_REGEXP }
  validates :user_id, presence: true
  validates :category_id, presence: { message: 'should be selected' }
end
