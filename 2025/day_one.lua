function ParseRotation(r)
  local dir
  local num
  for str in string.gmatch(r, "%a") do
    dir = string.lower(str)
  end
  for d in string.gmatch(r, "%d%d?") do
    num = d
  end
  return dir, tonumber(num)
end

function SpinDial(pos, dir, clicks)
  if dir == "l" then
    -- if clicks > pos then
    if pos - clicks < 0 then
      pos = 100 + (pos - clicks)
    else
      pos = pos - clicks
    end
  end
  if dir == "r" then
    if pos + clicks > 99 then
      pos = (pos + clicks) - 100
    else
      pos = pos + clicks
    end
  end
  return pos
end

function Input(pos, sequence)
  local zero_cnt = 0
  for _, v in pairs(sequence) do
    local dir, num = ParseRotation(v)
    pos = SpinDial(pos, dir, num)
    -- print(pos)
    if pos == 0 then
      zero_cnt = zero_cnt + 1
    end
  end
  return zero_cnt
end

function GetPassword()
  local pos = 50
  local sequence = { "L68", "L30", "R48", "L5", "R60", "L55", "L1", "L99", "R14", "L82" }
  local code = Input(pos, sequence)
  print(code)
end

function GetPwFromFile()
  local f = io.open("input.txt", "r")
  if not f then return nil end
  local inputs = {}
  for line in f:lines() do
    table.insert(inputs, line)
  end
  print(table.maxn(inputs))
  local code = Input(50, inputs)
  print(code)
end
