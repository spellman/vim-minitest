let s:plugin_path = expand("<sfile>:p:h:h")

if !exists("g:minitest_command")
  let s:cmd = "ruby -Itest {test}"

  if has("gui_running") && has("gui_macvim")
    let g:minitest_command = "silent !" . s:plugin_path . "/bin/run_in_os_x_terminal '" . s:cmd . "'"
  else
    let g:minitest_command = "!echo " . s:cmd . " && " . s:cmd
  endif
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
    let l:test = AppendTestFunctionNameToTestFilePath(NearestFunctionName())
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
  return match(expand("%"), 'test_.*.rb$') != -1
endfunction

function! SetLastTestCommand(test)
  let s:last_test_command = a:test
endfunction

function! RunTests(test)
  execute substitute(g:minitest_command, "{test}", a:test, "g")
endfunction

function! NearestFunctionName()
  if IsTestFunctionDefLine(".")
    return GetTestFunctionNameFromLine(".")
  elseif IsTestFunctionDefLine(PreviousFunctionDefLine())
    return GetTestFunctionNameFromLine(PreviousFunctionDefLine())
  elseif IsTestFunctionDefLine(NextFunctionDefLine())
    return GetTestFunctionNameFromLine(NextFunctionDefLine())
  endif
endfunction

function! IsTestFunctionDefLine(lineNumber)
  return IsNonEmptyLine(a:lineNumber)            &&
        \ FirstWordOfLine(a:lineNumber) == "def" &&
        \ match(SecondWordOfLine(a:lineNumber), 'test_\w*') == 0
endfunction

function! GetTestFunctionNameFromLine(lineNumber)
  return SecondWordOfLine(a:lineNumber)
endfunction

function! AppendTestFunctionNameToTestFilePath(functionName)
  return @% . " -n " . a:functionName
endfunction

function! IsNonEmptyLine(lineNumber)
  return !empty(getline(a:lineNumber))
endfunction

function! PreviousFunctionDefLine()
  return search("def ", "nbceW")
endfunction

function! NextFunctionDefLine()
  return search("def ", "nceW")
endfunction

function! FirstWordOfLine(lineNumber)
  return NthWordOfLine(0, a:lineNumber)
endfunction

function! SecondWordOfLine(lineNumber)
  return NthWordOfLine(1, a:lineNumber)
endfunction

function! NthWordOfLine(n, lineNumber)
  return split(getline(a:lineNumber))[a:n]
endfunction
