" adapted from http://technotales.wordpress.com/2007/10/03/like-slime-for-vim/
" put in ~/.vim/plugin/

function Send_to_Screen(text)
  if !exists("g:screenrepl_sessionname") || !exists("g:screenrepl_windowname")
    call Screen_Vars()
  end

  echo system("screen -S " . g:screenrepl_sessionname . " -p " . g:screenrepl_windowname . " -X stuff '" . substitute(a:text, "'", "'\\\\''", 'g') . "'")
endfunction

function Screen_Session_Names(A,L,P)
  return system("screen -ls | awk '/Attached/ {print $1}'")
endfunction

function Screen_Vars()
  if !exists("g:screenrepl_sessionname") || !exists("g:screenrepl_windowname")
    let g:screenrepl_sessionname = ""
    let g:screenrepl_windowname = "0"
  end

  let g:screenrepl_sessionname = input("session name: ", "", "custom,Screen_Session_Names")
  let g:screenrepl_windowname = input("window name: ", g:screenrepl_windowname)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <Leader>cc "ry :call Send_to_Screen(@r)<CR>
nmap <Leader>cc vip<Leader>cc

" nmap <C-c>v :call Screen_Vars()<CR>
