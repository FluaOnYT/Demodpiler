return function(Value, Key)
  local Line = ""
  
  Line = Line .. string.format("%d", tonumber(Value))

  return Line .. ",\n"
end
