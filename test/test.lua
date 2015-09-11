reggae = require('reggae')
lu = require('luaunit')

TestJson = {}
function TestJson:testLeafFoo()
   local foo = reggae.Target('foo.d')
   lu.assertEquals(foo:to_json(), "{}")
end

lu.LuaUnit.verbosity = 2
os.exit(lu.LuaUnit.run())
