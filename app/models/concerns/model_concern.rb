module ModelConcern
  EMAIL_REGEXP = /\A([\w+\-].?)+@andela+(\.[a-z]+)*\.[a-z]+\z/.freeze
  BUSINESS_EMAIL_REGEXP = /\A[^@\s]+@[^@\s]+\z/.freeze
  CONTACT_NUMBER_REGEXP = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze
end
