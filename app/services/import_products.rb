class ImportProducts
  NAME = 'name'.freeze
  DESCRIPTION = 'description'.freeze
  PRICE = 'price'.freeze
  AVAILABILITY_DATE = 'availability_date'.freeze
  SLUG = 'slug'.freeze
  STOCK_TOTAL = 'stock_total'.freeze
  CATEGORY = 'category'.freeze

  attr_accessor :products

  def initialize products
    @products = products
  end

  def self.call products
    service = new products
    service.call
  end

  def call
    products.each do |product|
      create_product product
    end
  end

  def create_product hash
    price = hash[PRICE].to_d
    availability_date = Time.parse(hash[AVAILABILITY_DATE])
    stock_total = hash[STOCK_TOTAL].to_i
    Spree::Product.transaction do
      product = Spree::Product.create! name: hash[NAME], description: hash[DESCRIPTION], price: price,
                             availability_date: availability_date, slug: hash[SLUG]
      product.master.stock_items.first.adjust_count_on_hand stock_total
      product.save!
      find_or_create_category! product, hash[CATEGORY]
      add_product_to_stock! product, stock_total
    end
  end

  def find_or_create_category! product, category_name
    puts "#{product} - #{category_name}"
    #HERE SOME CODE FOR THIS
  end

  def add_product_to_stock product, stock_total
    puts "#{product} - #{stock_total}"
    #HERE SOME CODE FOR THIS
  end
end