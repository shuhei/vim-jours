" jours.vim
" Author: Shuhei Kagawa <shuhei.kagawa@gmail.com>

if exists('g:jours_loaded')
  finish
endif

if !exists('g:jours_dir')
  let g:jours_dir = '~/jours'
endif

function g:JoursTodayPath()
  let l:today = strftime("%Y%m%d")
  return expand(g:jours_dir . '/' . l:today . '.md')
endfunction

function g:JoursLastFile()
  let l:file_pattern = g:jours_dir . '/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].md'
  return split(glob(l:file_pattern), '\n')[-1]
endfunction

function s:JoursCarryOver()
  let l:today = g:JoursTodayPath()
  if !empty(glob(l:today))
    echo l:today . ' already exists.'
    return
  endif

  execute 'edit' g:JoursLastFile()
  execute 'save' l:today
endfunction

command! JoursEditToday execute 'edit' g:JoursTodayPath()
command! JoursWriteToday execute 'write' g:JoursTodayPath()
command! JoursSaveToday execute 'save' g:JoursTodayPath()
command! JoursCarryOver call s:JoursCarryOver()
command! JoursCd execute 'cd' g:jours_dir

let g:jours_loaded = 1
