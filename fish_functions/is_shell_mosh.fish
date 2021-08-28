function is_shell_mosh
string match -eq mosh (pstree -s $fish_pid)
end
