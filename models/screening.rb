require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :time, :ticket_id

  def initialize(options)
    @id = options['id'].to_i if options['to_i']
    @time = options['time'].to_i
    @ticket_id = options['ticket_id'].to_i
  end

  
end
