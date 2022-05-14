-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback


-- setup with all defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
nvim_tree.setup {
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = true,
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha"
  },
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}

vim.g["nvim_tree_git_hl"] = 1
vim.g["nvim_tree_root_folder_modifier"] = ":t"



-- <CR> or o on the root folder will cd in the above directory (目录)
-- <C-]> will cd in the directory (目录) under the cursor (光标)
-- <BS> will close current opened directory (目录) or parent
-- type a to add a file. Adding a directory (目录) requires leaving a leading / at the end of the path.
-- you can add multiple directories (目录) by doing foo (foo) /bar/baz/f and it will add foo bar and baz directories and f as a file
--
-- type r to rename (重命名) a file
-- type <C-r> to rename (重命名) a file and omit the filename on input
-- type x to add/remove file/directory to cut clipboard (剪贴板)
-- type c to add/remove file/directory to copy clipboard (剪贴板)
-- type y will copy name to system clipboard (剪贴板)
-- type Y will copy relative path to system clipboard (剪贴板)
-- type gy will copy absolute path to system clipboard (剪贴板)
-- type p to paste from clipboard (剪贴板) . Cut clipboard has precedence (优先) over copy (will prompt for confirmation)
-- type d to delete (删除) a file (will prompt for confirmation)
-- type D to trash a file ( configured (配置) in setup())
-- type ]c to go to next git (git) item
-- type [c to go to prev git (git) item
-- type - to navigate up to the parent directory (目录) of the current file/directory
-- type s to open a file with default system application or a folder with default file manager (if you want to change the command used to do it see :h nvim-tree.setup under system_open)
-- if the file is a directory (目录) , <CR> will open the directory (目录) otherwise it will open the file in the buffer (缓冲区) near the tree
-- if the file is a symlink, <CR> will follow the symlink (if the target is a file)
-- <C-v> will open the file in a vertical split
-- <C-x> will open the file in a horizontal split
-- <C-t> will open the file in a new tab
-- <Tab> will open the file as a preview (keeps the cursor (光标) in the tree)
-- I will toggle (切换) visibility of hidden folders / files
-- H will toggle (切换) visibility of dotfiles (files/folders starting with a .)
-- R will refresh (刷新) the tree
-- Double left click acts like <CR>
-- Double right click acts like <C-]>
-- W will collapse the whole tree
-- S will prompt the user to enter a path and then expands the tree to match the path
-- . will enter vim (Vim) command mode with the file the cursor (光标) is on
-- C-k will toggle (切换) a popup with file infos about the file under the cursor (光标)
