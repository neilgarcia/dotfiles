" Find imported path
setlocal path=.,src,node_nodules,app/client
setlocal suffixesadd=.js,.jsx,.scss
setlocal tags=./jstags/tags;

function! LoadMainNodeModule(fname)
    let nodeModules = "./node_modules/"
    let packageJsonPath = nodeModules . a:fname . "/package.json"

    if filereadable(packageJsonPath)
        return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
    else
        return nodeModules . a:fname
    endif
endfunction

setlocal includeexpr=LoadMainNodeModule(v:fname)
