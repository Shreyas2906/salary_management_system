class PayrollCalculator
  TAX_RATES = {
    "India" => 0.1,
    "USA" => 0.2
  }

  def self.calculate(employee, attendance)
    tax_rate = TAX_RATES[employee.country] || 0.1

    gross = employee.salary * (attendance.days_present.to_f / attendance.total_working_days)
    tax = gross * tax_rate
    net = gross - tax

    { gross: gross, tax: tax, net: net }
  end
end