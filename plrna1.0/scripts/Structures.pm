package Structures;

use strict;
use warnings;

# Copyright 2008 by Jakob Hull Havgaard. hull@genome.ku.dk


# The functions in this package are used for working with structures and
# sequences.

sub reverseComplement {

	my ($sequence) = @_;
	
	my $reverse = reverse $sequence;
	
	# Note: A's are changed into U's not T's (RNA not DNA)
	$reverse =~ tr/ACGTUacgtu/UGCAAugcaa/;

	return $reverse;
}

sub reverseComplementStructure {

	my ($structure) = @_;
	
	my $reverse = reverse $structure;
	
	$reverse =~ tr/()[]{}<>/)(][}{></;

	return $reverse;
}


sub id {

	# Calculate the idendity between two sequences. Gaps are not counted. Case is
	# ignored
	
	#   The first sequence
	#          # The second sequence
	#                 # The gap character
	my ($seq1, $seq2, $gap) = @_;
	
	my $len = length($seq1);
	
	if (length($seq2) != $len) {warn "$seq1, $seq2\n";}
	
	my $count = 0;
	my $sim = 0;
	for(my $i=0; $i < $len; $i++) {
		my $let1 = uc substr($seq1, $i, 1);
		my $let2 = uc substr($seq2, $i, 1);
		
		if ($let1 eq $gap or $let2 eq $gap) {next;}
		
		$count++;
		if ($let1 eq $let2) {$sim++;}
	}
	
	if ($count == 0) {return 0;}
	return $sim/$count;
}


sub cleantab {

	# Removes gaps from the sequence and structure. The sequence will be changed
	# to uppercase. Also any non-standard base-pairs are removed from the
	# structure. Which basepairs are allowed is set in the canonWoble function

	    # A reference to the sequence
		       # A reference to the structure
				         # A reg exp matching the gaps
							      # The base-pair open character
									       # The base-pair close character
											         # The single strand character
														         # If true non standard base-
																	# pairs are allowed. The 
																	# standard bps are:
																	# A-U, G-C, G-U.
																				  # If true gaps
																				  # are not removed
	my ($seq, $struc, $gap, $open, $close, $single, $noncanon, $keepGaps, $noLonePairs) = @_;

	$$seq = uc $$seq;
	
	$$struc =~ s/[^$open$close$single]/$single/g;
	
	&canonWoble($seq, $struc, $noncanon, $noLonePairs, $gap, $open, $close, $single);
	
	unless ($keepGaps) {&rmGaps($seq, $struc, $gap);}
	
	if (length($$seq) != length($$struc)) {warn "Sequence and structure does not have the same length for sequence.\n";}

}

sub rmGaps {

	my ($seq, $struc, $gap) = @_;

	my $rmlet = "q";
	
	if ($$struc =~ /$rmlet/) {warn "A sequence contains the rmlet character\n";}

	while ($$seq =~ /$gap/g) {
	
		substr($$struc, pos($$seq) -1, 1) = $rmlet;
		
	}

	$$seq =~ s/$gap//g;
	$$struc =~ s/$rmlet//g;


}

