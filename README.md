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

    # sample images for our board
    images = [build_image('http://tinyurl.com/mnvjm96'),
              build_image('http://tinyurl.com/kt3hp7v')]

    # special note: An array of values (like "images") will
    # be flattened into a single value in the cell...
    # so no need to concatenate things like rows of images.
    data = [['Project A', "5 days", images,    progress_bar_to(3)], 
            ['Project B', "2 days", images[0], progress_bar_to(7)],
            ['Project C', "9 days", images[1], progress_bar_to(1)],
            ['Project D', "1 day",  nil,       progress_bar_to(8)]]

    table = PanicBoardData::Table.new data

    # optionally set the column widths
    table.widths = [nil, 125, 100]

    # return HTML necessary for import into Status Board
    table.to_html
  
  end
````

#### Graphs

![Graph](https://raw.github.com/darrencauthon/panic_board_data/master/samples/graphs.jpg "Graph")

````ruby
  #another Sinatra example
  get '/graph_example' do

    # one set of data
    hotdogs = PanicBoardData::DataSequence.new('Hotdogs')
    hotdogs.data['Sunday']    = 4
    hotdogs.data['Monday']    = 3
    hotdogs.data['Tuesday']   = 4
    hotdogs.data['Wednesday'] = 8
    hotdogs.data['Thursday']  = 10
    hotdogs.data['Friday']    = 11
    hotdogs.data['Saturday']  = 2

    # another set of data
    burgers = PanicBoardData::DataSequence.new('Burgers')
    burgers.data['Sunday']    = 1
    burgers.data['Monday']    = 7
    burgers.data['Tuesday']   = 5
    burgers.data['Wednesday'] = 6
    burgers.data['Thursday']  = 10
    burgers.data['Friday']    = 15
    burgers.data['Saturday']  = 5

    # build the graph
    graph = PanicBoardData::Graph.new
    graph.title = "Purchases"

    # this can be :bar or :line
    graph.type = :bar

    # add the sets of data you want to display in the graph
    graph.data_sequences << hotdogs
    graph.data_sequences << burgers

    # return JSON necessary for import into Status Board
    graph.to_json

  end
````

#### Single Values

These can be really big...

![SingleValue](https://raw.github.com/darrencauthon/panic_board_data/master/samples/single_value_1.jpg "Single Value")

````ruby
  # yet another Sinatra example
  get '/single_value' do
    heading = 'How many people live in the United States?'
    value = PanicBoardData::SingleValue.new heading, '317,044,240'

    # return HTML necessary for import into Status Board
    value.to_html
  end
````

... or very small.

![SingleValue](https://raw.github.com/darrencauthon/panic_board_data/master/samples/single_value_2.jpg "Single Value")

````ruby
  # yet another Sinatra example
  get '/single_value' do
    PanicBoardData::SingleValue.new('Logins Today', 1).to_html
  end
````


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
