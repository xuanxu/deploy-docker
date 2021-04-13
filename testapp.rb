require 'sinatra/base'
require 'open3'

class TestApp < Sinatra::Base
  post '/run' do
    command = "docker run --rm --volume $PWD/paper:/data --user $(id -u):$(id -g) --env JOURNAL=joss openjournals/paperdraft"
    result, stderr, status = Open3.capture3("docker run")
    status.success? ? result : "Docker failed to run: #{stderr}"
  end

  get '/status' do
    "Up and running!"
  end

  post '/docker' do
    result, stderr, status = Open3.capture3("docker --version")
    status.success? ? result : "Docker version unknown: #{stderr}"
  end
end