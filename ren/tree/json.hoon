::
::::  /hoon/json/tree/ren
  ::
/?    310
/+    tree
/=    gas    /$    fuel
/=    dat    /^    tree-include    /tree-include/
/=    kid    /^    (map knot tree-include)
             /_    /tree-include/
!:
::::
  ::
|%
++  schema  (dict {term $@(mark schema)})
++  dict    |*(a/_* $^({a (dict a)} a))
++  plist   (list {term $@(mark plist)})
++  query
  $%  {$kids p/(list query)}
      {$name $t}
      {$path $t}
      {$spur $t}
  ::
      {$comt $j}
      {$head $r}
      {$sect $j}
      {$snip $r}
      {$body $r}
      {$meta $j}
      {$mime $m}
  ==
++  schema-to-plist                   :: pad improper list
  |=  a/schema  ^-  plist
  ?@(-.a [(to-item a) ~] [(to-item -.a) $(a +.a)])
::
++  to-item
  |=  b/{term $@(mark schema)}  ^-  {term $@(mark plist)}
  ?@(+.b b [-.b (schema-to-plist +.b)])
::
++  from-type                         ::  XX holding out for noun odors
  |=  a/$%({$t p/cord} {$r p/json} {$j p/json} {$m mime})
  ?-  -.a
    $t  [%s p.a]
    $m  (jobe mite+[%s (moon p.a)] octs+[%s q.q.a] ~)
    $r  p.a
    $j  p.a
  ==
++  from-queries
  |=  {bem/beam quy/(list query)}
  =<  (jobe (turn quy .))
  |=  a/query
  :-  -.a
  ?-  -.a
    $name  (from-type +.a ?^(s.bem i.s.bem q.bem))
    $path  (from-type +.a (crip (spud (flop s.bem))))
    $spur  (from-type +.a (crip (spud s.bem)))
    $comt  (from-type +.a comt.dat)
    $head  (from-type +.a head.dat)
    $snip  (from-type +.a snip.dat)
    $sect  (from-type +.a sect.dat)
    $meta  (from-type +.a meta.dat)
    $mime  (from-type +.a mime.dat)
    $body  (from-type +.a body.dat)
    $kids  ?<  (~(has by (malt p.a)) %kids)  ::  XX recursion? 
           =<  o+(~(urn by kid) .)
           |=  {dir/knot dak/tree-include}  ^-  json
           ^^$(quy p.a, s.bem [dir s.bem], dat dak, kid ~)
  ==
--
!:
::::
  ::
[tree .]
^-  json
=+  default='spur.t_mime.m_body.r_comt.j_kids.name.t'
=+  ^=  schem
    =+  seh=(fall (~(get by qix.gas) 'q') default)
    ~|(bad-noun+seh ;;(schema (rash seh read-schem)))
%+  from-queries  bem.gas(s but.gas)
~|  invalid-query+schem
;;((list query) (schema-to-plist schem))
