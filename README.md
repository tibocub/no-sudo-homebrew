# No sudo Homebrew

> Setup brew on linux without sudo privilege

---

## One-line installer
Automatically detect bash/zsh/fish configs
and add homebrew path to each.

Copy-paste in your terminal:
```shell
/bin/sh -c "$(curl -L https://raw.githubusercontent.com/tibocu
b/no-sudo-homebrew/refs/heads/main/install.sh)"
```

Installs in ~/.local/homebrew by default.

Can be change in install.sh by changing
`install_dir`.

## Uninstall
If you installed in the default path
```shell
/bin/sh -c "$(curl -L https://raw.githubusercontent.com/tibocu
b/no-sudo-homebrew/refs/heads/main/install.sh)"
```

otherwise
```shell
rm -rf ~./local/homebrew
```

and clean the eval command from your bashrc/zshrc/config.fish.
