module Beholder

  class Config
    include StoreData

    def initialize
      @file = "#{Dir.pwd}/data/config.yml"
      temp = load_file(@file)
      @config = temp if temp.is_a?(Hash) && !temp.empty?
      setup_config if @config.nil?
      create_methods
    end

    private

    def setup_config
      @config = {}

      @config[:discord_token] = 'MjQ5NzIyNjkxOTI4NDU3MjE3.C5BTCg.Ogc2tSHE9hjFGTZde0n9-UKmmGo'

      @config[:discord_client_id] = 249722691928457217

      @config[:owner_id] = 216213016172036096

      @config[:prefix] = ';'

      @config[:permissions_code] = 2110221431
      save
    end

    def create_methods
      @config.keys.each do |key|
        self.class.send(:define_method, key) do
          @config[key]
        end
      end
    end

    def save
      save_to_file(@file, @config)
    end
  end
end