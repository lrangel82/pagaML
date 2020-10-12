class Status < ApplicationRecord
   has_many :loans, dependent: :destroy
end
