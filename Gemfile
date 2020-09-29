# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in rotas.gemspec
gemspec

# XXX see https://github.com/mat813/rb-kqueue/pull/12
if RbConfig::CONFIG["target_os"] =~ /(?i-mx:freebsd)/
  gem "rb-kqueue",
      git: "https://github.com/stevebob/rb-kqueue.git",
      ref: "144ee7bb7963c77fc219ba736df7ee952d50ab19"
end
