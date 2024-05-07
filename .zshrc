# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# export ZDOTDIR="$HOME/.config/zsh"
# export PATH=$HOME/.local/bin:$PATH
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="alanpeabody"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

bindkey -v

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
#
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Aliases over .zshrc and .bashrc being automatically the same start
while read -r alias_definition; do 
    eval "alias $alias_definition"
done << EOF

    pv=$(grep 'pv' .env.local | cut -d '=' -f 2)

    b='linux-terminal-battery-status'

    clo='tty-clock'

    cf='xsel --clipboard <'

    ci='xsel --clipboard --input'

    h='cd ~'

    cg='cd ~/Documents/git/github'

    cs='cd ~/Documents/git/github/scripts'

    cl='~/Documents/git/github/scripts/countLines.sh'

    se='setxkbmap'

    us='se us'

    cz='se cz'

    s='cd src'

    a='cd app'

    c='cd components'

    sa='cd src/app'

    sac='cd src/app/components'

    sc='cd src/components'

    scu='cd src/components/ui'

    k='cd ~/Documents/git/github/k12tabor'

    al='alsamixer'

    nv='nvim'

    z='nv ~/.zshrc'

    vz='vim ~/.zshrc'

    ba='nv ~/.bashrc'

    vb='vim ~/.bashrc'

    so='source'

    sz='so ~/.zshrc'

    sb='so ~/.bashrc'

    sp='sudo pacman'

    i='sp -S'

    u='sp -Syu'

    pa='paru'

    pi='pa -S'

    pu='pa -Syu'

    y='yay'

    ys='y -S'

    yu='y -Syu'

    stc='nv ~/.local/src/st/config.h'

    str='cd ~/.local/src/st'

    o='cd ~/Documents/git/github/obsidian-notes'

    v='cd ~/Videos'

    p='cd public'

    np='nv page.tsx'

    n='npm run dev'

    t='tee dev.log'

    dl='nv dev.log'

    nt='n | t'

    bu='npm run build'

    bt='bu | t'

    doc='cd ~/Documents'

    scr='cd ~/Documents/screenshots'

    f='feh'

    pict='cd ~/Pictures'

    lo='xtrlock'

    lh='i3lock -c 000000'

    si='~/Documents/git/github/scripts/saveImgsFromInternetInOrder.sh'

    zb='~/Documents/git/github/scripts/automatic_bashrc_aliases_changes_based_on_zshrc_aliases_changes.sh'

    bb='cp ~/Documents/git/github/scripts/.bashrc ~/.bashrc'

    rbzb='rm -rf ~/.bashrc; bb; zb'

    zbg='rm -rf ~/Documents/git/github/scripts/.zshrc; rm -rf ~/Documents/git/github/scripts/.bashrc; cp ~/.zshrc ~/Documents/git/github/scripts/.zshrc; cp ~/.bashrc ~/Documents/git/github/scripts/.bashrc'

    gzb='rm -rf ~/.zshrc; rm -rf ~/.bashrc; cp ~/Documents/git/github/scripts/.zshrc ~/.zshrc; bb'

    szb='so ~/.zshrc; rbzb; so ~/.bashrc; zsh'

    br='brave'

    aus='yt-dlp -x --audio-format mp3'

    au='mplayer'

    m='cd ~/Music'

    ash='m; au -shuffle *.mp3'

    ass='m; au -af scaletempo -speed 1.5 -shuffle *.mp3'

    vs='yt-dlp bestvideo+bestaudio'

    hi='history'

    x='vim .xinitrc'

    sx='so ~/.xinitrc'

    hb='du -h'

    cfz='cf ~/.zshrc'    

    sy='sudo systemctl'

    die='sy poweroff' 

    re='sy reboot'

    wi='nmcli dev wifi'

    we='wi connect'

    gl='cd ~/Documents/git/gitlab'

    dif='~/Documents/git/github/scripts/different_rc_generating_based_on_files_structure.sh'

    ac='m; au code.mp3'

    te='cd ~/temp; ls'

    mte='mkdir ~/temp'

    di='dict'

    le='less'

    cgr='hunspell -d cs_CZ'

    cr='clear'

    di='dict'

    lc='locate'

    cy='cd ~/yay'

    mp='makepkg -si'    

    mc='sudo make clean install'

    asm='amixer set Master'
    
    e='eval "\$(ssh-agent -s)"'

    soa='ssh-add ~/.ssh/github_ed25519'

    sst='ssh -T git@github.com'

    ma='bc'

    ot='o; nv tech.md'

    oe='o; nv everything.md'
EOF 
# Aliases over .zshrc and .bashrc being automatically the same end
#
