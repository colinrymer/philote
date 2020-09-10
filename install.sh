#!/bin/bash
set -u

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install ansible

cd $TMPDIR

curl https://github.com/colinrymer/philote/archive/master.zip -o philote.zip
unzip philote.zip
rm philote.zip

ansible-playbook -i philote/localhost philote/localhost.yml
