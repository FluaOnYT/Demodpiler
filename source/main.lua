local GET = loadstring and function(...) return game:HttpGet(...) end or function(...) return game:GetService("HttpService"):GetAsync(...) end

local Extractors = {
  string = GET("https://cdn.jsdelivr.net/gh/FluaOnYT/Demodpiler@main/source/extractors/string.lua"),
  number = GET("https://cdn.jsdelivr.net/gh/FluaOnYT/Demodpiler@main/source/extractors/number.lua"),
}

function _Extract(Table, Indent)
  local Extracted = "return {"

  for I, V in next, Table do
    if type(V) == "table" then
      Extracted = Extracted .. _Extract(V, Indent + 1)
    else
      local Extrator = Extractors[type(V)]
      
      Extracted = Extracted .. Extractor(V, Indent, I)
    end
  end
  
  return Extracted .. "}"
end

function Extract(Module)
  Module = require(Module)

  return _Extract(Module)
end