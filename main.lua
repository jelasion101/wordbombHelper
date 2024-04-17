local p = game:GetService("Players").LocalPlayer -- Player
local htps = game:GetService("HttpService")
local tb1 = false
local tb2 = false

local function getFullName(x)
	local t = {}
	while x ~= game do
		local name = x.Name:gsub('[\"]', '\\%0')
		table.insert(t, 1, name)
		x = x.Parent
	end
	return 'game["'..table.concat(t, '"]["')..'"]'
end

local function createGui()
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("ImageLabel")
	local access_alarm = Instance.new("ImageButton")
	local Pattern = Instance.new("ImageLabel")
	local Roundify = Instance.new("ImageLabel")
	local TextLabel = Instance.new("TextLabel")
	local TextLabel_2 = Instance.new("TextLabel")
	ScreenGui.Parent = game.CoreGui
	Frame.Name = "Frame"
	Frame.Parent = ScreenGui
	Frame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
	Frame.BackgroundTransparency = 1.000
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0, 50, 0, 50)
	Frame.Size = UDim2.new(0, 150, 0, 55)
	Frame.Image = "rbxassetid://3570695787"
	Frame.ImageColor3 = Color3.fromRGB(99, 99, 99)
	Frame.ScaleType = Enum.ScaleType.Slice
	Frame.SliceCenter = Rect.new(100, 100, 100, 100)
	Frame.SliceScale = 0.120
	access_alarm.Name = "access_alarm"
	access_alarm.Parent = Frame
	access_alarm.BackgroundTransparency = 1.000
	access_alarm.Position = UDim2.new(0.0399999991, 0, 0.118181817, 0)
	access_alarm.Size = UDim2.new(0, 14, 0, 14)
	access_alarm.ZIndex = 2
	access_alarm.Image = "rbxassetid://3926307971"
	access_alarm.ImageRectOffset = Vector2.new(284, 244)
	access_alarm.ImageRectSize = Vector2.new(36, 36)
	Pattern.Name = "Pattern"
	Pattern.Parent = Frame
	Pattern.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Pattern.BackgroundTransparency = 1.000
	Pattern.BorderSizePixel = 0
	Pattern.Size = UDim2.new(0, 150, 0, 54)
	Pattern.ZIndex = 9
	Pattern.Image = "rbxassetid://2151741365"
	Pattern.ImageTransparency = 0.600
	Pattern.ScaleType = Enum.ScaleType.Tile
	Pattern.SliceCenter = Rect.new(0, 256, 0, 256)
	Pattern.TileSize = UDim2.new(0, 250, 0, 250)
	Roundify.Name = "Roundify"
	Roundify.Parent = Pattern
	Roundify.AnchorPoint = Vector2.new(0.5, 0.5)
	Roundify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Roundify.BackgroundTransparency = 1.000
	Roundify.Position = UDim2.new(0.5, 0, 0.5, 0)
	Roundify.Size = UDim2.new(1, 24, 1, 24)
	Roundify.Image = "rbxassetid://3570695787"
	Roundify.ImageTransparency = 1.000
	Roundify.ScaleType = Enum.ScaleType.Slice
	Roundify.SliceCenter = Rect.new(100, 100, 100, 100)
	Roundify.SliceScale = 0.120
	TextLabel.Parent = Frame
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0, 0, 0.372727275, 0)
	TextLabel.Size = UDim2.new(0, 150, 0, 33)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = "placeholder"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextWrapped = true
	TextLabel_2.Parent = Frame
	TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.BackgroundTransparency = 1.000
	TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_2.BorderSizePixel = 0
	TextLabel_2.Position = UDim2.new(0.13333334, 0, 0.118181817, 0)
	TextLabel_2.Size = UDim2.new(0, 30, 0, 13)
	TextLabel_2.Font = Enum.Font.SourceSans
	TextLabel_2.Text = "placeholder"
	TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.TextScaled = true
	TextLabel_2.TextSize = 14.000
	TextLabel_2.TextWrapped = true
	tb1 = TextLabel
	tb2 = TextLabel_2
end

local function getStart()
	local word = ""
	local gui = p.PlayerGui.GameUI.Container.GameSpace.DefaultUI
	if gui:FindFirstChild("GameContainer") then
		if gui.GameContainer.DesktopContainer.InfoFrameContainer.InfoFrame:FindFirstChild("TextFrame") then
			newgui = gui.GameContainer.DesktopContainer.InfoFrameContainer.InfoFrame:FindFirstChild("TextFrame")
			for i, v in pairs(newgui:GetChildren()) do
				if v.Name == "LetterFrame" then
					color = v.Letter.ImageColor3
					if color.B <= 0.6745 then
						word = word .. v.Letter.TextLabel.Text
					end
				end
			end
		end
	end
	return word
end

local function getRandomWord(start)
	fintable = {}
	request = htps:JSONDecode(game:HttpGet("https://api.datamuse.com/words?sp=*" .. start .. "*&max=100", true))
	if request ~= nil then
		for i, v in pairs(request) do
			for i2, v2 in pairs(v) do
				if type(v2) == "string" then
					table.insert(fintable, v2)
				end
			end
		end
	end
	tb1.Text = fintable[math.random(1, #fintable)]
end

local function updated()
	local time = 0
	while _G.running == true do
		wait(.01)
		time = time + .01
		tb2.Text = string.format("%0.2f", tostring(_G.time - time))
		if time >= _G.time then
			getRandomWord(getStart())
			time = 0
		end
	end
end

createGui()
updated()
print("running")
