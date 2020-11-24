namespace :import do
  desc "TODO"
  task loans: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("db", "prestamos.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    Payment.destroy_all
    Loan.destroy_all
    i = 1
    csv.each do |row|
      i = i + 1
      l = Loan.new
      l.id              = row["id"][2..-1].to_i
      l.moneylender_id  = row["quien"] == "M" ? 3 : 1
      l.status_id       = 1
      l.status_id       = 2 if row["Resta"].to_i <= 0
      l.loan_type_id = 9                                                                 #id: 9, short_name: "Eterno"
      l.loan_type_id = 3 if row["interes %"] == "30"  && row["semanas"] == "12"          #id: 3, short_name: "12 Semanas 30%",
      l.loan_type_id = 4 if row["interes %"] == "18"  && row["semanas"] == "12"          #id: 4, short_name: "12 Semanas 18%",
      l.loan_type_id = 6 if row["interes %"] == "5"   && row["semanas"] == "1"           #id: 6, short_name: "1 Semanas 5%"
      l.loan_type_id = 7 if row["interes %"] == "10"  && row["semanas"] == "4"           #id: 7, short_name: "4 Semanas 10%"
      l.loan_type_id = 8 if row["interes %"] == "20"  && row["semanas"] == "8"           #id: 8, short_name: "8 Semanas 20%"
      l.loan_type_id = 10 if row["interes %"] == "40" && row["semanas"] == "16"          #id: 10, short_name: "16 Semanas 40%"
      l.loan_type_id = 5 if row["interes %"] == "15"  && row["Es Pago Mensual?"] == "1"  #id: 5, short_name: "Mensual 15%",
      l.loan_type_id = 2 if row["interes %"] == "6"   && row["Es Pago Mensual?"] == "1"  #id: 2, short_name: "Mensual 6%",
      l.loan_type_id = 1 if row["interes %"] == "10"  && row["Es Pago Mensual?"] == "1"  #id: 1, short_name: "Mensual 10%",

      l.amount_borrowed = row["monto"].sub(/,/, '.').to_f
      l.balance         = row["Resta"].sub(/,/, '.').to_f
      l.loan_date       = row["FechaIni"]
      l.start_date      = row["FechaIni"]
      u = User.find_by(name: row["persona"].strip)
      if u.nil?
         u = User.new
         u.name     = row["persona"].strip
         u.email    = "foo" + i.to_s + "@foo.com"
         u.password = "foooo14"
         u.admin    = false
         u.save!(:validate => false)
         puts "user: #{u.inspect}"
      end
      l.user_id         = u.id
      l.recal
      puts "#{l.inspect}  #{l.code}  for #{l.amount_borrowed} saved"
    end
  end

  task payments: :environment do
   require "csv"
    csv_text = File.read(Rails.root.join("db", "abonos.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    Payment.destroy_all
    i = 1
    csv.each do |row|
      i = i + 1
      p = Payment.new
      p.loan_id              = row["id"][2..-1].to_i
      p.amount               = row["monto"].sub(/,/, '.').to_f
      p.payment_date         = row["fecha_pago"]
      p.profit               = row["Interes"].sub(/,/, '.').to_f
      p.payment_to_borrowed  = row["Capital"].sub(/,/, '.').to_f
      p.status_id       = 2
      p.save
      p.loan.recal
      puts "Saved  #{p.inspect}"
    end
  end

end
