
# ~/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#

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

    cg='cd ~/d/g/gh'

    cs='cd ~/d/g/gh/scripts'

    cl='~/d/g/gh/scripts/countLines.sh'

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

    k='cd ~/d/g/gh/k12tabor'

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

    i='sp -S --needed'

    u='sp -Syu'

    pa='paru'

    pi='pa -S'

    pu='pa -Syu'

    y='yay'

    ys='y -S'

    yu='y -Syu'

    stc='nv ~/.local/src/st/config.h'

    str='cd ~/.local/src/st'

    o='cd ~/d/g/gh/obsidian-notes'

    v='cd ~/v'

    p='cd public'

    np='nv page.tsx'

    n='npm run dev'

    t='tee dev.log'

    dl='nv dev.log'

    nt='n | t'

    bu='npm run build'

    bt='bu | t'

    doc='cd ~/d'

    scr='cd ~/d/screenshots'

    f='feh'

    ff='f --draw-filename'

    pict='cd ~/p'

    lo='xtrlock'

    lh='i3lock -c 000000'

    si='~/d/g/gh/scripts/saveImgsFromInternetInOrder.sh'

    zb='~/d/g/gh/scripts/automatic_bashrc_aliases_changes_based_on_zshrc_aliases_changes.sh'

    bb='cp ~/d/g/gh/scripts/.bashrc ~/.bashrc'

    rbzb='rm -rf ~/.bashrc; bb; zb'

    zbg='rm -rf ~/d/g/gh/scripts/.zshrc; rm -rf ~/d/g/gh/scripts/.bashrc; cp ~/.zshrc ~/d/g/gh/scripts/.zshrc; cp ~/.bashrc ~/d/g/gh/scripts/.bashrc'

    gzb='rm -rf ~/.zshrc; rm -rf ~/.bashrc; cp ~/d/g/gh/scripts/.zshrc ~/.zshrc; bb'

    szb='so ~/.zshrc; rbzb; so ~/.bashrc; zsh'

    br='brave'

    aus='yt-dlp -x --audio-format mp3'

    au='mplayer'

    m='cd ~/m'

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

    gl='cd ~/d/g/gl'

    dif='~/d/g/gh/scripts/different_rc_generating_based_on_files_structure.sh'

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

    fi='firefox'

    dw='cd ~/do'

    tm='cs; vim test_for_wallpaper_math_pseudorandom_determination.sh'

    tx='~/d/g/gh/scripts/test_for_wallpaper_math_pseudorandom_determination.sh'

    py='python'

    ha='cs; py halving.py'

    nh='cs; nv halving.py'

    shc='shotcut'

    gi='gimp'
EOF 
# Aliases over .zshrc and .bashrc being automatically the same end
