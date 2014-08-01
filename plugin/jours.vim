" jours.vim
" Author: Shuhei Kagawa <shuhei.kagawa@gmail.com>

if exists('g:jours_loaded')
  finish
endif

if !exists('g:jours_dir')
  let g:jours_dir = '~/jours'
endif

function g:jours_today_path()
  let l:today = strftime("%Y%m%d")
  return expand(g:jours_dir . '/' . l:today . '.md')
endfunction

function g:jours_last_file()
  let l:file_pattern = g:jours_dir . '/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].md'
  return split(glob(l:file_pattern), '\n')[-1]
endfunction

function s:jours_carry_over()
  let l:today = g:jours_today_path()
  if !empty(glob(l:today))
    echo l:today . ' already exists.'
    return
  endif

  execute 'edit' g:jours_last_file()
  execute 'save' l:today
endfunction

command! JoursEditToday execute 'edit' g:jours_today_path()
command! JoursWriteToday execute 'write' g:jours_today_path()
command! JoursSaveToday execute 'save' g:jours_today_path()
command! JoursCarryOver call s:jours_carry_over()
command! JoursCd execute 'cd' g:jours_dir

let g:jours_loaded = 1
