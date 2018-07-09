" Find imported path
setlocal path=.,node_nodules,app/assets/webpack
setlocal suffixesadd=.js,.jsx,.scss

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
