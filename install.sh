  #!/bin/bash
set -eux

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

if test -f /opt/homebrew/bin/brew; then 
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew list | grep ansible

if [ -z $(brew list | grep ansible) ]; then
  brew install ansible
fi

cd $TMPDIR

if test -f philote.zip; then
  rm -f philote.zip
fi

if test -d philote-master; then
  rm -rf philote-master
fi

curl -fsSL https://github.com/colinrymer/philote/archive/master.zip -o philote.zip
unzip philote.zip
rm philote.zip

ansible-playbook -i philote-master/localhost philote-master/localhost.yml
