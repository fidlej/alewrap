
require 'paths'

-- Reads the whole content of the specified file.
local function readContent(path)
    local file = io.open(path)
    local content = file:read("*a")
    file:close()
    return content
end

local ffi = require 'ffi'
-- We let the ale::ALEInterface to look like a C struct.
ffi.cdef("typedef struct ALEInterface ALEInterface;")
ffi.cdef(readContent(paths.thisfile("alewrap_core.h")))
local lib = ffi.load(assert(package.searchpath('libalewrap',package.cpath)))

-- Defining the metatable for ALEInterface userdata.
local mt = {}
mt.__index = mt
mt.act = lib.ale_act
mt.fillObs = lib.ale_fillObs
mt.fillRamObs = lib.ale_fillRamObs
mt.isGameOver = lib.ale_isGameOver
mt.resetGame = lib.ale_resetGame
mt.loadState = lib.ale_loadState
mt.saveState = lib.ale_saveState
mt.numActions = lib.ale_numLegalActions
mt.actions = lib.ale_legalActions
ffi.metatype("ALEInterface", mt)

-- Creates a new ALEInterface instance.
function alewrap.newAle(romPath)
    if not paths.filep(romPath) then
        error(string.format('no such ROM file: %q', romPath))
    end
    return ffi.gc(lib.ale_new(romPath), lib.ale_gc)
end

-- Converts the palette values to RGB values.
-- A new ByteTensor is returned.
function alewrap.getRgbFromPalette(obs)
    obs = obs:contiguous()
    assert(obs:nElement() == obs:storage():size(),
        "the obs should not share a bigger storage")
    local rgbShape = {3, unpack(obs:size():totable())}

    local rgb = torch.ByteTensor(unpack(rgbShape))
    lib.ale_fillRgbFromPalette(torch.data(rgb), torch.data(obs),
            rgb:nElement(), obs:nElement())
    return rgb
end

