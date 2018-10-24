require 'mechanize'
class InvalidFIAPCredentials < StandardError; end

class FIAPAgent
  attr_reader :agent, :rm, :password

  def initialize(rm, password)
    @agent = Mechanize.new
    @rm = rm
    @password = password
  end

  def boletim
    login = agent.get('https://www2.fiap.com.br/').form
    login.usuario = rm
    login.senha = password

    agent.submit(login, login.buttons.first)
    raise InvalidFIAPCredentials if agent.page.uri.to_s == "https://www2.fiap.com.br/Aluno/LogOn"

    boletim = agent.get("https://www2.fiap.com.br/Aluno/Boletim").search("table .i-boletim-table-row")
    notas = boletim.map do |materia|
      fields = materia.search("td")
      id = fields[0]["id"]
      nac_page = agent.get("https://www2.fiap.com.br/Boletim/Nacs?CodDisciplina=#{id}").search("table.i-boletim-table")
      nacs = nac_page.map do |semestre|
        semestre.search(".td-small:nth-child(4)").map { |col| col.text.strip }
      end

      {
        id: id,
        disciplina: fields[0].text.strip,
        nac1: fields[1].text.strip,
        nacs1: (nacs[0] || []),
        am1: fields[2].text.strip,
        ps1: fields[3].text.strip,
        md1: fields[5].text.strip,
        nac2: fields[6].text.strip,
        nacs2: (nacs[1] || []),
        am2: fields[7].text.strip,
        ps2: fields[8].text.strip,
        md2: fields[10].text.strip,
        aulas: fields[11].text.strip,
        faltas1: fields[4].text.strip,
        faltas2: fields[9].text.strip,
        presenca: fields[12].text.strip,
        mp: fields[13].text.strip,
        exame: fields[14].text.strip,
        mf: fields[15].text.strip,
        situacao: fields[16].text.strip
      }
    end
  end
end
