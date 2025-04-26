//1 ophalen data csv bestand 

//misschien makkelijker om eerst handmatig data samen te voegen in verschillende bestanden per provincie?

Table table;

void setup() {
size(1250,500);
 drawGradientRect(450, 400, 400, 50, color(255, 0, 0), color(0, 0, 255));

  table = loadTable("Brussels_hospitalisaties_per_maand.csv", "header");
  println(table.getRowCount() + " total rows in table");
  for (TableRow row : table.rows()) {
    String datum = row.getString("YEAR_MONTH");
    fill(0);
    //text(datum,random(2000),random(500));
    //println(datum);
   
     
  }

 
  
}
void drawGradientRect(float x, float y, float w, float h, color c1, color c2){
  for (int i = 0; i < w; i++) {
    float inter = map(i, 0, w, 0, 1);
    color c = lerpColor(c1,c2, inter);
    stroke(c);
    line(x + i, y, x + i, y + h);
  }
}



//2 data omzetten naar objecten 

//3 heat map maken 

//4 visualizatie verbeteren
