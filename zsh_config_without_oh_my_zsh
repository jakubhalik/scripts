bindkey -v

#source ~/d/g/gh/scripts/generateAliases.sh
#source ~/d/g/gh/scripts/generateAliases.zsh

export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"

export HISTSIZE=99999
export SAVEHIST=99999
export HISTFILE=~/.zsh_history

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export EDITOR=nvim

bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

#if [ -f "$HOME/.cache/wal/colors.sh" ]; then
#    source "$HOME/.cache/wal/colors.sh"
#fi

PROMPT='[%F{#22c55e}%n@%F{#38bdf8}%m %F{#14b8a6}%~%F{none}] '

#fee2e2
#fecaca
#fca5a5
#f87171
#ef4444
#ffedd5
#fed7aa
#fdba74
#fb923c
#f97316
#ea580c
#fef3c7
#fde68a
#fcd34d
#fbbf24
#f59e0b
#d97706
#fef9c3
#fef08a
#fde047
#facc15
#eab308
#ecfccb
#d9f99d
#bef264
#a3e635
#84cc16
#65a30d
#4d7c0f
#3f6212
#365314
#1a2e05
#dcfce7
#bbf7d0
#86efac
#4ade80
#22c55e
#16a34a
#15803d
#166534
#14532d
#052e16
#d1fae5
#a7f3d0
#6ee7b7
#34d399
#10b981
#059669
#047857
#065f46
#064e3b
#022c22
#ccfbf1
#99f6e4
#5eead4
#2dd4bf
#14b8a6
#0d9488
#0f766e
#115e59
#134e4a
#042f2e
#cffafe
#a5f3fc
#67e8f9
#22d3ee
#06b6d4
#0891b2
#0e7490
#bae6fd
#7dd3fc
#38bdf8
#0ea5e9
#0284c7
#0369a1
#93c5fd
#60a5fa
#3b82f6
#2563eb
#1d4ed8
#1e40af
#a5b4fc
#818cf8
#6366f1
#4f46e5
#4338ca
#3730a3
#c4b5fd
#a78bfa
#8b5cf6
#7c3aed
#6d28d9
#5b21b6
#4c1d95
#2e1065
#d8b4fe
#c084fc
#a855f7
#9333ea
#7e22ce
#6b21a8
#581c87
#3b0764
#f0abfc
#e879f9
#d946ef
#c026d3
#a21caf
#86198f
#701a75
#4a044e
#fbcfe8
#f9a8d4
#f472b6
#ec4899
#db2777
#be185d
#9d174d
#831843
#500724
#fecdd3
#fda4af
#fb7185
#f43f5e
#e11d48
#be123c
#9f1239
#881337
#4c0519

setopt append_history        # Append history to the file (not overwrite it)
setopt share_history         # Share history across terminals
setopt inc_append_history    # Immediately append to the history file, not just when the session ends

autoload -Uz compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' menu select=2
eval "$(zsh-autosuggest-start)"

# Aliases over .zshrc and .bashrc being automatically the same start
while read -r alias_definition; do 
    eval "alias $alias_definition"
