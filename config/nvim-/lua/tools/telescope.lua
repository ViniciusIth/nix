return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', 'cljoly/telescope-repo.nvim', 'airblade/vim-rooter' },
    config = function()


        require 'telescope'.load_extension 'repo'

        local builtin = require('telescope.builtin')

    end
}
