local Menu = require("nui.menu")
local Input = require("nui.input")

local M = {}

M.first_upperCase = function(s)
  return (s:sub(1,1):upper() .. s:sub(2,string.len(s)))
end

M.creation_table = {
  cmd = "! mkdir -p ",
  projects = {
    processing = {
      workspace = "~/dev/projects/processing/"
    },
    cpp = {
      workspace = "~/dev/projects/cpp/",
    },
  },
}

M.items = {}

M.create_items = function()
  for k, _ in pairs(M.creation_table.projects) do
    table.insert(M.items,k)
  end
end

M.create_menu = function()
  local item_list = {}

  for _, v in pairs(M.items) do
    table.insert(item_list,Menu.item(M.first_upperCase(v)))
  end

  local menu_opts = {
    position = "50%",
    size = {
      width = 80,
      height = 10,
    },
    border = {
      padding = {
        top = 2,
        right = 3,
        bottom = 2,
        left = 3,
      },
      style = "rounded",
      text = {
        top = "Create Project for: ",
        top_align = "center",
      },
    },
    buf_options = {
      modifiable = true,
      readonly = false,
    },
    win_options = {
      winblend = 10,
      winhighlight = "Normal:Normal,FloatBorder:FloatNormal",
    },
  }

  -- local input_opts = {
  --   position = {
  --     row = "10%",
  --     col = "50%",
  --   },
  --   size = {
  --     width = 30,
  --     height = 5,
  --   },
  --   border = {
  --     padding = {
  --       top = 2,
  --       right = 3,
  --       bottom = 2,
  --       left = 3,
  --     },
  --     style = "rounded",
  --     text = {
  --       top = " Name of your project: ",
  --       top_align = "center",
  --     },
  --   },
  --   win_options = {
  --     winhighlight = "Normal:Normal,FloatBorder:FloatNormal",
  --   },
  -- }

  local menu = Menu(
    menu_opts,
    {
      lines = item_list,
      max_width = 30,
      on_close = function()
        print("Menu Closed!")
      end,
      -- on_submit = function(item)
      --   if item.text == "Processing" then
      --       local nmenu = Input(input_opts,{ lines ={}, on_close = {}, on_submit = {}})
      --       nmenu:mount()
      --   end
      -- end
  })
  menu:mount()
end

M.create_items()


return M

-- local menu_opts = {
--   position = "50%",
--   size = {
--     width = 80,
--     height = 10,
--   },
--   border = {
--     padding = {
--       top = 2,
--       right = 3,
--       bottom = 2,
--       left = 3,
--     },
--     style = "rounded",
--     text = {
--       top = "Create Project for: ",
--       top_align = "center",
--     },
--   },
--   buf_options = {
--     modifiable = true,
--     readonly = false,
--   },
--   win_options = {
--     winblend = 10,
--     winhighlight = "Normal:Normal,FloatBorder:FloatNormal",
--   },
-- }
-- local input_opts = {
--   position = {
--     row = "10%",
--     col = "50%",
--   },
--   size = {
--     width = 30,
--     height = 5,
--   },
--   border = {
--     padding = {
--       top = 2,
--       right = 3,
--       bottom = 2,
--       left = 3,
--     },
--     style = "rounded",
--     text = {
--       top = " Name of your project: ",
--       top_align = "center",
--     },
--   },
--   win_options = {
--     winhighlight = "Normal:Normal,FloatBorder:FloatNormal",
--   },
-- }
--
-- local menu = Menu(
--   menu_opts,
--  {
--   lines = {
--     Menu.item("Processing"),
--     Menu.item("Cpp"),
--     Menu.item("React"),
--     Menu.item("Other"),
--   },
--   max_width = 30,
--   on_close = function()
--     print("Menu Closed!")
--   end,
--   on_submit = function(item)
--     if item.text == "Processing" then
--         local nmenu = Input(input_opts,{lines ={}, on_close = {}, on_submit = {}})
--         nmenu:mount()
--     end
--   end
-- })
--
-- -- menu:mount()
--
-- local M = {}
--
-- M.setup = function(opts)
--   print("Options: ", opts)
-- end
--
-- M.create = function()
--   -- vim.ui.select({'processing','cpp'},{
--   --   prompt = 'Select a project to create: ',
--   --   format_item = function(item)
--   --     return "I'd like to create a " .. item
--   --   end,
--   -- }, function(choice)
--   --   if choice == 'processing' then
--   --     vim.ui.input({prompt = 'Enter your project name: '}, function(input)
--   --       print(string.format("\n Create project files for processing as: ") .. input)
--   --     end
--   --     )
--   --   else
--   --     print("Create another process")
--   --   end
--   -- end)
-- end
--
-- return M
