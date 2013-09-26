let s:plugin_path = expand("<sfile>:p:h:h")

if !exists("g:minitest_command")
  let s:cmd = "ruby -Itest {test}"
  let g:minitest_command = "!echo " . s:cmd . " && " . s:cmd
endif

function! RunAllTests()
  let l:test = "test/test_helper.rb"
  call SetLastTestCommand(l:test)
  call RunTests(l:test)
endfunction

function! RunCurrentTestFile()
  if InTestFile()
    let l:test = @%
    call SetLastTestCommand(l:test)
    call RunTests(l:test)
  else
    call RunLastTest()
  endif
endfunction

function! RunNearestTest()
  if InTestFile()
    " Test method name, assumed to be the word after the previous 'def'
    if split(getline("."))[0] == "def"
      let l:test = @% . " -n " . split(getline("."))[1]
    else
      let l:test = @% . " -n " . split(getline(search("def", "nbceW")))[1]
    endif
    call SetLastTestCommand(l:test)
    call RunTests(l:test)
  else
    call RunLastTest()
  endif
endfunction

function! RunLastTest()
  if exists("s:last_test_command")
    call RunTests(s:last_test_command)
  endif
endfunction

function! InTestFile()
  " File path contains a segment test_<words, underscores>.rb
  return match(expand("%"), "test_.*.rb$") != -1
endfunction

function! SetLastTestCommand(test)
  let s:last_test_command = a:test
endfunction

function! RunTests(test)
  execute substitute(g:minitest_command, "{test}", a:test, "g")
endfunction
