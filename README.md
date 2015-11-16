# Minitest.vim

This is a Minitest adaptation of [Rspec.vim from thoughtbot.](https://github.com/thoughtbot/vim-rspec)

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

As per [Rspec.vim](https://github.com/thoughtbot/vim-rspec), if using zsh on OS X it may be necessary to run move `/etc/zshenv` to `/etc/zshrc`.

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
