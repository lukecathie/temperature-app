worker_processes 1
timeout 30

@app_path = '/home/pi/apps/temp'
listen "#{@app_path}/tmp/sockets/unicorn.sock", :backlog => 64
pid "#{@app_path}/tmp/pids/unicorn.pid"
