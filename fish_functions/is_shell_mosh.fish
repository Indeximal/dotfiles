function is_shell_mosh
string match -eq mosh (pstree -s $fsh_pid)
end
