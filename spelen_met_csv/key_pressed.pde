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
