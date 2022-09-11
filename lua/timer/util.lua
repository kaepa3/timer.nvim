--analyzeExtention
local function analyzeExtention(extention)
  if extention == "m" then
    return 60 * 1000
  elseif extention == "s" then
    return 1000
  elseif extention == "h" then
    return 60 * 1000 * 60
  end
  return 1
end

--GetTimeFromStringTime
function GetTimeFromStringTime(timeStr)
  local num = tonumber(timeStr)
  if num ~= nil then
    return num
  end

  local totalVal = 0
  for val, extention in timeStr:gmatch("(%d+)(.)") do
    extra = analyzeExtention(extention)
    totalVal = totalVal + val * extra
  end
  return totalVal
end
