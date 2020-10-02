# Rotas

Welcome to your new gem! In this directory, you'll find the files you need to
be able to package up your Ruby library into a gem. Put your Ruby code in the
file `lib/rotas`. To experiment with that code, run `bin/console` for an
interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rotas'
```

And then execute:

```console
bundle
```

Or install it yourself as:

```console
gem install rotas
```

## Documentation

The documentation is available at [https://trombik.github.io/rotas/](https://trombik.github.io/rotas/).

## Usage

```console
> bundle exec rackup -p 4567
[2020-10-02 08:43:13] INFO  WEBrick 1.4.2
[2020-10-02 08:43:13] INFO  ruby 2.6.6 (2020-03-31) [amd64-freebsd13]
[2020-10-02 08:43:13] INFO  WEBrick::HTTPServer#start: pid=72125 port=4567
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

### Optional packages

The following packages are optional but useful for development.

* Nodejs (required by `markdownlint-cli`)
* python 3.x and `pip` (required by `yamllint`)

They are optional and tests are performed in CI. However, you probably want to
test changes before pushing them.

Install `pip` packages and `nodejs` modules (`bin/setup` does this for you).

```console
pip install --user -r requirements.txt
yarn install --frozen-lockfile
```

### Running tests

The default rake target runs all tests.

```console
bundle exec rake
```

You may run individual tests.

```console
bundle exec rake rubocop
bundle exec rake yamllint
bundle exec rake markdownlint
bundle exec rake spec
```

### Automate tests with `guard`

Install `Optional packages` above before running `guard`.

```console
> bundle exec guard
14:37:51 - INFO - Guard::RSpec is running
14:37:51 - INFO - Guard is now watching at '/usr/home/trombik/github/trombik/rotas'
[1] guard(main)>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at FIXME.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
