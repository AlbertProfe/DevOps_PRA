# instalar runlike con python

```
#!/bin/bash

# instalar runlike con python
mkdir -p ~/scripts
mkdir -p ~/scripts/runlike
cd ~/scripts/runlike

# si no esta instalado venv
sudo apt install python3.12-venv
python3 -m venv .venv
source .venv/bin/activate
pip install runlike
deactivate

IFS='' read -r -d '' SCRIPT <<'EOF'
#!/bin/bash

DIR=$(pwd)
cd ~/scripts/runlike
source .venv/bin/activate
runlike "$@"
deactivate
cd "${DIR}"
EOF

echo "${SCRIPT}" > ~/scripts/runlike.sh

# añadir el alias a ~/.bash_aliases
echo "" >> ~/.bash_aliases
echo "alias runlike='bash ~/scripts/runlike.sh'" >> ~/.bash_aliases

# hacer efectivo el alias
source ~/.bash_aliases


```
