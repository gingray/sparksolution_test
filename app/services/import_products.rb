class ImportProducts
  NAME = 'name'.freeze
  DESCRIPTION = 'description'.freeze
  PRICE = 'price'.freeze
  AVAILABILITY_DATE = 'availability_date'.freeze
  SLUG = 'slug'.freeze
  STOCK_TOTAL = 'stock_total'.freeze
  CATEGORY = 'category'.freeze
  REQUIRED_FIELDS = [NAME, DESCRIPTION, PRICE, AVAILABILITY_DATE, SLUG, STOCK_TOTAL, CATEGORY]

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
    validate! hash
    price = hash[PRICE].to_d
    availability_date = Time.parse(hash[AVAILABILITY_DATE])
    stock_total = hash[STOCK_TOTAL].to_i
    Spree::Product.transaction do
      product = Spree::Product.create! name: hash[NAME], description: hash[DESCRIPTION], price: price,
                                       available_on: availability_date, slug: hash[SLUG],
                                       shipping_category: Spree::ShippingCategory.first
      product.save!
      find_or_create_category! product, hash[CATEGORY]
      add_product_to_stock! product, stock_total
      [product, nil]
    end
  rescue ImportProductEx::Fields => e
    [nil, e]
  end

  def validate! hash
    REQUIRED_FIELDS.each do |key|
      raise ImportProductEx::Fields if hash[key].blank?
    end
  end

  def find_or_create_category! product, category_name
    #HERE SOME CODE FOR THIS
  end

  def add_product_to_stock! product, stock_total
    #HERE SOME CODE FOR THIS
  end
end