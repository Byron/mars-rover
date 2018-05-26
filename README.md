## Goal

Solve the mars rover problem the way I would like it, in Rust.
Try to be as idiomatic as possible, and consider the answer the main user
value to provide. Thus that and only that MUST be tested, anything else 
is 'extra', like actually testing for a few things the user can run into.

## Getting the answers

Run `make answers` if your `rust` installation is at least at v1.26.
If you have no `rust` but `docker`, run `make answers-in-docker`.

In any case, you can run all `make` targets using docker via `make interactive-developer-environment-in-docker`.
Please be warned that initial compilation takes a while.

## Features

* [x] shows correct answers
* [x] fully streaming with minimal state
* [x] support for profiling
* [x] support for benchmarking
* [x] support for linting
* [x] interactive developer environment in docker

## Implementation Notes

* file format parsing is case-insensitive, just because I personally prefer that.

## Benchmark Results

The Rust release binary comes in at 482kb on OSX (stripped). Max-heap is 412kb, and it processes a 7MB file in 850ms.
Amount of lines of code is 139, with 33 lines of bash for journey tests.

One Java implementation comes in at 324 lines of implementation code. After some wrangling I was able to run it on the actual benchmark input,
even though I couldn't get it to finish the run in any reasonable amount of time.

Another Java implementation had 345 implementation code, and I couldn't run it either as it was not accepting file input.

An implementation from github (https://github.com/max-winderbaum/Mars-Rover-Code-Challenge) used node, with 384 SLOC, while running
it consumed 103MB, and... it also didn't finish in a reasonable time so I had to abort it.

And I tried to find a few more, but none were in a state that could run a file :(.
