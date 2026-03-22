doc project:
    @cd {{project}} && {{uv}} run make -C doc html || true

_check-clean project:
    @cd {{project}} && git diff --exit-code || (echo -e "\e[1;97;43m[Warning]\e[0m Uncommitted changes in {{project}}! " && exit 1)
    @cd {{project}} && git diff --cached --exit-code || (echo -e "\e[1;97;43m[Warning]\e[0m Staged changes in {{project}}! " && exit 1)

_check-branch project branch="main":
    @cd {{project}} && git rev-parse --abbrev-ref HEAD | grep -qx {{branch}} || (echo "\e[1;97;43m[Warning]\e[0m {{project}} is not on {{branch}} branch!" && exit 1)

release project: (_check-clean project) (_check-branch project) (test project) (doc project)
    rm -rf dist/
    @cd {{project}} && {{uv}} run semantic-release version
    uv publish