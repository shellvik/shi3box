vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>x", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-----------------------------
-- Testing 1 --- Working Backup

-- Normal mode: compile & run
-- Normal mode compile & run (no input redirection)
-- vim.keymap.set(
--   "n",
--   "<F7>",
--   ":w<CR>:!g++ -fsanitize=address -std=c++17 -W -g -O2 -o %< % && ./%<<CR>",
--   { noremap = true, silent = true }
-- )
--
-- -- Insert mode compile & run (no input redirection)
-- vim.keymap.set(
--   "i",
--   "<F7>",
--   "<Esc>:w<CR>:!g++ -fsanitize=address -std=c++17 -W -g -O2 -o %< % && ./%<<CR>",
--   { noremap = true, silent = true }
-- )
--
-- -- Normal mode compile & run with input redirection (from inp.txt)
-- vim.keymap.set(
--   "n",
--   "<F8>",
--   ":w<CR>:!g++ -fsanitize=address -std=c++17 -W -g -O2 -o %:r % && ./%:r < %:p:h/inp.txt<CR>",
--   { noremap = true, silent = true }

--
-- -- Insert mode compile & run with input redirection (from inp.txt)
-- vim.keymap.set(
--   "i",
--   "<F8>",
--   "<Esc>:w<CR>:!g++ -fsanitize=address -std=c++17 -W -g -O2 -o %:r % && ./%:r < %:p:h/inp.txt<CR>",
--   { noremap = true, silent = true }
-- )
--

--------------------------------------
--- This works fine, just have to change terminal according to env

-- F7 = Compile & run (no input redirection, interactive)
vim.keymap.set(
  "n",
  "<F7>",
  ":w<CR>:!g++ -fsanitize=address -std=c++17 -W -g -O2 -o %:r % && ./%:r<CR>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  "i",
  "<F7>",
  "<Esc>:w<CR>:!g++ -fsanitize=address -std=c++17 -W -g -O2 -o %:r % && ./%:r<CR>",
  { noremap = true, silent = true }
)

-- F8 : Compile and run with terminator
local f8_cmd =
  ":w<CR>:!g++ -fsanitize=address -std=c++17 -W -g -O2 -o %:r % && ghostty -e \"./%:r; /bin/bash -c 'read -p Press\\ Enter\\ to\\ close\\ the\\ terminal'\">/dev/null 2>&1<CR>"
keymap.set("n", "<F8>", f8_cmd, { noremap = true, silent = true, desc = "Compile & run in terminal" })
keymap.set("i", "<F8>", "<Esc>" .. f8_cmd, { noremap = true, silent = true, desc = "Compile & run in terminal" })

-- F9 = Compile & run with input redirection (from inp.txt)
vim.keymap.set(
  "n",
  "<F9>",
  ":w<CR>:!g++ -fsanitize=address -std=c++17 -W -g -O2 -o %:r % && ./%:r < %:p:h/inp.txt<CR>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  "i",
  "<F9>",
  "<Esc>:w<CR>:!g++ -fsanitize=address -std=c++17 -W -g -O2 -o %:r % && ./%:r < %:p:h/inp.txt<CR>",
  { noremap = true, silent = true }
)

-- F10 = Just run compiled binary with input redirection form inp.txt
vim.keymap.set("n", "<F10>", ":!./%:r < %:p:h/inp.txt<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<F10>", "<Esc>:!./%:r < %:p:h/inp.txt<CR>", { noremap = true, silent = true })
