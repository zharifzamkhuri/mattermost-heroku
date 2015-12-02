get_os() {
  uname | tr A-Z a-z
}

get_cpu() {
  if [[ "$(uname -p)" = "i686" ]]; then
    echo "x86"
  else
    echo "x64"
  fi
}

os=$(get_os)
cpu=$(get_cpu)

install_nodejs() {
  local dir="$1"

  echo "Downloading and installing node 5.1.0..."
  local download_url="http://s3pository.heroku.com/node/v5.1.0/node-v5.1.0-$os-$cpu.tar.gz"
  curl "$download_url" --silent --fail -o /tmp/node.tar.gz || (echo "Unable to download node $version; does it exist?" && false)
  tar xzf /tmp/node.tar.gz -C /tmp
  rm -rf $dir/*
  mv /tmp/node-v5.1.0-$os-$cpu/* $dir
  chmod +x $dir/bin/*
}

platext() {
    case $1 in
    go1.0*|go1.1beta*|go1.1rc*|go1.1|go1.1.*) return ;;
    esac
    case $(uname|tr A-Z a-z) in
    darwin) printf %s -osx10.8 ;;
    esac
}

urlfor() {
    ver=$1
    file=$2
    case $ver in
    go1.0*|go1.1beta*|go1.1rc*|go1.1|go1.1.*|go1.2beta*|go1.2rc*|go1.2|go1.2.1)
        echo http://go.googlecode.com/files/$file
        ;;
    *)
        echo https://storage.googleapis.com/golang/$file
        ;;
    esac
}

install_go() {
    ver=$1
    cache=$2

    file=${GOFILE:-$ver.$(uname|tr A-Z a-z)-amd64$(platext $ver).tar.gz}
    url=${GOURL:-$(urlfor $ver $file)}

    if test -d $cache/$ver/go
    then
        step "Using $ver"
    else
        rm -rf $cache/* # be sure not to build up cruft
        mkdir -p $cache/$ver
        cd $cache/$ver
        start "Installing $ver"
            curl -sO $url
            tar zxf $file
            rm -f $file
        finished
        cd - >/dev/null
    fi
}

install_compass() {
  rubydir=$1

  if test -e $rubydir/bin/compass
  then
      step "using compass 1.0.3"
  else
      rm -rf $rubydir/*
      # Install compass gem
      gem install --install-dir $rubydir -v 1.0.3 compass
  fi
}
