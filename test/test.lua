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

lu.LuaUnit.verbosity = 2
os.exit(lu.LuaUnit.run())
