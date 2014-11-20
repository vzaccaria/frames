
frame-dispatcher = (domid) ->

    frame-view = require('./frameView.ls')
    frame-store = require('./frameStore.ls')

    frame-store-instance = new frame-store()
    frame-view-instance = new frame-view(domid)

    frame-store-instance.onChange ->
        frame-view-instance.data = frame-store-instance.store.data

    dispatcher = require('delorean').Flux.create-dispatcher {
        resize: -> @dispatch('resize', it)

        get-stores: -> {
            # Store instances served by this dispatcher
            frame-store : frame-store-instance
        }
    }

    return dispatcher

#connect this store instance to the view.

module.exports = frame-dispatcher