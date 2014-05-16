require 'bcrypt'

class Player < ActiveRecord::Base
  has_many :playergames
  has_many :games, through: :playergames
  has_many :wins, class_name: "Game"

  validates_presence_of :username

  # CODE REVIEW: you should check out 
  # http://guides.rubyonrails.org/active_record_querying.html#scopes
  def active_games
    self.games.select {|game| game.status == "active" }
  end

  def pending_games
    self.games.select {|game| game.status == "pending" }
  end

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(pass)
    @password = BCrypt::Password.create(pass)
    self.password_digest = @password
  end

  def self.authenticate(username, password)
    player = Player.find_by_username(username)
    return player if player && (player.password == password)
    nil
  end
end
