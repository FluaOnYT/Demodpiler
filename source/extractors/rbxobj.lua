return function(Value, IndentationCount, Key)
  local Line = ""
  local Parents = {}
  local PResult = {}
  local Parent = Key
  
  while Parent ~= game do
    table.insert(Parents, Parent.Parent.Name)
    
    Parent = Parent.Parent
  end
  
  table.freeze(Parents)
  
  for I = 1, #Parents do
    PResult[I] = Parents[#Parent - I + 1]
  end
  
  Line = Line .. string.format("%s", table.concat(PResult, "."))

  return Line .. "\n"
end