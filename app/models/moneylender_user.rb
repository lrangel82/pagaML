class MoneylenderUser < ApplicationRecord
  belongs_to :moneylender
  belongs_to :user
end
