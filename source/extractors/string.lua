return function(Value: string)
		local Line = ""

		Line = Line .. string.format("\"%s\"", tostring(Value))

		return Line
end
