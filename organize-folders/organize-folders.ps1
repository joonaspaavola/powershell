# Provide an array of folders which should be processes
# Use commas to separate folder paths
$folderArray = @('C:\Temp\Folder-1', 'C:\Temp\Folder-2')

foreach ($folder in $folderArray)
{
    # Create a list of files to archive
    $listOfFiles = Get-ChildItem $folder -File | where {!$_.PsIsContainer}
    
    # Target folder path to which files should be moved
    # Folders for year and month are automatically created
    $targetPath = $folder
 
    foreach ($file in $listOfFiles)
    {
        #Find the creation time for each file
        $createdYear = $file.CreationTime.Year.ToString()
        $createdMonth = $file.CreationTime.Month.ToString()

        # Print resulting filename, year and month
        # $file.Name
        # $createdYear
        # $createdMonth
 
        # Set output directory and check if such a folder already exists
        # If a directory cannot be found, it'll be created
        $outputDirectory = $targetPath + "\" + $createdYear + "\" + $createdMonth
        if (!(Test-Path $outputDirectory))
        {
            New-Item $outputDirectory -type Directory
        }
 
        # Move files
        $file | Move-Item -Destination $outputDirectory
    }
}