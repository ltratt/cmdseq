# cmdseq

## Overview

`cmdseq` allows users to execute interleaved sequences of commands. Assuming the
same counts and commands, on each execution cmdseq executes one of the
commands, cycling through the sequence and wrapping back to the beginning when
it is complete. For example, consider the following sequence:

```
$ cmdseq 2 "echo cmd1" 1 "echo cmd2"
cmd1
$ cmdseq 2 "echo cmd1" 1 "echo cmd2"
cmd1
$ cmdseq 2 "echo cmd1" 1 "echo cmd2"
cmd2
$ cmdseq 2 "echo cmd1" 1 "echo cmd2"
cmd1
```

`cmdseq` can be useful for integrating with tools such as cron. For example, if
one is automatically synchronising large directories, one can set up a cron job
which usually performs a quick synchronisation, occasionally performing a slow
synchronisation:

```
$ crontab -l
*/9 * * * * cmdseq 200 "sync quick" 1 "sync full"
```


## Usage

The command-line arguments are as follows:

```
cmdseq [-d <count dir>] <count1> <cmd1> [... <countn> <cmdn>]
```

Where:

* `-d <count dir>` is a directory used to store command sequence cookies. It
  defaults to `/tmp`.
* `<count1>` is an integer number of times cmd1 will be executed.
* <cmd1> is a command to be executed. If the command has options, it should be
  surrounded by quote marks.

`cmdseq` exits with the exit code of whichever cmd it ran.


## Security considerations

Since `cmdseq` does not stay in memory after the child command has completed,
it needs a way of storing its current position in the command sequence. It thus
stores a single integer in a cookie file (under `/tmp/` by default). The cookie
file's name is derived from a hash of the commands involved: although there can
be no guarantee of uniqueness, in practise multiple different command sequences
can be safely used. However, if an attacker can interfere with the cookie file
(which is marked user read/write only), they can prevent parts of the command
sequence from ever being run (e.g. by continually writing `0` to the cookie
file). Depending on your threat model you may thus not wish to use `cmdseq` for
security critical purposes.


## More information

More information about cmdseq can be found at its webpage:

  http://tratt.net/laurie/src/cmdseq/
