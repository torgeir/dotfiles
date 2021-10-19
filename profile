case $(uname) in
  Linux)
    # needs to be in .profile to load the theme correctly on manjaro
    export QT_QPA_PLATFORMTHEME="qt5ct"
    export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

    export BROWSER=/usr/bin/firefox

    # Shader caching is a strategy to reduce stuttering and improve overall performance by ‘prebaking’ some of the work your GPU has to do before it has to do so in-game.
    __GL_THREADED_OPTIMIZATION=1 #for OpenGL games
    __GL_SHADER_DISK_CACHE=1 #to create a shader cache for a game
    __GL_SHADER_DISK_CACHE_PATH=/home/torgeir/Games/shader-cache # to set the location for the shader cache.

    if [ -d "$HOME/.local/share/wine-6.14-staging-tkg-amd64/bin" ] ; then
      export PATH="$HOME/.local/share/wine-6.14-staging-tkg-amd64/bin:$PATH"
    fi
    export WINEFSYNC=1
    ;;
esac