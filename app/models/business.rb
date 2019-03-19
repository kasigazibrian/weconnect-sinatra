require_relative 'concerns/model_concern'
class Business < ApplicationRecord
  include ModelConcern
  # searchkick word_middle: %i[business_name]
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

  scope :has_name, ->(name) { where('business_name ilike ?', "%#{name}%") }
  scope :belongs_to_category, ->(category_id) { where category_id: category_id }
  scope :in_location, ->(location) { where business_location: location }

  def self.filter(filtering_params)
    results = where(nil)
    filtering_params.each do |key, value|
      results = results.public_send(key, value) if value.present?
    end
    results
  end
end
