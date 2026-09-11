-- ==========================================================================
-- 1. CONFIGURAÇÕES BASE E OPÇÕES
-- ==========================================================================
vim.g.mapleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.list = true
vim.o.confirm = true
vim.o.tabstop = 4       
vim.o.shiftwidth = 4    
vim.o.expandtab = true  
-- Sincronização da Área de Transferência (Mantido do seu original)
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- ==========================================================================
-- 2. MAPEAMENTO DE TECLAS (Ergonomia VS Code)
-- ==========================================================================

-- Sair do modo terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Navegação entre janelas (Alt + h, j, k, l)
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- Mover blocos selecionados no Modo Visual (Alt + Up/Down no VS Code, aqui Alt + j/k)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selecao para baixo' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selecao para cima' })

-- Mover a linha atual no Modo Normal
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move linha para baixo' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move linha para cima' })

-- ==========================================================================
-- 3. FUNCIONALIDADES VS CODE (LSP, Explorer e Buscas)
-- ==========================================================================

-- EXPLORADOR DE ARQUIVOS (Ctrl + B)
-- Configura o Netrw para parecer com o explorador lateral do VS Code
vim.g.netrw_banner = 0       -- Remove o cabeçalho inútil
vim.g.netrw_liststyle = 3    -- Exibe em formato de árvore
vim.g.netrw_winsize = 25     -- Ocupa 25% da tela
vim.g.netrw_altv = 1         -- Abre arquivos na janela à direita
vim.keymap.set('n', '<C-b>', ':Lexplore<CR>', { desc = 'Alterna Barra Lateral de Arquivos' })

-- BUSCADOR DE ARQUIVOS (Ctrl + P)
vim.keymap.set('n', '<C-p>', '<cmd>lua require("fzf-lua").files()<CR>', { desc = 'Busca de Arquivos (FZF)' })

-- COMANDOS LSP (Inteligência de Código)
-- Ir para a declaração/definição (F12 ou gd)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Ir para definicao' })
vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, { desc = 'Ir para definicao' })

-- Renomear todas as ocorrências no escopo (F2)
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Renomear Variavel/Funcao' })

-- Exibir documentação da função (Hover)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Mostrar documentacao' })

-- ==========================================================================
-- 4. EVENTOS E COMANDOS CUSTOMIZADOS
-- ==========================================================================
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.')
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
end, { desc = 'Print the git blame for the current line' })

-- ==========================================================================
-- 5. PLUGINS (via Sistema Nativo vim.pack)
-- ==========================================================================
vim.cmd('packadd! nohlsearch')

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nvim-mini/mini.completion', -- Autocomplete minimalista
})

-- Inicialização do FZF
require('fzf-lua').setup { fzf_colors = true }

-- Inicialização do Autocomplete
require('mini.completion').setup {
  mappings = {
    -- Ctrl+Space força a exibição dos métodos do objeto
    -- Nota: Em alguns emuladores de terminal, Ctrl+Space é lido como <C-@>
    force_twostep = '<C-Space>',
    force_fallback = '<A-Space>',
  }
}

-- Configuração dos Servidores de Linguagem (Python e Java)

-- Python (Leve)
vim.lsp.enable('pylsp')

-- Java (Muito pesado)
-- Requer a instalação do 'jdtls' no seu Arch Linux (yay -S jdtls)
-- vim.lsp.enable('jdtls')
