#!/bin/sh

tmp=$$
trap "rm -f $tmp.*" 0 1 2 3 15

makeps () {
  cat >$tmp.mp <<-END
	input feynmp;
	beginchar (1, 40mm, 14mm, 0);
          pickup pencircle scaled thick;
	  arrow_len:=6mm;
	  idraw ("$1", (0,.5h)--(w,.5h));
	  ivertex ("d.sh=circle,d.fi=1,d.si=1pt", (0,.5h));
	  ivertex ("d.sh=circle,d.fi=1,d.si=1pt", (w,.5h));
	endchar;
	end.
	END
   mp $tmp.mp
}

eps2gif () {
  gs -q -dNOPAUSE -dNO_PAUSE -sDEVICE=ppmraw -sOutputFile=- - \
    | pnmcrop | ppmtogif -trans '#ffffff'
}

for sty in curly dbl_curly \
           dashes dashes_arrow dbl_dashes dbl_dashes_arrow \
           dots dots_arrow dbl_dots dbl_dots_arrow \
           phantom phantom_arrow \
           plain plain_arrow dbl_plain dbl_plain_arrow \
           wiggly dbl_wiggly zigzag dbl_zigzag; do
  makeps $sty
  eps2gif < $tmp.1 > $sty.gif
done

exit 0
