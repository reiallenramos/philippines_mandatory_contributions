Gem::Specification.new do |s|
  s.name        = 'philippines_mandatory_contributions'
  s.version     = '0.0.1'
  s.date        = '2018-09-28'
  s.summary     = "Mandatory Government Contributions in the Philippines"
  s.description = "Calculate SSS, Philhealth, and Pagibig"
  s.authors     = ["Rei Ramos"]
  s.email       = 'reiallenramos@gmail.com'
  s.files       = ["lib/philippines_mandatory_contributions.rb",
                   "lib/pagibig_calculator.rb",
                   "lib/philhealth_calculator.rb",
                   "lib/sss_calculator.rb",
                   "lib/tables/pagibig_table.csv",
                   "lib/tables/philhealth_table.csv",
                   "lib/tables/sss_table.csv",
                   "lib/helpers.rb"]
  s.homepage    = 'https://github.com/reiallenramos/philippines_mandatory_contributions'
  s.license     = 'MIT'
end
