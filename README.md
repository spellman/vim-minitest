# Minitest.vim

This is a Minitest adaptation of [Rspec.vim from thoughtbot.](https://github.com/thoughtbot/vim-rspec)

## Installation

Recommended installation with [vundle](https://github.com/gmarik/vundle):

```vim
Bundle 'spellman/vim-minitest'
```

As per [Rspec.vim](https://github.com/thoughtbot/vim-rspec), if using zsh on OS X it may be necessary to run move `/etc/zshenv` to `/etc/zshrc`.

## Example of key mappings

```vim
" Minitest.vim mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR>
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
