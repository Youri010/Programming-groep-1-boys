Table[][] allProvinceData; // Correct declaration as 2D array
int[][][] allValues;      // [dataset][province][dataPoint]
int currentDataset = 0;

String[][] allProvinceFiles = {
  {"antwerpen_TOT_IN.csv", "westVlaanderen_TOT_IN.csv", "oostVlaanderen_TOT_IN.csv", "limburg_TOT_IN.csv",
    "vlaamsBrabant_TOT_IN.csv", "brussel_TOT_IN.csv", "luxemburg_TOT_IN.csv", "namen_TOT_IN.csv",
  "hainaut_TOT_IN.csv", "liege_TOT_IN.csv", "brabantWallon_TOT_IN.csv"},
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

float cellWidth, cellHeight;
int dataPoints = 40;
int provinces = 11;
int numDatasets = 6;

void setup() {
  size(1500, 600);
  noStroke();

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
  cellWidth = (width - 3) / dataPoints;
  cellHeight = (height - 10) / provinces;
}

void draw() {
  background(255);

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
      float intensity = map(allValues[currentDataset][i][j], 0, maxVal, 50, 255);
      fill(intensity);
      rect(j * cellWidth, i * cellHeight, cellWidth, cellHeight);

      fill(0);
      textSize(8);
      text(allValues[currentDataset][i][j], j * cellWidth + 2, i * cellHeight + 12);
    }
  }

  // Display current dataset
  fill(0);
  textSize(20);
  text("Dataset: " + (currentDataset + 1), 20, 30);
}

void keyPressed() {
  // Switch datasets with number keys (1-9)
  if (key >= '1' && key <= '9') {
    int newDataset = key - '1';
    if (newDataset < numDatasets) {
      currentDataset = newDataset;
    }
  }

  // Arrow key navigation
  if (keyCode == LEFT) {
    currentDataset = (currentDataset - 1 + numDatasets) % numDatasets;
  } else if (keyCode == RIGHT) {
    currentDataset = (currentDataset + 1) % numDatasets;
  }
}
