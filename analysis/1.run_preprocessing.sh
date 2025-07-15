#!/bin/bash

# Run only the preprocess rules
snakemake --use-conda --cores all \
    --snakefile "../brieflow/workflow/Snakefile" \
    --configfile "config/config.yml" \
    --until all_preprocess -n
