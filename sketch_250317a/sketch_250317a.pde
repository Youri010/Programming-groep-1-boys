//1 ophalen data csv bestand 


Table table;

void setup() {

  table = loadTable("COVID19BE_HOSP.csv", "header");
  println(table.getRowCount() + " total rows in table");

 
  
}


//2 data omzetten naar objecten 

//3 heat map maken 

//4 visualizatie verbeteren
