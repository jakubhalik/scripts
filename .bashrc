
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

    aus='yt-dlp -x --audio-format mp3'

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
    
    isa='sudo iptables-save | sudo tee /etc/iptables/iptables.rules'    

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
EOF 
# Aliases over .zshrc and .bashrc being automatically the same end
