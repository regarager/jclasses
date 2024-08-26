if exists("g:loaded_jclasses")
    finish
endif

let g:loaded_jclasses = 1

command! -nargs=0 JClassesTest lua require("jclasses").test()
