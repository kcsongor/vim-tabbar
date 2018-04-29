function! tabbar#tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let s .= ' %{tabbar#tab_label(' . (i + 1) . ')} '
  endfor
  let s .= '%#TabLineFill#%T'
  return s

endfunction
function! tabbar#tab_label(n)
  let name = gettabvar(a:n, 'name')
  if (name == "")
    let buflist = tabpagebuflist(a:n)
    let names = map(buflist, {k, v -> substitute(bufname(v), '.*/', '', '')})
    let names = filter(names, {k, v -> v != ""})
    return "[" . join(names, ",") . "]"
  else
    return name
  endif
endfunction

function! tabbar#rename_current_tab(...)
  let to = 0 < a:0 ? a:1 : inputdialog("Rename tab to: ",
                                      \ gettabvar(tabpagenr(), 'name', ""))
  if (to == "")
    unlet! t:name
  else
    let t:name = to
  endif
  set showtabline=1
endfunction
