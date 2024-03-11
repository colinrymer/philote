#!/bin/bash
set -eux

# Try to add homebrew to PATH on apple silicon
eval "$(/opt/homebrew/bin/brew shellenv)"

if ! command -v brew &> /dev/null ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if test -f /opt/homebrew/bin/brew; then 
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -z $(brew list | grep ansible) ]; then
  brew install ansible
fi

clean_up() {
  test -d "$tmp_dir" && rm -rf "$tmp_dir"
}

tmp_dir=$(mktemp -d -t philote)
trap "clean_up ${tmp_dir}" EXIT
echo "Using directory: ${tmp_dir}"

cd $tmp_dir

curl -fsSL https://github.com/colinrymer/philote/archive/master.zip -o philote.zip
unzip philote.zip
rm philote.zip

ansible-playbook -i philote-master/localhost philote-master/localhost.yml