sub canonWoble {

	# Remove any basepair where either of the nucleotides are gaps. If the
	# parameter noncanon is false then all noncanonical (or those not in the %bp)
	# basepairs are changed to single strand nucleotides.

		 # A reference to the sequence
		       # A reference to the structure
				         # If true then basepairs not in the %bp hash are allowed
							           # Gap character
										        # Bp open character
												         # Bp close character
															        # Single strand nuc chr.
	my ($seq, $struc, $noncanon, $noLonePairs, $gap, $open, $close, $single) = @_;
	
	# This hash holds the allowed basepairs
	my %bp;
	$bp{"A"}{"U"} = 1;
	$bp{"C"}{"G"} = 1;
	$bp{"G"}{"C"} = 1;
	$bp{"G"}{"U"} = 1;
	$bp{"U"}{"A"} = 1;
	$bp{"U"}{"G"} = 1;


	my %struc;
	&parsestruc($seq, $struc, \%struc, $gap, $open, $close, $single);
	
	$$struc = "";
	my $len = length($$seq);
	unless ($noncanon) {
		for(my $i=0; $i<$len; $i++) {
	
			my $pos = $i+1;
			if ($struc{$pos} > $pos) {
				
				my $nuc1 = substr($$seq, $i, 1);
				my $nuc2 = substr($$seq, $struc{$pos} -1, 1);

				unless (defined $bp{$nuc1}{$nuc2}) {
					my $pos2 = $struc{$pos};
					$struc{$pos2} = -1;
					$struc{$pos} = -1;
				}
			}
		}
	}

	for(my $i=0; $i<$len; $i++) {
		my $pos = $i+1;
		if ($struc{$pos} > $pos) {

			if ($noLonePairs) {
				my $cl = $struc{$pos};
				if (defined $struc{$pos-1} and defined $struc{$pos+1} and
					 defined $struc{$cl-1} and defined $struc{$cl+1} and
					 $struc{$pos-1} == -1 and $struc{$pos+1} == -1 and 
					 $struc{$cl-1} == -1 and $struc{$cl+1} == -1) {
					$struc{$pos} = -1;
					$struc{$cl} = -1;
					$$struc .= $single;
					next;
				}
			}
			
			$$struc .= $open;
		}
		elsif ($struc{$pos} > -1) {
			$$struc .= $close;
		}
		else {$$struc .= $single;}
	}


}


