Table[][] allProvinceData; // Correct declaration as 2D array
int[][][] allValues;      // [dataset][province][dataPoint]
int currentDataset = 0;
int hoverRow = -1;
int hoverCol = -1;

String[][] allProvinceFiles = {
  {"Antwerpen_TOT_IN.csv", "WestVlaanderen_TOT_IN.csv", "OostVlaanderen_TOT_IN.csv", "Limburg_TOT_IN.csv",
    "VlaamsBrabant_TOT_IN.csv", "Brussel_TOT_IN.csv", "luxemburg_TOT_IN.csv", "namen_TOT_IN.csv",
  "Hainaut_TOT_IN.csv", "Liege_TOT_IN.csv", "BrabantWallon_TOT_IN.csv"},
  {"antwerpen_TOT_ICU.csv", "westVlaanderen_TOT_ICU.csv", "oostVlaanderen_TOT_ICU.csv", "limburg_TOT_ICU.csv",
    "vlaamsBrabant_TOT_ICU.csv", "brussel_TOT_ICU.csv", "luxemburg_TOT_ICU.csv", "namen_TOT_ICU.csv", "hainaut_TOT_ICU.csv", "liege_TOT_ICU.csv",
  "brabantWallon_TOT_ICU.csv"},
  {"antwerpen_NEW_IN.csv", "westVlaanderen_NEW_IN.csv", "oostVlaanderen_NEW_IN.csv", "limburg_NEW_IN.csv",
    "vlaamsBrabant_NEW_IN.csv", "brussel_NEW_IN.csv", "luxemburg_NEW_IN.csv", "namen_NEW_IN.csv", "hainaut_NEW_IN.csv", "liege_NEW_IN.csv",
  "brabantWallon_NEW_IN.csv"},
  {"antwerpen_NEW_ICU.csv", "westVlaanderen_NEW_ICU.csv", "oostVlaanderen_NEW_ICU.csv", "limburg_NEW_ICU.csv",
    "vlaamsBrabant_NEW_ICU.csv", "brussel_NEW_ICU.csv", "luxemburg_NEW_ICU.csv", "namen_NEW_ICU.csv", "hainaut_NEW_ICU.csv", "liege_NEW_ICU.csv",
  "brabantWallon_NEW_ICU.csv"},
  {"antwerpen_TOT_RESP.csv", "westVlaanderen_TOT_RESP.csv", "oostVlaanderen_TOT_RESP.csv", "limburg_TOT_RESP.csv",
    "vlaamsBrabant_TOT_RESP.csv", "brussel_TOT_RESP.csv", "luxemburg_TOT_RESP.csv", "namen_TOT_RESP.csv", "hainaut_TOT_RESP.csv", "liege_TOT_RESP.csv",
  "brabantWallon_TOT_RESP.csv"},
  {"antwerpen_TOT_ECMO.csv", "westVlaanderen_TOT_ECMO.csv", "oostVlaanderen_TOT_ECMO.csv", "limburg_TOT_ECMO.csv",
    "vlaamsBrabant_TOT_ECMO.csv", "brussel_TOT_ECMO.csv", "luxemburg_TOT_ECMO.csv", "namen_TOT_ECMO.csv", "hainaut_TOT_ECMO.csv", "liege_TOT_ECMO.csv",
  "brabantWallon_TOT_ECMO.csv"}

};

String[] provinceNames = {
  "Antwerpen", "West-Vlaanderen", "Oost-Vlaanderen", "Limburg",
  "Vlaams-Brabant", "Brussel", "Luxemburg", "Namen",
  "Henegouwen", "Luik", "Waals-Brabant"
}; //voor X-as

String[] months = {
  "Maart 2020", "April 2020", "Mei 2020", "Juni 2020", "Juli 2020", "Augustus 2020", "September 2020", "October 2020", "November 2020", "December 2020", "Januari 2021", "Februari 2021", 
  "Maart 2021", "April 2021", "Mei 2021", "Juni 2021",  "Juli 2021", "Augustus 2021", "September 2021", "October 2021", "November 2021", "December 2021", "Januari 2022", "Februari 2022", 
  "Maart 2022", "April 2022", "Mei 2022", "Juni 2022", "Juli 2022", "Augustus 2022", "September 2022", "October 2022", "November 2022", "December 2022", "Januari 2023", "Februari 2023", 
  "Maart 2023", "April 2023", "Mei 2023", "Juni 2023",
}; //voor Y-as



