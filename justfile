set shell := ["bash", "-cu"]

uv := "env -u VIRTUAL_ENV uv"

projects := "ptyx ptyx-mcq ptyx-mcq-corrector ptyx-mcq-editor"


default:
    just --list
    
    
sync:
   {{uv}} run sync
   
doc project:
    @cd {{project}} && {{uv}} run make -C doc autodoc
    @cd {{project}} && {{uv}} run make -C doc html

ruff project:
    @cd {{project}} && {{uv}} run ruff check {{replace(project, "-", "_")}} tests

mypy project: 
    @cd {{project}} && {{uv}} run mypy {{replace(project, "-", "_")}} tests

pytest project:
    @cd {{project}} && {{uv}} run pytest -n auto tests
    
test project: (ruff project) (mypy project) (pytest project)

test-all:
    for p in {{projects}}; do just test $p; done

push project:
    @cd {{project}} && git push
    @cd {{project}} && git push --tags    

_check-clean project:
    @cd {{project}} && git diff --exit-code || (echo "Uncommitted changes in {{project}}!" && exit 1)
    @cd {{project}} && git diff --cached --exit-code || (echo "Staged changes in {{project}}!" && exit 1)

_check-branch project branch="main":
    @cd {{project}} && git rev-parse --abbrev-ref HEAD | grep -qx {{branch}} || (echo "{{project}} is not on {{branch}} branch!" && exit 1)

_build project: (_check-clean project) (_check-branch project)
    rm -rf dist/
    uv build --package {{project}}

release project: (_check-clean project) (_check-branch project) (test project) (_update-version project) (_publish project)
    uv publish

fix project:
    @cd {{project}} && {{uv}} run black .
    @cd {{project}} && {{uv}} run ruff check --fix {{project}} tests
    
lock:
    git commit uv.lock -m "dev: update uv.lock"

install:
    ( cd ptyx; uv tool install --editable . )
    ( cd ptyx-mcq; uv tool install --editable . )  
    ( cd ptyx-mcq-editor; uv tool install  --with-executables-from ruff --editable . )
    ( cd ptyx-mcq-corrector; uv tool install --editable . )

full-install: install
    mcq install shell-completion
    mcq-editor --install-shortcuts
        
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

