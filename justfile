set shell := ["bash", "-cu"]

uv := "env -u VIRTUAL_ENV uv"

default:
    just --list

install:
    ( cd ptyx; uv tool install --editable . )
    ( cd ptyx-mcq; uv tool install --editable . )  
    ( cd ptyx-mcq-editor; uv tool install --editable . )
    ( cd ptyx-mcq-corrector; uv tool install --editable . )
        
clone:
    git clone git@github.com:wxgeo/ptyx.git
    git clone git@github.com:wxgeo/ptyx-mcq.git
    git clone git@github.com:wxgeo/ptyx-mcq-editor.git
    git clone git@github.com:wxgeo/ptyx-mcq-corrector.git

status:
    @echo -e "\n\e[1;97;44m ptyx-workplace \e[0m"
    @git status
    @echo -e "\n\e[1;97;44m ptyx \e[0m"
    @( cd ptyx; git status )
    @echo -e "\n\e[1;97;44m ptyx-mcq \e[0m"
    @( cd ptyx-mcq; git status )
    @echo -e "\n\e[1;97;44m ptyx-mcq-editor \e[0m"
    @( cd ptyx-mcq-editor; git status )
    @echo -e "\n\e[1;97;44m ptyx-mcq-corrector \e[0m"
    @( cd ptyx-mcq-corrector; git status )

lock:
    git commit uv.lock -m "dev: update uv.lock"

