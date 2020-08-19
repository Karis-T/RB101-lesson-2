def prompt(message)
  Kernel.puts("=> #{message}")
end

def float?(num)
  num.to_f().to_s() == num
end

def integer?(num)
  num.to_i().to_s() == num
end

def percent?(num)
  if num.to_f().between?(1, 100)
    num.to_s()
  end
end

prompt("Welcome to Loan Calculator! Enter your name:")
name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt("Make sure to use a valid name")
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  loan_a = ''
  loop do
    prompt("Please enter your loan amount in dollars $:")
    loan_a = Kernel.gets().chomp()

    if float?(loan_a)
        prompt("Invalid, numbers only.")
      else
        break
      end
    end

  a_percent = ''
  loop do
    prompt("Please enter your annual percentage rate (APR) %:")
    a_percent = Kernel.gets().chomp()

    if percent?(a_percent)
      break
    else
      prompt("Enter a percent value between 0 and 100")
    end
  end

  loan_d = ''
  loop do
    prompt("Please enter your loan duration in months:")
    loan_d = Kernel.gets().chomp()

    if integer?(loan_d)
      break
    else
      prompt("Invalid, whole numbers only.")
    end
  end

  prompt("Calulating your car loan...")
  m_percent = ((a_percent.to_f()( / 100) / 12)
  month_pay = loan_a.to_f * (m_percent / (1 - (1 + m_percent)**(-loan_d.to_i)))

  prompt("Repayments are $#{month_pay.round(2)} per month for #{loan_d} months")
  prompt("Would you like to calculate again? Type 'y' to start over")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using Car Loan Calculator! Goodbye.")
