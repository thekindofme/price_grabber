# price_grabber

* Homepage: [http://github.com/thekindofme/price_grabber](http://github.com/thekindofme/price_grabber)
* Code: [http://github.com/thekindofme/price_grabber](http://github.com/thekindofme/price_grabber)

## Author(s)

* [http://thekinfofme.wordpress.com](http://thekinfofme.wordpress.com)

## Description

A library to parse various information (such as item names/price...etc) from selected list of sri lankan computer seller's price lists / product catalogs / shopping applications.

## Features

* Supports
    * www.abc.lk
    * www.barclays.lk
    * www.laptop.lk
    * shop.memory.lk
    * www.slmega.lk
    * www.bhavik.com/techwarehouse/
* Parses price, description, model name...etc

## Problems:

* This is a parser so if the site's that's been parsed change their layout..etc the parsers will not work.
* This will not parse all the information available about a product from all the sites.

## Example Code:

    require "data_structures/category"
    require "data_structures/product"
    require "parsers/abc_computers_parser"

    LPriceGrabber::ABCComputersParser.new.categories.each { |result| puts result }
    LPriceGrabber::ABCComputersParser.new.parse

## Requirements

* ruby
* mechanize rubygem

## Warning!
running this script(s) continuously against any site could put a hevy strain on the web site. So be mindful of how you use it.

## License

(The MIT License)

Copyright (c) 2009 thekinfofme.wordpress.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.