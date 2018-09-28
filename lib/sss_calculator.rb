require 'csv'
require 'helpers'

class SSS < MandatoryContributionCalculator
  include Helpers

  def call
    load_csv
    set_bracket
    set_er
    set_ee
    set_ec
    return_contributions
  end

  private

  # read CSV then create array of hashes for each row
  def load_csv
    @csv = get_rows_from_csv("sss_table.csv")
  end

  def set_bracket
    @bracket = @csv.select { |row| row["min"] <= @compensation && row["max"] >= @compensation }
    @bracket = @bracket.any? ? @bracket.first : { er: 0, ee: 0, ec: 0 }
  end

  def set_er
    @er = @bracket["er"]
  end

  def set_ee
    @ee = @bracket["ee"]
  end

  def set_ec
    @ec = @bracket["ec"]
  end

  def return_contributions
    { er: @er, ee: @ee, ec: @ec}
  end
end
