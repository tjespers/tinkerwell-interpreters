# tinkerwell-interpreters

## ⚠️⚠️⚠️ BIG DISCLAIMER ⚠️⚠️⚠️

This is in no case a robust / solid / production-ready solution, it is purely a wild experiment to see if custom tinkerwell interpreters (as a concept) could ever become a viable addition to the Tinkerwell application by [@mpociot](https://github.com/mpociot).

## Usecase

Taking the ideas from issues [#2](https://github.com/beyondcode/tinkerwell-suggestions/issues/2) & [#46](https://github.com/beyondcode/tinkerwell-suggestions/issues/46) in the [beyondcode/tinkerwell-suggestions repo](https://github.com/beyondcode/tinkerwell-suggestions) i noticed that docker support / custom PHP interpreters were a thing many people with me are wanting when using tinkerwell. While a working "solution" is posted in [#46](https://github.com/beyondcode/tinkerwell-suggestions/issues/46) (install SSH in docker), it requires some setup as well as custom build docker containers which isn't for everyone.

Therefore i started tinkering around a bit and came up with a possible solution (read: hack) to tackle the interpreter problem i had while working on my own projects (running in docker-compose stacks).

## Homegrown solution

As there already is firstclass support for custom drivers in tinkerwell (which is really a great thing!). I kind of took this idea to hack custom (project-based) interpreters in as well. In order to do so I wrote a little script and configured it as the PHP-binary in the Tinkerwell settings.

This script simply checks for the presence of a `.tinkerwell/cli.interpreter` file inside the Tinkerwell current working dir. If such file is found, it executes the interpreter with the exact same arguments as it was called with itself.

For CLI tinker actions this seems to be the following:

- `$1` => The path to the tinkerwell phar
- `$2` => A tmp file containing the current tinker code
- `$3` => The current tinker working dir
- `$4` => a value currently always being null, (purpose unclear at this point)

## TLDR; i need this now

As a quick POC i uploaded some sample scripting to showcase the idea, currently this is based on MacOs but i think this could easily be adapted to work on Linux / windows as well.

### Setup

- Put tinkerwell-dynamic-interpreter-resolver.sh in an executable location and set it as PHP binary in tinkerwell's advanced settings.
- Copy any of the examples to a `.tinkerwell` folder in your project root
- Open your project directory in Tinkerwell / Use Tinkerwell IDE extension to tinker some
- Enjoy