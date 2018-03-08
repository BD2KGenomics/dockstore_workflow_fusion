#!/usr/bin/env cwl-runner
#

class: Workflow
cwlVersion: v1.0

doc: "Fusion workflow, runs STARFusion and Arriba"

requirements:
  - class: MultipleInputFeatureRequirement
  - class: StepInputExpressionRequirement
  - class: InlineJavascriptRequirement

inputs:

  FASTQ1: File

  FASTQ2: File

  STAR_INDEX: File

  CPUS: int

  GENO_FA_GZ: File

  GTF: File

  GENOME_VERSION: string

  KNOWN_FUSIONS: File

outputs:

  STARFUSIONS:
    type: File
    outputSource: starfusion/output_files

  ARRIBAFUSIONS:
    type: File
    outputSource: arriba/output_file


steps:

  starfusion:
    run: starfusion.cwl
    in:
      fastq1: FASTQ1
      fastq2: FASTQ2
      index: STAR_INDEX
      cpu: CPUS
    out:
      [output_files]

  arriba:
    run: arriba.cwl
    in:
      fastq1: FASTQ1
      fastq2: FASTQ2
      genofa: GENO_FA_GZ
      genoversion: GENOME_VERSION
      annotation: GTF
      knownfusions: KNOWN_FUSIONS
      star_index: STAR_INDEX
      threads: CPUS
    out:
      [output_file]


