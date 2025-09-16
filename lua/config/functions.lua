P = function(o)
	vim.print(vim.inspect(o))
end

DirExists = function(path)
  local stat = vim.uv.fs_stat(path)
  return stat and stat.type == "directory"
end
