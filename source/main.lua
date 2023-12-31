local Extractors = {
	string = function(Value: string)
		local Line = ""

		Line = Line .. string.format("\"%s\"", tostring(Value))

		return Line
	end,
	number = function(Value: number)
		local Line = ""

		Line = Line .. string.format("%f", Value)

		return Line
	end,
	boolean = function(Value: boolean)
		local Line = ""
		
		Line = Value and "true" or "false"
		
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

		Line = string.format("Vector2.new(%f, %f)", Value.X, Value.Y)

		return Line
	end,
	Vector2int16 = function(Value: Vector2int16)
		local Line = ""

		Line = string.format("Vector2.new(%d, %d)", Value.X, Value.Y)

		return Line
	end,
	Vector3 = function(Value: Vector3)
		local Line = ""

		Line = string.format("Vector3.new(%f, %f, %f)", Value.X, Value.Y, Value.Z)

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
			Line = string.format("CFrame.new(%f, %f, %f)", Components[1], Components[2], Components[3])
		else
			Line = string.format("CFrame.new(%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f)", unpack(Components))
		end

		return Line
	end,
	UDim = function(Value: UDim)
		local Line = ""

		Line = string.format("UDim.new(%f, %f)", Value.Scale, Value.Offset)

		return Line
	end,
	UDim2 = function(Value: UDim2)
		local Line = ""

		Line = string.format("UDim2.new(%f, %f, %f, %f)", Value.X.Scale, Value.X.Offset, Value.Y.Scale, Value.Y.Offset)

		return Line
	end,
	Region3int16 = function(Value: Region3int16)
		local Line = ""

		Line = string.format("Region3int16.new(Vector3int16.new(%d, %d, %d), Vector3int16.new(%d, %d, %d))", Value.Min.X, Value.Min.Y, Value.Min.Z, Value.Max.X, Value.Max.Y, Value.Max.Z)

		return Line
	end,
	TweenInfo = function(Value: TweenInfo)
		local Line = ""

		Line = string.format("TweenInfo.new(%f, Enum.EasingStyle.%s, Enum.EasingDirection.%s, %d, %s, %d)", Value.Time, Value.EasingStyle.Name, Value.EasingDirection.Name, Value.RepeatCount, Value.Reverses and "true" or "false", Value.DelayTime)

		return Line
	end,
	RaycastParams = function(Value: RaycastParams)
		local Line = "RaycastParams.new()"

		return Line
	end,
	Ray = function(Value: Ray)
		local Line = ""

		Line = string.format("Ray.new(Vector3.new(%f, %f, %f), Vector3.new(%f, %f, %f))", Value.Origin.X, Value.Origin.Y, Value.Origin.Z, Value.Direction.X, Value.Direction.Y, Value.Direction.Z)

		return Line
	end,
	PhysicalProperties = function(Value: PhysicalProperties)
		local Line = ""

		Line = string.format("PhysicalProperties.new(%f, %f, %f, %f, %f)", Value.Density, Value.Friction, Value.Elasticity, Value.FrictionWeight, Value.ElasticityWeight)

		return Line
	end,
	PathWaypoint = function(Value: PathWaypoint)
		local Line = ""

		Line = string.format("PathWaypoint.new(Vector3.new(%f, %f, %f), Enum.PathWaypointAction.%s, %s)", Value.Position.X, Value.Position.Y, Value.Position.Z, Value.Action.Name, Value.Label)

		return Line
	end,
	NumberSequenceKeypoint = function(Value: NumberSequenceKeypoint)
		local Line = ""

		Line = string.format("NumberSequenceKeypoint.new(%f, %f, %f)", Value.Time, Value.Value, Value.Envelope)

		return Line
	end,
	NumberRange = function(Value: NumberRange)
		local Line = ""
		
		Line = string.format("NumberRange.new(%f, %f)", Value.Min, Value.Max)
		
		return Line
	end,
	Color3 = function(Value: Color3)
		local Line = ""
		
		Line = string.format("Color3.fromRGB(%f, %f, %f)", Value.R, Value.G, Value.B)
		
		return Line
	end,
	FloatCurveKey = function(Value: FloatCurveKey)
		local Line = ""
		
		Line = string.format("FloatCurveKey.new(%d, %d, Enum.KeyInterpolationMode.%s)", Value.Time, Value.Value, Value.Interpolation.Name)
		
		return Line
	end,
	
}

function SharedTabletoTable(Table)
	local t = {}
	
	for i, v in Table do
		t[i] = v
	end
	
	return t
end

function _Extract(Table: SharedTable | {any}, Indent)
	local Extracted = "{\n"
	local Table = typeof(Table) == "SharedTable" and SharedTabletoTable(Table) or Table
	
	for I, V in pairs(Table) do
		local Line = ""

		for i  = 1, Indent do
			Line = Line .. "  "
		end

		if type(I) == "number" then
			Line = Line .. string.format("[%f]", I)
		else
			I = string.gsub(I, "\"", "\\\"")
			Line = Line .. string.format("[\"%s\"] = ", I)
		end

		print(type(V))

		if type(V) == "table" then
			Extracted = Extracted .. Line .. _Extract(V, Indent + 1)
		elseif typeof(V) == "SharedTable" then
			Extracted = Extracted .. Line .. "SharedTable.new(" .. _Extract(V, Indent + 1) .. ")"
		else
			local Extractor = Extractors[typeof(V)]

			if Extractor == nil then
				Extracted = Extracted .. Line .. string.format("nil --[[%s type is not supported]]", typeof(V))
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

	Extracted = Extracted:gsub(".000000", "")

	return Extracted .. "}"
end

function Extract(Module)
	Module = require(Module)

	return "return " .. _Extract(Module, 1)
end

return Extract
