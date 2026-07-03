local cache = {}

local function cached(ttl, key, fn)
    local now = os.time()

    if cache[key] and cache[key].t + ttl > now then
        return table.unpack(cache[key].v)
    end

    local v = { fn() }

    cache[key] = {
        t = now,
        v = v
    }

    return table.unpack(v)
end

local function sleep(s)
    local timer = io.popen("sleep " .. s)
    if not timer then
        return
    end
    timer:close()
end

-- Animation
local animation_frames = {
    "   ",
    "░░░",
    "▒▒▒",
    "▓▓▓",
}

local animation_ticker = 1
local animation_dir = 1 -- 1 = forward, -1 = backward

local function frame()
    local f = animation_frames[animation_ticker]

    animation_ticker = animation_ticker + animation_dir

    if animation_ticker > #animation_frames then
        animation_ticker = #animation_frames - 1
        animation_dir = -1
    elseif animation_ticker < 1 then
        animation_ticker = 2
        animation_dir = 1
    end

    return f
end

local function kube()
    local handle = io.popen("kubectl config current-context 2>/dev/null")
    if not handle then
        return "", ""
    end

    local ctx = handle:read("*a"):gsub("\n", "")
    handle:close()

    local ns = io.popen(
        "kubectl config view --minify -o jsonpath='{..namespace}' 2>/dev/null"
    ):read("*a"):gsub("\n", "")

    return ctx, (ns ~= "" and ns or "default")
end

local function get_ip()
    local handle = io.popen("ip route get 1.1.1.1 2>/dev/null")
    if not handle then
        return nil
    end

    local out = handle:read("*a") or ""
    handle:close()

    return out:match("src%s+([%d%.]+)")
end

while true do
    local parts = {}
    -- kubernetes
    local kube_ctx, kube_ns = cached(5, "kube", kube)

    if kube_ctx:find("prod") then
        local current_frame = frame()
        table.insert(parts, current_frame .. " " .. kube_ctx .. "/" .. kube_ns .. " " .. current_frame)
    else
        table.insert(parts, "☸ " .. kube_ctx .. "/" .. kube_ns)
    end

    -- network
    local ip = cached(5, "ip", get_ip)
    table.insert(parts, ip)

    -- clock
    table.insert(parts, os.date("%H:%M:%S"))

    print(table.concat(parts, " | "))
    io.flush()
    sleep(1)
end
