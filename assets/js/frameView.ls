debug = require('debug')('frame-view')

class frame-view 

    (id) ->
        @duration = 500
        @paper = Snap(id)
        @data = { wx: 50, wy: 50 }
        @el = @paper.rect(0, 0, @data.wx, @data.wy).attr(fill-opacity: 0.33)

        Object.observe @, (changes) ~>
            @scale!

    scale: ~>
        @el.addClass('attention')
        setTimeout((~> @el.removeClass('attention')), 1800)



module.exports = frame-view
