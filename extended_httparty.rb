# Reference : https://github.com/mdoyle13/httparty-retry

# Extended HTTParty
# A Wrapper class to control the HTTParty calls, allowing retry capabilities

module ExtendedHttparty
  include HTTParty

  DEFAULT_TRIES = 3
  SLEEP_DURATION = 3

  def self.included(base)
    HTTParty.included(base)
  end

  def self.perform_request(http_method, path, options, &block)
    options.reverse_merge!(:tries => DEFAULT_TRIES, :raise_errors => false)
    tries ||= options[:tries]
    result =  super
  rescue => e
    sleep SLEEP_DURATION
    if (tries -= 1) > 0
      retry
    else
      log_message("Unable to connect to the api. #{e}")
      return nil unless options[:raise_errors]
      raise "Can't connect to the API, #{e}"
    end
  else
    if result.code == 200
      result
    else
      if (tries -= 1) > 0
        sleep SLEEP_DURATION
        perform_request(http_method, path, :tries => tries, :query => options[:query], &block)
      else
        log_message("Request failed with status #{result.code}")
        return nil unless options[:raise_errors]
        raise "API responded with non 200, #{result.code}"
      end
    end
  end


  def self.log_message(message)
    log_options = {
      title: 'HTTParty Request failed.',
      message: "#{self.class.name} #{message}",
    }
    # TODO: Log it somewhere ...
  end
end
