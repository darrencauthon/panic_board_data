# PanicBoardData

This gem exists to make it eaiser to display data on your Panic Status Board.

## Installation

Add this line to your application's Gemfile:

    gem 'panic_board_data'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install panic_board_data

## Usage

#### Tables

![Table](https://raw.github.com/darrencauthon/panic_board_data/master/samples/tables.jpg "Table")

````ruby
  # Sinatra example
  get '/my_table' do

    images = [build_image('http://tinyurl.com/mnvjm96'),
              build_image('http://tinyurl.com/kt3hp7v')]

    table = PanicBoardData::Table.new
    table.data = [['Project A', "5 days", images,    progress_bar_to(3)], 
                  ['Project B', "2 days", images[0], progress_bar_to(7)],
                  ['Project C', "9 days", images[1], progress_bar_to(1)],
                  ['Project D', "1 day",  nil, progress_bar_to(8)]]
    table.widths = [nil, 125, 100]
    table.to_html
  end
````

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
