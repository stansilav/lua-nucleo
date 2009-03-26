local serial = function(...)
 local n = select("#", ...)
 ans = "";

 for i = 1, n do
  b = 0;
  if (type (select(i, ...)) == "number") then
   ans = ans..string.format("%d", select(i, ...));
   b = 1;
  end;

  if (type (select(i, ...)) == "boolean") then
   if (select(i, ...) == true) then
    ans = ans.."true";
   else
    ans = ans.."false";
   end;
   b = 1;
  end;

  if (type (select(i, ...)) == "string") then
   ans = ans.."\"";
   ans = ans..select(i, ...);
   ans = ans.."\"";
   b = 1;
  end;

  --if (type (select(i, ...)) == "table") then
  -- b = 1;
  --end;

  if (i ~= n and b == 1) then
   ans = ans..",";
  end
 end
 return ans;
end
print(serial (true, 1, 2, 3, false, "sdsdsd"));
 