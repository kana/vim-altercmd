call altercmd#define('full', 'F-U-L-L')
call altercmd#define('ab[br]', 'A-B-B-R')

function! RecordTheCurrentCommandLine()
  let g:cmdline = getcmdline()
  return ''
endfunction
cnoremap <expr> {X}  RecordTheCurrentCommandLine()

function! Test(lhs, rhs)
  let g:cmdline = ''
  silent execute 'normal' ":".a:lhs."\<C-]>{X}\<C-c>"
  Expect g:cmdline ==# a:rhs
endfunction

describe 'altercmd#define'
  it 'replaces a built-in command'
    call Test('full', 'F-U-L-L')
  end

  it 'replaces all abbreviated names of a built-in command'
    call Test('ab', 'A-B-B-R')
    call Test('abb', 'A-B-B-R')
    call Test('abbr', 'A-B-B-R')
  end
end
