cache = {}

function cached(ttl, key, fn)
  local now = os.time()

  if cache[key] and cache[key].t + ttl > now then
    return cache[key].v
  end

  local v = fn()
  cache[key] = { t = now, v = v }
  return v
end

function kube()
  local handle = io.popen("kubectl config current-context 2>/dev/null")
  local ctx = handle:read("*a"):gsub("\n","")
  handle:close()

  local ns = io.popen(
    "kubectl config view --minify -o jsonpath='{..namespace}' 2>/dev/null"
  ):read("*a"):gsub("\n","")

  if ctx == "" then return "" end
  return "☸ " .. ctx .. "/" .. (ns ~= "" and ns or "default")
end

while true do
  local k = cached(5, "kube", kube)
  local time = os.date("%H:%M:%S")

  print(k .. " | " .. time)
  io.flush()
  os.execute("sleep 1")
end
