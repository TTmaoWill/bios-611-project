.PHONY: clean

clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirs
	rm -f report.pdf

.created-dirs:
	mkdir -p figures
	mkdir -p derived_data
	touch .created-dirs

# It is usefual to propogate the panas_na and panas_pa values forward
# in time for subsequent analysis which attempts to cluster the state
# of each person in the study regardless of time so that we can track
# their progress through a lower dimensional space.
derived_data/processed.csv: .created-dirs preprocess.R source_data/data.csv
	Rscript preprocess.R

# Draw the histograms
figures/hists.png: .created-dirs hists.R derived_data/processed.csv
	Rscript hists.R

# Draw a PCA plot of PC1 and PC2
figures/pca.png: .created-dirs make_pca.R derived_data/processed.csv
	Rscript make_pca.R

# Draw a tSNE plot
figures/tsne.png: .created-dirs make_tsne.R derived_data/processed.csv
	Rscript make_tsne.R

# Draw the ROC curve plot
figures/roc.png: .created-dirs logit_reg_roc.R derived_data/processed.csv
	Rscript logit_reg_roc.R

# Produce the final report
report.pdf: figures/hists.png figures/pca.png figures/tsne.png figures/roc.png report.Rmd
	R -e "rmarkdown::render(\"report.Rmd\", output_format=\"pdf_document\")"