# set to fasttmp or lore depending on where your primary dev directories are located
DEVLOC=fasttmp
# preferences
export EDITOR=emacs

USER=`whoami`
if [ ! -f /etc/redhat-release ] ; then
  echo "ERROR: This .bashrc file is intended for use on the SCOREC RHEL7 systems!"
  exit
fi

export DEVROOT=/${DEVLOC}/${USER}/dev
if [ ! -d ${DEVROOT} ] ; then
  mkdir ${DEVROOT}
fi
export PATH=/usr/share/lmod/lmod/libexec:${PATH}
unset MODULEPATH
module use /opt/scorec/spack/lmod/linux-rhel7-x86_64/Core/
module use /opt/scorec/modules/
module load tmux
module load emacs
module load vim
module load git
module load cmake
module load gcc
module load mpich
module load petsc/3.9.3-int32-hdf5+ftn-real-c-meo4jde
module load totalview

if [ -f ${GIT_ROOT}/share/git-prompt.sh ] ; then
  source $GIT_ROOT/share/git-prompt.sh
fi

export VISUAL=${EDITOR}
export GIT_EDITOR=${EDITOR}

# configure emacs if that is the preferred editor
if [[ "${EDITOR}" == "emacs" ]] ; then
  if [ ! -d ${HOME}/.emacs.d ] ; then
    mkdir .emacs.d
  fi
  # grab the cmake mode file for emacs if it doesn't currently exist
  #  the .emacs file assumes this file is available
  if [ ! -f $HOME/.emacs.d/cmake-mode.el ] ; then
    wget https://raw.githubusercontent.com/Kitware/CMake/master/Auxiliary/cmake-mode.el ~/.emacs.d/
  fi
fi

if [ -f ${HOME}/.aliases ] ; then
  source .aliases
fi

if [ -f ${HOME}/.ps1 ] ; then
  source .ps1
fi
