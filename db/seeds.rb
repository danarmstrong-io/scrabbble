# Seed words from dictionary.txt into Words table
File.open('db/dictionary.txt').each_line do |word|

  Word.create!(text: word.chomp.upcase) if word.chomp!.length > 1
end
# Seed Tiles for scrabbble game
# E
12.times { Tile.create!(letter: 'E', value: 1) }
# A, I
9.times { Tile.create!(letter: 'A', value: 1)
          Tile.create!(letter: 'I', value: 1) }
# O
8.times { Tile.create!(letter: 'O', value: 1) }
# N, R, T
6.times { Tile.create!(letter: 'N', value: 1)
          Tile.create!(letter: 'R', value: 1)
          Tile.create!(letter: 'T', value: 1) }
# L, S, U, D
4.times { Tile.create!(letter: 'L', value: 1)
          Tile.create!(letter: 'S', value: 1)
          Tile.create!(letter: 'U', value: 1)
          Tile.create!(letter: 'D', value: 2) }
# G
3.times { Tile.create!(letter: 'G', value: 2) }
# B, C, M, P, F, H, V, W, Y
2.times { Tile.create!(letter: 'B', value: 3)
          Tile.create!(letter: 'C', value: 3)
          Tile.create!(letter: 'M', value: 3)
          Tile.create!(letter: 'P', value: 3)
          Tile.create!(letter: 'F', value: 4)
          Tile.create!(letter: 'H', value: 4)
          Tile.create!(letter: 'V', value: 4)
          Tile.create!(letter: 'W', value: 4)
          Tile.create!(letter: 'Y', value: 4) }
# K, J, X, Q, Z
          Tile.create!(letter: 'K', value: 5)
          Tile.create!(letter: 'J', value: 8)
          Tile.create!(letter: 'X', value: 8)
          Tile.create!(letter: 'Q', value: 10)
          Tile.create!(letter: 'Z', value: 10)

# Seed Cells to hold location data
14.times do |row_index|
     14.times do |col_index|
          Cell.create!(x_coord: col_index, y_coord: row_index)
     end
end

# !!!!!!!!!!!! TEST DATA BEYOND THIS POINT !!!!!!!!!!!!!!!!
# Create players, id's 1 & 2
p1 = Player.create!(username: 'player1', password: 'password', email: 'player1@example.com')
p2 = Player.create!(username: 'player2', password: 'password', email: 'player2@example.com')

# Create game, id 1
g = Game.create!(status: 'started', )

# Create playerGames id's 1 & 2
p1g = Playergame.create!(player: p1, game: g)
p2g = Playergame.create!(player: p2, game: g)

# give 7 starting tiles to each player
tiles = Tile.all

p1_sample = tiles.sample(7)
p1_sample.map { |tile| Gametile.create!(game: g, tile: tile, playergame: p1g) }

tiles -= p1_sample

p2_sample = tiles.sample(7)
p2_sample.map { |tile| Gametile.create!(game: g, tile: tile, playergame: p2g) }

# put some tiles on the board

board_sample = tiles.sample(7)
