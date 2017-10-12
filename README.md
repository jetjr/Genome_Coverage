## Genome Coverage
Generates a "depth of coverage" graph using a sample file containing WGS reads and a reference genome.

# Instructions for use:

    $ git pull 

Edit the config.sh file for the following variables:

SEQ=/full/path/to/reference.fasta
SAMPLE=/full/path/to/sample.fasta
OUT=/full/path/to/output/directory

To run the job, execute "submit.sh"
    $ ./submit.sh

This version only supports generating a single coverage graph at a time. 

# Output:

A coverage graph will be generated using the data contained in [sample].coverage file. The Y-axis describes the number of reads that matched the reference at the position specified on the X-axis. 
