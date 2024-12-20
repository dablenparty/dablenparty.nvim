# dablenparty.nvim

## Installation

### Install Neovim

I recommend installing from [Homebrew](https://brew.sh/), it usually has the most recent [stable](https://github.com/neovim/neovim/releases/tag/stable) version.
There is also the [nightly](https://github.com/neovim/neovim/releases/tag/nightly) version.

### Install External Dependencies

External Requirements:
- Package manager
  - macOS/Linux: [Homebrew](https://brew.sh/)
  - Windows: `winget` and Chocolatey ([see below](#windows-installation))
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
  - needed to sync clipboard with neovim
- A [Nerd Font](https://www.nerdfonts.com/) (I currently use [JetBrains Mono](https://www.programmingfonts.org/#jetbrainsmono))
- NodeJS and NPM (use a version manager like [fnm](https://github.com/Schniz/fnm))
  - Although very few of them actually specify this, NPM is needed to install most language servers

### Windows Installation

#### Windows with gcc/make using chocolatey

Choosing to use `gcc` and `make` *won't require changing the config* to work on Windows.
The easiest way is to use `choco`:

1. install [chocolatey](https://chocolatey.org/install); either follow the instructions on the page or use `winget` as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using `choco`, exit previous terminal and open a new one so that `choco` path is set, and run the following as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```

#### WSL (Windows Subsystem for Linux)

First, install WSL2 in an **admin** PowerShell

```powershell
wsl --install
wsl
```

Then, in WSL, install everything

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

