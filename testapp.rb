require 'sinatra/base'
require 'open3'

class TestApp < Sinatra::Base
  get '/run' do
    command = "docker run --rm --volume $PWD/paper:/data --user $(id -u):$(id -g) --env JOURNAL=joss openjournals/paperdraft"
    result, stderr, status = Open3.capture3(command)
    status.success? ? result : "Docker failed to run: #{stderr}"
  end

  get '/docker' do
    result, stderr, status = Open3.capture3("docker --version")
    status.success? ? result : "Docker version unknown: #{stderr}"
  end

  get '/status' do
    "Up and running!"
  end

  get '/' do
    "Welcome"
  end
end
