CSV_DATA_DIR = '/Users/ihower/g0v/GovCash/accounts'

task :import => :environment do
  require 'csv'
  RawTransaction.delete_all

  Dir.glob("#{CSV_DATA_DIR}/*.csv").each do |file_name|
    CSV.foreach(file_name, :headers => true) do |row|
      RawTransaction.create(
        :account_name => File.basename(file_name),
        :date => row[0],
        :code => row[1],
        :donator => row[2],
        :identification => row[3],
        :income => row[4],
        :payout => row[5],
        :is_money => row[6],
        :address => row[7],
        :page => row[8],
        :row => row[9]
      )
    end

  end
end
