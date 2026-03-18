
clone-all:
    git clone git@github.com:wxgeo/ptyx.git
    git clone git@github.com:wxgeo/ptyx-mcq.git
    git clone git@github.com:wxgeo/ptyx-mcq-editor.git
    git clone git@github.com:wxgeo/ptyx-mcq-corrector.git


push project:
    @cd {{project}} && git push
    @cd {{project}} && git push --tags

push-all:
    just push .
    for p in {{projects}}; do just push $p; done

_status dir:
    @output=$(cd "{{dir}}" && git -c color.status=always status -s); \
     if [ -z "$output" ]; then echo -e "\n\e[1;97;44m {{dir}} \e[0m \e[32m✔\e[0m"; \
     else echo -e "\n\e[1;97;44m {{dir}} \e[0m\n$output"; fi
     
all:
    @just _status .
    @just _status ptyx
    @just _status ptyx-mcq
    @just _status ptyx-mcq-editor
    @just _status ptyx-mcq-corrector

git-lock:
    git commit uv.lock -m "dev: update uv.lock"