sub parsestruc {
	# Parse the basepairing structure. The $anno structure in () format is parsed
	# into a hash where position in the structure is used as index. The value
	# is the other partner in a basepair for basepairs and -1 for single strand
	# nucleotides. Basepairs where either of the nucleotides is a gap are
	# parsed as single stranded. The main result is the parsed structure returned
	# through the $data hash, but the number of basepairs is the return value of
	# the function.
	# So far this only works for global structures

		 # A reference to the sequence
		       # A reference to the structure
				        # A reference to the hash holding the parsed structure
						         # The gap, bp open, bp close and single strand chr.
	my ($seq, $anno, $data, $gap, $open, $close, $singel) = @_; # The annotation and the structure

	my $notBp = -1; # Unpaired nucleotides get this value
	my $len = length($$seq);
	my $begin = 1; # No local structures
	my $end = $len;
	my @lager;   # A stack
	my $n;
	my $countbp=0;

	# Erase any old structure
	undef(%$data);

	for(my $i=$begin-1; $i<$end; $i++) {
		$n=$i+1;

		my $struc = substr($$anno,$i,1);
		my $nuc = substr($$seq, $i,1);

		if ($struc eq $open) {

			# This is the left side of a base pair

			if ($nuc eq $gap) {
				# Gaps can not base pair
				$$data{$n} = $notBp;
			}
			# If its the left part of a basepair put it in the stack
			push(@lager, $n); 
		}
		elsif ($struc eq $close) {

			# This is the right side of a base pair

			# The left side of a basepair
			my $start;
			
			if ($#lager < 0) {print STDERR "Could not parse stack. Underflow error\n";$start = 0;}
			else {
				# Get the left side from the stack
				$start = pop(@lager);
			}
			
			if ((defined $$data{$start}) and ($$data{$start} == $notBp)) {
				# The left side of the base pair is a gap. This position is not base
				# paired.
				$$data{$n} = $notBp;
			}
			else {
				if ($nuc eq $gap) {
					# This position is a gap.
					$$data{$n} = $notBp;
					# The left side of the base pair no longer base pairs.
					$$data{$start} = $notBp;
				}
				else {
					# Put the complementary positions into the structure
					$$data{$start} = $n;
					$$data{$n} = $start;
					$countbp++;
				}
			}
		}
		else {
			# No basepairing
			if ($struc eq $singel) {
				$$data{$n} = $notBp;
			}
			else {
				warn "Im not sure this point should ever be reached (in parsestruc)\n";
			}
		}
	}
	if ($#lager != -1) {print STDERR "Could not parse stack. $#lager elements left in the stack\n";}
	while (my $start = pop(@lager)) {$$data{$start} = $notBp; warn "The base pair stack is not empty\n";}

	#foreach my $p (sort {$a <=> $b} keys %$data) {warn "$p\t$$data{$p}\n";}
	return $countbp;
}

sub readTab {

	my ($file, $anno) = @_;

	# Read the tabfile
	# Foreach key (sequence id) in the $anno hash
	# store an array with the "official" structure type at position 0,
	# and an array with the structure types, and their start & stop positions
	# as the 1 position
	open(IN, $file) or die "Could not open file: $file\n$!";
	while(<IN>) {
		my ($seqName, $seq, $structure, $type, @motifs) = split " ";
#		my @in = split(/\s+/);
		if (defined $$anno{$seqName}) {
			warn "$seqName has been seen before. Something is rotten\n";
			next;
		}

		push @{$$anno{$seqName}}, $type;

		# Get struture types and their positions
		my ($start, $stop) = $seqName =~ /(\d+)-(\d+)$/;

		my $length = $stop - $start +1;
		my $isSequenceForward = 1;
		if ($start > $stop) {
			$length = $start - $stop +1;
			$isSequenceForward = 0;
#			&swap(\$start, \$stop);
		}
		for(my $i=0; $i <= $#motifs; $i++) {

			my ($t, $b, $e) = $motifs[$i] =~ /^(.*)\/(\d+)-(\d+)$/;

			my $begin;
			my $end;
			if ($isSequenceForward) {
				if ($b > $e) {
					&swap(\$b, \$e);
				}
				$begin = $b-$start+1;
				$end = $e-$start+1;
			}
			else {
				if ($b < $e) {
					&swap(\$b, \$e);
				}
				$begin = $start - $b+1;
				$end = $start - $e+1;
			}
			if ($begin < 1) {
				$begin = 1;
			}
			if ($end > $length) {
				$end = $length;
			}
			push @{$anno->{$seqName}[1]}, [$t, $begin, $end];
		}
	}
	close IN;
}

sub readOldTab {

	my ($file, $anno) = @_;

	# Read the tabfile
	# Foreach key (sequence id) in the $anno hash
	# store an array with the "official" structure type at position 0,
	# and an array with the structure types, and their start & stop positions
	# as the 1 position
	open(IN, $file) or die "Could not open file: $file\n$!";
	while(<IN>) {
		my ($seqName, $seq, $structure, $startStop, @motifs) = split " ";
		my $id = pop @motifs;

		if (defined $$anno{$seqName}) {
			warn "$seqName has been seen before. Something is rotten\n";
			next;
		}

		my $type = getType($structure, \@motifs);

		push @{$$anno{$seqName}}, $type;

		# Get struture types and their positions
		my ($start, $stop) = $startStop =~ /(\d+)-(\d+)$/;

		my $length = $stop - $start +1;
		my $isSequenceForward = 1;
		if ($start > $stop) {
			$length = $start - $stop +1;
			$isSequenceForward = 0;
#			&swap(\$start, \$stop);
		}
		for(my $i=0; $i <= $#motifs; $i++) {

			$structure =~ /([^-]+)/g;
			my $e = pos $structure;
			my $b = $e - length $1;
			my $t = $motifs[$i];

			push @{$anno->{$seqName}[1]}, [$t, $b, $e];
		}
	}
	close IN;
}

sub getType {

	my ($structure, $motifs) = @_;
	
	my $count = 0;
	while ($structure =~ /([^-]+)/g) {
		my $motif = $1;
		if ($motif =~ /[\(\)\.]/) {
			return $$motifs[$count];
		}
		$count++;
	}
	warn "No type found in perl module Structures.pm function getType";
}

sub checkGeneOverLap {

	my ($n, $b, $e, $annos, $good) = @_;

	# Find the annotated genes a prediction overlaps
	# if more than half of the prediction overlaps annotations then this is a
	# true positive prediction

	my $tp = 0;
	my $l = $e - $b+1;
	foreach my $anno (@$annos) {
		my ($t, $st, $sl) = @$anno;

		if ($b <= $sl and $e >= $st) {
			if ($b < $st) {
				if ($e > $sl) {
					$tp += $sl - $st +1;
				}
				else {
					$tp += $e - $st +1;
				}
	    	}
	    	else {
				if ($e > $sl) {
					$tp += $sl - $b +1;
				}
				else {
					$tp += $e - $b +1;
				}
			}
			push @$good, $anno;
		}
	}

	if ($tp/$l > 0.5) {return 1;}
	else {return 0;}
}

sub calcGenePPVSens {

	my ($hits, $annotation, $name1, $name2) = @_;

	# Count the number of:
	# annotated genes which are also predicted (tp),
	# annotated genes which are not predicted (fn, genes),
	# predicted genes which are not annotated (fp)
	
	# A prediction where more than half of prediction overlaps annotated
	# structures are counted as a true predictions, if it is less then
	# it is counted as a false positive. Each gene can only be counted once.

	# The annotated genes
	my %genes;
	# The genes which have already been found
	my %found;
	# The correctly predicted genes
	my %tp;
	# The false positive predictions
	my $fp = 0;

	my $annoArrayPosInAnnotation = 1;

	countSameGenePairs($annotation, $name1, $name2, \%genes, \%found, \%tp);

	# Check all the hits
	foreach my $hit (@$hits) {

		my ($n1, $b1, $e1, $n2, $b2, $e2) = split(/\s+/, $hit);
		my $found = 0;

		# These are the annoted genes this prediction overlaps
		my @foundGenes1;
		my @foundGenes2;

		# Does the prediction overlap annotation in both sequences? if not then
		# the prediction is a false positive
		if (&checkGeneOverLap($n1, $b1, $e1, \@{$annotation->{$name1}[1]}, \@foundGenes1) and 
			 &checkGeneOverLap($n2, $b2, $e2, \@{$annotation->{$name2}[1]}, \@foundGenes2)) {

			
			foreach my $good1 (@foundGenes1) {
				my ($t1, $b1, $e1) = @$good1;
				foreach my $good2 (@foundGenes2) {

					# if the two overlapped genes exists and has not been found 
					# before
					if (defined $found{$good1}{$good2} and not $found{$good1}{$good2}) {
						# then they have been found now
						$found{$good1}{$good2} = 1;
						# there is one less false negative
						$genes{$$good1[0]}--;
						# and one more true positive prediction
						$tp{$$good1[0]}++;
					}
				}
	    	}
		}
		else {$fp++;}
	}

	# The false positives don't have type yet but the tp's and fn's does
	# so they are printed with types
	printf " %2i ", $fp;
	foreach my $type (sort keys %genes) {
		my $ppv = Math::ppvsense($tp{$type}, $fp);
		my $sens = Math::ppvsense($tp{$type}, $genes{$type});
		printf " $type %2i %2i %1.2f %1.2f %1.2f", $tp{$type}, $genes{$type}, $ppv, $sens, (sqrt($ppv*$sens));
	}
}

sub countSameGenePairs {

	my ($annotation, $name1, $name2, $genes, $found, $tp) = @_;
	
	my $annoArrayPosInAnnotation = 1;

	# Count the number of combinations of genes, only genes of the same type
	# are counted
	foreach my $anno1 (@{$annotation->{$name1}[$annoArrayPosInAnnotation]}) {
		my ($t1, $st1, $sl1) = @$anno1;

		foreach my $anno2 (@{$annotation->{$name2}[$annoArrayPosInAnnotation]}) {
			my ($t2, $st2, $sl2) = @$anno2;
			
			# only the same type of genes are counted
			if ($t1 eq $t2) {
				$$genes{$t1}++;
				$$found{$anno1}{$anno2} = 0;
				$$tp{$t1} = 0;
			}
		}
	}


}

sub calcGeneCC {

	my ($hits, $annotation, $name1, $name2, $length1, $length2) = @_;

	# Calculate the CC for a prediction on a nucleotide scale
	# tp is a nucleotide in a prediction which is also annotated
	# fp is a nucleotide in a prediction which is not annotated
	# fn is a nucleotide which is annotated but not predicted
	# tn is a nucleotide which is not annotated and not in a prediction
	# uc nucleotides are nucleotides which annotated with different structure
	# types. These nucleotides are not counted.

	my $typePosInAnnotation = 0;
	my $annoArrayPosInAnnotation = 1;

	my ($tp, $fp, $fn, $tn, $uc);

	# Initiate the counters
	&Structures::initTpFpFnTnUc(\$tp, \$fp, \$fn, \$tn, \$uc, $annotation, $name1, $name2, $length1, $length2);

	# Get the official types
	my $type1 = $annotation->{$name1}[$typePosInAnnotation];
	my $type2 = $annotation->{$name2}[$typePosInAnnotation];

	if ($type1 ne $type2) {
		warn "eval_nohit the official types of the $name1 and $name2 predcitions are not the same: $type1 != $type2\n";
	}
	# Check each hit
	foreach my $hit (@$hits) {

		# Get the names, begin, and end positions of the two aligned sequences
		my ($n1, $b1, $e1, $n2, $b2, $e2) = split(/\s+/, $hit);

		# Was it found? Default: no.
		my $found = 0;

		# A falls positive counter for this prediction
		# By default all nucleotides are false positives
		my $lfp = ($e1 - $b1 +1)*($e2 - $b2 +1);

		foreach my $anno1 (@{$annotation->{$name1}[$annoArrayPosInAnnotation]}) {
			my ($t1, $st1, $sl1) = @$anno1;

			# Does the prediction overlap with this annotation from the first
			# sequence?
			if ($st1 <= $e1 and  $b1 <= $sl1) {
				foreach my $anno2 (@{$annotation->{$name2}[$annoArrayPosInAnnotation]}) {
					my ($t2, $st2, $sl2) = @$anno2;

					# Does the prediction overlap with this annotation from the
					# second sequence?
					if ($st2 <= $e2 and $b2 <=$sl2) {
			
						# The overlapping coords
						my $ob1 = $b1;
						my $ob2 = $b2;
						my $oe1 = $e1;
						my $oe2 = $e2;

						if ($b1 < $st1) {$ob1 = $st1;}
						if ($b2 < $st2) {$ob2 = $st2;}
						if ($e1 > $sl1) {$oe1 = $sl1;}
						if ($e2 > $sl2) {$oe2 = $sl2;}

						# The number of predicted nucs. which overlaps annotation
						my $overlap = ($oe1 - $ob1 +1)*($oe2 - $ob2 +1);
						$lfp -= $overlap;

						if ($type1 eq $t1 and $type2 eq $t2 and $t1 eq $t2) {
							# These are similar annotations
							$tp += $overlap;
							$fn -= $overlap;
						}
						else {
							# These are unsimilar annotations
							$uc += $overlap;
						}
					}
				}
			}
		}

		# Correct the grand total of fp's
		$fp += $lfp;
	}

	my $cc = Math::cc($tp, $fp, $fn, $tn);
	printf " %3i %7i %7i %7i %7i %7i\t%1.3f", scalar(@$hits), $tp, $fp, $fn, $tn, $uc, $cc;
			
}


sub initTpFpFnTnUc {

	my ($tp, $fp, $fn, $tn, $uc, $annotation, $name1, $name2, $length1, $length2) = @_;
    
	# Init the number true positives, false positives, false negatives, true
	# negatives, and uncounted.
	# The genes annotations are in $annotation hash

	$$tp = $$fp = $$fn = $$uc = $$tn = 0;

	# Get the "official" structure type
	my $type1 = $annotation->{$name1}[0];
	my $type2 = $annotation->{$name2}[0];

	# It is necessary to known the number of uncounted nucleotides to calculate
	# the number of true negatives.
	my $local_uc = 0;

	unless ($type1 eq $type2) {
		warn "There is something wrong with the annotation $type1 ne $type2\n";
	}
	foreach my $anno1 (@{$annotation->{$name1}[1]}) {
		my ($t1, $b1, $e1) = @{$anno1};

		foreach my $anno2 (@{$annotation->{$name2}[1]}) {
			my ($t2, $b2, $e2) = @{$anno2};

			# The number of potentially false positve/true positive nucs.
			my $s = ($e1-$b1+1)*($e2-$b2+1);
			if ($t1 eq $t2 and $t2 eq $type2 and $t1 eq $type1) {
				# The two structures have the same type, these positions count
				$$fn += $s;
			}
			else {
				# Two different structures. These positions do not count
				$local_uc += $s;
			}
		}
	}
	# Calc the number of true negatives
	$$tn = $length1 * $length2 - $$fn - $local_uc;
    
}

sub swap {

	my ($a, $b) = @_;

	my $t=$$a;
	$$a=$$b;
	$$b=$t;
}

# The one must be here. Its a perl thing.
1;
