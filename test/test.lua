reggae = require('reggae')
lu = require('luaunit')

TestJson = {}
    function TestJson:testLeafFoo()
       lu.assertEquals(1, 2)
    end

lu.LuaUnit.verbosity = 2
os.exit(lu.LuaUnit.run())
