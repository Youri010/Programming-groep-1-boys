//1 ophalen data csv bestand 

//misschien makkelijker om eerst handmatig data samen te voegen in verschillende bestanden per provincie?

Table table;

void setup() {
size(1250,500);
background(255);
  table = loadTable("COVID19BE_HOSP.csv", "header");
  println(table.getRowCount() + " total rows in table");
  for (TableRow row : table.rows()) {
    String datum = row.getString("DATE");
    fill(0);
    //text(datum,random(2000),random(500));
    //println(datum);
  }

 
  
}


//2 data omzetten naar objecten 

//3 heat map maken 

//4 visualizatie verbeteren
