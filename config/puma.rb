# Configure “min” to be the minimum number of threads to use to answer requests and “max” the maximum. The default is “0, 16”.
threads 0, 16

# === Cluster mode ===
# How many worker processes to run. The default is “0”.
workers 4
preload_app!

# Code to run when a worker boots to setup the process before booting the app. This can be called multiple times to add hooks.

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
