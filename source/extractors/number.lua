return function(Value, IndentationCount, Key)
  local Line = ""
  
  for i  = 1, IndentationCount do
    Line = Line .. "  "
  end
  
  if type(Location) == "number" then
    Line = Line .. string.format("[%d]", Key)
  else
    Location = string.gsub(Key, "\"", "\\\"")
    Line = Line .. string.format("[\"%s\"]", Key)
  end

  Line = Line .. string.format(" = %d", tonumber(Value))

  return Line .. "\n"
end
