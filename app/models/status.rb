class Status < ApplicationRecord
   has_many :loans, dependent: :destroy

   def is_active?
      self.name == "Open"
   end
end
