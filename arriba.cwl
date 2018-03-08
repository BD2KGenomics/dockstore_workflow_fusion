#!/usr/bin/env cwl-runner

class: CommandLineTool
id: "dockstore_tool_arriba"
label: "Arriba workflow by Sebastian Uhrig; CWL by Jeltje van Baren"
cwlVersion: v1.0

dct:creator:
  "@id": "jeltje"
  foaf:name: Jeltje van Baren
  foaf:mbox: "mailto:jeltje.van.baren@gmail.com"

doc: |
     Arriba workflow by Sebastian Uhrig; CWL by Jeltje van Baren

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: "quay.io/ucsc_cgl/dockstore_tool_arriba:0.12.0"

baseCommand: ["run_arriba"]

inputs:

  fastq1:
    type: File
    inputBinding:
      prefix: -f

  fastq2:
    type: File
    inputBinding:
      prefix: -r

  genofa:
    type: File
    inputBinding:
      prefix: -a

  genoversion:
    type: string
    inputBinding:
      prefix: -b

  annotation:
    type: File
    inputBinding:
      prefix: -g

  knownfusions:
    type: File
    inputBinding:
      prefix: -k

  outputdir:
    type: string
    default: arriba_out 
    inputBinding:
      prefix: -o

  star_index:
    type: File
    inputBinding:
      prefix: -s

  threads:
    type: int
    default: 8
    inputBinding:
      prefix: -T

outputs:
  output_file:
    type: File
    outputBinding:
       glob: $(inputs.outputdir + '/fusions.tsv')


