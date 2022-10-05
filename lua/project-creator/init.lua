local Menu = require("nui.menu")
local Input = require("nui.input")

local M = {}

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

local input_opts = {
  position = {
    row = "10%",
    col = "50%",
  },
  size = {
    width = 30,
    height = 5,
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
      top = " Name of your project: ",
      top_align = "center",
    },
  },
  win_options = {
    winhighlight = "Normal:Normal,FloatBorder:FloatNormal",
  },
}

M.creation_table = {}

M.setup = function(opts)
  M.creation_table.projects = opts
end

M.setup({
  processing = {
    workspace = "~/dev/projects/processing",
    cmd = "mkdir",
    structure = {
    }
  },
  cpp_sfml = {
    workspace = "~/dev/projects/cpp",
    cmd = "mkdir -p",
    structure = {
      src = {"main.cpp"},
    }
  },
})

local first_upperCase = function(s)
  return (s:sub(1,1):upper() .. s:sub(2,string.len(s)))
end

local get_structure = function (project_config)
  for k, _ in pairs(M.creation_table.projects) do
    if k == project_config then
      return M.creation_table.projects[project_config].structure
    end
  end
  return nil
end

local create_files = function(folder)
  for _, file in ipairs(folder) do
    vim.api.nvim_command(":! touch " .. file)
  end
  vim.api.nvim_command(":cd .. ")
end

local create_paths = function(project_table, project_name)
  local structure = project_table.structure
  local path = project_table.workspace .. "/" .. project_name

  vim.api.nvim_command(":! " .. project_table.cmd .. " " .. path)
  vim.api.nvim_command(":! cd " .. path )

  for k, v in pairs(structure) do
    vim.api.nvim_command(":! " .. project_table.cmd .. " " .. path .. "/" .. k)
    vim.api.nvim_command(":cd " .. path .. "/" .. k)
    -- vim.api.nvim_command(":! cd " .. k )
    create_files(structure[k])
  end
end


local items = {}

local create_items = function()
  for k, _ in pairs(M.creation_table.projects) do
    table.insert(items,k)
  end
end

local on_submit_menu = function(item)

  local type = ""

  for k,_ in pairs(M.creation_table.projects) do

    if item.text == first_upperCase(k) then
      type = first_upperCase(k)
    end

  end

  if item.text == type then

    local nmenu = Input(input_opts,
    {
        lines ={},
        on_submit =
          function(project_name)
            local project_table = M.creation_table.projects[string.lower(type)]
            local path = project_table.workspace .. "/" .. project_name
            create_paths(project_table,project_name)
            -- vim.api.nvim_command(":! " .. project_table.cmd .. " " .. path)
            -- vim.api.nvim_command(":! cd " .. path .. " && touch " .. project_name .. ".pde" )
          end
    })
    nmenu:mount()

  end
end

M.create_menu = function()
  local item_list = {}

  for _, v in pairs(items) do
    table.insert(item_list,Menu.item(first_upperCase(v)))
  end

  local menu = Menu(
    menu_opts,
    {
      lines = item_list,
      max_width = 30,
      on_close = function()
        print("Menu Closed!")
      end,
      on_submit = on_submit_menu
  })
  menu:mount()
end


create_items()


return M

