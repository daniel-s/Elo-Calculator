use v6;

# K factor used in calculating new rating
my $kFactor = 32;
# default value to give a new player
my $defaultELO;
my $file = open "results.txt";
# @results will hold everything. It's an array, with each element a result
# result is (First, Second, outcome) ie. (Bob, Alice, 1) (3 element array)
my @results;

# hash table of player name (key) and rating
my %player;

# expected () gives the expected result for $player1, with inputs
# $player1 and $player2
sub expected ($player1, $player2)
{
	if %player.exists($player1) && %player.exists($player2)
	{
		return 1/(1+10**((%player{$player2} - %player{$player1})/400));
	}
	else
	{
		say "Error: Player without key in %player has been referenced";
	}
}

# collecting results from file into array
for $file.lines -> $line
{
	@results.push($line.split(":"));
}

for @results -> $p1, $p2, $score
{
	# say $p1 ~ $p2 ~ $score;
	# set scores to 1000 if it's the first time their results appear
	if (%player.exists($p1) == Bool::False) {%player{$p1} = 1000};
	if (%player.exists($p2) == Bool::False) {%player{$p2} = 1000};
	%player{$p1} = round ( %player{$p1} + $kFactor * ($score - expected($p1, $p2)) );
}

# this simply lists all of the players and their ratings
for %player.keys -> $p1
{
	say "$p1 has rating of: %player{$p1}";
}

say @results;
@results.sort;
say @results;
say @results.sort;
