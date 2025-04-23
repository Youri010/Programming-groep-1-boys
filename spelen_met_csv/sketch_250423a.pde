// Simplest possible heatmap for 40 data points
Table[] provinceData = new Table[4];
String[] provinceFiles = {"Antwerpen.csv", "Liege.csv", "Brussel.csv", "BrabantWallon.csv"};
int[][] values; // Will store all values [province][dataPoint]

float cellWidth, cellHeight;
int dataPoints = 40;
int provinces = 4;

void setup() {
  size(1000, 300); // Wider window for 40 points
  
  // Initialize array
  values = new int[provinces][dataPoints];
  
  // Load all data files
  for (int i = 0; i < provinces; i++) {
    provinceData[i] = loadTable(provinceFiles[i]);
    println("Loading " + provinceFiles[i]);
    
    // Check if we got data
    if (provinceData[i] == null) {
      println("ERROR: Could not load " + provinceFiles[i]);
      exit();
    }
    
    // Print first few values to verify
    for (int j = 0; j < min(5, provinceData[i].getRowCount()); j++) {
      println("Row " + j + ": " + provinceData[i].getInt(j, 0));
    }
    
    // Store all values
    for (int j = 0; j < dataPoints; j++) {
      values[i][j] = provinceData[i].getInt(j, 0);
    }
  }
  
  // Calculate cell dimensions
  cellWidth = width / dataPoints;
  cellHeight = height / provinces;
}

void draw() {
  background(255);
  
  // Find maximum value for color scaling
  int maxVal = 0;
  for (int i = 0; i < provinces; i++) {
    for (int j = 0; j < dataPoints; j++) {
      if (values[i][j] > maxVal) {
        maxVal = values[i][j];
      }
    }
  }
  
  // Draw the heatmap
  for (int i = 0; i < provinces; i++) {
    for (int j = 0; j < dataPoints; j++) {
      // Map value to color intensity (darker = higher value)
      float intensity = map(values[i][j], 0, maxVal, 50, 255);
      fill(intensity);
      
      // Draw rectangle
      rect(j * cellWidth, i * cellHeight, cellWidth, cellHeight);
      
      // Optional: Display the actual number (might be too small)
      // fill(0);
      // textSize(8);
      // text(values[i][j], j*cellWidth + 2, i*cellHeight + 12);
    }
  }
}
