-- mason で導入するツールを明示的に固定する。
--
-- LSP サーバーは通常、対応するファイルタイプを開いたときに mason-lspconfig
-- 経由で入るが、それだと「どのファイルを開いたか」に再現性が左右される。
-- ここで列挙しておくと、新しいマシンでも初回起動時にまとめて導入される。
--
-- LazyVim 側のデフォルト（stylua / shfmt）は opts_extend により保持されるので
-- 上書きにはならない。名前は mason のパッケージ名（`:Mason` の表示と同じ）。
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "clangd", -- C / C++
        "json-lsp", -- JSON
        "lua-language-server", -- Lua
        "marksman", -- Markdown
        "vtsls", -- TypeScript / JavaScript
        -- フォーマッタ・リンタ
        "markdownlint-cli2",
        "markdown-toc",
        "shfmt",
        "stylua",
      },
    },
  },
}
