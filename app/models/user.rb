require_relative 'concerns/model_concern'
class User < ApplicationRecord
  include ModelConcern
  has_many :businesses
  has_many :reviews
  has_secure_password
  validates :email, presence: true, format: {
    with: EMAIL_REGEXP,
    message: 'should be a valid Andela email address'
  },
                    uniqueness: { message: 'has already been taken' }
  validates :username, uniqueness: { message: 'has already been taken' },
                       presence: { message: 'is a required field' }
end
