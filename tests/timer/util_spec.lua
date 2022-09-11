local plugin = require("timer.util")

describe("GetTimeFromStringTime", function()
  it("works with min", function()
    local val = GetTimeFromStringTime("2m")
    local expected = 2 * 60 * 1000
    assert.are.equal(expected, val)
  end)
  it("works with sec", function()
    local val = GetTimeFromStringTime("5s")
    local expected = 5 * 1000
    assert.are.equal(expected, val)
  end)
  it("works with hour", function()
    local val = GetTimeFromStringTime("2h")
    local expected = 2 * 60 * 60 * 1000
    assert.are.equal(expected, val)
  end)
  it("number only", function()
    local val = GetTimeFromStringTime("400")
    local expected = 400 
    assert.are.equal(expected, val)
  end)
  it("complex", function()
    local val = GetTimeFromStringTime("4m50s")
    local expected = (4 * 60 * 1000) + (50 * 1000)
    assert.are.equal(expected, val)
  end)
end)
