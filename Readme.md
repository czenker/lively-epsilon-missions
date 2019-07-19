# Lively Epsilon Missions

These are missions for [Empty Epsilon](https://daid.github.io/EmptyEpsilon/)(EE) that are based
on the framework [Lively Epsilon](https://czenker.github.io/lively-epsilon/).

[Details on the mission](https://czenker.github.io/lively-epsilon-missions/) can be read online.

### Installation

Installation has to be done on all stations.

1. Locate EmptyEpsilon's directory of your installation. On Windows this is the directory the `EmptyEpsilon.exe`
file is located in. On Linux and Mac use `~/.emptyepsilon`.
2. This directory contains the `options.ini` file. Open it with any text editor, locate the line that starts with `mod=` and change it to `mod=le/`.
3. Close the file and make sure the `resources/mods` directory exists in the same directory. If not, just create it.
4. Inside the `resources/mods` directory create a directory called `le` and extract the [Release](https://github.com/czenker/lively-epsilon-missions/releases) there.
5. Start Empty Epsilon and you should be able to start a mission called `Krepios`.
6. Be aware that none of the default scenarios will work with the mod enabled. They pop up on the mission selection still, but ignore these. To run EE's vanilla scenarios switch the line in `options.ini` back to `mod=`.

### Contact

I would really like to read of your endeavors and your impression of the missions. 
The best way to share it is on [bridgesim.net](http://bridgesim.net/categories/emptyepsilon). Im called [xopn](http://bridgesim.net/profile/1483/xopn) there.
Also if you have problems running the scenario don't hesitate to send me a message.

The latest version of the missions can be [downloaded on Github](https://github.com/czenker/lively-epsilon-missions/releases).

You can issue [bug reports, feature requests](https://github.com/czenker/lively-epsilon-missions/issues) or [pull requests](https://github.com/czenker/lively-epsilon-missions/pulls) on Github. 
Also if you want to help improve the translations or submit a new one, this is the place to go to.

### Development

[![Build Status](https://travis-ci.org/czenker/lively-epsilon-missions.svg?branch=master)](https://travis-ci.org/czenker/lively-epsilon-missions)

There are a few tests to make sure the scenario is not totally broken. ;) But they are by far a guarantee that
you won't run into any issues.

You can run the tests by installing [Busted](https://olivinelabs.com/busted/) and run

```bash
busted
```
