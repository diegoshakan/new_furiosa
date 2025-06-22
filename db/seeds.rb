# Categorias e Subcategorias
casamento = Category.create(name: "Casamento")
Category.create(name: "Festa Infantil")
cha_bebe = Category.create(name: "Chá de Bebê")
Subcategory.create(name: "Buffet", category: casamento)
Subcategory.create(name: "Decoração", category: cha_bebe)

# Usuários
user1 = User.create!(name: "Diego", email: "diego@example.com", password: "diego@example.com")
user1.create_address!(street: "Rua A", city: "São Paulo", state: "SP", cep: "12345-678")

user2 = User.create!(name: "Kassandra", email: "kassandra@example.com", password: "kassandra@example.com")
user2.create_address!(street: "Rua B", city: "Rio de Janeiro", state: "RJ", cep: "87654-321")

# Anúncios
announcement1 = user1.announcements.create!(
  title: "Buffet para Casamento",
  description: "Buffet completo para 100 pessoas",
  code: "ADM001",
  price: 5000.00,
  category: casamento,
  subcategory: Subcategory.first,
  posted_at: Time.now
)
announcement1.images.attach(io: File.open("public/image1.jpg"), filename: "image1.jpg")

announcement2 = user2.announcements.create!(
  title: "Decoração para Chá de Bebê",
  description: "Decoração temática personalizada",
  code: "ADM002",
  price: 800.00,
  category: cha_bebe,
  subcategory: Subcategory.last,
  posted_at: Time.now
)
announcement2.images.attach(io: File.open("public/image2.jpg"), filename: "image2.jpg")

# Comentários e Curtidas
announcement1.comments.create!(content: "Ótimo serviço!", user: user2)
announcement1.likes.create!(user: user2)
