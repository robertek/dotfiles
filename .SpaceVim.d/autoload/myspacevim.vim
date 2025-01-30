function! myspacevim#after() abort
	" coc {{
	let g:coc_config_home = '~/.SpaceVim.d/'

	let g:coc_global_extensions = [
				\ 'coc-rust-analyzer',
				\ 'coc-sh',
				\ 'coc-vimlsp',
				\ 'coc-dictionary',
				\ 'coc-word',
				\ ]

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" coc }}
endfunction
