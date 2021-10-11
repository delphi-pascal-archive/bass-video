unit uCommonType;

interface

type
  TMyBande = record
    fCenter:double;
    fBandwidth:double;
    fGain:double;
  end;

  TMyEqualiseur = record
    Bande1 : TMyBande;
    Bande2 : TMyBande;
    Bande3 : TMyBande;
    Bande4 : TMyBande;
    Bande5 : TMyBande;
  end;

implementation

end.
