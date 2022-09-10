local plugin = require("timer")

describe("setup", function()
  it("works with default", function()
    assert("my first function with param = Hello!", plugin.hoge())
  end)

  it("works with custom var", function()
    plugin.setup({ opt = "custom" })
    assert("my first function with param = custom", plugin.hoge())
  end)
end)
