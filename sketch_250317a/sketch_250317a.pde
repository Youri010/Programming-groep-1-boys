import java.util.Collections;
//1 ophalen data csv bestand 

//misschien makkelijker om eerst handmatig data samen te voegen in verschillende bestanden per provincie?

Table table;

void setup() {
size(2000,500);
background(255);
  table = loadTable("COVID19BE_HOSP.csv", "header");
HashMap<String, ArrayList<TableRow>> provincieMap = new HashMap<>();
for (TableRow row : table.rows()) {
    String provincie = row.getString("PROVINCE");

    // Voeg een nieuwe lijst toe als de provincie nog niet bestaat
    if (!provincieMap.containsKey(provincie)) {
        provincieMap.put(provincie, new ArrayList<TableRow>());
    }

    // Voeg de rij toe aan de lijst voor die provincie
    provincieMap.get(provincie).add(row);
}

// Sorteer provincienamen alfabetisch
ArrayList<String> provincies = new ArrayList<>(provincieMap.keySet());
Collections.sort(provincies);

// Print alle data, gesorteerd per provincie
for (String provincie : provincies) {
    println("Provincie: " + provincie);

    for (TableRow row : provincieMap.get(provincie)) {
        String datum = row.getString("DATE");
        int newIn = row.getInt("NEW_IN");

        println("  " + datum + ": " + newIn + " nieuwe opnames");
    }
}
 
  
}


//2 data omzetten naar objecten 

//3 heat map maken 

//4 visualizatie verbeteren
