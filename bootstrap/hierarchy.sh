echo -e "\n[$] > Creating folders hierarchy..."
mkdir -p $HOME/downloads &&
mkdir -p $HOME/projects &&
mkdir -p $HOME/documents &&
mkdir -p $HOME/documents/notes &&
mkdir -p $HOME/documents/books &&
mkdir -p $HOME/documents/music &&
mkdir -p $HOME/documents/videos &&
mkdir -p $HOME/documents/pictures &&

mkdir -p $HOME/.config &&
mkdir -p $HOME/.local/share/fonts &&
mkdir -p $HOME/.local/share/icons &&
mkdir -p $HOME/.local/share/themes &&
mkdir -p $HOME/.mozilla/firefox/main.main/chrome &&
mkdir -p $HOME/.mozilla/firefox/main.main/assets &&
mkdir -p $HOME/.mozilla/firefox/main.main/extensions
echo -e "\n[$] > Hierarchy created successfully!"
