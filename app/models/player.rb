class Player < ActiveRecord::Base
  has_many :playergames
  has_many :games, through: :playergames
  has_many :wins, class_name: "Game"

include BCrypt

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(pass)
    @entered_password = pass
    @password = Password.create(pass)
    self.password_digest = @password
  end

  def self.authenticate(username, password)
    player = Player.find_by_username(username)
    return player if player && (player.password == password)
    nil
  end
end
