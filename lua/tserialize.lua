 local used = table
local names = table
num = 1;

tserialize  = function(...)
  local n = select("#", ...)
  local ans = "";
  for i = 1, n do
    local arg = select(i, ...)
    local type_arg = type (arg)

    if arg == nil
	then
      ans = ans.."nil"

	elseif type_arg == "number" or
	        type_arg == "boolean" or
			type_arg == "nil"
    then
  	  ans = ans..tostring(arg)

	elseif type_arg == "string"
	then
      ans = ans..string.format("%q", arg)

	elseif type_arg == "table"
	then
      if (type (used[arg]) ~= "string") and (arg ~= true)
	  then
        used[arg] = "arg"..tostring (num)
        num = num+1;
        ans = ans.."{"
        local flag = false;
        local sz = 0;

		for key, value in ipairs(arg) do
          if type(value) ~= "function"
		  then
            if flag
			then
              ans = ans..", "
            end
            ans = ans..tserialize (value)
            flag = true;
            sz = key;
	      end
        end

        for key, value in pairs(arg) do
	      if type(value) ~= "function" then
            if (type (key) ~= "number") or (key > sz) then
              if flag then
                ans = ans..", "
              end
              ans = ans.."["..tserialize(key).."]".."="..tserialize(value)
              flag = true;
            end
          end
        end
		used[arg] = nil;
		ans = ans.."}"

	  else
        ans = ans..used[arg]
      end
    end

	if i ~= n then
      ans = ans..", "
	end
  end

  return ans
end

local g = {1, 2, 3}
local t = {1, 2, g};
t[4] = t;

print(tserialize (t, g))
