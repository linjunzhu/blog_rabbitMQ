class Publisher

  def self.publish(exchange, message = {})
    # grab the fanout exchange
    x = channel.fanout("blog.#{exchange}")
    # and simply publish message
    x.publish(message.to_json)
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.connection
    @connection ||= Bunny.new.tap do
      |c| c.start
    end
  end
end