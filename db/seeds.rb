User.destroy_all
Product.destroy_all

names = [
  'Jacinta Simien',
  'Art Sebesta',
  'Greg Braddock',
  'Garnett Voorhies',
  'Jake Hoyos',
  'Olympia Sant',
  'Jasmine Blomberg',
  'Conception Bolan',
  'Elza Parm',
  'Ok Scheurer',
  'Salvatore Licari',
  'Leslie Belt',
  'Roma Hackney',
  'Nevada Boutwell',
  'Sheron Kurz',
  'Amos Boe',
  'Kermit Lehmkuhl',
  'Evelia Maland',
  'Twanda Pecora',
  'Verona Bailes'
]

product_nouns = %w[
  box
airplane
goat
machine
kayak
robe
jumprope
hair
pavement
shampoo
book
wrench
kettle
bicycle
bracelet
candy
]

product_adjectives = %w[
great
large
uneven
skilled
difficult
green
blue
gold
jumpy
soft
magnetic
round
]

product_images = %w[
https://get.pxhere.com/photo/liquid-glass-bottle-research-glass-bottle-product-laboratory-colored-test-experiment-many-chemical-lab-medical-chemistry-pharmaceutical-microbiology-drinkware-analyze-pharmacology-test-mixer-filled-test-tube-1005187.jpg
https://c.pxhere.com/photos/b6/da/pencil_sharpener_pencil_pencil_tip_school_school_supplies-899557.jpg!d
https://c.pxhere.com/photos/0f/a9/yarn_ball_wool_string_blanket-6058.jpg!d
https://c.pxhere.com/photos/81/be/sport_shoe_running_shoe_shoe_blue_jeans_rubber_sole_black_run_jog-602034.jpg!d
https://c.pxhere.com/images/48/5a/cdfbe9bd1f158824fb715953ca04-1419113.jpg!d
]

(0..19).to_a.each do |num|
  name = names[num]
  first_name = name.split(' ').first
  u = User.create(name: name, email: "#{first_name}@#{first_name}.com", password: first_name)

  5.times do
    Product.create(name: "#{product_adjectives.sample} #{product_nouns.sample}",
                   user_id: u.id,
                   min_price: rand(1...10000).round(2),
                   image: product_images.sample,
                   offered: true,
                   description: Faker::Lorem.sentences(rand(1...15)).join(' '))
  end
end
