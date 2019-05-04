case "$1" in
   'install')
      apt update
      apt install git curl zsh vim -y
      chsh -s $(which zsh)
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
      ;;
   'docker')
      apt-get update
      apt-get install \
          apt-transport-https \
          ca-certificates \
          curl \
          gnupg2 \
          software-properties-common -y
      curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
      add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
        $(lsb_release -cs) \
        stable" -y
      apt-get update
      apt-get install docker-ce -y
      ;;
   'config')
      sed  -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g'  ~/.zshrc
      mkdir -p ~/.vim/colors
      curl https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim > ~/.vim/colors/solarized.vim
      touch ~/.vimrc
      cat >> ~/.vimrc<<EOF
syntax enable
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized
EOF
      ;;
   'ssh')
      mkdir -p ~/.ssh
      touch ~/.ssh/authorized_keys
      curl https://gist.githubusercontent.com/muzea/dc3e5dad46741de9dfc36a9acb82ea08/raw/54626ac5a07de81d4e6968bc0684ee7cfc10b298/ali-hz >> ~/.ssh/authorized_keys
      ;;
   *)
     echo ':D'
     ;;
esac
