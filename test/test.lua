reggae = require('reggae')
lu = require('luaunit')
JSON = require('JSON')

TestJson = {}
function TestJson:testLeafFoo()
   local foo = reggae.Target('foo.d')
   lu.assertEquals(JSON:decode(foo:to_json()),
                   JSON:decode([[
                     {"type": "fixed",
                      "command": {},
                      "outputs": ["foo.d"],
                      "dependencies": {"type": "fixed", "targets": []},
                      "implicits": {"type": "fixed", "targets": []}}]]))
end

function TestJson:testLeafBar()
   local bar = reggae.Target('bar.d')
   lu.assertEquals(JSON:decode(bar:to_json()),
                   JSON:decode([[
                     {"type": "fixed",
                      "command": {},
                      "outputs": ["bar.d"],
                      "dependencies": {"type": "fixed", "targets": []},
                      "implicits": {"type": "fixed", "targets": []}}]]))
end


function TestJson:testBuild()
   local bld = reggae.Build(reggae.Target('foo',
                                          'dmd -offoo foo.d',
                                          {reggae.Target('foo.d')}))
   lu.assertEquals(JSON:decode(bld:to_json()),
                   JSON:decode([[
[{"type": "fixed",
          "command": {"type": "shell",
                      "cmd": "dmd -offoo foo.d"},
          "outputs": ["foo"],
          "dependencies": {"type": "fixed",
                           "targets":
                           [{"type": "fixed",
                             "command": {},
                           "outputs": ["foo.d"],
                           "dependencies": {
                               "type": "fixed",
                               "targets": []},
                           "implicits": {
                               "type": "fixed",
                               "targets": []}}]},
          "implicits": {"type": "fixed", "targets": []}}]
   ]]))
end

lu.LuaUnit.verbosity = 2
os.exit(lu.LuaUnit.run())
