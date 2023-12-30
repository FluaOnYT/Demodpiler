local Extractors = {
	string = function(Value: string)
		local Line = ""

		Line = Line .. string.format("\"%s\"", tostring(Value))

		return Line
	end,
	number = function(Value: number)
		local Line = ""

		Line = Line .. string.format("%d", Value)

		return Line
	end,
	Instance = function(Value: Instance)
		local Line = ""
		local Parents = {Value.Name}
		local PResult = {}
		local Parent = Value

		if Parent.Parent == nil then
			Line = "Instance.new(\"" .. Value.ClassName .. "\")"
		else
			while Parent ~= game do
				if Parent.Parent == game then
					table.insert(Parents, "game")
				else
					table.insert(Parents, Parent.Parent.Name)
				end

				Parent = Parent.Parent
			end

			table.freeze(Parents)

			for I = 1, #Parents do
				PResult[I] = Parents[#Parents - I + 1]
			end

			Line = Line .. table.concat(PResult, ".")
		end

		return Line
	end,
	Vector2 = function(Value: Vector2)
		local Line = ""

		Line = string.format("Vector2.new(%d, %d)", Value.X, Value.Y)

		return Line
	end,
	Vector2int16 = function(Value: Vector2int16)
		local Line = ""

		Line = string.format("Vector2.new(%d, %d)", Value.X, Value.Y)

		return Line
	end,
	Vector3 = function(Value: Vector3)
		local Line = ""

		Line = string.format("Vector3.new(%d, %d, %d)", Value.X, Value.Y, Value.Z)

		return Line
	end,
	Vector3int16 = function(Value: Vector3int16)
		local Line = ""

		Line = string.format("Vector3.new(%d, %d, %d)", Value.X, Value.Y, Value.Z)

		return Line
	end,
	CFrame = function(Value: CFrame)
		local Line = ""
		local Components = table.pack(Value:GetComponents())

		if Components[4] == 1 and Components[8] == 1 and Components[12] == 1 then
			Line = string.format("CFrame.new(%d, %d, %d)", Components[1], Components[2], Components[3])
		else
			Line = string.format("CFrame.new(%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)", unpack(Components))
		end
		
		return Line
	end,
}

function _Extract(Table, Indent)
	local Extracted = "{\n"

	for I, V in pairs(Table) do
		local Line = ""

		for i  = 1, Indent do
			Line = Line .. "  "
		end

		if type(I) == "number" then
			Line = Line .. string.format("[%d]", I)
		else
			I = string.gsub(I, "\"", "\\\"")
			Line = Line .. string.format("[\"%s\"] = ", I)
		end

		print(type(V))

		if type(V) == "table" then
			Extracted = Extracted .. Line .. _Extract(V, Indent + 1)
		else
			local Extractor = Extractors[typeof(V)]

			if Extractor == nil then
				Extracted = Extracted .. Line .. string.format("nil, --[[%s type is not supported]]", typeof(V))
			else
				Extracted = Extracted .. Line .. Extractor(V)
			end
		end

		Extracted = Extracted .. ",\n"
	end
	
	if Indent - 0 > 0 then
		for i = 1, Indent do
			Extracted = Extracted .. "  "
		end
	end
	
	return Extracted .. "}"
end

function Extract(Module)
	Module = require(Module)

	return "return " .. _Extract(Module, 1)
end

return Extract
