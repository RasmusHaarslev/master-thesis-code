import matplotlib.pyplot as plt
import numpy as np

def prepare_data(filename):
	f = open(filename, "r")
	
	voters = []
	times = []
	for line in f.readlines()[1:-1]:
		split_lines = line.split('&')
		if len(split_lines) == 2:
			voter, time = split_lines
		else:
			voter, time,  _ = split_lines

		voters.append(voter)
		times.append(time)

	f.close()

	voters = map(lambda x: float(x), voters)
	times = map(lambda x: float(x)*1000, times)

	return voters, times

def plot_single_round_5_voters():
	kemeny_voters, kemeny_times = prepare_data("../spec/benchmark_results/kemeny/single_round_5_voters.csv")
	schulze_voters, schulze_times = prepare_data("../spec/benchmark_results/schulze/single_round_5_voters.csv")
	ranked_pairs_voters, ranked_pairs_times = prepare_data("../spec/benchmark_results/ranked_pairs/single_round_5_voters.csv")

	kemeny_times.append(2001)
	kemeny_voters.append(len(kemeny_voters)+1)

	plt.figure(0)
	plt.title("5 voters, single round")
	plt.plot(kemeny_voters, kemeny_times, label='kemeny')
	plt.plot(schulze_voters, schulze_times, label='schulze')
	plt.plot(ranked_pairs_voters, ranked_pairs_times, label='ranked_pairs')
	plt.legend()
	plt.xlabel("# of alternatives")
	plt.ylabel("avg time to compute [ms]")
	plt.xlim(2, 100)
	plt.ylim(0, 1000)
	plt.savefig("../spec/benchmark_results/single_round_5_voters.pdf", format="pdf")
	

def plot_single_round_25_voters():
	kemeny_voters, kemeny_times = prepare_data("../spec/benchmark_results/kemeny/single_round_25_voters.csv")
	schulze_voters, schulze_times = prepare_data("../spec/benchmark_results/schulze/single_round_25_voters.csv")
	ranked_pairs_voters, ranked_pairs_times = prepare_data("../spec/benchmark_results/ranked_pairs/single_round_25_voters.csv")

	kemeny_times.append(2001)
	kemeny_voters.append(len(kemeny_voters)+1)

	plt.figure(1)
	plt.title("25 voters, single round")
	plt.plot(kemeny_voters, kemeny_times, label='kemeny')
	plt.plot(schulze_voters, schulze_times, label='schulze')
	plt.plot(ranked_pairs_voters, ranked_pairs_times, label='ranked_pairs')
	plt.legend()
	plt.xlabel("# of alternatives")
	plt.ylabel("avg time to compute [ms]")
	plt.xlim(2, 100)
	plt.ylim(0, 1000)
	plt.savefig("../spec/benchmark_results/single_round_25_voters.pdf", format="pdf")


def plot_three_rounds_5_voters():
	kemeny_voters, kemeny_times = prepare_data("../spec/benchmark_results/kemeny/three_round_5_voters.csv")
	schulze_voters, schulze_times = prepare_data("../spec/benchmark_results/schulze/three_round_5_voters.csv")
	ranked_pairs_voters, ranked_pairs_times = prepare_data("../spec/benchmark_results/ranked_pairs/three_round_5_voters.csv")

	kemeny_times.append(2001)
	kemeny_voters.append(len(kemeny_voters)+1)

	plt.figure(2)
	plt.title("5 voters, three rounds")
	plt.plot(kemeny_voters, kemeny_times, label='kemeny')
	plt.plot(schulze_voters, schulze_times, label='schulze')
	plt.plot(ranked_pairs_voters, ranked_pairs_times, label='ranked_pairs')
	plt.legend()
	plt.xlabel("# of alternatives")
	plt.ylabel("avg time to compute [ms]")
	plt.xlim(2, 100)
	plt.ylim(0, 1000)
	plt.savefig("../spec/benchmark_results/three_round_5_voters.pdf", format="pdf")


def plot_three_rounds_25_voters():
	kemeny_voters, kemeny_times = prepare_data("../spec/benchmark_results/kemeny/three_round_25_voters.csv")
	schulze_voters, schulze_times = prepare_data("../spec/benchmark_results/schulze/three_round_25_voters.csv")
	ranked_pairs_voters, ranked_pairs_times = prepare_data("../spec/benchmark_results/ranked_pairs/three_round_25_voters.csv")

	kemeny_times.append(2001)
	kemeny_voters.append(len(kemeny_voters)+1)

	plt.figure(3)
	plt.title("25 voters, three rounds")
	plt.plot(kemeny_voters, kemeny_times, label='kemeny')
	plt.plot(schulze_voters, schulze_times, label='schulze')
	plt.plot(ranked_pairs_voters, ranked_pairs_times, label='ranked_pairs')
	plt.legend()
	plt.xlabel("# of alternatives")
	plt.ylabel("avg time to compute [ms]")
	plt.xlim(2, 100)
	plt.ylim(0, 1000)
	plt.savefig("../spec/benchmark_results/three_round_25_voters.pdf", format="pdf")


def plot_majority_5_voters():
	kemeny_voters, kemeny_times = prepare_data("../spec/benchmark_results/kemeny_majority/three_round_5_voters.csv")
	schulze_voters, schulze_times = prepare_data("../spec/benchmark_results/schulze_majority/three_round_5_voters.csv")
	ranked_pairs_voters, ranked_pairs_times = prepare_data("../spec/benchmark_results/ranked_pairs_majority/three_round_5_voters.csv")

	kemeny_times.append(2001)
	kemeny_voters.append(len(kemeny_voters)+1)

	plt.figure(4)
	plt.title("5 voters, three rounds with majority")
	plt.plot(kemeny_voters, kemeny_times, label='kemeny')
	plt.plot(schulze_voters, schulze_times, label='schulze')
	plt.plot(ranked_pairs_voters, ranked_pairs_times, label='ranked_pairs')
	plt.legend()
	plt.xlabel("# of alternatives")
	plt.ylabel("avg time to compute [ms]")
	plt.xlim(2, 100)
	plt.ylim(0, 1000)
	plt.savefig("../spec/benchmark_results/majority_5_voters.pdf", format="pdf")


def plot_majority_25_voters():
	kemeny_voters, kemeny_times = prepare_data("../spec/benchmark_results/kemeny_majority/three_round_25_voters.csv")
	schulze_voters, schulze_times = prepare_data("../spec/benchmark_results/schulze_majority/three_round_25_voters.csv")
	ranked_pairs_voters, ranked_pairs_times = prepare_data("../spec/benchmark_results/ranked_pairs_majority/three_round_25_voters.csv")

	kemeny_times.append(2001)
	kemeny_voters.append(len(kemeny_voters)+1)
	
	plt.figure(5)
	plt.title("25 voters, three rounds with majority")
	plt.plot(kemeny_voters, kemeny_times, label='kemeny')
	plt.plot(schulze_voters, schulze_times, label='schulze')
	plt.plot(ranked_pairs_voters, ranked_pairs_times, label='ranked_pairs')
	plt.legend()
	plt.xlabel("# of alternatives")
	plt.ylabel("avg time to compute [ms]")
	plt.xlim(2, 100)
	plt.ylim(0, 1000)
	plt.savefig("../spec/benchmark_results/majority_25_voters.pdf", format="pdf")


if __name__ == "__main__":
	plot_single_round_5_voters()
	plot_single_round_25_voters()
	plot_three_rounds_5_voters()
	plot_three_rounds_25_voters()
	plot_majority_5_voters()
	plot_majority_25_voters()