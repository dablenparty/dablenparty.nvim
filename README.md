# dablenparty.nvim

## Installation

### Install Neovim

I recommend installing from [Homebrew](https://brew.sh/), it usually has the most recent [stable](https://github.com/neovim/neovim/releases/tag/stable) version.
There is also the [nightly](https://github.com/neovim/neovim/releases/tag/nightly) version.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/)
- NodeJS and NPM
  - Needed for most language servers
  - Use a version manager like [fnm](https://github.com/Schniz/fnm)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

#### Windows Installation

<details><summary>Windows with gcc/make using chocolatey</summary>
One can install gcc and make which won't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

