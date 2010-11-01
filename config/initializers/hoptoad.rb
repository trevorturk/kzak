HoptoadNotifier.configure do |config|
  config.api_key = CONFIG['HOPTOAD_API_KEY']
  config.ignore_only = []
end if CONFIG['HOPTOAD_API_KEY']