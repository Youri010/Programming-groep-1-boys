String[] provincienaam = {
  "Antwerpen", "West-Vlaanderen", "Oost-Vlaanderen", "Limburg",
  "Vlaams-Brabant", "Brussel", "Luxemburg", "Namen",
  "Henegouwen", "Luik", "Waals-Brabant"
}; //voor X-as

String[] months = {
  "Maart 2020", "April 2020", "Mei 2020", "Juni 2020", "Juli 2020", "Augustus 2020", "September 2020", "October 2020", "November 2020", "December 2020", "Januari 2021", "Februari 2021",
  "Maart 2021", "April 2021", "Mei 2021", "Juni 2021", "Juli 2021", "Augustus 2021", "September 2021", "October 2021", "November 2021", "December 2021", "Januari 2022", "Februari 2022",
  "Maart 2022", "April 2022", "Mei 2022", "Juni 2022", "Juli 2022", "Augustus 2022", "September 2022", "October 2022", "November 2022", "December 2022", "Januari 2023", "Februari 2023",
  "Maart 2023", "April 2023", "Mei 2023", "Juni 2023",
}; //voor Y-as
void assen (float cellHeight, float cellWidth,String[] provincienaam,String[] months){ 
  int dataPoints = 40;
  int provinces = 11;
   // Y-as tekenen, provincie
  fill(0);
  textAlign(RIGHT, CENTER);
  textSize(14);
  for (int i = 0; i < provinces; i++) {
    text(provincienaam[i], -10, i*cellHeight + cellHeight/2);
  }

  // X-as maken, datum
  textAlign(CENTER, TOP);
  for (int j = 0; j < dataPoints; j += 5) {
    String label = months [j];
    text(label, j*cellWidth + cellWidth/2, provinces*cellHeight + 5);
  }

  // Titel assen
  textSize(18);
  textAlign(CENTER, CENTER);
  text("Datum", (dataPoints*cellWidth)/2, provinces*cellHeight + 50);

  pushMatrix();
  translate(-120, (provinces*cellHeight)/2);
  rotate(-HALF_PI);
  text("Provincie", 0, 0);
  popMatrix();//zorgen dat niet alles meegaat translaten
}
void muis(){
  int hoverRow = -1;
  int hoverCol = -1;
  float actualmouseX = mouseX-translateX;
  float actualmouseY = mouseY-translateY;
  for (int i = 0; i < provinces; i++) {
    for (int j = 0; j < dataPoints; j++) {
      if (actualmouseX >= j*cellWidth && actualmouseX < (j+1)*cellWidth &&
        actualmouseY >= i*cellHeight && actualmouseY < (i+1)*cellHeight) {
        hoverRow = i;
        hoverCol = j;
      }
    }
  }

  // Only show text if hovering over a cell
  if (hoverRow != -1 && hoverCol != -1) {
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(12);
    text(allValues[currentDataset][hoverRow][hoverCol],
      hoverCol * cellWidth + cellWidth/2,
      hoverRow * cellHeight + cellHeight/2);

    fill(0);
    textSize(16);
    textAlign(RIGHT, BOTTOM);

    String provinceName = provincienaam[hoverRow];
    String monthName = months[hoverCol % months.length];
    String info = provinceName + " - " + monthName;

    text(info, width - 200 - translateX, height - 20 - translateY);
  }
}
