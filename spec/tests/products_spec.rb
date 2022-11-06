# frozen_string_literal: true
products_service = Products.new

describe '#Products' do
  context 'GET - Consultar informações dos produtos' do
    
    it 'GET ALL PRODUCTS' do
      @response = products_service.get_all_products

      for i in 0..@response['products'].length - 1
        expect(@response.code).to eq(200)
        expect(@response.body).to match_json_schema("get_all_products_schema")
      end
    end
  end

  context 'POST - Adicionar um novo produto e exceções' do
    it 'Criar produto' do
      body = {
        title: Faker::Name.first_name,
        description: Faker::Name.first_name,
        price: rand(99..999),
        discountPercentage: 10.56,
        rating: 4.57,
        stock: 999,
        brand: "Car Aux",
        category: "automotive",
        thumbnail: "https://dummyjson.com/image/i/products/86/thumbnail.jpg",
        images: []
      }

      @response = products_service.post_new_product(body)

      expect(@response.code).to eq(200)
      expect(@response['id']).not_to be_nil
      expect(@response['title']).not_to be_nil
      expect(@response['stock']).to eq(999)
      expect(@response.body).to match_json_schema("post_new_product_schema")
    end
  end

  context "PUT - Atualizar produto e exceções" do
    it "Atualizar produto com sucesso" do
      id_random = products_service.get_all_products
      id_random = id_random['products'].sample

      body = {
        title: Faker::Name.first_name,
        description: Faker::Name.first_name,
        price: rand(99..999),
        discountPercentage: 10.56,
        rating: 4.57,
        stock: 999,
        brand: "Car Aux",
        category: "automotive",
        thumbnail: "https://dummyjson.com/image/i/products/86/thumbnail.jpg",
        images: []
      }

      @response = products_service.put_product(id_random['id'], body)

      expect(@response.code).to eq 200
      expect(@response['id']).to eq("#{id_random['id']}")
      expect(@response['title']).to eq(body[:title])
      expect(@response.body).to match_json_schema("put_product_schema")
    end

    it "Tentativa de atualizar um produto com id invalido" do
      id_random = products_service.get_all_products
      id_random = id_random['products'].last
      id = (id_random['id'] + 9999)

      body = {
        title: Faker::Name.first_name,
        description: Faker::Name.first_name,
        price: rand(99..999),
        discountPercentage: 10.56,
        rating: 4.57,
        stock: 999,
        brand: "Car Aux",
        category: "automotive",
        thumbnail: "https://dummyjson.com/image/i/products/86/thumbnail.jpg",
        images: []
      }

      @response = products_service.put_product(id, body)

      expect(@response.code).to eq 404
      expect(@response['message']).to eq ("Product with id '#{id}' not found")
      expect(@response.body).to match_json_schema("put_product_exception_schema")
    end
  end

  context "DELETE - Deletar produto e exceções" do
    it "Deletar produto com sucesso" do
      id_random = products_service.get_all_products
      id_random = id_random['products'].sample

      @response = products_service.delete_product(id_random['id'])

      expect(@response.code).to eq 200
      expect(@response['id']).to eq(id_random['id'])
      expect(@response['isDeleted']).to be true
      expect(@response.body).to match_json_schema("delete_product_schema")
    end

    it "Tentativa de deletar um produto com id invalido" do
      id_random = products_service.get_all_products
      id_random = id_random['products'].last
      id = (id_random['id'] + 9999)

      @response = products_service.delete_product(id)

      expect(@response.code).to eq 404
      expect(@response['message']).to eq("Product with id '#{id}' not found")
      expect(@response.body).to match_json_schema("put_product_exception_schema")
    end
  end
end