done << EOF

    pv=$(grep 'pv' .env.local | cut -d '=' -f 2)

    b='linux-terminal-battery-status'

    clo='tty-clock'

    cf='sudo xsel --clipboard <'

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

    bd='bun run dev'

    bdt='bd | t'

    bb='bun run build'

    bbt='bb | t'

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

    zbg='rm ~/d/g/gh/scripts/.zshrc ~/d/g/gh/scripts/.bashrc ~/d/g/gh/scripts/zsh_config_without_oh_my_zsh; cp ~/.zshrc ~/d/g/gh/scripts/.zshrc; cp ~/.zshrc ~/d/g/gh/scripts/zsh_config_without_oh_my_zsh; cp ~/.bashrc ~/d/g/gh/scripts/.bashrc'

    gzb='rm -rf ~/.zshrc; rm -rf ~/.bashrc; cp ~/d/g/gh/scripts/.zshrc ~/.zshrc; bb'

    szb='so ~/.zshrc; rbzb; so ~/.bashrc; zsh'

    br='brave'

    aus='sudo yt-dlp -x --audio-format mp3'

    au='mplayer'

    m='cd ~/m'

    ash='m; au -shuffle *.mp3'

    ass='m; au -af scaletempo -speed 1.5 -shuffle *.mp3'

    vs='sudo yt-dlp bestvideo+bestaudio'

    hi='cat ~/.zsh_history'

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

    sog='ssh-add ~/.ssh/gitlab_ed25519'

    sst='ssh -T git@github.com'

    ma='bc'

    ot='o; nv tech.md'

    vt='o; vim tech.md'

    ot2='o; nv tech2.md'

    vt2='o; vim tech2.md'
    
    ot3='o; nv tech3.md'

    vt3='o; vim tech3.md'

    oe='o; nv everything.md'

    fi='firefox -no-remote -ProfileManager'

    dw='cd ~/do'

    tm='cs; vim test_for_wallpaper_math_pseudorandom_determination.sh'

    tx='~/d/g/gh/scripts/test_for_wallpaper_math_pseudorandom_determination.sh'

    py='python'

    ha='cs; py halving.py'

    nh='cs; nv halving.py'

    shc='shotcut'

    gi='gimp'

    ne='neofetch'

    do='cd ~/d'

    pdf='zathura'    

    li='libreoffice'

    ex='cd ~/excalidraw'

    dk='docker-compose up --build -d'

    to='tor-browser'

    ic='~/d/g/gh/scripts/install_all_vids_from_a_youtube_channel.sh'

    vl='cd ~/v/l'

    va='cs; vim arch_install_manual'

    na='cs; nv arch_install_manual'

    sl='systemctl suspend; lo'

    bs='acpi'

    lsd='lsblk'

    ft='feh -g 640x480 --auto-zoom --thumbnails'

    sxt='sxiv -t'

    mo='mogrify -resize 800x800 -path'

    nf='feh --zoom 20 --draw-filename'

    wip='curl ipinfo.io/ip'    

    gr='docker exec -it gitlab-server gitlab-rails console'

    ng='nginx'

    rn='sy reload ng'

    rsn='sy restart ng'

    rs='sy start ng'

    rst='sy stop ng'

    rn2='sudo nginx -s reload'

    en='sy enable ng'

    ngt='sudo nginx -t'

    nsta='sy status ng'

    dr='docker' 

    drn='sy reload dr'

    drst='sy stop dr'

    drs='sy start dr'

    drsn='sy restart dr'

    dren='sy enable dr'

    drd='dr compose down'

    dru='dr compose up'

    drsta='sy status dr'

    sn='sy restart systemd-networkd'

    ipt='iptables' 

    ir='sy reload ipt' 

    ie='sy enable ipt'

    ist='sy stop ipt'

    is='sy start ipt'

    ire='sy restart ipt'

    ista='sy status ipt'

    il='sudo ipt -L --line-numbers'

    i0='sudo ipt -P INPUT DROP'

    i01='sudo ipt -P FORWARD DROP'

    i02='sudo ipt -P OUTPUT ACCEPT'

    i1='sudo ipt -I INPUT 1 -i lo -j ACCEPT'

    i2='sudo ipt -I OUTPUT 1 -o lo -j ACCEPT'

    i3='sudo ipt -A INPUT -p udp --sport 53 -j ACCEPT'

    i4='sudo ipt -A OUTPUT -p udp --dport 53 -j ACCEPT'

    i5='sudo ipt -A INPUT -i lo -j ACCEPT'

    i6='sudo ipt -A OUTPUT -o lo -j ACCEPT'

    i7='sudo ipt -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT'

    i8='sudo ipt -A INPUT -p tcp --dport 80 -j ACCEPT'

    i9='sudo ipt -A INPUT -p tcp --dport 443 -j ACCEPT'

    i10='sudo ipt -A INPUT -p tcp --dport 22 -j ACCEPT'

    i11='sudo ipt -A INPUT -m conntrack --ctstate INVALID -j DROP'

    i12='sudo ipt -I INPUT -p tcp --dport 8080 -j ACCEPT'

    i13='sudo ipt -I INPUT -p tcp --dport 8443 -j ACCEPT' 

    i14='sudo ipt -I INPUT -p tcp --dport 822 -j ACCEPT'
    
    ste='sudo tee'

    isa='sudo iptables-save | ste /etc/iptables/iptables.rules'    

    isa2='sudo iptables-save > /etc/iptables/rules.v4'

    ill='sudo ipt -L'

    iln='ill -n'

    il2='sudo ipt -L -v'

    il3='sudo ipt -t nat -L -v'

    il4='sudo ipt -L -n -v | grep 443'

    il5='sudo ipt -I INPUT 1 -j LOG --log-prefix "IPTables-Dropped: "'
    
    il6='dmesg | grep IPTables-Dropped'

    il7='sudo tail -f /var/log/kern.log | grep IPTables-Dropped'

    i6l='sudo ip6tables -L'

    nl0=' sudo tail -f /var/log/nginx/access.log'

    nl1=' sudo tail -f /var/log/nginx/error.log'

    it=' nmap -Pn 86.49.243.46 -p 80,443,8080'

    ot4='nv ~/d/g/gh/obsidian-notes/tech4.md'

    vt4='vim ~/d/g/gh/obsidian-notes/tech4.md'

    ot5='nv ~/d/g/gh/obsidian-notes/tech5.md'

    vt5='vim ~/d/g/gh/obsidian-notes/tech5.md'

    czt='sudo timedatectl set-timezone 'Europe/Prague''

    fl='cd ~/filebrowser'

    fr='fl; ./run_filebrowser.sh'

    ra='openssl rand -base64 16'

    csz='chsh -s /usr/bin/zsh'

    csd='chsh -s /usr/bin/dash'

    ca='calcurse'

    ot6='nv ~/d/g/gh/obsidian-notes/tech6.md'

    vt6='vim ~/d/g/gh/obsidian-notes/tech6.md'

    ot7='nv ~/d/g/gh/obsidian-notes/tech7.md'

    vt7='vim ~/d/g/gh/obsidian-notes/tech7.md'

    m0='cd ~/monitoring'

    m1='htop | ste monitoring1.log'

    m2='top | ste monitoring2.log'

    m3='iostat -x 1 | ste monitoring3.log'

    m4='vmstat 1 | ste monitoring4.log'

    m5='sar -u 1 | ste monitoring5.log'

    m6='netstat -tuln | ste monitoring6.log'

    m7='sudo iftop | ste monitoring7.log'

    m8='sudo nload | ste monitoring8.log'

    m9='free -h | ste monitoring9.log'

    m10='vmstat 1 5 | ste monitoring10.log'

    m11='ps aux --sort=-%mem | head -n 10 | ste monitoring11.log'

    wd='ne | grep Host'

    bit='uname -m'

    tw='echo "Real World Onion Sites, Dark.Fail, Ahmia.fi, Torch, Not Evil, Haystak, Onion Links, and The Hidden Wiki"'

    wb='curl wttr.in/Brno'

    ce='crontab -e'

    crl='crontab -l'

    km='~/d/g/gh/scripts/kill_music.sh'

    ti='~/d/g/gh/scripts/timer.sh'

    td='~/d/g/gh/scripts/timer_dynamic.sh'

    ct='cd ~/d/g/gh/text_kuba'

    sd='/home/x/d/g/gh/scripts/save_dwm_layout.sh'

    rx='/home/x/d/g/gh/scripts/restart_xorg.sh'

    rl='home/x/d/g/gh/scripts/restore_dwm_layout.sh'
EOF 
# Aliases over .zshrc and .bashrc being automatically the same end

export GITLAB_HOME=/srv/gitlab

