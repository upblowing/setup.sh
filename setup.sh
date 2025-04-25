if [ "$EUID" -ne 0 ]
then
    echo "run as root"
    exit 1
fi

if [ -f /etc/debian_version ]; then
    pkg="apt"
    update="apt update"
    install="apt install -y"
elif [ -f /etc/redhat-release ]; then
    pkg="yum" 
    update="yum update -y"
    install="yum install -y"
elif [ -f /etc/arch-release ]; then
    pkg="pacman"
    update="pacman -Syu --noconfirm"
    install="pacman -S --noconfirm"
elif [ "$(uname)" == "Darwin" ]; then
    pkg="brew"
    update="brew update"
    install="brew install"
elif [ -f /etc/cubeos-release ]; then
    pkg="zypper"
    update="zypper refresh"
    install="zypper install -y"
else
    echo "unsupported distro"
    exit 1
fi

$update

case $pkg in
    "apt")
        $install build-essential git curl wget neofetch python3-pip nodejs npm htop vim tmux ffmpeg imagemagick unzip zip jq
        ;;
    "yum")
        $install gcc make git curl wget neofetch python3-pip nodejs npm htop vim tmux ffmpeg ImageMagick unzip zip jq
        ;;
    "pacman")
        $install base-devel git curl wget neofetch python-pip nodejs npm htop vim tmux ffmpeg imagemagick unzip zip jq
        ;;
    "brew")
        $install git curl wget neofetch python3 pip node npm htop vim tmux ffmpeg imagemagick unzip zip jq
        ;;
    "zypper")
        $install gcc make git curl wget neofetch python3-pip nodejs npm htop vim tmux ffmpeg ImageMagick unzip zip jq
        ;;
esac

clear
neofetch
echo ""
echo "     (\__/)"
echo "     (o.o )"
echo "     (> < ) Bunny says installation done ~.~"
echo ""
exit 0