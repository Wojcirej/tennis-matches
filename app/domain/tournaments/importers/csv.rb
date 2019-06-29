module Tournaments
  module Importers
    class Csv

      def initialize(file)
        @file = file
      end

      def self.call(file)
        new(file).call
      end

      def call
        data = CSV.read(file.path, headers: true).map { |row| Tournament.new(row.to_h) }
        Tournament.import(data)
      end

      private
      attr_reader :file
    end
  end
end
