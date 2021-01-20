uses
  GraphABC;

type
  obj = record
    t: integer;
    gen: array [0..19] of integer;
    Now: integer;
    x, y: integer;
    energy: integer;
    dt: integer;
  end;

var
  Bact: array of obj;
  Cnt: integer;
  Pole: array [,] of integer;
  dx: array of integer := (0,1,0,-1);
  dy: array of integer := (1,0,-1,0);
  
  
  SzX, SzY: integer;
  md: integer;
  label Next;
  
  
  
  procedure OnKey(key: integer);
  begin
    if(key = VK_W) then md := 1 - md;
  
  
  end;
  
begin
  onkeydown:=OnKey;
  Cnt := 10;
  Bact := new obj[Cnt];
  SzX := 500;
  SzY := 500;
  Pole := new integer[SzX div 10, SzY div 10];
  
  //var md := 0;
  
  for var i := 0 to SzX div 10 - 1 do 
  begin
    for var j := 0 to SzY div 10 - 1 do 
    begin
      Pole[i, j] := -1;
    end;
  end;
  for var i := 0 to Cnt - 1 do 
  begin
    Bact[i].t := 1;
    Bact[i].x := random(SzX div 10);
    Bact[i].y := random(SzY div 10);
    Pole[Bact[i].x, Bact[i].y] := i;
    for var j := 0 to 19 do 
    begin
      Bact[i].gen[j] := random(0, 50);
    end;
    //Bact[i].gen[5] := 99;
    Bact[i].energy := 20;
  end;
  setwindowsize(SzX, SzY);
  {Bact[0].t := 6;
  Bact[0].energy := 50000;
  Bact[1].t := 6;
  Bact[1].energy := 50000;}
  // //////////////////////////////////////////////////

  repeat
    lockdrawing();
    window.Clear();
    var Mx := 0;
    for var i := Cnt - 1 downto 0 do 
    begin
     
      if(i = 0) then begin
        var a := 1;
      end;
      var tx := Bact[i].x;
      var ty := Bact[i].y;
      //if(Bact[i].t <> 6) then
      Bact[i].energy -= 1;
      var n := 0;
      if(Bact[i].t <> 4) then
        n := Bact[i].gen[Bact[i].Now] mod 4
      else 
        n := Bact[i].gen[Bact[i].Now] mod 1;
      
      var nx := tx + dx[n];
      var ny := ty + dy[n];
      if(nx < 0) then nx += SzX div 10;
      if(nx >= (SzX div 10)) then nx -= SzX div 10;
      
      Bact[i].Now += 1;
      Bact[i].Now := Bact[i].Now mod 20;
      
      if(nx >= 0) and ( ny >= 0) and ( nx < (SzX div 10)) and (ny < (SzY div 10)) then begin
        if(Bact[i].t = 1) or ( Bact[i].t = 3) or ( Bact[i].t = 4) then begin
          if(Pole[nx, ny] = -1) then begin
            Pole[nx, ny] := Pole[tx, ty];
            Pole[tx, ty] := -1;
            Bact[i].x := nx;
            Bact[i].y := ny;
          end;
        end else if( Bact[i].t = 2) then begin
          if(Pole[nx, ny] = -1) then begin
            Pole[nx, ny] := Pole[tx, ty];
            Pole[tx, ty] := -1;
            Bact[i].x := nx;
            Bact[i].y := ny;
          end else if(Pole[nx, ny] <> -1) then begin
            var id := Pole[nx, ny];
            if(id >= Cnt) then continue;
            //if(Bact[id].t = 3) then swap(Bact[i], Bact[id]);
            if(Bact[id].t = 4)then begin goto Next; end;
            //if(Bact[id].t = 6)then begin goto Next; end;
            Pole[nx, ny] := Pole[tx, ty];
            Pole[tx, ty] := -1;
            Bact[i].x := nx;
            Bact[i].y := ny;
            Bact[i].energy += round(0.1 * Bact[id].energy);
            swap(Bact[Cnt-1], Bact[id]);
            setlength(Bact, Cnt-1);
            Cnt -= 1;
            if(id <> Cnt) then begin
              Pole[Bact[id].x, Bact[id].y] := id;
            end;
          end;
        end else if( Bact[i].t = 5) then begin
          if(Pole[nx, ny] = -1) then begin
            Pole[nx, ny] := Pole[tx, ty];
            Pole[tx, ty] := -1;
            Bact[i].x := nx;
            Bact[i].y := ny;
          end else if(Pole[nx, ny] <> -1) then begin
            var id := Pole[nx, ny];
            if(id >= Cnt) then continue;
            //if(Bact[id].t = 3) then swap(Bact[i], Bact[id]);
            if(Bact[id].t = 1)then begin goto Next; end;
            if(Bact[id].t = 2)then goto Next;
            if(Bact[id].t = 3)then goto Next;
            if(Bact[id].t = 5)then goto Next;
            if(Bact[id].t = 6)then goto Next;
            Pole[nx, ny] := Pole[tx, ty];
            Pole[tx, ty] := -1;
            Bact[i].x := nx;
            Bact[i].y := ny;
            Bact[i].energy +=20;
            swap(Bact[Cnt-1], Bact[id]);
            setlength(Bact, Cnt-1);
            Cnt -= 1;
            if(id <> Cnt) then begin
              Pole[Bact[id].x, Bact[id].y] := id;
            end;
          end;
        end else if(Bact[i].t = 6) then begin
          
          var d := random(0,3);
          var sx := Bact[i].x + dx[d];
          var sy := Bact[i].y + dy[d];
          sx+= (SzX div 10);
          sx := sx mod (SzX div 10);
          if(sx < 0) or ( sy < 0) or  ( sx >= (SzX div 10)) or  (sy >= (SzY div 10)) then begin end else begin
          
            var id := Pole[sx, sy];
            if(id = -1) then begin
            
            end else begin
              if(Bact[id].energy < 0) then goto Next;
              if(Bact[id].t = 6) or (Bact[id].t = 4) then begin
                //if(Bact[i].energy >= Bact[id].energy) then begin
                  Bact[i].energy += round(0.5 * Bact[id].energy);
                  Bact[id].energy := round(0.5 * Bact[id].energy);
                 //end;
              end else begin
                if(id > Cnt-1) then begin end else begin
                  Bact[i].energy += round(0.5 * Bact[id].energy);
                  Bact[id].energy := round(0.5 * Bact[id].energy);
                  //Bact[id].t := 6;
                end;
              end;
              if(Bact[i].energy >= 2000) {and(Bact[id].t = 4)} then begin
                Bact[i].energy -= 1000;
                Bact[id].energy := 1000;

                for var j := 0 to 19 do 
                begin
                  var f := random(0, 100);
                  if(f <= 10 ) then Bact[id ].gen[j] := random(0, 100)
                  else Bact[id ].gen[j] := Bact[i].gen[j];
                  
                  if(Bact[id ].gen[j] < 3) and ( j < 3) then begin
                    Bact[id ].t := 2;
                  end else if(Bact[id].gen[j] = 99) and( j > 4) then begin
                    Bact[id ].t := 3;
                  end else if(Bact[id ].gen[j] = 98) and(j > 15) then begin
                    Bact[id ].t := 5;
                  end; 
                end;
                if(Bact[id].t = 4) then Bact[id].t := 6;
              end;
            end;
          end;
        
        end;
      end else continue;
      if(i >= Cnt) then continue;
   
      if(Bact[i].gen[Bact[i].Now] >= 35) and (Bact[i].t = 1) then Bact[i].energy += max(20 - Bact[i].y, 0) * 2;
      if(Bact[i].gen[Bact[i].Now] >= 35) and (Bact[i].t = 3) then Bact[i].energy -= max(20 - Bact[i].y, 0) * 2;
      //if(abs(50 - Bact[i].gen[Bact[i].Now]) <= 5) and(Bact[i].t = 1) then Bact[i].energy += max(Bact[i].y - 35, 0) * 1;
      if(Bact[i].t = 3) then Bact[i].energy += max(Bact[i].y - 30, 0) * 2;
      
      Next: if(Bact[i].energy <= 0)  {  or ((Bact[i].energy >= 500) and (Bact[i].t <>6))} then begin
        Bact[i].energy := 0;
        Bact[i].t := 4;
        continue;
      
        Pole[Bact[i].x, Bact[i].y] := -1;
        swap(Bact[i], Bact[Cnt - 1]);
        setlength(Bact, Cnt - 1);
        Cnt -= 1;
        if(i = Cnt) then continue;
        Pole[Bact[i].x, Bact[i].y] := i;
        continue;
      end;
      if(Bact[i].energy >= 10000) then Bact[i].t :=6;
      
      
      
      if(Bact[i].energy >= 200) and ((Pole[nx, ny] = -1) or (Pole[tx, ty] = -1)) {and (Bact[i].t <>6)} then begin
        setlength(Bact, Cnt + 1);
        Cnt += 1;
        var f := random(0, 50);
        if(Bact[i].t = 1) then begin
          if(f = 1) then 
            Bact[Cnt - 1].t := 2
          else if(f = 2)then begin
            
          end else
            Bact[Cnt - 1].t := 1;
        end;
        
        if(Bact[i].t = 2) then begin
          Bact[Cnt - 1].t := 2
        end;
          
        if(Pole[nx, ny] = -1) then begin 
          Bact[Cnt - 1].x := nx;
          Bact[Cnt - 1].y := ny;
        end else begin
          Bact[Cnt - 1].x := tx;
          Bact[Cnt - 1].y := ty;
        end;
        
        Pole[Bact[Cnt - 1].x, Bact[Cnt - 1].y] := Cnt - 1;
        for var j := 0 to 19 do 
        begin
          f := random(0, 100);
          if(f <= 10 ) then Bact[Cnt - 1].gen[j] := random(0, 100)
          else Bact[Cnt - 1].gen[j] := Bact[i].gen[j];
          
          if(Bact[Cnt - 1].gen[j] < 3) and ( j < 3) then begin
            Bact[Cnt - 1].t := 2;
          end else if(Bact[Cnt - 1].gen[j] = 99) and( j > 4) then begin
            Bact[Cnt - 1].t := 3;
          end else if(Bact[Cnt - 1].gen[j] = 98) and(j > 15) then begin
            Bact[Cnt - 1].t := 5;
          end;
          
          
        end;
        if(Bact[Cnt-1].t = 0) then Bact[Cnt-1].t := 1;
        if(Bact[i].t = 6) then begin
         Bact[Cnt - 1].t := 6;
        end;
        Bact[Cnt - 1].energy := 20;
        Bact[i].energy -=200;
        Bact[i].dt += 1;
      end;
      
      
      
      
      
    end;
    
    for var i := 29 to 49 do begin
      setbrushcolor(RGB(0, 240 - (i - 29)*12,240 - (i - 29)*12)); 
      fillrect(0,i*10,500,i *10 + 10);
    end;
    
    for var i := 0 to 29 do begin
      setbrushcolor(RGB(240 - ( i) * 8, 240, i* 8)); 
      fillrect(0,i*10,500,i *10 + 10);
    end;
    
    foreach Bt: obj in Bact do 
    begin
      if(md = 0) then begin
        if(Bt.t = 2) then begin
          //setbrushcolor(RGB(max(50, min(255, (Bt.energy  ))), 0,0));
         setbrushcolor(clred);
        end;
        if(Bt.t = 1) then begin
          //setbrushcolor(RGB(0, 0,max(50, min(255, (Bt.energy ) ))));
          setbrushcolor(clblue);
        end;
        if(Bt.t = 3) then begin
          setbrushcolor(clGray);
        end;
        if(Bt.t = 4) then begin
          setbrushcolor(clWhite);
        end;
        if(Bt.t = 5) then begin
          setbrushcolor(clPurple);
        end;
        if(Bt.t = 6) then begin
          setbrushcolor(clGreen);
        end;
       end else if(md = 1) then begin
        
        var a := round(255.0 / 10000.0 * max(0,Bt.energy));
        setbrushcolor(RGB(a,a,a));
       
       end;
     
      if(Mx < Bt.dt) then Mx := Bt.dt;
      fillrect(Bt.x * 10 + 1, Bt.y * 10 + 1, Bt.x * 10 + 10 - 1, Bt.y * 10 + 10 - 1);
    end;
    
    {if(Mx >= 10) then begin
      var t := random(0,Cnt-1);
      Bact[t].t  := 6;
      Bact[t].energy  := 200;
    end;}
    
   
    sleep(100);
    redraw();
  until false;
  
  
  
end.