Use .cel files and the following order:
1.	Pancreas_limma.R
  # read .cel files, perform RMA, fit linear model, perform eBayes, annotate with gene information.
2.	drop_duplicate_genes.py
  # removes rows with NA, sorts by SYMBOL and then P.Value, drops duplicate gene
3.	volcano_plot.py
  # creates volcano plot from RMA_pancreas.csv (generated using drop_duplicate_genes.py)
4.	mas5.R
  # read .cel files, perform mas5 for RFE
5.	transpose.py
  # data from mas5.R
  # transposes large dataframes
6.	merge_mas5_geneID.py
  # data from transpose.py
  # Data cleaning, join mas5 and gene ID data
7.	merge_ebayes_mas5_annotation.py
  # data from merge_mas5_geneID.py (mas5_gene_pancreas.csv) and drop_duplicate.gene.py (pancreas_final_drop.csv)
  # Data cleaning, join mas5 and gene ID data
8.	final_ mas5_drop_pancreas.csv is transposed using transpose.py
9.	remove_rows.py
  # makes SYMBOL row header row
  # removes non-mas5 data rows
10.	RFE_number_features.py
  # evaluate RFE for classification
11.	rfe.py
  # performs recursive feature elimination (RFE)
