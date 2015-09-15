reggae-lua
=============

A lua interface / front-end to [the reggae meta-build system](https://github.org/atilaneves/

Installation
------------

Set the `LUAPATH` environment variable to point to the installation path
(e.g. `~/.luarocks/lib/luarocks/rocks-5.3/reggae/0.0-1/?.lua`).


Usage
------------

This package makes available a few classes and functions that allow
the user to write build descriptions in Javacript using node-js. It is
essentially the same API as the D version but in Lua syntax. A simple
C build could be written like this:

    local reggae = require('reggae')
    local main_obj = reggae.Target('main.o', 'gcc -I$project/src -c $in -o $out', reggae.Target('src/main.c'))
    local maths_obj = regage.Target('maths.o', 'gcc -c $in -o $out', reggae.Target('src/maths.c'))
    local app = reggae.Target('myapp', 'gcc -o $out $in', {main_obj, maths_obj})
    return {bld = reggae.Build(app)}

This should be contained in a file named `reggaefile.lua` in the project's root directory.
Running the `reggae` D binary on that directory will produce a build with the requested backend
(ninja, make, etc.)

Most builds will probably not resort to low-level primitives as above. A better way to describe
that C build would be:

    local reggae = require('reggae')
    local objs = reggae.object_files({flags = '-I$project/src', src_dirs = {'src'}})
    local app = link({exe_name = 'app', dependencies = objs})
    exports.bld = reggae.Build(app)


Please consult the [reggae documentation](https://github.com/atilaneves/reggae/tree/master/doc/index.md)
for more details.
