def success(message)
  puts "\033[32m#{message}\033[0m"
end

def failure(message)
  puts "\033[31m#{message}\033[0m"
  exit -1
end

