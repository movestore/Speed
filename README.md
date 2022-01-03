# Speed Between Locations

MoveApps

Github repository: https://github.com/movestore/Speed_BetweenLocations

## Description
Calculation of the speed between consecutive locations.

## Documentation
This App calculates speed between each consecutive locations. This measurement is a segment characteristic, and will be assigned to the first location of each segment. Therefore the speed of the last location of the track will be set to NA.

**Units**: map units/second. If the the coordinates are geographic (i.e.long/lat) all values are returned in "m/s", otherwise in the "map units/second" of the current projection. 

A histogram of the speed distribution of all individuals and per individual is automatically created and can be downloaded in the output as a pdf

A column named _**speed**_ will be appended to the dataset that is returned for further use in next Apps. This column also contains the **unit** information in which the speed was calculated.

### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
`speeds_histogram.pdf`: PDF with histograms of the speeds per individual

### Parameters
no parameters

### Null or error handling
**Data**: The full input dataset with the addition of speed is returned for further use in a next App and cannot be empty.

**Units**: If the projection does not have defined units, a warning message will be issued
