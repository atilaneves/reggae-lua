local Target = {}
Target.__index = Target

setmetatable(Target, {
                __call = function (cls, ...)
                   return cls.new(...)
                end,
})

function Target.new(init)
   local self = setmetatable({}, Target)
   self.value = init
   return self
end

function Target:to_json()
   return self.value
end

return {
   Target = Target,
}
