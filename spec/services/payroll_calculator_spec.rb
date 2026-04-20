class PayrollCalculator
  TAX_RATES = {
    "India" => 0.1,
    "USA" => 0.2,
    "UK" => 0.15
  }

  def self.calculate(employee, attendance)
    tax_rate = TAX_RATES[employee.country] || 0.1

    attendance_ratio =
      attendance.days_present.to_f / attendance.total_working_days

    gross = employee.salary * attendance_ratio
    tax = gross * tax_rate
    net = gross - tax

    {
      gross: gross.round(2),
      tax: tax.round(2),
      net: net.round(2)
    }
  end
end