class ImportProductsTask
  include Sidekiq::Worker

  def perform products
    ImportProducts.call products
  end
end