  require 'csv'

CSV_ACCOUNTS_DIR = '/Users/ihower/g0v/GovCash/accounts'
CSV_ACCOUNTS_FILE = '/Users/ihower/g0v/sunshine.cy.gov.tw/list.csv'

task :build => [:import_transactions, :import_accounts, :normalize, :calculate]

# https://github.com/ronnywang/GovCash/tree/master/accounts
task :import_transactions => :environment do
  RawTransaction.delete_all

  Dir.glob("#{CSV_ACCOUNTS_DIR}/*.csv").each do |file_name|
    CSV.foreach(file_name, :headers => true) do |row|
      RawTransaction.create(
        :account_name => File.basename(file_name).gsub(".csv",""),
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
  Politician.delete_all
  Account.delete_all
  Donator.delete_all
  Code.delete_all
  Transaction.delete_all

  RawAccount.find_each do |ra|
    p = Politician.find_or_create_by( :name => ra.politician_name )
    a = Account.find_or_create_by( :name => ra.account_name, :politician_id => p.id )
  end

  RawTransaction.find_each do |t|
    account = Account.find_or_create_by( :name => t.account_name )
    donator = Donator.find_or_create_by( :name => t.donator, :identification => t.identification )
    code = Code.find_or_create_by( :name => t.code )

    if t.income.present?
      transaction_type = "income"
      amount = t.income
    else
      transaction_type = "payout"
      amount = t.payout
    end

    Transaction.create( :transaction_type => transaction_type,
                        :date => t.date,
                        :account => account,
                        :politician => account.politician,
                        :donator => donator,
                        :code => code,
                        :amount => amount,
                        :is_money => (t.is_money == "是"),
                        :address => t.address,
                        :page => t.page,
                        :row => t.row
                      )
  end
end

task :calculate => :environment do
  Account.find_each do |a|
    a.transactions_count = a.transactions.count
    a.income_amount = a.transactions.income.sum(:amount)
    a.payout_amount = a.transactions.payout.sum(:amount)
    a.save
  end

  Politician.find_each do |p|
    p.transactions_count = p.accounts.map{ |a| a.transactions_count }.sum
    p.income_amount = p.accounts.map{ |a| a.income_amount }.sum
    p.payout_amount = p.accounts.map{ |a| a.payout_amount }.sum
    p.save
  end

  Donator.find_each do |d|
    d.transactions_count = d.transactions.count
    d.income_amount = d.transactions.income.sum(:amount)
    d.payout_amount = d.transactions.payout.sum(:amount)
    d.save
  end
end
