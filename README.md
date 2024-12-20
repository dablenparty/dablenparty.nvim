# dablenparty.nvim

## Installation

### Install Neovim

I recommend installing from [Homebrew](https://brew.sh/), it usually has the most recent [stable](https://github.com/neovim/neovim/releases/tag/stable) version.
There is also the [nightly](https://github.com/neovim/neovim/releases/tag/nightly) version.

### Install External Dependencies

> **IMPORTANT!!**
> Before you install anything, make sure you have a [Nerd Font](https://www.nerdfonts.com/). At the time of writing, I use [JetBrains Mono](https://www.programmingfonts.org/#jetbrainsmono).

#### Package Managers
- macOS/Linux: [Homebrew](https://brew.sh/)
- Windows: `winget` and Chocolatey ([see below](#native-windows-installation))

#### Command Line Utilities

- Basic utils: `git`, `unzip`
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
  - Used to sync clipboard with neovim
- CMake (`make`)
- [`fd`](https://github.com/sharkdp/fd)
  - Install with **Homebrew**
- `gcc`
  - Any C compiler will *technically* work, but most of my work is done on macOS and Linux, so it's easier for me to just [install `gcc` on Windows](#native-windows-installation).
- NodeJS, NPM, and Yarn (use a version manager like [fnm](https://github.com/Schniz/fnm))
  -  `npm i -g yarn`
  - Although very few of them actually specify this, NPM is needed to install most language servers.
- [`ripgrep`](https://github.com/BurntSushi/ripgrep#installation)
  - Install with **Homebrew**
- [`rustup`](https://rustup.rs/) with nightly toolchain
  - `rustup toolchain install nightly`
  - For building [`blink.cmp`](lua/custom/plugins/blink.lua) from source


### Native Windows Installation

#### Windows with gcc/make using chocolatey

Choosing to use `gcc` and `make` *won't require changing the config* to work on Windows.
The easiest way is to use `choco`:

1. install [chocolatey](https://chocolatey.org/install); either follow the instructions on the page or use `winget` as **admin**:
```powershell
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using `choco`, exit previous terminal and open a new one so that `choco` path is set, and run the following as **admin**:
```powershell
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
