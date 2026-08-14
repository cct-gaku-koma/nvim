# 💤 Neovim config (LazyVim)

[LazyVim](https://github.com/LazyVim/LazyVim) ベースの個人用 Neovim 設定。
別PCでもこのリポジトリを clone するだけで同じ環境を再現できる。

プラグインのバージョンは `lazy-lock.json` で、有効な LazyVim extras は `lazyvim.json` で固定されている。
この2ファイルがあるので、どのマシンでも**まったく同じバージョン**のプラグインが入る。

## セットアップ

### 1. 前提パッケージ

Neovim は 0.11 以上（開発環境は 0.12.4）。

**Arch Linux**

```sh
sudo pacman -S neovim git curl unzip gcc make ripgrep fd lazygit
```

**Debian / Ubuntu**

```sh
sudo apt install git curl unzip build-essential ripgrep fd-find
# neovim は apt 版が古いことが多いので公式リリースを使う
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
# lazygit は https://github.com/jesseduffield/lazygit/releases から
# Debian 系では fd コマンドが fdfind なので別名を張っておく
mkdir -p ~/.local/bin && ln -sf "$(command -v fdfind)" ~/.local/bin/fd
```

### 2. Node.js

TypeScript の LSP（vtsls）と一部の mason パッケージに必要。

```sh
# volta を使う場合（開発環境と同じ方式）
curl https://get.volta.sh | bash
volta install node
# もしくはディストリのパッケージで:  sudo pacman -S nodejs npm
```

### 3. Nerd Font

アイコンが豆腐（□）にならないよう、ターミナルのフォントに [Nerd Font](https://www.nerdfonts.com/) を設定する。
例: `sudo pacman -S ttf-jetbrains-mono-nerd` → ターミナル側で JetBrainsMono Nerd Font を選択。

### 4. clone して起動

```sh
git clone git@github.com:cct-gaku-koma/nvim.git ~/.config/nvim
nvim
```

初回起動時に `lua/config/lazy.lua` が lazy.nvim を自動で取得し、`lazy-lock.json` に記録されたコミットのプラグインをインストールする。
続いて mason が LSP / フォーマッタを導入するので、完了まで待つ。

### 5. 確認

| コマンド | 見るもの |
| --- | --- |
| `:Lazy` | プラグインがすべて入っているか |
| `:Mason` | LSP・フォーマッタが入っているか |
| `:checkhealth` | 外部依存の不足がないか |

## 構成

```
init.lua              -- config.lazy を読むだけ
lazy-lock.json        -- プラグインのバージョン固定（★コミット必須）
lazyvim.json          -- 有効な LazyVim extras（★コミット必須）
lua/config/
  lazy.lua            -- lazy.nvim のブートストラップと設定
  options.lua         -- 追加オプション
  keymaps.lua         -- 追加キーマップ
  autocmds.lua        -- 追加 autocmd
lua/plugins/          -- プラグインの追加・上書き
```

有効にしている LazyVim extras:

- `lang.clangd` (C/C++)
- `lang.json`
- `lang.markdown`
- `lang.typescript`

extras の増減は `nvim` 内で `:LazyExtras` から行う。変更すると `lazyvim.json` が書き換わるのでコミットすること。

## 複数PC間での同期

**設定を変えた側:**

```sh
cd ~/.config/nvim
git add -A && git commit -m "..." && git push
```

**プラグインを更新した場合**（`:Lazy update` 後）は `lazy-lock.json` に差分が出るので、それも一緒にコミットして push。

**もう一方のPC:**

```sh
cd ~/.config/nvim && git pull
nvim
```

起動後に `:Lazy restore` を実行すると、`lazy-lock.json` に記録されたバージョンへプラグインを揃えられる。

## 注意

`~/.local/share/nvim`、`~/.local/state/nvim`、`~/.cache/nvim` はマシンごとの生成物なので、**別PCにコピーしない**。clone 後の初回起動で自動的に作り直される。
