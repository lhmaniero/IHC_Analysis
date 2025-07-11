// Base directory for input and output
// baseDir = "/Volumes/SanDisk/CROPS/";
inputDir = "/Users/luizmaniero/Documents/DataScience/HMRI_IHC_colab/20250503_bGAL_results/20250701_bGAL_nuclei_masks/Image_B_Gal_nuclei_masks/"
outputDir = "/Users/luizmaniero/Documents/DataScience/HMRI_IHC_colab/20250701_bGAL_results/";

// === List of image files ===
imageList = getFileList(inputDir);

setBatchMode(true);

for (i = 0; i < imageList.length; i++) {
    imageName = imageList[i];
    open(inputDir + imageName);
    selectWindow(imageName);

    // Threshold and Mask
    setAutoThreshold("Default dark no-reset");
    setThreshold(1, 65535, "raw");
    setOption("BlackBackground", true);
    run("Convert to Mask");
    run("Watershed");

    // Set measurements
    run("Set Measurements...", "area centroid perimeter area_fraction limit display redirect=None decimal=3");
    run("Analyze Particles...", "display exclude summarize overlay");

    // Save measurement results
    //saveAs("Results", outputDir + replace(imageName, ".tif", "_Results.csv"));

    run("Flatten");
    saveAs("Tiff", outputDir + replace(imageName, ".tif", "_Overlay.tif"));

    //close();
}


// Save measurement results
// saveAs("Results", outputDir + replace(imageName, ".tif", "_Results.csv"));

// Save overlay image as TIFF
// saveAs("Tiff", outputDir + replace(imageName, ".tif", "_Overlay.tif"));

// Export results
saveAs("Results", outputDir + "bGAL_Nuclei_count_20250107.csv");
run("Close All");

setBatchMode(false);

    
    
    
    
    
    
    