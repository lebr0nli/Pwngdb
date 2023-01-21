#!/bin/bash

# Try to parse the output of `gdb -ex ...` to get the path to pwndbg
# If that fails, we ask the user to enter the path to pwndbg
pwndbg=$(gdb -q -ex 'pi import sys;p=sys.modules.get("pwndbg",None);print(p.__path__[0] if p else p)' -ex 'quit' 2>/dev/null | tail -n 1)
# if pwndbg path is "None", ask the user to enter the path
if [ " $pwndbg " = "None" ]; then
    echo "Please enter the path to pwndbg: "
    read pwndbg
else
    echo "Found pwndbg at $pwndbg "
    echo "Is this correct? [Y/n]"
    read answer
    if [ "$answer" = "n" ]; then
        echo "Please enter the path to pwndbg: "
        read pwndbg
    fi
fi

# Check if the path is valid
if [ ! -d "$pwndbg" ]; then
    echo "Invalid path to pwndbg"
    exit 1
fi

pwngdb=$(dirname `readlink -f $0`)

echo "Installing pwngdb to $pwndbg"

cp -v $pwngdb/pwngdb.py $pwndbg/pwngdb.py
cp -v $pwngdb/angelheap.py $pwndbg/angelheap.py

cp -v $pwngdb/commands/pwngdb.py $pwndbg/commands/pwngdb.py
cp -v $pwngdb/commands/angelheap.py $pwndbg/commands/angelheap.py

echo "Modifying $pwndbg/commands/__init__.py"
sed -i -e '/import pwndbg.commands.xor/a \ \ \ \ import pwndbg.commands.pwngdb' $pwndbg/commands/__init__.py
sed -i -e '/import pwndbg.commands.xor/a \ \ \ \ import pwndbg.commands.angelheap' $pwndbg/commands/__init__.py

echo "Done"
