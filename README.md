# FileManagement
[![Build Status](https://travis-ci.org/Mikeks81/File-Management.svg?branch=master)](https://travis-ci.org/Mikeks81/File-Management)

Simple File Management library for creating, deleting, file stats and listing all files in a directory. Gem is still in the very early phase of development. Please feel free to make suggestions or identify bugs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'file_management'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install file_management

## Usage

### initialize
You can initialize the gem by telling it the path you would like to manage (via path) and and file that would like to ignore (via excludes). If you don't specify a path it will set to './'.  File Manager will make all necessary directories needed if they don't exist.

```
FileManager.new
=> #<FileManager:0x007fe2ab267790 @path="./", @excludes="">

FileManager.new(path: '/some/cool/path', excludes: 'ignore_me.rb')
=> #<FileManager:0x007fe2ab20f608 @path="some/cool/path", @excludes="ignore_me.rb">
```

## Methods
### all_files
returns an array of files in the directory
all files listed in the excludes attribute are ignored and not added to the array
```
f = FileManager.new(path: '/some/cool/path', excludes: 'ignore_me.rb')
f.all_files
=> ["test.rb", "test1.rb", "test2.rb"]
```
### make_file(new_file)
returns the file path of the newly created file
returns false if the file name is already taken
```
f.make_file('new_file.rb')
=> ["test/test/new_file.rb"]
```
### pwd(file)
returns a string path
returns false if file doesn't exist or isn't found
```
f.pwd('new_file.rb')
=> "test/test/new_file.rb"
```
### file_exists?(file)
returns a boolean value of true if the file exists in the given director and false if it doesn't
```
f.file_exists?('new_file.rb')
=> true
```
### stats(file, request)
A Wrapper for File::Stat. The first argument is the file and the second is the stat method you would like. Currently if the the method from File::State isn't chained onto the end it is not supported ( directory? is one )
```
f.stats('new_file.rb', 'birthtime')
=> 2017-06-12 20:27:11 -0400

f.stats('new_file.rb', 'ftype')
=> "file"
```

### file_size(file)
Gives you the file size in SI standard.
```
f.file_size('file_manager.rb')
=> "1.77 kB"
```

### rename(file, new_name)
Renames file if it's present in path. Returns 0 if successful and false if the file doesn't exist
```
f.rename('new_file.rb', 'new_shit.rb')
=> 0
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/file_management. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FileManagement project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/file_management/blob/master/CODE_OF_CONDUCT.md).
