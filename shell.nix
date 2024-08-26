let
  pkgs = import <nixpkgs> { config.cudaSupport = true; };
in 

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    poetry
    which
    gcc
    binutils
    stdenv.cc.cc

	libGLU libGL
	glib
    cudatoolkit
	ncurses5
	linuxPackages.nvidia_x11

    # # All the C libraries that a manylinux_1 wheel might depend on:
    # ncurses
    # xorg.libX11
    # xorg.libXext
    # xorg.libXrender
    # xorg.libICE
    # xorg.libSM
    # glib
  ];
  shellHook = ''
    poetry install
    export PATH=$PATH:/run/current-system/sw/bin
	# export LD_DEBUG=libs
  	# export LD_LIBRARY_PATH=${pkgs.libGL}/lib:${pkgs.libGLU}/lib:${pkgs.freeglut}/lib:${pkgs.xorg.libX11}/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.glib.out}/lib:$LD_LIBRARY_PATH
  	export LD_LIBRARY_PATH=${pkgs.libGL}/lib:${pkgs.libGLU}/lib:${pkgs.freeglut}/lib:${pkgs.xorg.libX11}/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.glib.out}/lib:${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib:$LD_LIBRARY_PATH
    export CUDA_PATH=${pkgs.cudatoolkit}
    export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
    export EXTRA_CCFLAGS="-I/usr/include"
  '';
}