float cellWidth, cellHeight;
int dataPoints = 40;
int provinces = 11;
int numDatasets = 6;

void setup() {
  size(1500,600);
  //noStroke();

  // Initialize arrays with correct dimensions
  allProvinceData = new Table[numDatasets][provinces];
  allValues = new int[numDatasets][provinces][dataPoints];

  // Load all datasets
  for (int d = 0; d < numDatasets; d++) {
    for (int i = 0; i < provinces; i++) {
      // Skip if no file defined for this dataset/province
      if (allProvinceFiles[d].length > i && allProvinceFiles[d][i] != null) {
        allProvinceData[d][i] = loadTable(allProvinceFiles[d][i]);

        // Error check
        if (allProvinceData[d][i] == null) {
          println("ERROR: Could not load " + allProvinceFiles[d][i]);
          exit();
        }

        // Store values
        for (int j = 0; j < dataPoints; j++) {
          if (j < allProvinceData[d][i].getRowCount()) {
            allValues[d][i][j] = allProvinceData[d][i].getInt(j, 0);
          }
        }
      }
    }
  }

  // Calculate cell dimensions
  cellWidth = (width - 200) / dataPoints;
  cellHeight = (height - 150) / provinces; //kleiner maken om ruimte te creeeren
}

void draw() {
  background(255);
  
  translate(150,50); //ruimte laten voor assen (ook nog voor legenda?)

  // Find maximum value in CURRENT dataset
  int maxVal = 0;
  for (int i = 0; i < provinces; i++) {
    for (int j = 0; j < dataPoints; j++) {
      if (allValues[currentDataset][i][j] > maxVal) {
        maxVal = allValues[currentDataset][i][j];
      }
    }
  }

  // Draw heatmap for current dataset
  for (int i = 0; i < provinces; i++) {
    for (int j = 0; j < dataPoints; j++) {
      
      color minColor = color(0, 0, 255); // Blue
      color maxColor = color(255, 0, 0); // Red

      float interp = map(allValues[currentDataset][i][j], 0, maxVal, 0, 1);
      fill(lerpColor(minColor, maxColor, interp));
      rect(j * cellWidth, i * cellHeight, cellWidth, cellHeight);

    }
  }

  
 



 hoverRow = -1;
  hoverCol = -1;
  for (int i = 0; i < provinces; i++) {
    for (int j = 0; j < dataPoints; j++) {
      if (mouseX >= j*cellWidth && mouseX < (j+1)*cellWidth &&
          mouseY >= i*cellHeight && mouseY < (i+1)*cellHeight) {
        hoverRow = i;
        hoverCol = j;
      }
    }
  }

  // Only show text if hovering over a cell
  if (hoverRow != -1 && hoverCol != -1) {
    fill(0);
    textSize(12);
    text(allValues[currentDataset][hoverRow][hoverCol], 
         hoverCol * cellWidth + cellWidth/2, 
         hoverRow * cellHeight + cellHeight/2);
  }
  
  // Y-as tekenen, (provincies)
  fill(0);
  textAlign(RIGHT, CENTER);
  textSize(14);
  for (int i = 0; i < provinces; i++) {
    text(provinceNames[i], -10, i*cellHeight + cellHeight/2);
  }

  // X-as maken, (Datum)
  textAlign(CENTER, TOP);
  for (int j = 0; j < dataPoints; j += 5) {
    String label = months [j%40];
    text(label, j*cellWidth + cellWidth/2, provinces*cellHeight + 5);
  }

  // Titel assen
  textSize(18);
  textAlign(CENTER, CENTER);
  text("Datum", (dataPoints*cellWidth)/2, provinces*cellHeight + 50);

  pushMatrix();
  translate(-100, (provinces*cellHeight)/2);
  rotate(-HALF_PI);
  text("Provincie", 0, 0);
  popMatrix();


  // Display current dataset
  fill(0);
  textSize(20);
  text("Dataset: " + (currentDataset + 1), 20, 30);
}

void keyPressed() {

  if (key >= '1' && key <= '9') {
    int newDataset = key - '1';
    if (newDataset < numDatasets) {
      currentDataset = newDataset;
    }
  }

  if (keyCode == LEFT) {
    currentDataset = (currentDataset - 1 + numDatasets) % numDatasets;
  } else if (keyCode == RIGHT) {
    currentDataset = (currentDataset + 1) % numDatasets;
  }
}
