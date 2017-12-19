from __future__ import division
from pyjarowinkler import distance as jw
from os import listdir

def stringify(words1, words2):
	letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
	lookup_table = {}

	encoded_word1 = ''
	for idx, word in enumerate(words1):
		encoded_word1 += letters[idx]
		lookup_table[word] = letters[idx]

	encoded_word2 = ''
	for word in words2:
		encoded_word2 += lookup_table[word]

	return encoded_word1, encoded_word2

def jaro_winkler_distance(words1, words2):
	word1, word2 = stringify(words1, words2)
	return jw.get_jaro_distance(word1, word2, winkler=True, scaling=0.25)

def prepare_data(file):
	return map(lambda line: line.rstrip().split(','), file.readlines())

def compare_files(file1, file2):
	results1 = prepare_data(file1)
	results2 = prepare_data(file2)

	distances = []
	for result1, result2 in zip(results1, results2):
		distances.append(jaro_winkler_distance(result1, result2))

	return sum(distances) / len(distances)


def schulze_kemeny():
	filenames = listdir('../spec/comparison/results/schulze')

	for filename in filenames:
		schulze_f = open('../spec/comparison/results/schulze/' + filename, 'r')
		kemeny_f = open('../spec/comparison/results/kemeny/' + filename, 'r')

		print compare_files(schulze_f, kemeny_f)

		schulze_f.close()
		kemeny_f.close()

	return None

def schulze_ranked():
	filenames = listdir('../spec/comparison/results/schulze')

	for filename in filenames:
		schulze_f = open('../spec/comparison/results/schulze/' + filename, 'r')
		ranked_f = open('../spec/comparison/results/ranked_pairs/' + filename, 'r')

		print compare_files(schulze_f, ranked_f)

		schulze_f.close()
		ranked_f.close()

	return None

def kemeny_ranked():
	filenames = listdir('../spec/comparison/results/kemeny')

	for filename in filenames:
		ranked_f = open('../spec/comparison/results/ranked_pairs/' + filename, 'r')
		kemeny_f = open('../spec/comparison/results/kemeny/' + filename, 'r')

		print compare_files(ranked_f, kemeny_f)

		ranked_f.close()
		kemeny_f.close()

	return None
if __name__ == "__main__":
	print 'Jaro-Winkler distances between Schulze and Kemeny:'
	schulze_kemeny()
	print 'Jaro-Winkler distances between Schulze and Ranked pairs:'
	schulze_ranked()
	print 'Jaro-Winkler distances between Ranked pairs and Kemeny:'
	kemeny_ranked()