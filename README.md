# STRAH
**STRAH** is an R package to search for short tandem repeats (STR) in a specified region of the (human) chromosome. This analysis can also be expanded when specifying that several chromosomes should be studied. These STRs can be grouped into hotspot as well as flanking regions of user specified length. Hotspots are defined by the double strand break maps from Pratto et al. (2014). Moreover, we implemented a function to search for a specified motif in a provided DNAStringSet-object, or a fasta-file, or a specified region of the (human) chromosome. For further details see the [PDF Manual](./STRAH.pdf) with complete documentation for each function. The accompanying paper with an application of STRAH can be found [here](<https://doi.org/10.26508/lsa.201900364>). 

### Authors (Requests)
Please contact us in case of questions, comments, bug reports, etc...

    Authors: Philipp Hermann, Monika Heinzl, Angelika Heissl, Irene Tiemann-Boege, Andreas Futschik
    E-Mail: philipp.hermann@jku.at, monika.heinzl@edumail.at

## Dependencies & System Requirements
This package makes use of functions of other R-packages. Here we provide the list of the used R-packages: 

* R (>= 2.10)
* Biostrings (>= 2.38.4)
* BSgenome.Hsapiens.UCSC.hg19

Notice that [Biostrings](<http://bioconductor.org/packages/release/bioc/html/Biostrings.html>) and [BSgenome.Hsapiens.UCSC.hg19](<https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg19.html>) need to be installed via Biocondutor using the underlying links.

## Installation
The ZIP-File of the package can be downloaded via "Clone or download" as well as the command line: 

```markdown
git clone https://github.com/PhHermann/STRAH.git
R CMD build STRAH
R CMD INSTALL STRAH_<version>.tar.gz
``` 

Using *R* one can also install the *.tar.gz* file with the following command: 
```R
install.packages("/PathToSTRAH/STRAH_<version>.tar.gz", repos=NULL, type="source")
```

## Usage

### STR_analysis
After loading the package in the workspace one can use the main function *STR_analysis* in order to analyse Short Tandem Repeats (STRs) in a given sequence of the (human) chromosome under study. This function calls *STR_detection* but we start with the description of *STR_analysis* and then explain further options with *STR_detection*. 

```R
require(STRAH)
STR_analysis(nr.STRs = 10, nr.mismatch = 0, chrs = "chr22", STR = "A", lens.grey = 0:5*1000,
  addToHs = 0, start.position = 30000000, end.position = 40000000, reverse.comp = FALSE, 
  bed_file = "", pos_matrix = "", output_file="")
```

Detailed descriptions of the main functions and all adjacent functions to detect and analyze STRs can be found via e.g.

```R
?STRAH
```
The first two function arguments *nr.STRs* and *nr.mismatch* contain the minimum length of the short tandem repeat and the number of allowed mismatches per STR. Hence, both are non-negative integer parameters and we recommend to only search for STRs of at least length 6. 

A string parameter *chrs* reflects the chromosome to be analyzed. This parameter should start with "chr" and is followed either by one of the intergers 1-22 or "X" or "Y". This parameter can also be a vector of several strings (or integers) to study several chromosomes. 

A string parameter *STR* equals to one of the nucleotides A,C,G,T and by default one searches for poly-As (set to "A"). 

An integer parameter vector *lens.grey* contains the lengths of the regions to be analysed as outside regions next to the hotspot positions used. By default it is a vector of 6 integer values ending up with 5 regions of length 1kb, left and right from the hotspot regions. 

An optional integer argument *addToHs* enables to enlarge the analyzed hotspot zones left and right by a positive integer value. 

The two arguments *start.position* and *end.position* contain the corresponding positions on the chromosome and are indicated with positive integer values. Naturally, these positions must fit the start and end position of the given chromosome. If these are set to *NA*, then the function will analyze from the first position and until the last position of the chromosome. They can also be set separately to *NA* to search either from the starting position or until the end position if *start.position* or *end.position* are set to *NA*, respectively. If one wants to use several chromosomes with different start and end positions, we refer to the arguments *bed_file* or *pos_matrix*.

A logical parameter *reverse.comp* is by default *FALSE*, but if set to *TRUE* it enables to search for STRs on the reverse complement. 

With the string parameter *bed_file* (leading to a prepared bed-file), **STRAH** reads the chromosome, start, and end position of the regions to be analyzed. These data can also be fed with the argument *pos_matrix*. 

The parameter *species* enables to use other reference genomes than the human one installing for instance the chimpanzees reference genome *BSgenome.Ptroglodytes.UCSC.panTro5* via e.g.:

```R
source("http://bioconductor.org/biocLite.R")
biocLite("BSgenome.Ptroglodytes.UCSC.panTro5")
library(BSgenome.Ptroglodytes.UCSC.panTro5)
```

The string parameter *dsb_map* is set to the human DSB map of Pratto et al. (2014) by default. It can be changed to maps of different genomes. The DSB map for chimpanzees is included in the package which was tranlated via [liftOver](<https://genome.ucsc.edu/cgi-bin/hgLiftOver>) of the UCSC Genome Browser. 

A user defined string *output_file* excluding the extension (always .bed) writes the output to this filename. By default it is an empty string and does not save an output file. 

### STR_detection

The function *STR_detection* detects short tandem repeats in any genome provided by the user. An example for the download of the chimpanzees reference genome can be found in the previous section. The following example shows how to detect STRs in the chimpanzees reference genome:

```R
require(STRAH)
STR_detection(seqName = "", chrs = "chr1", start.position =222339618, end.position = 222339660,
 nr.STRs = 10, nr.mismatch = 0, reverse.comp = FALSE, STR = "A", species = BSgenome.Ptroglodytes.UCSC.panTro5)
```

The logical parameter *translated_regions* is *FALSE* by default. If set to *TRUE* then the function assumes that the parameters *start.position* and *end.position* were translated by some tool (e.g. [liftOver](<https://genome.ucsc.edu/cgi-bin/hgLiftOver>)) from one species to another. The untranslated and translated positions are included in the output.

### Motif_detection

This function searches for a given "motif" in a sequence (*seqName*). The argument *seqName* can be either a *DNAStringSet* object or refers to a fasta-file. Additionally, we provide the option to specify a chromosome as well as start and stop position for a region of the human genome to be analyzed. Optionally, one can also specify the number of mismatches and whether the reverse complement has to be searched.

```R
motif_detection(seqName = chr6_1580213_1582559, chrs="",
 start.position = NA, end.position = NA, motif = "CCNCCNTNNCCNC",
nr.mismatch = 1, reverse.comp = FALSE, print.status = TRUE)

motif_detection(seqName = "", chrs = "chr6", start.position = 1580213, end.position = 1582559,  motif = "CCNCCNTNNCCNC", nr.mismatch = 1, reverse.comp = FALSE, print.status = FALSE)
```

The following command detects the specified "motif" in the chimpanzees reference genome: 

```R
motif_detection(seqName = "", chrs = "chr1", start.position =222339618, end.position = 222339660, motif = "A", nr.mismatch = 0, reverse.comp = FALSE, print.status = FALSE, species = BSgenome.Ptroglodytes.UCSC.panTro5)
```

# References 
Heissl, A., Betancourt, A. J., Hermann, P., Povysil, G., Arbeithuber, B., Futschik, A., Ebner, T., Tiemann-Boege, I. (2018). Length asymmetry and heterozygosity strongly influences the evolution of poly-A microsatellites at meiotic recombination hotspots. bioRxiv 431841; [doi](<https://doi.org/10.1101/431841>). 

Pratto, F., Brick, K., Khil, P., Smagulova, F., Petukhova, G. V. & Camerini-Otero, R. D. (2014) DNA recombination. Recombination initiation maps of individual human genomes. Science, 825 346, 1256442. 

Kuhn RM, et al. (2013) The UCSC genome browser and associated tools, Brief. Bioinform., 14, 144-161.
