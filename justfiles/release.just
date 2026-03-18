doc project:
    @cd {{project}} && {{uv}} run make -C doc autodoc
    @cd {{project}} && {{uv}} run make -C doc html

_check-clean project:
    @cd {{project}} && git diff --exit-code || (echo "Uncommitted changes in {{project}}!" && exit 1)
    @cd {{project}} && git diff --cached --exit-code || (echo "Staged changes in {{project}}!" && exit 1)

_check-branch project branch="main":
    @cd {{project}} && git rev-parse --abbrev-ref HEAD | grep -qx {{branch}} || (echo "{{project}} is not on {{branch}} branch!" && exit 1)

build project: (_check-clean project) (_check-branch project)
    rm -rf dist/
    uv build --package {{project}}

release project: (_check-clean project) (_check-branch project) (test project) (doc project) (build project)
    uv publish