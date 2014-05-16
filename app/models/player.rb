require 'bcrypt'

class Player < ActiveRecord::Base
  has_many :playergames
  has_many :games, through: :playergames
  has_many :wins, class_name: "Game", foreign_key: :winner_id
  has_many :current_games, class_name: "Game", foreign_key: :current_player_id

  validates_presence_of :username

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
