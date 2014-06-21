CASH_FILE = '/Users/ihower/g0v/GovCash/data/govcash.csv'
CASH_COLUMNS = %w[no page row txn_dt txn_code user_nm identification receive_money pay_money cash_ind area correct_rate correct_rate_imp file account position term]


task :import => :environment do
  require 'csv'
  RawCash.delete_all

  CSV.foreach(CASH_FILE) do |row|
    h = Hash[ CASH_COLUMNS.each_with_index.map{|x,i| [x, row[i]] } ]
    RawCash.create!(h)
  end

end
