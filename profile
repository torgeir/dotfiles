[[ -f "$HOME/.profile.priv" ]] && source ~/.profile.priv

case $(uname) in
  Linux)
    # needs to be in .profile to load the theme correctly on manjaro
    unset QT_STYLE_OVERRIDE
    export QT_QPA_PLATFORMTHEME="qt5ct"
    #export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

    # sudo pacman -Syu arc-gtk-theme
    export GTK_THEME=Arc:dark

    export BROWSER=/usr/bin/brave

    # Shader caching is a strategy to reduce stuttering and improve overall performance by ‘prebaking’ some of the work your GPU has to do before it has to do so in-game.
    __GL_THREADED_OPTIMIZATION=1                                 # for OpenGL games
    __GL_SHADER_DISK_CACHE=1                                     # to create a shader cache for a game
    __GL_SHADER_DISK_CACHE_PATH=/home/torgeir/Games/shader-cache # to set the location for the shader cache.

    # https://wiki.archlinux.org/title/Vulkan#Switching_between_AMD_drivers
    # As of amdvlk 2021.Q3.4, a new switching logic was implemented which enforces AMDVLK as the default and mandates you either
    # set AMD_VULKAN_ICD=RADV to switch from the AMDVLK default,
    export AMD_VULKAN_ICD=RADV

    export WINEFSYNC=1

    # To enable compatibility with high-resolution displays, set the following environment variables accordingly:
    # https://wiki.archlinux.org/title/DaVinci_Resolve

    # Warning: QT_DEVICE_PIXEL_RATIO is deprecated. Instead use:
    #  QT_AUTO_SCREEN_SCALE_FACTOR to enable platform plugin controlled per-screen factors.
    #  QT_SCREEN_SCALE_FACTORS to set per-screen DPI.
    #  QT_SCALE_FACTOR to set the application global scale factor.
    #export QT_DEVICE_PIXEL_RATIO=1
    #export QT_AUTO_SCREEN_SCALE_FACTOR=true

    # Make ssh use the gpg-agent's ssh socket
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
      # export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
      export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi

    if [ "$(tty)" = "/dev/tty1" ]; then
      exec dbus-launch sway
    fi

    ;;
  Darwin)
    # Make ssh use gpg and emacs use 1password ssh socket
    export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    ;;
esac
