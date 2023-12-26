local GET = loadstring and function(...) return game:HttpGet(...) end or function(...) return game:GetService("HttpService"):GetAsync(...) end

local Extractors = {
  string = loadstring(GET("https://cdn.jsdelivr.net/gh/FluaOnYT/Demodpiler@main/source/extractors/string.lua"))(),
  number = loadstring(GET("https://cdn.jsdelivr.net/gh/FluaOnYT/Demodpiler@main/source/extractors/number.lua"))(),
  rbxobj = loadstring(GET("https://cdn.jsdelivr.net/gh/FluaOnYT/Demodpiler@main/source/extractors/rbxobj.lua"))()
}

function _Extract(Table, Indent)
  local Extracted = "{"

  for I, V in next, Table do
    
    local Line = ""

    for i  = 1, IndentationCount do
      Line = Line .. "  "
    end

    if type(Location) == "number" then
      Line = Line .. string.format("[%d]", Key)
    else
      Location = string.gsub(Key, "\"", "\\\"")
      Line = Line .. string.format("[\"%s\"] = ", Key)
    end
    
    if type(V) == "table" then
      Extracted = Extracted .. Line .. _Extract(V, Indent + 1)
    elseif V["Parent"] ~= nil then
      Extractors["rbxobj"](V, I)
    else
      local Extrator = Extractors[type(V)]
      
      Extracted = Extracted .. Line .. Extractor(V, I)
    end
  end
  
  return Extracted .. "}"
end

function Extract(Module)
  Module = require(Module)

  return "return" .. _Extract(Module)
end