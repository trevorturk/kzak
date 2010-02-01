HoptoadNotifier.configure do |config|
  config.api_key = CONFIG['hoptoad_key']
  config.ignore_only = []
end if CONFIG['hoptoad_key']