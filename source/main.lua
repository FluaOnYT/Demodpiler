local GET = loadstring and function(...) return game:HttpGet(...) end or function(...) return game:GetService("HttpService"):GetAsync(...) end

local Extractors = {
  String = GET("https://cdn.jsdelivr.net/gh/FluaOnYT/Demodpiler@main/source/extractors/string.lua"),
  Number = GET("https://cdn.jsdelivr.net/gh/FluaOnYT/Demodpiler@main/source/extractors/number.lua"),
}

function Extract(Module)
  
end