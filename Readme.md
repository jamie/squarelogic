# SquareLogic Solver

This program solves puzzles from [Everyday Genius: Square Logic](http://www.squarelogicgame.com/).

### Usage

`bundle exec ruby ocr.rb`

Application will grab a screenshot, crop it, process the image, and output a solution to the terminal.

After a 5 second delay, it will repeat.

### Caveats

Does not solve "Straight" or "<,>" clues, Hidden-Cage, or Double Board puzzles.

Straights should just be a matter of parsing correctly.

Inequalities will need a bunch of additional scanner work to parse out all the between-square directional clues.

Hidden-Cage puzzles will probably need to be color-solved manually ahead of time, or possibly supported by adding some size-flexible dedicated constraints to the solver - I will probably never implement this.

Double Board ought to be easy to support, just do an extra scanner pass and accumulate constraints against the solver.

### Limitations

As I run this game in a Windows VM on an OSX host, this code will only run on OSX.

It assumes a very specific window location, and currently has some hard-coded image coordinates for the 4x4 puzzle.

### Dependencies

[tesseract-ocr](https://github.com/meh/ruby-tesseract-ocr) requires a local `brew install tesseract`.

I do some image manipulation with [imagemagick]() directly (as well as the Rmagick ruby front-end), so `brew install imagemagick`.

Solving is done via Matthew Barry's [CSP Solver](https://github.com/komputerwiz/csp-solver), which I've just included directly as it's not a gem.

Finally, I'm planning on including some automated mouse control via [cliclick](https://github.com/BlueM/cliclick), (`brew install cliclick`) but it's not in yet.


### License

`lib/csp.rb` and `lib/mathdoku.rb` Copyright (c) 2014 Matthew Barry, [MIT Licensed](https://github.com/komputerwiz/csp-solver/blob/master/LICENSE).

All other files:

> The MIT License (MIT)
>
> Copyright (c) 2015 Jamie Macey
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> SOFTWARE.
