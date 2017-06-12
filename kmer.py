import sys

# convert command line arguments to variables
seq_file = sys.argv[1]
kmer_size = int(sys.argv[2])


# difine the function to split dna
def split_dna(dna, kmer_size):
	kmers = []
	for start in range(0, len(dna)-(kmer_size - 1), 1):
		kmer = dna[start:start+kmer_size]
		kmers.append(kmer)
	return kmers
	
# create an empty file to hold counts
kmer_counts = {}

#process each line of the file
seqs = open(seq_file)
for line in seqs:
	if line.startswith('>'):
		pass
	else:
		dna = line.rstrip('\n')
		for kmer in split_dna(dna, kmer_size):
			current_kmer_count = kmer_counts.get(kmer, 0)
			new_kmer_count = current_kmer_count + 1
			kmer_counts[kmer] = new_kmer_count 
			
# sort the dictionary based on counts
counts = []
for keys, values in kmer_counts.items():
	counts.append((values, keys))
	counts.sort(reverse = True)
	
# print top 20
for values, keys in counts[:20]:
	print keys, values	
