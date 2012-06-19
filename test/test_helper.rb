require [File.expand_path('../../../../test/test_helper.rb', __FILE__),
         File.expand_path('../../../../../test/test_helper.rb', __FILE__)].find{|file|puts file;File.exists?(file)}
