debug = require('debug')('frame-store')

frame-store = require('delorean').Flux.create-store {
    data: 
        wx: 100 
        wy: 100 

    actions:
        resize: 'resize'

    resize: (data) ->
        debug "Resize action received from the store"
        debug data
        @data = data
        @emit('change') # needed by the view

}




module.exports = frame-store

