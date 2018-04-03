# Eisiges::DI::Core

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/eisiges/di/core`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eisiges-di-core', '~> 0.1.2'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install eisiges-di-core

## Usage

```
require 'eisiges/di/core'

class MyClass
	include Eisiges::DI::Core

	inject klasse: OtherClass, as: other_object

	def method_with_class
		@other_object.call_method_on_other_class
	end
end
```

