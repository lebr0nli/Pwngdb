# Pwngdb ❤️ pwndbg

## How to install

1. Put `pwngdb.py` and `angelheap.py` into `/path/to/pwndbg/pwndbg/`

2. Put `commands/pwngdb.py` and `commands/angelheap.py` into `/path/to/pwndbg/pwndbg/commands/`

3. Add `import pwndbg.commands.pwngdb` and `import pwndbg.commands.angelheap` into `/path/to/pwndbg/pwndbg/__init__.py`

You can use [install.sh](install.sh) to do this automatically or use the following commands:

```shell
#!/bin/bash
# You need to change the `/path/to/pwdbg` to your pwndbg location

pwndbg='/path/to/pwndbg'

cp pwngdb.py $pwndbg/pwndbg/pwngdb.py
cp angelheap.py $pwndbg/pwndbg/angelheap.py

cp commands/pwngdb.py $pwndbg/pwndbg/commands/pwngdb.py
cp commands/angelheap.py $pwndbg/pwndbg/commands/angelheap.py

sed -i -e '/import pwndbg.commands.xor/a \ \ \ \ import pwndbg.commands.pwngdb' $pwndbg/pwndbg/commands/__init__.py
sed -i -e '/import pwndbg.commands.xor/a \ \ \ \ import pwndbg.commands.angelheap' $pwndbg/pwndbg/commands/__init__.py
```

## Note

To avoid the conflict with pwndbg, some commands will be different or be removed.

| pwngdb command | pwndbg command                                     |
| -------------- | -------------------------------------------------- |
| `got`          | renamed to `objdump_got`                           |
| `canary`       | removed since pwndbg has same command (`canary`)   |
| `tls`          | removed since pwndbg has same command (`tls`)      |
| `free`         | removed since pwndbg has same command (`try_free`) |
| `at`           | removed since pwndbg has same command (`attachp`)  |
| `codebase`     | removed since pwndbg has same command (`piebase`)  |

## TODO

- [ ] Use more pwndbg API if possible instead of using `gdb.execute` (see [developer notes of pwndbg](https://github.com/pwndbg/pwndbg/blob/dev/DEVELOPING.md))
