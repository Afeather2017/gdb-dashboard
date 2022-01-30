# GDB dashboard

GDB dashboard is a standalone `.gdbinit` file written using the [Python API][] that enables a modular interface showing relevant information about the program being debugged. Its main goal is to reduce the number of GDB commands needed to inspect the status of current program thus allowing the developer to primarily focus on the control flow.

![Screenshot](https://raw.githubusercontent.com/wiki/cyrus-and/gdb-dashboard/Screenshot.png)

[Python API]: https://sourceware.org/gdb/onlinedocs/gdb/Python-API.html

## Quickstart

Just place [`.gdbinit`][] in your home directory, for example with:

```
wget -P ~ https://git.io/.gdbinit
```

Optionally install [Pygments][] to enable syntax highlighting:

```
pip install pygments
```

Then debug as usual, the dashboard will appear automatically every time the inferior program stops.

Keep in mind that no GDB command has been redefined, instead all the features are available via the main `dashboard` command (see `help dashboard`).

## Improve the show of value

Program a function such as ` std::string debug(BinaryTree& tree)` which returns a string which shows tree directly like this:

```python
           ╭╴d
         ╭╴a
         c
         │ ╭╴e
         ╰╴b
           ╰╴f

```

Then edit you gdb script like this.

```gdb
python
user_methons['BinaryTree'] = 'debug'
end
```

Let's name you script "gdb.binary-tree", then run `gdb -x gdb.binary-tree`, then dashboard will call `BinaryTree(debug)`.

Then you tree will look like this.

![Screenshot_20220130_000116.png](https://s2.loli.net/2022/01/30/Csghu3RiAIXyeBF.png)

You'd better NEVER USE A VALUE NAME repeatly, or you may not get right resualt.

Head to the [wiki][] to learn how to perform the most important tasks.

[`.gdbinit`]: https://raw.githubusercontent.com/cyrus-and/gdb-dashboard/master/.gdbinit
[Pygments]: http://pygments.org/
[wiki]: https://github.com/cyrus-and/gdb-dashboard/wiki
