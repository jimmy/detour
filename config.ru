require 'rubygems'
$LOAD_PATH.unshift("vendor/jimmy-rack-offline/lib")


require 'sinatra/base'
require 'rack/offline'
require 'app'

map '/cache.manifest' do
  run Detour::Offline.configure
end

map '/' do
  run Detour::Application
end

