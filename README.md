# Philippines Mandatory Government Contributions

Calculate your monthly government contributions:
* SSS ([source](https://www.sss.gov.ph/sss/appmanager/pages.jsp?page=scheduleofcontribution))
* Philhealth ([source](https://www.philhealth.gov.ph/advisories/2018/adv2018-0003.pdf))
* Pagibig ([source](https://philpad.com/pagibig-contribution-table/))

## Installation
Add to your Gemfile:

```ruby
gem 'philippines_mandatory_contributions', github: 'reiallenramos/philippines_mandatory_contributions'
```

## I/O

### Input
All three requires one parameter `compensation` of type **float**.

### Output
All three will return a hash of **float** parameters:

* SSS        -> `er`, `ee`, `ec`
* Philhealth -> `personal_share`, `employer_share`
* Pagibig    -> `employee_share`, `employer_share`

## Rounding Off

### Input
The input parameter `compensation` will be rounded off to the nearest hundredths. 
```
1.1111  -> 1.11
1.555   -> 1.56
1.991   -> 1.99
1.99999 -> 2.00
```

### Output
No rounding off.


## Examples:

#### SSS
```console
>> SSS.new(compensation: 10000).call
=> {:er=>736.7, :ee=>363.3, :ec=>10.0}

>> SSS.new(compensation: 12345).call
=> {:er=>920.8, :ee=>454.2, :ec=>10.0}

>> SSS.new(compensation: 200000).call
=> {:er=>1178.7, :ee=>581.3, :ec=>30.0}
```

#### Philhealth
```console
>> Philhealth.new(compensation: 8999.99).call
=> {:employer_share=>137.5, :personal_share=>137.5}

>> Philhealth.new(compensation: 25410.00).call
=> {:employer_share=>349.39, :personal_share=>349.39}

>> Philhealth.new(compensation: 41999.99).call
=> {:employer_share=>550.0, :personal_share=>550.0}
```

In the case of an excess centavo when diving the monthly premium, the excess centavo will be reflected on the employer_share:
```console
>> Philhealth.new(compensation: 22500).call
=> {:employer_share=>309.38, :personal_share=>309.37}
```

#### Pagibig
```console
>> Pagibig.new(compensation: 1499.9999).call
=> {:employee_share=>15.0, :employer_share=>30.0}

>> Pagibig.new(compensation: 1500).call
=> {:employee_share=>15.0, :employer_share=>30.0}

>> Pagibig.new(compensation: 4000).call
=> {:employee_share=>80.0, :employer_share=>80.0}
```

Note that although Pagibig contribution is percentage-based, Pagibig limits the allowed compensation level for computation to P5,000.00 so anything above this level will result in the same computation as with P5,000.00.

```
>> Pagibig.new(compensation: 5000).call
=> {:employee_share=>100.0, :employer_share=>100.0}

>> Pagibig.new(compensation: 10000).call
=> {:employee_share=>100.0, :employer_share=>100.0}
```