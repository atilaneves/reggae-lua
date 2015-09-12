local JSON = require('JSON')

local Target = {}
Target.__index = Target

setmetatable(Target, {
                __call = function (cls, ...)
                   return cls.new(...)
                end,
})

function Target.new(outputs)
   local self = setmetatable({}, Target)
   self.type = 'fixed'
   self.command = ''
   self.outputs = arraify(outputs)
   self.dependencies = {}
   self.implicits = {}
   return self
end

function Target:to_json()
   return JSON:encode(self:jsonify())
end

function Target:jsonify()
   tbl = {
           type = self.type,
           command = self.command,
           outputs = self.outputs,
           dependencies = self.dependencies,
           implicits = self.implicits,
   }
   return tbl
end

function arraify(arg)
   if type(arg) == 'table 'then
      return arg
   else
      return {arg}
   end
end

function jsonise(tbl)
   result = '{'
   for k, v in pairs(tbl) do
      result = result .. '"' .. k .. '"' .. ':' .. '"' .. show(v) .. '"' .. ', '
   end
   result = result .. '}'

   return result
end

function show(val)
   if type(arg) == 'table 'then
      return '[' .. val .. ']'
   else
      return ''
   end
end

return {
   Target = Target,
}
