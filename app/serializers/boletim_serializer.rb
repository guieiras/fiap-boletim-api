require 'ostruct'

class BoletimSerializer
  def self.call(boletim)
    boletim.map { |row| transform(row) }
  end

  def self.transform(data)
    [:nac1, :am1, :ps1, :md1, :nac2, :am2, :ps2, :md2, :mp, :exame, :mf, :presenca].each do |column|
      data[column] = data[column].yield_self do |value|
        value = value.gsub("-", "").gsub(",", ".")
        value.empty? ? nil : value.to_f
      end
    end
    [:id, :aulas, :faltas1, :faltas2].each do |column|
      data[column] = data[column].yield_self do |value|
        value = value.gsub(",", ".")
        value.empty? ? nil : value.to_i
      end
    end
    [:nacs1, :nacs2].each do |column|
      data[column] = data[column].map do |nac|
        nac == '-' ? nil : nac.gsub(",", ".").to_f
      end
    end

    OpenStruct.new(data)
  end
end
