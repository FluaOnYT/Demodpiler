return function(Value, IndentationCount, Key)
  local Line = ""
  
  Line = Line .. string.format("%d", tonumber(Value))

  return Line .. ",\n"
end
