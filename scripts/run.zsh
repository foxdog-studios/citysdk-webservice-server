#!/usr/bin/env zsh

setopt err_exit
cd ${0:h}/..

bundle exec rerun 'rackup --port 9295 --server thin'

