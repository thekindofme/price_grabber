module LPriceGrabber
  class Category
    attr_accessor :name, :url

    def to_s
      puts ''
      puts "name: #{@name}"
      puts "url: #{@url}"
    end
  end
end