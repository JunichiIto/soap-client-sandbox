require 'savon'

class RumbasClient
  WSDL_URL = "https://localhost:3443/rumbas/wsdl"
  CERT_DIR = File.join(Rails.root, 'ssl')
  def self.test
    # http://stackoverflow.com/questions/15973285/does-savon-support-client-side-certificates-authentication
    savonConfig = {
        :wsdl => WSDL_URL,
        :log_level => :debug,
        :log => true,
        :ssl_verify_mode => :none,
        :ssl_cert_file => File.join(CERT_DIR, 'newcert.pem'),
        :ssl_cert_key_file => File.join(CERT_DIR, 'newkey.pem'),
        :ssl_cert_key_password => ssl_cert_key_password,
        :open_timeout => 600,
        :read_timeout => 600
    }

    client = Savon::Client.new(savonConfig)

    client.operations # => [:integer_to_string, :concat, :add_circle]

    result = client.call(:concat, message: { :a => "123", :b => "abc" })

    # actual wash_out
    result.to_hash # => {:concat_reponse => {:value=>"123abc"}}

    # wash_out below 0.3.0 (and this is malformed response so please update)
    result.to_hash # => {:value=>"123abc"}
  end

  # http://keep-up-with-tech.blogspot.jp/2013/03/ruby.html
  def self.ssl_cert_key_password
    data = Settings.crypted_pass
    key = Settings.key
    iv = Settings.iv

    text = Base64::strict_decode64(data)
    decrypt(text, key, iv)
  end

  def self.decrypt(data, key, iv)
    cipher = OpenSSL::Cipher.new('aes-128-cbc')
    cipher.decrypt
    cipher.key = key
    cipher.iv = iv
    cipher.update(data) + cipher.final
  end
end