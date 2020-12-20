with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with LISTE; use LISTE;

procedure testliste is
    liste : T_LISTE;
    Doub : Boolean;
begin
    Initialiser(liste);
    
    Enregistrer(liste, 0, 1, Doub);
    if Doub then
        Put_Line ("Element present");
    else
        Put_Line("Non present");
    end if;
    Enregistrer(liste, 0, 2, Doub);
    if Doub then
        Put_Line ("Element present");
    else
        Put_Line("Non present");
    end if;
    Enregistrer(liste, 0, 5, Doub);
    Enregistrer(liste, 0, 3, Doub);
    Enregistrer(liste, 1, 2, Doub);
    Enregistrer(liste, 1, 1, Doub);
    Enregistrer(liste, 0, 3, Doub);

    if Doub then
        Put_Line ("Element present");
    else
        Put_Line("Non present");
    end if;
    
    
    Afficher(liste);
end testliste;
