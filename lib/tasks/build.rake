  require 'csv'

CSV_ACCOUNTS_DIR = '/Users/ihower/g0v/GovCash/accounts'
CSV_ACCOUNTS_FILE = '/Users/ihower/g0v/sunshine.cy.gov.tw/list.csv'

task :build => [:import_transactions, :import_accounts, :normalize]

# https://github.com/ronnywang/GovCash/tree/master/accounts
task :import_transactions => :environment do
  RawTransaction.delete_all

  Dir.glob("#{CSV_ACCOUNTS_DIR}/*.csv").each do |file_name|
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

# https://github.com/ronnywang/sunshine.cy.gov.tw/blob/master/list.csv
task :import_accounts => :environment do
  RawAccount.delete_all

  CSV.foreach(CSV_ACCOUNTS_FILE, :headers => true) do |row|
    begin
    RawAccount.create(
      :politician_name => row[0],
      :account_name => row[1],
      :bank_name => row[2],
      :bank_account => row[3],
      :bank_address => row[4],
      :date1 => row[5],
      :date2 => row[6],
    )
    rescue
      puts "Save failed: #{row}"
    end
  end

end

task :normalize => :environment do
  RawAccount.find_each do |p|

  end

  RawTransaction.find_each do |t|
  end
end
