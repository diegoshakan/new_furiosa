# frozen_string_literal: true

Kaminari.configure do |config|
  # Número padrão de itens por página
  config.default_per_page = 12

  # Máximo de itens por página (segurança contra ataques)
  config.max_per_page = 50

  # Número de páginas mostradas ao redor da página atual
  config.window = 4

  # Número de páginas mostradas no início e fim
  config.outer_window = 1

  # Nome do método para paginação
  config.page_method_name = :page

  # Nome do parâmetro da página na URL
  config.param_name = :page

  # Máximo de páginas permitidas (segurança)
  config.max_pages = 1000

  # Não incluir parâmetros na primeira página (URLs mais limpas)
  config.params_on_first_page = false
end
