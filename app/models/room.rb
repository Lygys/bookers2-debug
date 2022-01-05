class Room < ApplicationRecord
  has_many :chats
  has_many :user_rooms
end
