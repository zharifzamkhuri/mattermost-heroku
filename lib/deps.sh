# Sourced by bin/compile

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

get_platform() {
  ARCH=$(uname -m|tr A-Z a-z)

  if test $ARCH = x86_64
  then ARCH=amd64
  fi

  echo "$(uname|tr A-Z a-z)-$ARCH"
}

install_nodejs() {
  NODE_VERSION="v6.2.1"
  NODE_DOWNLOAD_URL="http://s3pository.heroku.com/node/$NODE_VERSION/node-$NODE_VERSION-$OS-$CPU.tar.gz"
  curl "$NODE_DOWNLOAD_URL" --silent --fail -o /tmp/node.tar.gz || (step "Unable to download node $NODE_VERSION; does it exist?" && false)
  tar xzf /tmp/node.tar.gz -C /tmp
  rm -rf $NODE_BUILD_DIR/*
  mv /tmp/node-$NODE_VERSION-$OS-$CPU/* $NODE_BUILD_DIR
  chmod +x $NODE_BUILD_DIR/bin/*
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
    GOVERSION=go1.6.1
    GOFILENAME=${GOFILE:-$GOVERSION.$(uname|tr A-Z a-z)-amd64$(platext $GOVERSION).tar.gz}
    GODOWNLOADURL=${GOURL:-$(urlfor $GOVERSION $GOFILENAME)}
    
    export GOROOT=$CACHE_DIR/$GOVERSION/go
    export GOPATH=$BUILD_DIR/.heroku/go
    export PATH=$GOROOT/bin:$PATH

    if test -d $CACHE_DIR/$GOVERSION/go
    then
        echo "Using cached version: $GOVERSION"
    else
        rm -rf $CACHE_DIR/* # be sure not to build up cruft
        mkdir -p $CACHE_DIR/$GOVERSION
        cd $CACHE_DIR/$GOVERSION
        echo "Installing $GOVERSION"
            curl -sO $GODOWNLOADURL
            tar zxf $GOFILENAME
            rm -f $GOFILENAME
        cd - >/dev/null
        go get github.com/tools/godep
    fi
}
