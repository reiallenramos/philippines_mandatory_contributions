require 'csv'
require 'helpers'

class Pagibig < MandatoryContributionCalculator
  include Helpers

  MAX_ALLOWABLE_COMPENSATION = 5000.freeze

  def call
    load_csv
    reset_compensation if more_than_allowed_compensation?
    set_bracket
    set_employer_share
    set_employee_share
    return_contributions
  end

  private

  def load_csv
    @csv = get_rows_from_csv("pagibig_table.csv")
  end
  
  def set_bracket
    @bracket = @csv.select { |row| row["min"] <= @compensation && row["max"] >= @compensation }.first
  end

  def more_than_allowed_compensation?
    @compensation >= MAX_ALLOWABLE_COMPENSATION
  end

  def reset_compensation
    @compensation = MAX_ALLOWABLE_COMPENSATION
  end

  def set_employee_share
    @employee_share = @compensation * @bracket["employee_share"]
  end

  def set_employer_share
    @employer_share = @compensation * @bracket["employer_share"]
  end
  
  def return_contributions
    { employee_share: @employee_share, employer_share: @employer_share }
  end
end