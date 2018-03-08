#!/usr/bin/env cwl-runner

class: CommandLineTool
label: "STAR-fusion workflow by Jacob Pfeil; CWL by Jeltje van Baren"
cwlVersion: v1.0

doc: |
     STAR-Fusion workflow by Jacob Pfeil; CWL by Jeltje van Baren

dct:creator:
  "@id": "https://orcid.org/0000-0002-8773-8520"
  foaf:name: Jacob Pfeil
  foaf:mbox: "mailto:jpfeil@ucsc.edu"

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: "ucsctreehouse/fusion:0.3.0"

baseCommand: []

inputs:

  fastq1:
    type: File
    inputBinding:
      prefix: --left-fq

  fastq2:
    type: File
    inputBinding:
      prefix: --right-fq

  outputdir:
    type: string
    default: starfusion_out 
    inputBinding:
      prefix: --output-dir

  tar_gz:
    type: string
    default: starfusion_out
    inputBinding:
      prefix: --tar-gz

  index:
    type: File
    inputBinding:
      prefix: --genome-lib-dir

  do_untar:
    type: boolean
    default: True
    inputBinding:
      prefix: --untargz-ref

  cpu:
    type: int
    default: 8
    inputBinding:
      prefix: --CPU

  genelist:
    type: File?
    inputBinding:
      prefix: --genelist

  skip_filter:
    type: boolean
    default: False
    inputBinding:
      prefix: --skip-filter

  save_intermediates:
    type: boolean
    default: False
    inputBinding:
      prefix: --save-intermediates

  root-ownership:
    type: boolean
    default: True
    inputBinding:
      prefix: --root-ownership

  test:
    type: boolean
    default: False
    inputBinding:
      prefix: --test

outputs:
  output_files:
    type: File
    outputBinding:
       glob: $(inputs.outputdir + '/*.tar.gz')


