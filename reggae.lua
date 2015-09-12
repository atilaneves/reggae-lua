local JSON = require('JSON')

local Target = {}
Target.__index = Target

setmetatable(Target, {
                __call = function (cls, ...)
                   return cls.new(...)
                end,
})

local FixedDependencies = {}
FixedDependencies.__index = FixedDependencies

setmetatable(FixedDependencies, {
                __call = function (cls, ...)
                   return cls.new(...)
                end
})

function Target.new(outputs, cmd, deps, imps)
   local self = setmetatable({}, Target)
   self.command = {}
   self.outputs = arrayify(outputs)
   self.dependencies = dependify(deps, FixedDependencies)
   self.implicits = dependify(imps, FixedDependencies)
   return self
end

function Target:to_json()
   return JSON:encode(self:jsonify())
end

function Target:jsonify()
   return {
           type = 'fixed',
           command = self.command,
           outputs = self.outputs,
           dependencies = self.dependencies:jsonify(),
           implicits = self.implicits:jsonify(),
   }
end

function dependify(arg, klass)
   return ((arg and arg.isDependency) and arg or klass.new(arg))
end

function arrayify(arg)
   if arg == nil then
      return {}
   end

   if type(arg) == 'table 'then
      return arg
   else
      return {arg}
   end
end


function FixedDependencies.new(deps)
   local self = setmetatable({}, FixedDependencies)
   self.isDependency = true
   self.type = 'fixed'
   self.targets = arrayify(deps)
   return self
end


function FixedDependencies:jsonify()
   local targets = {}
   for k, v in pairs(self.targets) do
      targets[k] = v:jsonify()
   end
   return {type = 'fixed', targets = targets}
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
