class MandatoryContributionCalculator
  def initialize(options)
    @compensation = options[:compensation].round(2)
  end
end

require 'pagibig_calculator'
require 'philhealth_calculator'
require 'sss_calculator'