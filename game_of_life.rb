sort_variant = -1
incorrect_variant_flag = false
while sort_variant < 1 || sort_variant > 3
  if incorrect_variant_flag
    puts 'Был выбран некорректный вариант! Выберите из списка'
  end
  incorrect_variant_flag = true
  puts 'Варианты сортировки:'
  puts '1. Random'
  puts '2. Stable'
  puts '3. Glider'
  print '> '
  sort_variant = gets.chomp.to_i
end

if sort_variant == 1
  print 'Ширина поля: '
  field_width = gets.chomp.to_i
  print 'Высота поля: '
  field_height = gets.chomp.to_i
else
  field_height = field_width = 10
end


# -----------------
# -----------------
# -----------------

require './game_field'

game_field = GameField.new(sort_variant, field_width, field_height)
game_field.show_field

loop do
  game_field.life_round
  game_field.show_field
  sleep 0.1
end