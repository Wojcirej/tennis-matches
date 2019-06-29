module Players
  module Importers
    class Csv

      def initialize(file)
        @file = file
      end

      def self.call(file)
        new(file).call
      end

      def call
        data = CSV.read(file.path, headers: true).map { |row| Player.new(row.to_h) }
        Player.import(data)
      end

      private
      attr_reader :file
    end
  end
end
