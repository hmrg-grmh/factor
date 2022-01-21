# podman_app_def () { n="${1:-pypy}" && nn="${2:-${n}}" && bash -rc "$n"' () { c_name="${1:-oncerun_$(date +%s%N)}" && podman run `case $# in 0) echo -ti ;; *) ;; esac` --rm --name pdmrun_'"'$n'"'_"$c_name" -v "$PWD":/usr/src/"$c_name" -w /usr/src/"$c_name" '"'$nn'"' '"'$n'"' "$@" ; } && declare -f -- '"$n" ; }

podman_app_def ()
{
    n="${1:-pypy}" &&
    nn="${2:-${n}}" &&
    bash -rc "$n"' ()
    {
        c_name="${1:-oncerun_$(date +sec%sdot%N)}" &&
        podman run `case $# in 0) echo -ti ;; *) ;; esac
        ` --rm --name pdmrun_'"'$n'"'_"$c_name" -v "$PWD":/usr/src/"$c_name" -w /usr/src/"$c_name" '"'$nn'"' '"'$n'"' "$@" ;
    } &&
    declare -f -- '"$n" ;
} ;

# usage:

## podman_app_def pypy pypy:slim > src
## source src ; pypy --version

# need: Podman

