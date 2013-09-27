# Minitest.vim

This is a Minitest adaptation of [Rspec.vim from thoughtbot.](https://github.com/thoughtbot/vim-rspec)

## Installation

Recommended installation with [vundle](https://github.com/gmarik/vundle):

```vim
Bundle 'spellman/vim-minitest'
```

Running all tests is achieved via running <project root>/test/test_helper.rb, which should require all tests.
I used the following code from the [CrashRuby blog](http://crashruby.com/2013/05/10/running-a-minitest-suite/):
```ruby
require "minitest/autorun"

if __FILE__ == $0
  $LOAD_PATH.unshift 'lib', 'test'
  Dir.glob('./test/**/test_*.rb') { |f| require f }
end
```

As per [Rspec.vim](https://github.com/thoughtbot/vim-rspec), if using zsh on OS X it may be necessary to run move `/etc/zshenv` to `/etc/zshrc`.

## Example of key mappings

```vim
" Minitest.vim mappings
nnoremap <Leader>t :call RunCurrentTestFile()<CR>
nnoremap <Leader>s :call RunNearestTest()<CR>
nnoremap <Leader>l :call RunLastTest()<CR>
nnoremap <Leader>a :call RunAllTests()<CR>
```

## Configuration

Overwrite `g:minitest_command` variable to execute a custom command.

Example:

```vim
let g:minitest_command = "!ruby -Itest {test}"
```

## License

Minitest.vim is copyright © 2013 Cort Spellman. It is free software and may be
redistributed under the terms specified in the `LICENSE` file.
