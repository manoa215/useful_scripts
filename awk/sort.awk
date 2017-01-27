{

        if ( RES[$0] != $0 ) {

                RES[$0] = $0

        }

}

END {

        for ( r in RES ) {

                print RES[r]

        }

}
