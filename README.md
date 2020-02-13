# tinkerwell-interpreters

Dynamic, fully programmable CLI PHP interpreters for Tinkerwell app on a per-project basis. Currently tested on MacOS and provided with both docker & docker-compose examples.

## TLDR;

Within the `src` directory of this repo you'll find the proxy that should be configured in Tinkerwell as PHP binary to kickstart the use of dynamic interpreters. In the examples folder you'll find both a docker & docker-compose example which can be copied into your own project's `.tinkerwell` folder to get started.

## Usecase

Taking the ideas from issues [#2](https://github.com/beyondcode/tinkerwell-suggestions/issues/2) & [#46](https://github.com/beyondcode/tinkerwell-suggestions/issues/46) in the [beyondcode/tinkerwell-suggestions repo](https://github.com/beyondcode/tinkerwell-suggestions) i noticed that docker support / custom PHP interpreters were a thing many people with me are wanting when using tinkerwell. While a "solution" is posted in [#46](https://github.com/beyondcode/tinkerwell-suggestions/issues/46) (install SSH in docker), it requires some setup as well as custom build docker containers which isn't for everyone.

Therefore i started tinkering around a bit and came up with a possible solution (read: hack) to tackle the interpreter problem i had while working on my own projects (running in docker-compose stacks).

## Homegrown solution

As there already is firstclass support for custom drivers in tinkerwell (which is really a great thing!). I kind of took this idea to hack custom (project-based) interpreters in as well. In order to do so I wrote a little proxy script and configured it as the PHP-binary in the Tinkerwell settings.

This script simply checks for the presence of a `.tinkerwell/cli.interpreter` file inside the Tinkerwell current working dir. If such file is found, it executes the interpreter with the exact same arguments as it was called with itself.

This effectively means that we now have gained full control over how Tinkerwell is communicating with PHP to execute it's code. This opens the door to supporting every possible environment you can think of.

## Setup

- Put `src/tinkerwell-dynamic-interpreter-resolver.sh` in an executable location and set it as PHP binary in Tinkerwell's advanced settings.
- Copy any of the examples to a `.tinkerwell` folder in your own project root
- Open your project directory in Tinkerwell / Use a Tinkerwell IDE extension
- Enjoy

## ⚠️⚠️⚠️ BIG DISCLAIMER ⚠️⚠️⚠️

This is in no case a robust / solid / production-ready solution and is currently only tested on MacOS, it is purely an  experiment to see if custom tinkerwell interpreters (as a concept) could ever become a viable addition to the Tinkerwell application by [@mpociot](https://github.com/mpociot).