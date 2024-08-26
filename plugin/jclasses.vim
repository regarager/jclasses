if exists("g:loaded_jclasses")
    finish
endif

let g:loaded_jclasses = 1

command! -nargs=0 JCTest lua require("jclasses").test()
command! -nargs=0 JCNew lua require("jclasses").new_class()
