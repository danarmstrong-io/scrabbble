# Seed words from dictionary.txt into Words table
File.open('db/dictionary.txt').each_line do |word|
  Word.create(text: word.chomp!)
end
# Seed Tiles for scrabbble game
# 1 point: E ×12, A ×9, I ×9, O ×8, N ×6, R ×6, T ×6, L ×4, S ×4, U ×4
# 2 points: D ×4, G ×3
# 3 points: B ×2, C ×2, M ×2, P ×2
# 4 points: F ×2, H ×2, V ×2, W ×2, Y ×2
# 5 points: K ×1
# 8 points: J ×1, X ×1
# 10 points: Q ×1, Z ×1

# E
12.times { Tile.create(letter: 'E', value: 1) }
# A, I
9.times { Tile.create(letter: 'A', value: 1) 
          Tile.create(letter: 'I', value: 1) }
# O
8.times { Tile.create(letter: 'O', value: 1) }
# N, R, T
6.times { Tile.create(letter: 'N', value: 1) 
          Tile.create(letter: 'R', value: 1)
          Tile.create(letter: 'T', value: 1) }
# L, S, U, D
4.times { Tile.create(letter: 'L', value: 1) 
          Tile.create(letter: 'S', value: 1)
          Tile.create(letter: 'U', value: 1) 
          Tile.create(letter: 'D', value: 2) }
# G
3.times { Tile.create(letter: 'G', value: 2) }
# B, C, M, P, F, H, V, W, Y
2.times { Tile.create(letter: 'B', value: 3) 
          Tile.create(letter: 'C', value: 3)
          Tile.create(letter: 'M', value: 3)
          Tile.create(letter: 'P', value: 3)
          Tile.create(letter: 'F', value: 4)
          Tile.create(letter: 'H', value: 4)
          Tile.create(letter: 'V', value: 4)
          Tile.create(letter: 'W', value: 4)
          Tile.create(letter: 'Y', value: 4) }
# K, J, X, Q, Z
          Tile.create(letter: 'K', value: 5)
          Tile.create(letter: 'J', value: 8)
          Tile.create(letter: 'X', value: 8)
          Tile.create(letter: 'Q', value: 10)
          Tile.create(letter: 'Z', value: 10)          