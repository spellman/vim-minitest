# Minitest.vim

This is a Minitest adaptation of [Rspec.vim from thoughtbot.](https://github.com/thoughtbot/vim-rspec) to run specific tests from Vim.

## NOTE: 2016-02-21: I think [minitest-line](https://github.com/judofyr/minitest-line) makes this plugin obsolete.

## Installation

Recommended installation with [vundle](https://github.com/gmarik/vundle):

```vim
Bundle 'spellman/vim-minitest'
```

Running all tests is achieved via running <project root>/test/test_helper.rb, which should require all tests.
I used the following code in test_helper.rb from the [CrashRuby blog](http://crashruby.com/2013/05/10/running-a-minitest-suite/). Note this assumes that vim's working directory is the project root.
```ruby
require "minitest/autorun"
require "bundler/setup"

if __FILE__ == $0
  $LOAD_PATH.unshift "lib", "test"
  Dir.glob("./test/**/test_*.rb") { |f| require f }
end
```

## Example of key mappings

```vim
" Minitest.vim mappings
nmap <Leader>t <Plug>vim-minitest#RunCurrentTestFile
nmap <Leader>s <Plug>vim-minitest#RunNearestTest
nmap <Leader>l <Plug>vim-minitest#RunLastTest
nmap <Leader>a <Plug>vim-minitest#RunAllTests
```

## Configuration

Overwrite `g:minitest_command` variable to execute a custom command.

Example:

```vim
let g:minitest_command = "!ruby -Itest {test}"
```
