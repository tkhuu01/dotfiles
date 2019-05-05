alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias vi='vim'

#========================
# Aliases with parameters
#========================
##################################################
# Specific type and file to find
#
# args:
#   $1 - the type of file to find
#   $2 - file name
#
cfind() {
    find . -type "$1" -name "$2"
}

##################################################
#  Generates ctag file and will place the file in
#  ~/vim-tags/ if the directory already exists
#  or if it doesn't exist the directory will be
#  created. Also will append the tag at the end
#  of the vimrc file.
#
# args:
#   $1 - name of tag file
#   $2 - the relative path of the directory
#
genCTags() {
    if type ctags > /dev/null; then
        ctags -f "$1" -R "$2"
        if [ ! -d ~/vim-tags/ ]; then
            mkdir ~/vim-tags/
        fi
        mv "$1" ~/vim-tags/
        echo "set tags+=~/vim-tags/$1" >> ~/.vimrc
    else
        echo "ctags doesn't exist"
    fi
}

##################################################
# Normal file finding
#
# args:
#   $1 - file name
#
nfind() {
    find . -type f -name "$1"
}
