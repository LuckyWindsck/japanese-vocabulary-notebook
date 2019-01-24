# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  :email => 'admin@test',
  :username => 'admin',
  :password => '123456',
  :password_confirmation => '123456'
)

Vocabulary.create(
  part_of_speech: '動詞',
  vocab: '欺く',
  pronunciation: 'あざむく',
  user_id: User.find_by(username: 'admin').id
)

Vocabulary.create(
  part_of_speech: '形容詞',
  vocab: '鋭い',
  pronunciation: 'するどい',
  user_id: User.find_by(username: 'admin').id
)

Vocabulary.create(
  part_of_speech: '名詞',
  vocab: '常夏',
  pronunciation: 'とこなつ',
  user_id: User.find_by(username: 'admin').id
)

Vocabulary.create(
  part_of_speech: '形容動詞',
  vocab: '厄介',
  pronunciation: 'やっかい',
  user_id: User.find_by(username: 'admin').id
)

Vocabulary.create(
  part_of_speech: '動詞',
  vocab: '明かす/証す',
  pronunciation: 'あかす',
  user_id: User.find_by(username: 'admin').id
)

Vocabulary.create(
  part_of_speech: '動詞',
  vocab: '至る',
  pronunciation: 'いたる',
  user_id: User.find_by(username: 'admin').id
)
