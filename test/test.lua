reggae = require('reggae')
lu = require('luaunit')

TestJson = {}
function TestJson:testLeafFoo()
   local foo = reggae.Target('foo.d')
   lu.assertEquals(foo:to_json(),
                   [[{"type": "fixed",
                      "command": {},
                      "outputs": ["foo.d"],
                      "dependencies": {"type": "fixed", "targets": []},
                      "implicits": {"type": "fixed", "targets": []}}]])
end

-- function TestJson:testLeafBar()
--    local bar = reggae.Target('bar.d')
--    lu.assertEquals(bar:to_json(),
--                    [[{"type": "fixed",
--                       "command": {},
--                       "outputs": ["bar.d"],
--                       "dependencies": {"type": "fixed", "targets": []},
--                       "implicits": {"type": "fixed", "targets": []}}]])
-- end

lu.LuaUnit.verbosity = 2
os.exit(lu.LuaUnit.run())
