local JSON = require('JSON')

local Build = {}
Build.__index = Build
setmetatable(Build, {
                __call = function(cls, ...)
                   return cls.new(...)
                end,
})

local Target = {}
Target.__index = Target

setmetatable(Target, {
                __call = function (cls, ...)
                   return cls.new(...)
                end,
})

local ShellCommand = {}
ShellCommand.__index = ShellCommand

setmetatable(ShellCommand, {
                __call = function (cls, ...)
                   return cls.new(...)
                end
})


local FixedDependencies = {}
FixedDependencies.__index = FixedDependencies

setmetatable(FixedDependencies, {
                __call = function (cls, ...)
                   return cls.new(...)
                end
})


function Build.new(target)
   local self = setmetatable({}, Build)
   self.targets = {target}
   return self
end

function Build:to_json()
   return JSON:encode(self:jsonify())
end

function Build:jsonify()
   targets = {}
   for k, v in pairs(self.targets) do
      targets[k] = v:jsonify()
   end

   return targets
end

function Target.new(outputs, cmd, deps, imps)
   local self = setmetatable({}, Target)

   cmd = cmd or ''

   self.command = jsonifiable(cmd, ShellCommand)
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
           command = self.command:jsonify(),
           outputs = self.outputs,
           dependencies = self.dependencies:jsonify(),
           implicits = self.implicits:jsonify(),
   }
end

function jsonifiable(arg, cls)
   return (arg and arg.jsonify) and arg or cls.new(arg)
end

function dependify(arg, cls)
   return (arg and arg.isDependency) and arg or cls.new(arg)
end

function arrayify(arg)
   if arg == nil then
      return {}
   end

   if type(arg) == 'table' then
      return arg
   else
      return {arg}
   end
end

function ShellCommand.new(cmd)
   local self = setmetatable({}, ShellCommand)
   self.cmd = (cmd == '') and {} or {type='shell', cmd=cmd}
   return self
end

function ShellCommand:jsonify()
   return self.cmd
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
   Build = Build,
   Target = Target,
}
