module ReadCache
  class << self
    def redis
      @redis ||= Redis.new(host: 'localhost', port: 6379)
    end
  end
end
