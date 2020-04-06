class Phone < ApplicationRecord
  has_many :patients, dependent: :delete_all
  has_one :volunteer, dependent: :destroy
end
