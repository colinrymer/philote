#!/bin/bash
set -u

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

if test -f /opt/homebrew/bin/brew; then 
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew install ansible

cd $TMPDIR

curl -fsSL https://github.com/colinrymer/philote/archive/master.zip -o philote.zip
unzip philote.zip
rm philote.zip

ansible-playbook -i philote-master/localhost philote-master/localhost.yml
