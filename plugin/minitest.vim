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

function! NthWordOfLine(n, lineNumber)
  return split(getline(a:lineNumber))[a:n]
endfunction

function! FirstWordOfLine(lineNumber)
  return NthWordOfLine(0, a:lineNumber)
endfunction

function! SecondWordOfLine(lineNumber)
  return NthWordOfLine(1, a:lineNumber)
endfunction

function! IsNonEmptyLine(lineNumber)
  return !empty(getline(a:lineNumber))
endfunction

function! IsTestFunctionDefLine(lineNumber)
  return IsNonEmptyLine(a:lineNumber) && FirstWordOfLine(a:lineNumber) == "def"
endfunction

function! PreviousFunctionDefLine()
  return search("def", "nbceW")
endfunction

function! GetTestFunctionNameFromLine(lineNumber)
  if IsNonEmptyLine(a:lineNumber)
    return SecondWordOfLine(a:lineNumber)
  endif
endfunction

function! AppendTestFunctionNameToTestFilePath(functionName)
  return @% . " -n " . a:functionName
endfunction

function! RunNearestTest()
  if InTestFile()
    " Test method name, assumed to be the word after the previous 'def'
    if IsTestFunctionDefLine(".")
      let l:testName = GetTestFunctionNameFromLine(".")
    else
      let l:testName = GetTestFunctionNameFromLine(PreviousFunctionDefLine())
    endif
    let l:test = AppendTestFunctionNameToTestFilePath(l:testName)
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
