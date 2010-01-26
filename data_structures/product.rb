module LPriceGrabber
  class Product
    attr_accessor :name, :price, :model, :description, :sku, :tag, :stock, :image, :url, :brand, :warranty, :items_in_stock

    def to_s
      puts ''
      puts "name: #{@name}" if @name
      puts "brand: #{@brand}" if @brand
      puts "price: #{@price}" if @price
      puts "image: #{@image}" if @image
      puts "description: #{@description}" if @description
      puts "url: #{@url}" if @url
      puts "model: #{@model}" if @model
      puts "sku: #{@sku}" if @sku
      puts "stock: #{@stock}" if @stock
      puts "items_in_stock: #{@items_in_stock}" if @items_in_stock
      puts "tag: #{@tag}" if @tag
      puts "warranty: #{@warranty}" if @warranty
    end
  end
end