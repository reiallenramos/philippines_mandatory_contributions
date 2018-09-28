require 'csv'
require 'helpers'

class Philhealth < MandatoryContributionCalculator
  include Helpers

  MULTIPLIER = 0.0275.freeze

  def call
    load_csv
    set_bracket
    set_monthly_premium
    set_employer_share
    set_personal_share
    deduct_excess_centavo_from_employer if with_excess_centavo?(@employer_share)
    return_contributions
  end

  private

  # read CSV then create array of hashes for each row
  def load_csv
    @csv = get_rows_from_csv("philhealth_table.csv")
  end

  def set_bracket
    @bracket = @csv.select { |row| row["min"] <= @compensation && row["max"] >= @compensation }.first
  end

  def set_monthly_premium
    case
    when bracket_1?, bracket_3?
      @monthly_premium = @bracket["monthly_premium"]
    when bracket_2?
      @monthly_premium = (@compensation * MULTIPLIER).round(2)
    end
  end

  def bracket_1?
    @bracket == @csv[0]
  end

  def bracket_2?
    @bracket == @csv[1]
  end

  def bracket_3?
    @bracket == @csv[2]
  end

  def set_employer_share
    @employer_share = @monthly_premium / 2
  end

  def set_personal_share
    @personal_share = @monthly_premium / 2
  end

  def return_contributions
    { employer_share: @employer_share, personal_share: @personal_share }
  end

  def deduct_excess_centavo_from_employer
    @employer_share += 0.005
    @personal_share -= 0.005
  end
end