module Helpers
  def get_rows_from_csv(filename)
    gem_root = File.expand_path("../..", __FILE__)
    csv_text = File.read("#{gem_root}/lib/tables/#{filename}")
    csv_headers = CSV.parse(csv_text, headers: true).headers
    
    keys = csv_headers
    csv = CSV.parse(csv_text, headers: false).map { |a| Hash[ keys.zip(a) ] }

    # convert strings as floats
    csv.each do |row|
      row.each_pair { | k, v | row[k] = Float(v) rescue v }
    end

    # change last row[:max] to infinity
    last_row = csv.length - 1
    csv[last_row]["max"] = Float::INFINITY

    # delete first row
    csv.shift

    csv
  end

  def with_excess_centavo?(a)
    decimals(a) > 2
  end

  def decimals(a)
    num = 0
    while(a != a.to_i)
        num += 1
        a *= 10
    end
    num
  end
end