
frame-dispatcher = require('./dispatcher.ls')

frame-drawing-dispatcher = frame-dispatcher('#drawing')

actions = {
    resize: (x, y) -> frame-drawing-dispatcher.resize(wx: x, wy: y)
}

module.exports = actions