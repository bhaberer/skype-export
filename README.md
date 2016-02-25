# SkypeExport

I wrote this simple gem to allow me to export full history for a given contact so I could remove said history as after a couple years those logs get a bit unweildy.

## Installation

    $ gem install skype-export

## Usage

Currently the only thing supported is exporting history with a single person.

Specify your skype username and the name of the person whose logs with you you want to export.

    export-skype-history -u YOUR_SKYPE_USERNAME -t YOUR_FRIENDS_SKYPE_USERNAME
    
this will create a file in the current directory named `YOUR_FRIENDS_SKYPE_USERNAME.txt` with the full history.

**Note: I don't have skype on a windows or linux box to test, so I borrowed logic from @aigarsdz main.db location logic from the [runoff gem](https://github.com/aigarsdz/runoff), which was handy, but didn't quite do what I wanted. If you need to export everything in your skype db, I suggest looking into that gem instead.**

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/skype-export. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

