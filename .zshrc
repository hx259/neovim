# !!! 
# REMEMBER: $HOME/... means in dir /home/hx259/...
# !!!

# ---------------------
# ZSH Setups
# ---------------------
export ZSH="/home/hx259/.oh-my-zsh"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="random"
ZSH_THEME_RANDOM_CANDIDATES=( "agnoster")
plugins=(git)
source $ZSH/oh-my-zsh.sh
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# ENABLE_CORRECTION="true"


# ---------------------
# TILIX
# ---------------------
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# ---------------------
# SYSTEM DEFAULTS
# ---------------------
export EDITOR=nvim 
export VISUAL=nvim

# ---------------------
# ALIAS
# ---------------------
alias vi=nvim # to use the "real" vi: type "\vi"
alias pdf=evince # or zathura?
alias cmakedebug='cmake -DCMAKE_BUILD_TYPE=Debug'
alias dunewatch='dune build --watch --terminal-persistence=clear-on-rebuild'
alias bearmake='bear -- make allobj -j14 && bear -- make lib && bear -- make all -j14'
eval $(thefuck --alias dafaq)

# ---------------------
# COMPILATION Settings
# ---------------------
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export USE_OPENMP=YES
export OMP_NUM_THREADS=16

# ---------------------
# PYTHON PATHS
# ---------------------
export PYTHONPATH=$HOME/coding/pyscf:$PYTHONPATH
export PYTHONPATH=$HOME/coding/wicked:$PYTHONPATH
export PYTHONPATH=$HOME/coding/kofo/orca_helpers:$PYTHONPATH

# ---------------------
# MIN (Necessary!) PATHS
# ---------------------
export PATH_MIN=\
/bin:\
/sbin:\
/snap/bin:\
/usr/bin:\
/usr/sbin:\
/usr/local/bin:\
/usr/local/sbin:\
/opt/nvim-linux64/bin:\
$HOME/bin:\
$HOME/.local/bin

# ---------------------
# DEFAULT PATHS
# ---------------------
export PATH_DEFAULT=\
$HOME/coding/dalton/build:\
$HOME/.opam/default/bin:\
$HOME/.cargo/bin:\
$HOME/coding/openmpi-4.1.6/bin:\
$HOME/coding/cfour_v1/bin
#
export LD_LIB_DEFAULT=\
$HOME/coding/openmpi-4.1.6/lib:\
$HOME/intel/oneapi/mkl/latest/lib/intel64

# ---------------------
# PATHS: Orca Dev
# ---------------------
export PATH_Dev=\
$HOME/coding/kofo/OrcaDev/x86_exe:\
$HOME/coding/kofo/OrcaDev/ORCA_AGE/x86_exe:\
$HOME/coding/kofo/OrcaDev/ORCA_AGE/build
# $HOME/coding/kofo/OrcaDev/orca_tools:\
#
export LD_LIB_Dev=\
$HOME/coding/kofo/OrcaDev/orca_tools:\
$HOME/coding/kofo/OrcaDev/orca_tools/Tool-Libint/libint-2.0.2-stable/lib

# ---------------------
# PATHS: Orca Clean
# ---------------------
export PATH_Clean=\
$HOME/coding/kofo/OrcaClean/x86_exe:\
$HOME/coding/kofo/OrcaClean/ORCA_AGE/x86_exe:\
$HOME/coding/kofo/OrcaClean/ORCA_AGE/build
#
export LD_LIB_Clean=\
$HOME/coding/kofo/OrcaClean/orca_tools:\
$HOME/coding/kofo/OrcaClean/orca_tools/Tool-Libint/libint-2.0.2-stable/lib

# ---------------------
# PATHS: Orca Optimised
# ---------------------
export PATH_Opt=\
$HOME/coding/kofo/OrcaOptimised/orca_6_0_1_linux_x86-64_shared_openmpi416

# ---------------------
# Set Paths Function
# ---------------------
export PATH=${PATH_DEFAULT}:${PATH_MIN}
export LD_LIBRARY_PATH=${PATH_LIB_DEFAULT}
setpath() {
  case $1 in 
    dev)
      export PATH=${PATH_Dev}:${PATH_DEFAULT}:${PATH_MIN}
      export LD_LIBRARY_PATH=${LD_LIB_Dev}:${PATH_LIB_DEFAULT}
      echo "Switched to PATH: OrcaDev"
      ;;
    clean)
      export PATH=${PATH_Clean}:${PATH_DEFAULT}:${PATH_MIN}
      export LD_LIBRARY_PATH=${LD_LIB_Clean}:${PATH_LIB_DEFAULT}
      echo "Switched to PATH: OrcaClean"
      ;;
    opt6)
      export PATH=${PATH_Opt}:${PATH_DEFAULT}:${PATH_MIN}
      export LD_LIBRARY_PATH=${PATH_LIB_DEFAULT}
      echo "Switched to PATH: OrcaOptimised 6.0.1"
      ;;
    default)
      export PATH=${PATH_DEFAULT}:${PATH_MIN}
      export LD_LIBRARY_PATH=${PATH_LIB_DEFAULT}
      echo "Switched to PATH: DEFAULT"
      ;;
    min)
      export PATH=${PATH_MIN}
      export LD_LIBRARY_PATH=" "
      echo "Switched to PATH: MINIMAL"
      ;;
    *)
      echo "Usage: setpath [dev|clean|opt6|default|min]"
      ;;
  esac
}

# ---------------------
# PSI-4
# ---------------------
psi4conda(){
  . $HOME/coding/psi4conda/etc/profile.d/conda.sh
}
