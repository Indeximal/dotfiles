function fish_prompt
    set -l __last_command_exit_status $status

    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    set -l arrow_color "$green"
    if test $__last_command_exit_status != 0
        set arrow_color "$red"
    end

    set -l arrow "$arrow_color ➜ "
    if fish_is_root_user
        set arrow "$arrow_color # "
    end

    set -l cwd $cyan(basename (prompt_pwd))

    set -l repo_info $normal(fish_git_prompt)

    set -l hostinfo $green(hostname)" "
    if string match -eq mosh (pstree -s $fish_pid)
        set hostinfo $yellow(hostname)" "
    end

    echo -n -s $hostinfo $cwd $repo_info $arrow $normal
end
