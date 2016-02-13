#!/usr/bin/env bash

test_description='Test the shell'
source "$(dirname "$0")"/setup-05.sh

test_expect_success 'Test version and help' '
    run_shell_commands version | grep "pw: a simple password manager" &&
    run_shell_commands v | grep "pw: a simple password manager" &&
    run_shell_commands help | grep "Commands and their options are listed below."
'

test_expect_success 'Test ls' '
    run_shell_commands ls &&
    run_shell_commands "ls test2" | grep "test2/test3" &&
    [[ $(run_shell_commands "ls test1") == $PASS1 ]] &&
    [[ $(run_shell_commands "ls test2/test4") == $PASS2 ]]
'

test_expect_success 'Test ls -t' '
    cat <<-"_EOF" > ls-tree-1.txt &&
|-- test1
|-- test2
|   |-- test3
|   |-- test4
|   `-- test5
|-- test6
`-- test7
_EOF
    run_shell_commands "ls -t" | remove_special_chars > ls-tree-2.txt &&
    test_cmp ls-tree-1.txt ls-tree-2.txt
'

test_expect_success 'Test show' '
    [[ $(run_shell_commands "show test1") == $PASS1 ]] &&
    [[ $(run_shell_commands "show test2/test4") == $PASS2 ]]
'

test_done
