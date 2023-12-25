return function(Value)
  local Line = ""
  
  Line = Line .. string.format("\"%s\"", tostring(Value))

  return Line .. ",\n"
end
