require 'sketchup'

def rahmen(breite, tiefe, hoehe, dicke)
  modell = Sketchup.active_model
  gruppe = modell.entities.add_group
  aussenflaeche = gruppe.entities.add_face(
    [0,0,0],
    [breite, 0,0],
    [breite, tiefe, 0],
    [0, tiefe, 0]
  )
  innenflaeche = gruppe.entities.add_face(
    [dicke, dicke, 0],
    [breite - dicke, dicke, 0],
    [breite - dicke, tiefe - dicke, 0],
    [dicke, tiefe - dicke, 0]
  )
  innenflaeche.erase!
  aussenflaeche.reverse!
  aussenflaeche.pushpull(hoehe)  
end


def rahmen_mit_dialog
  namen = ['Breite (cm)', 'Tiefe (cm)', 'Hoehe (cm)', 'Dicke (cm)']
  werte = [20, 20, 5, 5]
  breite, tiefe, hoehe, dicke = UI.inputbox namen, werte, "Rahmen erstellen"
  rahmen(breite.cm, tiefe.cm, hoehe.cm, dicke.cm)
end

unless file_loaded? File.basename(__FILE__) 
  UI.menu("Plug-Ins").add_item("Rahmen erstellen") do 
    rahmen_mit_dialog
  end
end

file_loaded File.basename(__FILE__) 
