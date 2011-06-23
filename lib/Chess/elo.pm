use v6;

class Chess::elo:auth<daniel-s>:ver<0.1>
{

    # return the expected score of 2 players at a time
    # NOTE: this is actually not used by any of the following elo() functions
    method expectedBoth ($p1, $p2)
    {
        return (1/(1+10**(($p2 - $p1)/400))), (1/(1+10**(($p1 - $p2)/400)));
    }

    # return the expected score of only one player ($p1)
    method expected ($p1, $p2)
    {
        return 1/(1+10**(($p2 - $p1)/400));
    }

    # update rating of only $p1 (default k=32)
    method elo ($p1, $p2, $score)
    {
        return round($p1 + 32 * ($score - self.expected($p1, $p2)) );
    }

    # update rating of both $p1 and $p2 (default k=32)
    method eloBoth ($p1, $p2, $score)
    {
        return round( $p1 + 32 * ($score - self.expected($p1, $p2)) ), 
	    round( $p2 + 32 * ((1-$score) - self.expected($p2, $p1)) );
    }

    # update rating of only $p1 (k given as input)
    method eloK ($p1, $p2, $score, $k)
    {
        return round($p1 + $k * ($score - self.expected($p1, $p2)) );
    }

    # update rating of both $p1 and $p2 (k given as input)
    method eloBothK ($p1, $p2, $score, $k)
    {
        return ( round($p1 + $k * ($score - self.expected($p1, $p2)) ), 
	    round($p2 + $k * ((1-$score) - self.expected($p2, $p1)) ) );
    }

    # a more generic version of the elo function, with score, k factor and expected
    # result all supplied to get a new elo rating.
    method eloN ($p1, $score, $k, $e)
    {
        return $p1 + $k * ($score - $e);
    }

}
