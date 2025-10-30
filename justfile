set shell := ["bash", "-cu"]

uv := "env -u VIRTUAL_ENV uv"

default:
    just --list
    
    
clone:
    git clone git@github.com:wxgeo/ptyx.git
    git clone git@github.com:wxgeo/ptyx-mcq.git
    git clone git@github.com:wxgeo/ptyx-mcq-editor.git
    git clone git@github.com:wxgeo/ptyx-mcq-corrector.git
