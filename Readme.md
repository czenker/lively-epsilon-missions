# Lively Epsilon Missions

These are missions for [Empty Epsilon](https://daid.github.io/EmptyEpsilon/)(EE) that are based
on the framework [Lively Epsilon](https://czenker.github.io/lively-epsilon/).

[Details on the mission](https://czenker.github.io/lively-epsilon-missions/) can be read online.

### Installation

Installation has to be done on all stations. There are two installation possibilities with benefits and drawbacks.
Go with the **Easy way** if you want little hassle.  

#### Easy way

1. Locate the `scripts` directory in your Empty Epsilon installation. It is the one that contains `scenario_00_basic.lua`
amongst others.
2. Make a backup of that `scripts` directory now! You won't be able play any of the original scenarios
once you installed LE. Copying the directory and calling it `scripts_backup` is sufficient.
3. Remove all the files starting with `scenario_` in that directory.
4. Extract the content of the [Release](https://github.com/czenker/lively-epsilon-missions/releases) into that
directory. It will override some of the files, which is fine.

#### Experimental way

This is the recommended way, but might probably not work. If you do not like tinkering, take the **Easy way**
as it is pretty fail-safe.

The advantage with this way of installation is that you can easily switch between Empty Epsilon and Lively Epsilon.

1. Locate the `resources/mods` directory in your Empty Epsilon installation. It is empty by default.
2. Create a directory in it called `le` and extract the [Release](https://github.com/czenker/lively-epsilon-missions/releases) there.
3. Start Empty Epsilon with the command `EmptyEpsilon mod=le`.
4. Be aware that none of the default scenarios will work with the mod enabled. They pop up on the mission selection still, but ignore these. ;)

If everything went well, you should see the scenario `Krepios` in the scenario selection. The reason I would not
recommend this way of installation is, that there is currently a bug that shows scenarios from mods, but they can not be
started properly and give a message that the scenario could not be found.

A [pull request](https://github.com/daid/EmptyEpsilon/pull/620) is already issued, but not merged yet, but 
you could be able to circumvent the bug by calling `EmptyEpsilon mod=/le` on Linux or `EmptyEpsilon mod=\\le` on Windows.
I have not tried if this works,... but it should... theoretically. But as soon as you see the scenario getting
started everything should work from there on. Good luck, friend.

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
