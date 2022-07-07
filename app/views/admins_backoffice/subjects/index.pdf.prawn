prawn_document do |pdf|
  pdf.text 'Listagem de assuntos:'
  pdf.move_down 20
  pdf.table @subjects.collect{|s| [s.id,s.description]}
end