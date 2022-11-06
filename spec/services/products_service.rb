# frozen_string_literal: true
require_relative 'base_service'

class Products < BaseService

  base_uri ENV['URI_DUMMY']

  def get_all_products
    self.class.get('/products',
    headers:{
      'Content-Type': 'application/json'
    })
  end

  def post_new_product(body)
    self.class.post('/products/add',
    body: body.to_json,
    headers: {
      'Content-Type': 'application/json'
    })
  end

  def put_product(id, body)
    self.class.put("/products/#{id}",
    body: body.to_json,
    headers: {
      'Content-Type': 'application/json'
    })
  end

  def delete_product(id)
    self.class.delete("/products/#{id}",
    headers: {
      'Content-Type': 'application/json'
    })
  end
end