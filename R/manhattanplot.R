#' Creates a manhattan plot
#'
#' Creates a manhattan plot from PLINK assoc output (or any data frame with
#' chromosome, position, and p-value).
#'
#' @param df A data.frame with columns "BP," "CHR," "P," and optionally, "SNP."
#' @param chr A string denoting the column name for the chromosome. Defaults to
#'   PLINK's "CHR." Said column must be numeric. If you have X, Y, or MT
#'   chromosomes, be sure to renumber these 23, 24, 25, etc.
#' @param bp A string denoting the column name for the chromosomal position.
#'   Defaults to PLINK's "BP." Said column must be numeric.
#' @param p A string denoting the column name for the p-value. Defaults to
#'   PLINK's "P." Said column must be numeric.
#' @param snp A string denoting the column name for the SNP name (rs number).
#'   Defaults to PLINK's "SNP." Said column should be a character.
#' @param col A character vector indicating which colors to alternate.
#' @param chrlabs A character vector equal to the number of chromosomes
#'   specifying the chromosome labels (e.g., \code{c(1:22, "X", "Y", "MT")}).
#' @param suggestiveline Where to draw a "suggestive" line. Default
#'   -log10(1e-5). Set to FALSE to disable.
#' @param suggestiveline_col colour of suggestive line
#' @param genomewideline Where to draw a "genome-wide sigificant" line. Default
#'   -log10(5e-8). Set to FALSE to disable.
#' @param genomewideline_col colour of genomewide line
#' @param highlight A character vector of SNPs in your dataset to highlight.
#'   These SNPs should all be in your dataset.
#' @param highlight_col colour of highlighted SNPs
#' @param logp If TRUE, the -log10 of the p-value is plotted. It isn't very
#'   useful to plot raw p-values, but plotting the raw value could be useful for
#'   other genome-wide plots, for example, peak heights, bayes factors, test
#'   statistics, other "scores," etc.
#' @param annotatePval If set, SNPs below this p-value will be annotated on the plot. If logp is FALSE, SNPs above the specified value will be annotated.
#' @param annotateTop If TRUE, only annotates the top hit on each chromosome that is below the annotatePval threshold (or above if logp is FALSE).
#' @param ... Arguments passed on to other plot/points functions
#'
#' @return A manhattan plot.
#'
#' @keywords visualization manhattan
#' @export
manhattan <- function(df,
                      chr,
                      bp,
                      p,
                      snp,
                      col = c("gray10", "gray60"),
                      chrlabs = NULL,
                      suggestiveline = -log10(1e-5),
                      suggestiveline_col = "blue",
                      genomewideline = -log10(5e-8),
                      genomewideline_col = "red",
                      highlight = NULL,
                      highlight_col = "green3",
                      logp = TRUE,
                      annotatePval = NULL,
                      annotateTop = TRUE, ...) {

  # Not sure why, but package check will warn without this.

  # Check for sensible dataset
  ## Make sure you have chr, bp and p columns.
  if (!(chr %in% names(df))) stop(paste("Column", chr, "not found!"))
  if (!(bp %in% names(df))) stop(paste("Column", bp, "not found!"))
  if (!(p %in% names(df))) stop(paste("Column", p, "not found!"))
  ## warn if you don't have a snp column
  if (!(snp %in% names(df))) warning(paste("No SNP column found. OK unless you're trying to highlight."))
  ## make sure chr, bp, and p columns are numeric.
  if (!is.numeric(df[[chr]])) stop(paste(chr, "column should be numeric. Do you have 'X', 'Y', 'MT', etc? If so change to numbers and try again."))
  if (!is.numeric(df[[bp]])) stop(paste(bp, "column should be numeric."))
  if (!is.numeric(df[[p]])) stop(paste(p, "column should be numeric."))

  # If the input data frame has a SNP column, add it to the new data frame you're creating.
  if (!is.null(df[[snp]])) d = data.frame(CHR=df[[chr]], BP=df[[bp]], P=df[[p]], pos = NA, index = NA ,SNP=df[[snp]], stringsAsFactors = FALSE) else
    d = data.frame(CHR=df[[chr]], BP=df[[bp]], P=df[[p]], pos = NA, index = NA)


  # Set positions, ticks, and labels for plotting
  d <- d[order(d$CHR, d$BP), ]
  if (logp) {
    d$logp <- -log10(d$P)
  } else {
    d$logp <- d$P
  }

  # Fixes the bug where one chromosome is missing by adding a sequential index column.
  d$index = rep.int(seq_along(unique(d$CHR)), times = tapply(d$SNP,d$CHR,length))  # replcace the for loop of line 92-96 to improve efficiency

  # This section sets up positions and ticks. Ticks should be placed in the middle of a chromosome
  nchr = length(unique(d$CHR))
  if (nchr==1) {
    d$pos=d$BP
    xlabel = paste('Chromosome',unique(d$CHR),'position')
  } else {
    lastbase=0
    ticks=NULL
    for (i in unique(d$index)) {
      if (i==1) {
        d[d$index==i, ]$pos=d[d$index==i, ]$BP
      } else {
        ## chromosome position maybe not start at 1, eg. 9999. So gaps may be produced.
        lastbase = lastbase +max(d[d$index==(i-1),"BP"])   # replace line 128
        d[d$index == i,"BP"] = d[d$index == i,"BP"]-min(d[d$index==i,"BP"]) +1
        d[d$index == i, "pos"] = d[d$index == i,"BP"] + lastbase    # replace line 129
      }
    }
    ticks <- tapply(d$pos,d$index, stats::quantile,probs=0.5)   # replace line 135
    xlabel <- 'Chromosome'
    labs <- unique(d$CHR)
  }

  # Initialize plot
  xmax = ceiling(max(d$pos) * 1.03)
  xmin = floor(max(d$pos) * -0.03)

  def_args <- list(xaxt='n', bty='n', xaxs='i', yaxs='i', las=1, pch=20,
                   xlim=c(xmin,xmax), ylim=c(0,ceiling(max(d$logp))),
                   xlab=xlabel, ylab=expression(-log[10](italic(p))))
  ## Next, get a list of ... arguments
  #dotargs <- as.list(match.call())[-1L]
  dotargs <- list(...)
  ## And call the plot function passing NA, your ... arguments, and the default
  ## arguments that were not defined in the ... arguments.
  do.call("plot", c(NA, dotargs, def_args[!names(def_args) %in% names(dotargs)]))

  # If manually specifying chromosome labels, ensure a character vector and number of labels matches number chrs.
  if (!is.null(chrlabs)) {
    if (is.character(chrlabs)) {
      if (length(chrlabs)==length(labs)) {
        labs <- chrlabs
      } else {
        warning("You're trying to specify chromosome labels but the number of labels != number of chromosomes.")
      }
    } else {
      warning("If you're trying to specify chromosome labels, chrlabs must be a character vector")
    }
  }

  # Add an axis.
  if (nchr==1) { #If single chromosome, ticks and labels automatic.
    graphics::axis(1, ...)
  } else { # if multiple chrs, use the ticks and labels you created above.
    graphics::axis(1, at=ticks, labels=labs, ...)
  }

  # Create a vector of alternatiting colors
  #col=rep(col, max(d$CHR))  # replaced by line 187
  col = rep_len(col, max(d$index))  ## mean this one?  the results are same

  # Add points to the plot
  if (nchr==1) {
    with(d, graphics::points(pos, logp, pch=20, col=col[1], ...))
  } else {
    # if multiple chromosomes, need to alternate colors and increase the color index (icol) each chr.
    icol=1
    for (i in unique(d$index)) {
      #with(d[d$index==unique(d$index)[i], ], points(pos, logp, col=col[icol], pch=20, ...))
      graphics::points(d[d$index==i,"pos"], d[d$index==i,"logp"], col=col[icol], pch=20, ...)
      icol=icol+1
    }
  }

  # Add suggestive and genomewide lines
  if (suggestiveline) graphics::abline(h=suggestiveline, col = genomewideline_col)
  if (genomewideline) graphics::abline(h=genomewideline, col = suggestiveline_col)

  # Highlight snps from a character vector
  if (!is.null(highlight)) {
    if (any(!(highlight %in% d$SNP))) warning("You're trying to highlight SNPs that don't exist in your results.")
    d.highlight=d[which(d$SNP %in% highlight), ]
    with(d.highlight, points(pos, logp, col = highlight_col, pch=20, ...))
  }

  # Highlight top SNPs
  if (!is.null(annotatePval)) {
    # extract top SNPs at given p-val
    if (logp) {
      topHits = subset(d, P <= annotatePval)
    } else
      topHits = subset(d, P >= annotatePval)
    graphics::par(xpd = TRUE)
    # annotate these SNPs
    if (annotateTop == FALSE) {
      if (logp) {
        with(subset(d, P <= annotatePval),
             calibrate::textxy(pos, -log10(P), offset = 0.625, labs = topHits$SNP, cex = 0.45), ...)
      } else
        with(subset(d, P >= annotatePval),
             calibrate::textxy(pos, P, offset = 0.625, labs = topHits$SNP, cex = 0.45), ...)
    }
    else {
      # could try alternative, annotate top SNP of each sig chr
      topHits <- topHits[order(topHits$P),]
      topSNPs <- NULL

      for (i in unique(topHits$CHR)) {

        chrSNPs <- topHits[topHits$CHR == i,]
        topSNPs <- rbind(topSNPs, chrSNPs[1,])

      }
      if (logp ){
        calibrate::textxy(topSNPs$pos, -log10(topSNPs$P), offset = 0.625, labs = topSNPs$SNP, cex = 0.5, ...)
      } else
        calibrate::textxy(topSNPs$pos, topSNPs$P, offset = 0.625, labs = topSNPs$SNP, cex = 0.5, ...)
    }
  }
  graphics::par(xpd = FALSE)
}

