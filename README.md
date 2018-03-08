# dockstore_workflow_fusion

**This repository contains cwl to run the docker implementations of two fusion finding tools: STAR-Fusion and Arriba.**

For details on the individual tools, see the [Arriba](https://github.com/BD2KGenomics/dockstore_tool_arriba) and [STAR-Fusion](https://github.com/UCSC-Treehouse/fusion) github repos for the docker implementations, and the original [STAR-Fusion](https://github.com/STAR-Fusion/STAR-Fusion/wiki) and [Arriba](https://github.com/suhrig/arriba) github repositories.

This workflow is hosted on Dockstore as BD2KGenomics/dockstore_workflow_fusion

### Why these two tools

In a comparative analysis of fusion finder programs (see https://www.synapse.org/#!Synapse:syn2813589/wiki/401435), 
both programs consistently performed better than most other callers tested. For weaker signals (fewer reads per fusion), they tend to be sensitive to different fusions, so one may pick up fusions the other does not.

As a general note, fusion finders tend to overpredict. They are therefore more suitable to be run on cohorts than on individual samples.

### Inputs to the combined workflow:

`FASTQ1` and `FASTQ2`	are (gzipped) fastq format files of RNA-Seq reads aligned to the genome. 

`STAR_INDEX`	are [all the files](https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/) necessary to run STAR-Fusion and STAR. **See note below**

`CPUS`	number of CPUs to use. Both programs use this feature to speed up their workflows.

`GENO_FA_GZ`	is the genome in gzipped fasta format. Arriba expects this genome to be either hg19 (GRCHh37) or hg38 (GRCh38)

`GENOME_VERSION`	is used to determine which of the (Arriba supplied) blacklists to use. Should be hg19 or hg38

`GTF`	is the (optionally gzipped) [Gencode genome annotation](https://www.gencodegenes.org/releases/current.html) file for the sequence above. Note that the STAR-Fusion index also contains a GTF file, but it's not formatted correctly for Arriba.

`KNOWN_FUSIONS`	is a list of paired gene names that occur in the annotation GTF file. To obtain this list, follow instructions at [readthedocs] (http://arriba.readthedocs.io/en/latest/input-files/). **NOTE**: You will have to register with Cosmic to obtain the list, and will not have permissions to redistribute it. This is why the list is not provided with this code, or with Arriba itself.

**Note**: The STAR aligner is used by both programs, _but with different settings_. In the current setup, the input directory to STAR should be a subdirectory of the input directory to STAR-Fusion. Please follow directions under [Preparing the genome resource lib](https://github.com/STAR-Fusion/STAR-Fusion/wiki) at the STAR-Fusion wiki.


### Output

Arriba and STAR output several files. Only Arriba's `fusions.tsv` is retained here. Output for STAR-Fusion is a `tar.gz` file that contains a filtered and an unfiltered fusions list.

Note that Arriba's fusions file lists a `confidence` in field 15, which can be 'high', 'low', or 'medium'. Please take this information into account when determining which calls to trust.

Generally, fusion calling programs will find a number of false positives and miss weaker signals. STAR-Fusion and Arriba tend to find slightly different fusion sets.


