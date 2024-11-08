local M = {}

function M.flutter_commands()
  local commands = require "flutter-tools.commands"

  if commands.is_running() then
    cmds = {
      {
        id = "flutter-tools-hot-reload",
        label = "Flutter tools: Hot reload",
        hint = "Reload a running flutter project",
        command = commands.reload,
      },
      {
        id = "flutter-tools-hot-restart",
        label = "Flutter tools: Hot restart",
        hint = "Restart a running flutter project",
        command = commands.restart,
      },
      {
        id = "flutter-tools-visual-debug",
        label = "Flutter tools: Visual Debug",
        hint = "Add the visual debugging overlay",
        command = commands.visual_debug,
      },
      {
        id = "flutter-tools-quit",
        label = "Flutter tools: Quit",
        hint = "Quit running flutter project",
        command = commands.quit,
      },
      {
        id = "flutter-tools-detach",
        label = "Flutter tools: Detach",
        hint = "Quit running flutter project but leave the process running",
        command = commands.detach,
      },
      {
        id = "flutter-tools-widget-inspector",
        label = "Flutter tools: Widget Inspector",
        hint = "Toggle the widget inspector",
        command = commands.widget_inspector,
      },
      {
        id = "flutter-tools-construction-lines",
        label = "Flutter tools: Construction Lines",
        hint = "Display construction lines",
        command = commands.construction_lines,
      },
    }
  else
    cmds = {
      {
        id = "flutter-tools-run",
        label = "Flutter tools: Run",
        hint = "Start a flutter project",
        command = commands.run,
      },
    }
  end

  vim.list_extend(cmds, {
    {
      id = "flutter-tools-pub-get",
      label = "Flutter tools: Pub get",
      hint = "Run pub get in the project directory",
      command = commands.pub_get,
    },
    {
      id = "flutter-tools-pub-upgrade",
      label = "Flutter tools: Pub upgrade",
      hint = "Run pub upgrade in the project directory",
      command = commands.pub_upgrade,
    },
    {
      id = "flutter-tools-list-devices",
      label = "Flutter tools: List Devices",
      hint = "Show the available physical devices",
      command = require("flutter-tools.devices").list_devices,
    },
    {
      id = "flutter-tools-list-emulators",
      label = "Flutter tools: List Emulators",
      hint = "Show the available emulator devices",
      command = require("flutter-tools.devices").list_emulators,
    },
    {
      id = "flutter-tools-open-outline",
      label = "Flutter tools: Open Outline",
      hint = "Show the current files widget tree",
      command = require("flutter-tools.outline").open,
    },
    {
      id = "flutter-tools-generate",
      label = "Flutter tools: Generate ",
      hint = "Generate code",
      command = commands.generate,
    },
    {
      id = "flutter-tools-clear-dev-log",
      label = "Flutter tools: Clear Dev Log",
      hint = "Clear previous logs in the output buffer",
      command = require("flutter-tools.log").clear,
    },
  })

  local names = {}

  for _, value in pairs(cmds) do
    table.insert(names, value.label)
  end

  require("fzf-lua").fzf_exec(names, {
    actions = {
      ["default"] = function(selected, opts)
        for _, value in pairs(cmds) do
          if value.label == selected[1] then value.command() end
        end
      end,
      ["ctrl-y"] = function(selected, opts)
        for _, value in pairs(cmds) do
          if value.label == selected[1] then value.command() end
        end
      end,
    },
  })
end

return M
